Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99141C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BDC206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TXDAbmFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfKMX7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 18:59:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35449 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKMX7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:59:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so1780182plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 15:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fcw08UdydcvsBJmNfaE5FpkGaI0X2SeWT3anjJAfAKM=;
        b=TXDAbmFVx2zasHsFzlzjLg5kgTeaVsTOBSm6VeBwYgC+P7/JSrsktbX/BnEqZH2O3F
         sux1RGcAj+uXT0++vAQ7riu0JZoYpR/hiU8Hy6DZvB5YIQJWJdtpVjwviLW6o91Er2y7
         ak3pV81rFssj+Y+VYiAkkgwqp702+41gMgWVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fcw08UdydcvsBJmNfaE5FpkGaI0X2SeWT3anjJAfAKM=;
        b=CmfjMhtJPNG6pX7OJkYDYCFlDAddANub09rrV6aVjPtNhbKe3LfMnsLB1dBCtwPXVH
         9yUnk1drJ/+ehx7xL0gqdHAv8Vw4Yas5JBncQm/fqCbrIZJQRBxf7tvfanhPQuM1kpXo
         o828sSezcpktWHBX2Xtt97MUbMHt4IP39Hv8T0ZRwaL8R+Wl1KmV4UookzcKS6REp/4j
         kzTyr+kxnBANLlECpPIZkWYdBnP663vhCHaBCRUD5gtYIdJftGrCS4s3pTIxtaBSA4Pw
         zKVfQ0BRoQjvcynq9lrdbjdZM/iV6OGE+QGyfOVBfcn/+dBdfUMvRmXyy1VNpC6pzm6W
         wzsQ==
X-Gm-Message-State: APjAAAWtEOoVV6hmoSwWGI6YYsGJRArpYRxlieZG6NpC9TslZHYTQH0J
        vKzaQ8DK42NaaTH8CiWj92Q5bQ==
X-Google-Smtp-Source: APXvYqyyS2FgcbZZ3sGfsCc6CoXEX+xq0Gn2MsjtiS3pJ4j4FZLldhyWWZWT4BnRzAIjyfnb/BMsew==
X-Received: by 2002:a17:902:8c90:: with SMTP id t16mr6793961plo.56.1573689570027;
        Wed, 13 Nov 2019 15:59:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12sm4577095pfk.188.2019.11.13.15.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 15:59:28 -0800 (PST)
Date:   Wed, 13 Nov 2019 15:59:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH] sparc: vdso: fix build error of vdso32
Message-ID: <201911131558.6B0778229@keescook>
References: <20190922113436.10396-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922113436.10396-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 08:34:36PM +0900, Masahiro Yamada wrote:
> Since commit 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to
> take the path relative to $(obj)"), sparc allmodconfig fails to build
> as follows:
> 
>   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> 
> The cause of the breakage is that -pg flag not being dropped.
> 
> The vdso32 files are located in the vdso32/ subdirectory, but I missed
> to update the Makefile.
> 
> Fixes: 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I've tripped over this as well. Since no one has picked this up, can you
take it via your tree Masahiro?

Thanks!

-Kees

> ---
> 
>  arch/sparc/vdso/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 324a23947585..399bc22b1cf8 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -67,12 +67,14 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS
>  #
>  CFLAGS_REMOVE_vdso-note.o = -pg
>  CFLAGS_REMOVE_vclock_gettime.o = -pg
> +CFLAGS_REMOVE_vdso32/vdso-note.o = -pg
> +CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
>  
>  $(obj)/%.so: OBJCOPYFLAGS := -S
>  $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  	$(call if_changed,objcopy)
>  
> -CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> +CPPFLAGS_vdso32/vdso32.lds = $(CPPFLAGS_vdso.lds)
>  VDSO_LDFLAGS_vdso32.lds = -m elf32_sparc -soname linux-gate.so.1
>  
>  #This makes sure the $(obj) subdirectory exists even though vdso32/
> -- 
> 2.17.1
> 

-- 
Kees Cook
