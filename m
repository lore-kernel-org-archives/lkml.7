Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB94C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B2920854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbfJNP11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:27:27 -0400
Received: from foss.arm.com ([217.140.110.172]:46892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732968AbfJNP10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:27:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 236F728;
        Mon, 14 Oct 2019 08:27:26 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 886913F68E;
        Mon, 14 Oct 2019 08:27:24 -0700 (PDT)
Date:   Mon, 14 Oct 2019 16:27:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20191014152717.GA20438@lakrids.cambridge.arm.com>
References: <20191001065834.8880-1-dja@axtens.net>
 <20191001065834.8880-2-dja@axtens.net>
 <352cb4fa-2e57-7e3b-23af-898e113bbe22@virtuozzo.com>
 <87ftjvtoo7.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftjvtoo7.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 12:57:44AM +1100, Daniel Axtens wrote:
> Hi Andrey,
> 
> 
> >> +	/*
> >> +	 * Ensure poisoning is visible before the shadow is made visible
> >> +	 * to other CPUs.
> >> +	 */
> >> +	smp_wmb();
> >
> > I'm not quite understand what this barrier do and why it needed.
> > And if it's really needed there should be a pairing barrier
> > on the other side which I don't see.
> 
> Mark might be better able to answer this, but my understanding is that
> we want to make sure that we never have a situation where the writes are
> reordered so that PTE is installed before all the poisioning is written
> out. I think it follows the logic in __pte_alloc() in mm/memory.c:
> 
> 	/*
> 	 * Ensure all pte setup (eg. pte page lock and page clearing) are
> 	 * visible before the pte is made visible to other CPUs by being
> 	 * put into page tables.

Yup. We need to ensure that if a thread sees a populated shadow PTE, the
corresponding shadow memory has been zeroed. Thus, we need to ensure
that the zeroing is observed by other CPUs before we update the PTE.

We're relying on the absence of a TLB entry preventing another CPU from
loading the corresponding shadow shadow memory until its PTE has been
populated (after the zeroing is visible). Consequently there is no
barrier on the other side, and just a control-dependency (which would be
insufficient on its own).

There is a potential problem here, as Will Deacon wrote up at:

  https://lore.kernel.org/linux-arm-kernel/20190827131818.14724-1-will@kernel.org/

... in the section starting:

| *** Other architecture maintainers -- start here! ***

... whereby the CPU can spuriously fault on an access after observing a
valid PTE.

For arm64 we handle the spurious fault, and it looks like x86 would need
something like its vmalloc_fault() applying to the shadow region to
cater for this.

Thanks,
Mark.
