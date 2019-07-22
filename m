Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4697C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9561721901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfGVQiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:38:18 -0400
Received: from foss.arm.com ([217.140.110.172]:41824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfGVQiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:38:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E72BF28;
        Mon, 22 Jul 2019 09:38:16 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C3953F694;
        Mon, 22 Jul 2019 09:38:14 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:38:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Julien Grall <julien.grall@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        aou@eecs.berkeley.edu, gary@garyguo.net,
        Atish Patra <Atish.Patra@wdc.com>, hch@infradead.org,
        paul.walmsley@sifive.com, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, julien.thierry@arm.com,
        Will Deacon <will.deacon@arm.com>, christoffer.dall@arm.com,
        james.morse@arm.com, linux-csky@vger.kernel.org
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Message-ID: <20190722163811.GJ60625@arrakis.emea.arm.com>
References: <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
 <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
 <20190621141606.GF18954@arrakis.emea.arm.com>
 <CAJF2gTTVUToRkRtxTmtWDotMGXy5YQCpL1h_2neTBuN3e6oz1w@mail.gmail.com>
 <20190624153820.GH29120@arrakis.emea.arm.com>
 <CAJF2gTRUzHUNV+nzECUp5n2L1akdy=Aovb6tSd+PNVnpasBrqw@mail.gmail.com>
 <20190701091711.GA21774@arrakis.emea.arm.com>
 <CAJF2gTTEbhA-pZCPGuUNqXT9F-vk8fSTyNJyEOpn=QE=toAN3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTEbhA-pZCPGuUNqXT9F-vk8fSTyNJyEOpn=QE=toAN3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:31:27AM +0800, Guo Ren wrote:
> I saw arm64 to prevent speculation by temporarily setting TTBR0.el1 to
> a zero page table. Is that used to prevent speculative execution user
> space code or just prevent ld/st in copy_use_* ?

Only to prevent explicit ld/st from user. On ARMv8.1+, we don't normally
use the TTBR0 trick but rather disable user space access using the PAN
(privileged access never) feature. However, I don't think PAN disables
speculative accesses, only explicit loads/stores. Also, with ARMv8.2
Linux uses the LDTR/STTR instructions in copy_*_user() which don't need
to disable PAN explicitly.

-- 
Catalin
