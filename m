Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B546EC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879E5222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="D6yOqaUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfIZJZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:25:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49252 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfIZJZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:25:39 -0400
Received: from zn.tnic (p200300EC2F0C9800992DDCE9E55F1A04.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9800:992d:dce9:e55f:1a04])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE8811EC094F;
        Thu, 26 Sep 2019 11:25:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569489938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VnE/VlUp8h2C1JoQATvm8iWZZ7VVi4HUx14Dgj9smtk=;
        b=D6yOqaUaRPqkdfDg84pnxqjaIGzu3y0chmKbaJY7Swn3UIqBuZFip4JMMqORyHD+tQ+y68
        wYjSzG74WJznNJ2PVi5RMiSk1lXwpm1DoccxIIGdMRqosyJVfi7cFGqm/cs81i+2N45tTc
        ASMEutLmzUNWTp5ak+ztI7T7L9k8j1o=
Date:   Thu, 26 Sep 2019 11:25:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ross Burton <ross.burton@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86/boot: use prefix map to avoid embedded paths
Message-ID: <20190926092530.GA18383@zn.tnic>
References: <20190926091132.3845-1-ross.burton@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926091132.3845-1-ross.burton@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't forget to CC: lkml and x86@kernel.org on x86 patches.

On Thu, Sep 26, 2019 at 10:11:32AM +0100, Ross Burton wrote:
> From: Bruce Ashfield <bruce.ashfield@gmail.com>
> 
> It was observed that the kernel embeds the path in the x86 boot
> artifacts.
> 
> From https://bugzilla.yoctoproject.org/show_bug.cgi?id=13458:
> 
> [
>    If you turn on the buildpaths QA test, or try a reproducible build, you
>    discover that the kernel image contains build paths.
> 
>    $ strings bzImage-5.0.19-yocto-standard |grep tmp/
>    out of pgt_buf in
>    /data/poky-tmp/reproducible/tmp/work-shared/qemux86-64/kernel-source/arch/x86/boot/compressed/kaslr_64.c!?
> 
>    But what's this in the top-level Makefile:
> 
>    $ git grep prefix-map
>    Makefile:KBUILD_CFLAGS  += $(call
>    cc-option,-fmacro-prefix-map=$(srctree)/=)
> 
>    So the __FILE__ shouldn't be using the full path.  However
>    arch/x86/boot/compressed/Makefile has this:
> 
>    KBUILD_CFLAGS := -m$(BITS) -O2
> 
>    So that clears KBUILD_FLAGS, removing the -fmacro-prefix-map option.
> ]
> 
> Other architectures do not clear the flags, but instead prune before
> adding boot or specific options. There's no obvious reason why x86 isn't
> doing the same thing (pruning vs clearing) and no build or boot issues
> have been observed.
> 
> So we make x86 can do the same thing, and we no longer have embedded paths.
> 
> Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> Signed-off-by: Ross Burton <ross.burton@intel.com>
> ---
>  arch/x86/boot/compressed/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 6b84afdd7538..b246f18c5857 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -38,6 +38,7 @@ KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
>  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
> +KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  GCOV_PROFILE := n
> -- 

What about arch/x86/boot/Makefile ?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
