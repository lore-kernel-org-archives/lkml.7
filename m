Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C412C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17F921582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IHzJ0A0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLRAIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:08:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41522 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLRAIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:08:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so201836pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=da4hM4UJKgmO9iz3pXI2WshcEvtAp8fX82/geQVC7e0=;
        b=IHzJ0A0SVCJT2wgdRYnqM2827VaTp+bAXqjahUxWIakErH8H4u3BP8b0EC2opmBBP/
         zLgd/VEbimeoyZc9352qbSIanJqf1ICFPxO03lC2eDAprzihhwmC/rgNiFc/JIXuVZ/n
         jLkjlNMeGdOonrQIV5NUsTbwCMGflwi+FBnOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=da4hM4UJKgmO9iz3pXI2WshcEvtAp8fX82/geQVC7e0=;
        b=qpAkKr5OcDXwyyIRdwHCSA4dHXfi43JaJZ7R/tS2yceqcuUoqYeWH2ha2plfpjYckC
         zO1IUWPaKLwgYSJWtM2lDCFFZVwCyb5owXs/4KRRgNqOP2uTD63hTvHRsTpzRCgzpf+e
         lkLXTe8BjPl+diQcXc2+TGdWIzHQrJmcRSiknU8H9ki/mhS6t5hmCH2EUn5qSxbD1jJW
         VTgQXZXDssekvbUiftnKB5IPFvdaiLanAu85t0AEeuQxvW0kPUtQiqyFTq7wbgP+ZgsS
         yPGMPEhMtfGHPWYZXVgzTJfCHlG9iqlwMolVmQ8Qj++kQyNT5aAGTujOLohrW1uzpRSu
         w/Fw==
X-Gm-Message-State: APjAAAXMlSFylXQ25heaJvnabkJsn9Ud4WvW3an67S/EDhoJEkCNMhCn
        zUzyqbWfs/Xjh/HwPiko8+M4/g==
X-Google-Smtp-Source: APXvYqz8C5J4J9eWBQPXjg7+Paw02BtPeFdFGP5+iOGrZw/IMiECgcViQ8/ErKBABJ5diMLnc2/CaA==
X-Received: by 2002:aa7:98d0:: with SMTP id e16mr457396pfm.77.1576627684350;
        Tue, 17 Dec 2019 16:08:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t11sm77450pjf.30.2019.12.17.16.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:08:03 -0800 (PST)
Date:   Tue, 17 Dec 2019 16:08:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 1/3] ubsan: Add trap instrumentation option
Message-ID: <201912171607.73EE8133@keescook>
References: <20191121181519.28637-1-keescook@chromium.org>
 <20191121181519.28637-2-keescook@chromium.org>
 <20191216102655.GA11082@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216102655.GA11082@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:26:56AM +0000, Will Deacon wrote:
> Hi Kees,
> 
> On Thu, Nov 21, 2019 at 10:15:17AM -0800, Kees Cook wrote:
> > The Undefined Behavior Sanitizer can operate in two modes: warning
> > reporting mode via lib/ubsan.c handler calls, or trap mode, which uses
> > __builtin_trap() as the handler. Using lib/ubsan.c means the kernel
> > image is about 5% larger (due to all the debugging text and reporting
> > structures to capture details about the warning conditions). Using the
> > trap mode, the image size changes are much smaller, though at the loss
> > of the "warning only" mode.
> > 
> > In order to give greater flexibility to system builders that want
> > minimal changes to image size and are prepared to deal with kernel code
> > being aborted and potentially destabilizing the system, this introduces
> > CONFIG_UBSAN_TRAP. The resulting image sizes comparison:
> > 
> >    text    data     bss       dec       hex     filename
> > 19533663   6183037  18554956  44271656  2a38828 vmlinux.stock
> > 19991849   7618513  18874448  46484810  2c54d4a vmlinux.ubsan
> > 19712181   6284181  18366540  44362902  2a4ec96 vmlinux.ubsan-trap
> > 
> > CONFIG_UBSAN=y:      image +4.8% (text +2.3%, data +18.9%)
> > CONFIG_UBSAN_TRAP=y: image +0.2% (text +0.9%, data +1.6%)
> > 
> > Additionally adjusts the CONFIG_UBSAN Kconfig help for clarity and
> > removes the mention of non-existing boot param "ubsan_handle".
> > 
> > Suggested-by: Elena Petrova <lenaptr@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  lib/Kconfig.ubsan      | 22 ++++++++++++++++++----
> >  lib/Makefile           |  2 ++
> >  scripts/Makefile.ubsan |  9 +++++++--
> >  3 files changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > index 0e04fcb3ab3d..9deb655838b0 100644
> > --- a/lib/Kconfig.ubsan
> > +++ b/lib/Kconfig.ubsan
> > @@ -5,11 +5,25 @@ config ARCH_HAS_UBSAN_SANITIZE_ALL
> >  config UBSAN
> >  	bool "Undefined behaviour sanity checker"
> >  	help
> > -	  This option enables undefined behaviour sanity checker
> > +	  This option enables the Undefined Behaviour sanity checker.
> >  	  Compile-time instrumentation is used to detect various undefined
> > -	  behaviours in runtime. Various types of checks may be enabled
> > -	  via boot parameter ubsan_handle
> > -	  (see: Documentation/dev-tools/ubsan.rst).
> > +	  behaviours at runtime. For more details, see:
> > +	  Documentation/dev-tools/ubsan.rst
> > +
> > +config UBSAN_TRAP
> > +	bool "On Sanitizer warnings, abort the running kernel code"
> > +	depends on UBSAN
> > +	depends on $(cc-option, -fsanitize-undefined-trap-on-error)
> > +	help
> > +	  Building kernels with Sanitizer features enabled tends to grow
> > +	  the kernel size by around 5%, due to adding all the debugging
> > +	  text on failure paths. To avoid this, Sanitizer instrumentation
> > +	  can just issue a trap. This reduces the kernel size overhead but
> > +	  turns all warnings (including potentially harmless conditions)
> > +	  into full exceptions that abort the running kernel code
> > +	  (regardless of context, locks held, etc), which may destabilize
> > +	  the system. For some system builders this is an acceptable
> > +	  trade-off.
> 
> Slight nit, but I wonder if it would make sense to move all this under a
> 'menuconfig UBSAN' entry, so the dependencies can be dropped? Then you could
> have all of the suboptions default to on and basically choose which
> individual compiler options to disable based on your own preferences.

Sure; I can do that. I'll respin the series.

-- 
Kees Cook
