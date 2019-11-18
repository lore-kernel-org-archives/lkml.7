Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36305C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091BC20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="daNUb7ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKROgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:36:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34288 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfKROgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:36:01 -0500
Received: from zn.tnic (p200300EC2F27B50084A11D83797EBEC7.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b500:84a1:1d83:797e:bec7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 16D581EC05DE;
        Mon, 18 Nov 2019 15:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574087760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HIiagHNihEtq/23FNusQiNOrZ2Lv80N9XpOGmMlnIl0=;
        b=daNUb7ullbGMCWEXX6RLx4v+dpu7G4yTHbPJSUREkpYiXbffE2QidsmrcpVRNUo0PVyqT1
        1xJGGmawPcNnQEvBD+Vam0RBTCnq/EF6GpdfgDRamb7c7s6e3IORqooOnK3yXuiLIOh9WY
        JcR8xQsovJLCTJOlPvRUNaCvQJfmZks=
Date:   Mon, 18 Nov 2019 15:35:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH V2] x86/boot: explicitly place .eh_frame after .rodata
Message-ID: <20191118143553.GD6363@zn.tnic>
References: <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
 <20191106120629.28423-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106120629.28423-1-ilie.halip@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:06:28PM +0200, Ilie Halip wrote:
> When using GCC as compiler and LLVM's lld as linker, linking
> setup.elf fails:
>       LD      arch/x86/boot/setup.elf
>     ld.lld: error: init sections too big!
> 
> This happens because ld.lld has different rules for placing
> orphan sections (i.e. sections not mentioned in a linker script)
> compared to ld.bfd.
> 
> Particularly, in this case, the merged .eh_frame section is
> placed before __end_init, which triggers an assert in the script.
> 
> Explicitly place this section after .rodata, in accordance with
> ld.bfd's behavior.
> 
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/760
> ---
> 
> Changes in V2:
>  * removed wildcard for input sections (.eh_frame* -> .eh_frame)
> 
>  arch/x86/boot/setup.ld | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> index 0149e41d42c2..30ce52635cd0 100644
> --- a/arch/x86/boot/setup.ld
> +++ b/arch/x86/boot/setup.ld
> @@ -25,6 +25,7 @@ SECTIONS
>  
>  	. = ALIGN(16);
>  	.rodata		: { *(.rodata*) }
> +	.eh_frame	: { *(.eh_frame) }

The kernel proper linker script does

        /DISCARD/ : {
                *(.eh_frame)
        }

with the .eh_frame section.

Wouldn't that solve your issue too, if you add it to the /DISCARD/
section in that linker script too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
