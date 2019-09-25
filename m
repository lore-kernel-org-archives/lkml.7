Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0954C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43052146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ODZq6RdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502189AbfIYRK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:10:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437796AbfIYRKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:10:25 -0400
Received: from zn.tnic (p200300EC2F0BA100707709EB32B84CF4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:a100:7077:9eb:32b8:4cf4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 342BB1EC0A91;
        Wed, 25 Sep 2019 19:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569431424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mla4nxBtIg9/feNWHEP9qZqx4jpzG38YzJe1TshTJgU=;
        b=ODZq6RdWydjhNWwG0+WZCOT+YrLNPtB+Foj1KfPnS1mPdzx3S7tiuxDKCkx4KDbmPiQq5/
        wRFACbE+3vtapDpE1Mb7fpwuLLDDeyK2uSUs/qw5Yp2LJCH/hhDvWpheu1z9IpHVxXqaFz
        GR3PzEdy1Ccfb5TtTum3HC6LnlKdkI4=
Date:   Wed, 25 Sep 2019 19:10:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Tri Vo <trong@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        George Rimar <grimar@accesssoftek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <Peter.Smith@arm.com>, Rui Ueyama <ruiu@google.com>
Subject: Re: [PATCH v2] x86, realmode: explicitly set entry via command line
Message-ID: <20190925171025.GF3891@zn.tnic>
References: <CAKwvOdmFqPSyeKn-0th_ca9B3QU63G__kEJ=X0tfjhE+1_p=FQ@mail.gmail.com>
 <20190924193310.132104-1-ndesaulniers@google.com>
 <20190925102041.GB3891@zn.tnic>
 <CAKwvOdneE7kMupFzxZC-6c=ps_98FP+Nz88fCXQ74z90hmaaXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdneE7kMupFzxZC-6c=ps_98FP+Nz88fCXQ74z90hmaaXQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 09:35:24AM -0700, Nick Desaulniers wrote:
> Thanks for the consideration Boris.  So IIUC if the preceding sections
> are larger than 0x1000 altogether, setting the entry there will be
> wrong?

Well, I spent some time this morning grepping to find out whether PA
0x1000 was magical but didn't find anything. Perhaps hpa can refresh my
memory...

> Currently, .text looks like it's currently at 0x1000 for a defconfig,
> and I assume that could move in the case I stated above?

Yes, I think we shouldn't hardcode.

> $ readelf -S arch/x86/realmode/rm/realmode.elf | grep text
>   [ 3] .text             PROGBITS        00001000 201000 000f51 00  AX
>  0   0 4096
> ...
> 
> In that case, it seems that maybe I should set the ENTRY in the linker
> script as:
> diff --git a/arch/x86/realmode/rm/realmode.lds.S
> b/arch/x86/realmode/rm/realmode.lds.S
> index 3bb980800c58..64d135d1ee63 100644
> --- a/arch/x86/realmode/rm/realmode.lds.S
> +++ b/arch/x86/realmode/rm/realmode.lds.S
> @@ -11,6 +11,7 @@
> 
>  OUTPUT_FORMAT("elf32-i386")
>  OUTPUT_ARCH(i386)
> +ENTRY(pa_text_start)

Well, looking at arch/x86/boot/setup.ld, it does do:

ENTRY(_start)

for the global _start symbol in .../boot/header.S.

So you doing the respective thing in that linker script would make
sense...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
