Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBDFC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E19822ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfGXOHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:07:41 -0400
Received: from foss.arm.com ([217.140.110.172]:41662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfGXOHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:07:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 449AE28;
        Wed, 24 Jul 2019 07:07:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7DA53F71A;
        Wed, 24 Jul 2019 07:07:37 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:07:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Price <steven.price@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
Message-ID: <20190724140735.GD2624@lakrids.cambridge.arm.com>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190723101639.GD8085@lakrids.cambridge.arm.com>
 <e108b8a6-deca-e69c-b338-52a98b14be86@arm.com>
 <alpine.DEB.2.21.1907241541570.1791@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907241541570.1791@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 03:57:33PM +0200, Thomas Gleixner wrote:
> On Wed, 24 Jul 2019, Steven Price wrote:
> > On 23/07/2019 11:16, Mark Rutland wrote:
> > > Are there any visible changes to the arm64 output?
> > 
> > arm64 output shouldn't change. I've confirmed that "efi_page_tables" is
> > identical on a Juno before/after the change. "kernel_page_tables"
> > obviously will vary depending on the exact layout of memory, but the
> > format isn't changed.
> > 
> > x86 output does change due to patch 14. In this case the change is
> > removing the lines from the output of the form...
> > 
> > > 0xffffffff84800000-0xffffffffa0000000         440M                               pmd
> > 
> > ...which are unpopulated areas of the memory map. Populated lines which
> > have attributes are unchanged.
> 
> Having the hole size and the level in the dump is a very conveniant thing.

Mhmm; I thought that we logged which level was empty on arm64 (but
apparently not), since knowing the structure can be important.

> Right now we have:
> 
> 0xffffffffc0427000-0xffffffffc042b000          16K     ro                     NX pte
> 0xffffffffc042b000-0xffffffffc042e000          12K     RW                     NX pte
> 0xffffffffc042e000-0xffffffffc042f000           4K                               pte
> 0xffffffffc042f000-0xffffffffc0430000           4K     ro                     x  pte
> 0xffffffffc0430000-0xffffffffc0431000           4K     ro                     NX pte
> 0xffffffffc0431000-0xffffffffc0433000           8K     RW                     NX pte
> 0xffffffffc0433000-0xffffffffc0434000           4K                               pte
> 0xffffffffc0434000-0xffffffffc0436000           8K     ro                     x  pte
> 0xffffffffc0436000-0xffffffffc0438000           8K     ro                     NX pte
> 0xffffffffc0438000-0xffffffffc043a000           8K     RW                     NX pte
> 0xffffffffc043a000-0xffffffffc043f000          20K                               pte
> 0xffffffffc043f000-0xffffffffc0444000          20K     ro                     x  pte
> 0xffffffffc0444000-0xffffffffc0447000          12K     ro                     NX pte
> 0xffffffffc0447000-0xffffffffc0449000           8K     RW                     NX pte
> 0xffffffffc0449000-0xffffffffc044f000          24K                               pte
> 0xffffffffc044f000-0xffffffffc0450000           4K     ro                     x  pte
> 0xffffffffc0450000-0xffffffffc0451000           4K     ro                     NX pte
> 0xffffffffc0451000-0xffffffffc0453000           8K     RW                     NX pte
> 0xffffffffc0453000-0xffffffffc0458000          20K                               pte
> 0xffffffffc0458000-0xffffffffc0459000           4K     ro                     x  pte
> 0xffffffffc0459000-0xffffffffc045b000           8K     ro                     NX pte
> 
> with your change this becomes:
> 
> 0xffffffffc0427000-0xffffffffc042b000          16K     ro                     NX pte
> 0xffffffffc042b000-0xffffffffc042e000          12K     RW                     NX pte
> 0xffffffffc042f000-0xffffffffc0430000           4K     ro                     x  pte
> 0xffffffffc0430000-0xffffffffc0431000           4K     ro                     NX pte
> 0xffffffffc0431000-0xffffffffc0433000           8K     RW                     NX pte
> 0xffffffffc0434000-0xffffffffc0436000           8K     ro                     x  pte
> 0xffffffffc0436000-0xffffffffc0438000           8K     ro                     NX pte
> 0xffffffffc0438000-0xffffffffc043a000           8K     RW                     NX pte
> 0xffffffffc043f000-0xffffffffc0444000          20K     ro                     x  pte
> 0xffffffffc0444000-0xffffffffc0447000          12K     ro                     NX pte
> 0xffffffffc0447000-0xffffffffc0449000           8K     RW                     NX pte
> 0xffffffffc044f000-0xffffffffc0450000           4K     ro                     x  pte
> 0xffffffffc0450000-0xffffffffc0451000           4K     ro                     NX pte
> 0xffffffffc0451000-0xffffffffc0453000           8K     RW                     NX pte
> 0xffffffffc0458000-0xffffffffc0459000           4K     ro                     x  pte
> 0xffffffffc0459000-0xffffffffc045b000           8K     ro                     NX pte
> 
> which is 5 lines less, but a pain to figure out the size of the holes. And
> it becomes even more painful when the holes go across different mapping
> levels.

I agree.

Steven, could you align arm64 with the x86 behaviour here?

Thanks,
Mark.
