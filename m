Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2CDC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C92A21BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfGXN5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:57:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfGXN5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:57:39 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqHlu-0001CA-H9; Wed, 24 Jul 2019 15:57:34 +0200
Date:   Wed, 24 Jul 2019 15:57:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Price <steven.price@arm.com>
cc:     Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?ISO-8859-15?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
In-Reply-To: <e108b8a6-deca-e69c-b338-52a98b14be86@arm.com>
Message-ID: <alpine.DEB.2.21.1907241541570.1791@nanos.tec.linutronix.de>
References: <20190722154210.42799-1-steven.price@arm.com> <20190723101639.GD8085@lakrids.cambridge.arm.com> <e108b8a6-deca-e69c-b338-52a98b14be86@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019, Steven Price wrote:
> On 23/07/2019 11:16, Mark Rutland wrote:
> > Are there any visible changes to the arm64 output?
> 
> arm64 output shouldn't change. I've confirmed that "efi_page_tables" is
> identical on a Juno before/after the change. "kernel_page_tables"
> obviously will vary depending on the exact layout of memory, but the
> format isn't changed.
> 
> x86 output does change due to patch 14. In this case the change is
> removing the lines from the output of the form...
> 
> > 0xffffffff84800000-0xffffffffa0000000         440M                               pmd
> 
> ...which are unpopulated areas of the memory map. Populated lines which
> have attributes are unchanged.

Having the hole size and the level in the dump is a very conveniant thing.

Right now we have:

0xffffffffc0427000-0xffffffffc042b000          16K     ro                     NX pte
0xffffffffc042b000-0xffffffffc042e000          12K     RW                     NX pte
0xffffffffc042e000-0xffffffffc042f000           4K                               pte
0xffffffffc042f000-0xffffffffc0430000           4K     ro                     x  pte
0xffffffffc0430000-0xffffffffc0431000           4K     ro                     NX pte
0xffffffffc0431000-0xffffffffc0433000           8K     RW                     NX pte
0xffffffffc0433000-0xffffffffc0434000           4K                               pte
0xffffffffc0434000-0xffffffffc0436000           8K     ro                     x  pte
0xffffffffc0436000-0xffffffffc0438000           8K     ro                     NX pte
0xffffffffc0438000-0xffffffffc043a000           8K     RW                     NX pte
0xffffffffc043a000-0xffffffffc043f000          20K                               pte
0xffffffffc043f000-0xffffffffc0444000          20K     ro                     x  pte
0xffffffffc0444000-0xffffffffc0447000          12K     ro                     NX pte
0xffffffffc0447000-0xffffffffc0449000           8K     RW                     NX pte
0xffffffffc0449000-0xffffffffc044f000          24K                               pte
0xffffffffc044f000-0xffffffffc0450000           4K     ro                     x  pte
0xffffffffc0450000-0xffffffffc0451000           4K     ro                     NX pte
0xffffffffc0451000-0xffffffffc0453000           8K     RW                     NX pte
0xffffffffc0453000-0xffffffffc0458000          20K                               pte
0xffffffffc0458000-0xffffffffc0459000           4K     ro                     x  pte
0xffffffffc0459000-0xffffffffc045b000           8K     ro                     NX pte

with your change this becomes:

0xffffffffc0427000-0xffffffffc042b000          16K     ro                     NX pte
0xffffffffc042b000-0xffffffffc042e000          12K     RW                     NX pte
0xffffffffc042f000-0xffffffffc0430000           4K     ro                     x  pte
0xffffffffc0430000-0xffffffffc0431000           4K     ro                     NX pte
0xffffffffc0431000-0xffffffffc0433000           8K     RW                     NX pte
0xffffffffc0434000-0xffffffffc0436000           8K     ro                     x  pte
0xffffffffc0436000-0xffffffffc0438000           8K     ro                     NX pte
0xffffffffc0438000-0xffffffffc043a000           8K     RW                     NX pte
0xffffffffc043f000-0xffffffffc0444000          20K     ro                     x  pte
0xffffffffc0444000-0xffffffffc0447000          12K     ro                     NX pte
0xffffffffc0447000-0xffffffffc0449000           8K     RW                     NX pte
0xffffffffc044f000-0xffffffffc0450000           4K     ro                     x  pte
0xffffffffc0450000-0xffffffffc0451000           4K     ro                     NX pte
0xffffffffc0451000-0xffffffffc0453000           8K     RW                     NX pte
0xffffffffc0458000-0xffffffffc0459000           4K     ro                     x  pte
0xffffffffc0459000-0xffffffffc045b000           8K     ro                     NX pte

which is 5 lines less, but a pain to figure out the size of the holes. And
it becomes even more painful when the holes go across different mapping
levels.

From your 14/N changelog:

> This keeps the output shorter and will help with a future change

I don't care about shorter at all. It's debug information.

> switching to using the generic page walk code as we no longer care about
> the 'level' that the page table holes are at.

I really do not understand why you think that WE no longer care about the
level (and the size) of the holes. I assume that WE is pluralis majestatis
and not meant to reflect the opinion of you and everyone else.

I have no idea whether you ever had to do serious work with PT dump, but I
surely have at various occasions including the PTI mess and I definitely
found the size and the level information from holes very useful.

Thanks,

	tglx





