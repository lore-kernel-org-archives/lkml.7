Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBB9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFA820862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eOjdoTjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEOQUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:20:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34671 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:20:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so45354pgt.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vxHUVksygZiYkXH7EV0n/tRcr/H+bm78G99yEMzAC34=;
        b=eOjdoTjIr7ZKEcMSweuwLNwpjohCU1Fle2gxgWUpyAalIZ/ql6lUMO77yOY5/vhCIO
         YE1CR84RdwgQG5Dh5j/DQz185eopcu0OlZNuRSKh5fL4+uvczJhXSauFP8KMb/7Fcj3e
         6CKPoR99xDgfW+S+6DPCEgWpjb1VaompxR+d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vxHUVksygZiYkXH7EV0n/tRcr/H+bm78G99yEMzAC34=;
        b=CBxtgeN9ntzi2I7DAY5Rbd8fzgbT72xaZRze+j1JoDc3uqFQloh551phgHrQRPHjPY
         2C3YCYU3MkR9LVMJjTuroo3oTinPP2XcDbdtF3Oxkxf9KuorRwoYyBWGOhgCQYP2nfBk
         GniJn9XJFINw4mt4ZVuBBmc/YNnfjCrOGQPOfHF+RNdnN/ml+AVnjGwW0yhCQU8LPdgR
         Qj0kcuoX1knQAnfd+cW161Oa+iwfgEDc3+uyoiuEJ2yM56nxOKp6r5XSthrnQdP4jA4w
         izZz815Lq2U1R9OVq3/rAYB4+QFmwGNrtiUjL+/7HL06wNEi09KI98i0yEAej3Jusebe
         Qdhw==
X-Gm-Message-State: APjAAAWaIGiKDGk3WXTFzwBggF7//gsbC2ZhJWapbHjX6+ksZviwIiLn
        cLFxi6jni6K7NwEPLKqntTipSA==
X-Google-Smtp-Source: APXvYqxwKoY4ccQy0b/mDdBdzxSTzpQZnxktZIFccXEfZLFafGV8L/NnbJ4+g5GgogH5itIlxvlNlQ==
X-Received: by 2002:a62:460a:: with SMTP id t10mr46735334pfa.3.1557937223106;
        Wed, 15 May 2019 09:20:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t26sm3049004pgk.62.2019.05.15.09.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 09:20:21 -0700 (PDT)
Date:   Wed, 15 May 2019 09:20:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kbuild: check uniqueness of basename of modules
Message-ID: <201905150913.C23BD99AD@keescook>
References: <20190515073818.22486-1-yamada.masahiro@socionext.com>
 <CAK7LNAQgBKq9JDGtQUD1kgKrfLZ4jOjuLJi7_tpSPLJZsWtmag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQgBKq9JDGtQUD1kgKrfLZ4jOjuLJi7_tpSPLJZsWtmag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 04:53:15PM +0900, Masahiro Yamada wrote:
> On Wed, May 15, 2019 at 4:40 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > In the recent build test of linux-next, Stephen saw a build error
> > caused by a broken .tmp_versions/*.mod file:
> >
> >   https://lkml.org/lkml/2019/5/13/991
> >
> > drivers/net/phy/asix.ko and drivers/net/usb/asix.ko have the same
> > basename, and there is a race in generating .tmp_versions/asix.mod
> >
> > Kbuild has not checked this before, and it occasionally shows up with
> > obscure error message when this kind of race occurs.
> >
> > It is not trivial to catch this potential issue by eyes.
> >
> > Hence, this script.
> >
> > I compile-tested allmodconfig for the latest kernel as of writing,
> > it detected the following:
> >
> > warning: same basename '88pm800.ko' if the following are built as modules:
> >   drivers/regulator/88pm800.ko
> >   drivers/mfd/88pm800.ko
> > warning: same basename 'adv7511.ko' if the following are built as modules:
> >   drivers/gpu/drm/bridge/adv7511/adv7511.ko
> >   drivers/media/i2c/adv7511.ko
> > warning: same basename 'asix.ko' if the following are built as modules:
> >   drivers/net/phy/asix.ko
> >   drivers/net/usb/asix.ko
> > warning: same basename 'coda.ko' if the following are built as modules:
> >   fs/coda/coda.ko
> >   drivers/media/platform/coda/coda.ko
> > warning: same basename 'realtek.ko' if the following are built as modules:
> >   drivers/net/phy/realtek.ko
> >   drivers/net/dsa/realtek.ko
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> 
> > diff --git a/scripts/modules-check.sh b/scripts/modules-check.sh
> > new file mode 100755
> > index 000000000000..944e68bd22b0
> > --- /dev/null
> > +++ b/scripts/modules-check.sh
> > @@ -0,0 +1,18 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# Warn if two or more modules have the same basename
> > +check_same_name_modules()
> > +{
> > +       same_name_modules=$(cat modules.order modules.builtin | \
> > +                               xargs basename -a | sort | uniq -d)

While probably it'll never be a problem, just for robustness, I'd add "--"
to the end basename to terminate argument interpretation:

    xargs basename -a -- | sort | ...

> > +
> > +       for m in $same_name_modules
> > +       do
> > +               echo "warning: same basename '$m' if the following are built as modules:"
> > +               grep --no-filename -e /$m modules.order modules.builtin | \
> > +                                                       sed 's:^kernel/:  :'
> 
> 
> Self nit-picking:
> It might be better to send these messages to stderr instead of stdout.

Yeah, wrapping a ">&2" around the report would be good. With these fixes:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
