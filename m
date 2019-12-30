Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C2C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE74E2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VhyEFlYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfL3Tlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:41:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42977 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3Tlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:41:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so47415587otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PkkLXDj8HeyoAsXSUf7EB7C7ycPCZ7nOePq2CDe6W7A=;
        b=VhyEFlYR+ibRZhAU/Zlt2WaACOPEq9e9Vua53F8j4jJDylYSIMjRh8PTNivSdiOxNH
         GsF4EZ4lDP4c63w3DIq6yAiRMC7U2Wjn4E1OYu9+mjH50XgD09xcHuyi4vW53UbRh0Si
         PcAeooP0hmoYMydJKlP+uyiavUfPJ6ELFhEAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PkkLXDj8HeyoAsXSUf7EB7C7ycPCZ7nOePq2CDe6W7A=;
        b=fUXYVEp8NX45b3jRhIn26V/Nd6WUkD3M6zodLNrN/nLnV7uzHIqix1c4ekjkY1gR6B
         90V6NVFlQ3i0Tq9HrAwQfmZZ12Qzt5N+9LcpbcM9ORjlfZVjJFEgPT4EU/oXIXYEIvYh
         VOzt64vE272561XNRERrENGOYZ7UjVUxzJsPHhS+YohSsDvPkpcylhHOmyGEvHYFFs0Z
         BKUd3zwOXzRuUyfGlm2rnhXW5JhllpKEh5i0bmi2e9FozFWm6AYmner/54O8YMCxOYtk
         7TirpReLGbxyTP6tfsEtnlTGjd+ck/X8qC4PZSrk1laAhjzOSDGsSwSPjnXpnLv3nYxK
         YlVw==
X-Gm-Message-State: APjAAAVlb1uPYooIBzSZ25+UAcGkrFD2Vev8DjCZpUtdsRjOfpije2p+
        fVdr/UU7l8y0z2bHp8mc4z3CNw==
X-Google-Smtp-Source: APXvYqzVpx3dL/tLel5sEMYXF+VVdZW9N+hNBFJ6GOs9NKyDtNGyXnUBHxnP/VH+O2xwue27dLhq5A==
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr73720379otq.134.1577734906535;
        Mon, 30 Dec 2019 11:41:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k17sm14025460oic.45.2019.12.30.11.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:41:45 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:41:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Emese Revfy <re.emese@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] gcc-plugins: make it possible to disable
 CONFIG_GCC_PLUGINS again
Message-ID: <201912301141.38C6F7E0@keescook>
References: <20191211133951.401933-1-arnd@arndb.de>
 <CAK7LNASeyPxgQczSvEN4S3Ae7fRtYyynhU9kJ=96VX34S4TECA@mail.gmail.com>
 <CAK8P3a1dH+msCgxU-=w4gp30Bw+x3=6Cj473DuFzxun+3dfOcA@mail.gmail.com>
 <201912120943.486E507@keescook>
 <CAK7LNAQKuyyC-bjSZ=8bhkd1PHjRa-LDEsZra_tFdYbL7X-Azw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQKuyyC-bjSZ=8bhkd1PHjRa-LDEsZra_tFdYbL7X-Azw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 05:56:34PM +0900, Masahiro Yamada wrote:
> On Fri, Dec 13, 2019 at 2:44 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Dec 12, 2019 at 10:59:40AM +0100, Arnd Bergmann wrote:
> > > On Thu, Dec 12, 2019 at 5:52 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 11, 2019 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > >
> > > > > I noticed that randconfig builds with gcc no longer produce a lot of
> > > > > ccache hits, unlike with clang, and traced this back to plugins
> > > > > now being enabled unconditionally if they are supported.
> > > > >
> > > > > I am now working around this by adding
> > > > >
> > > > >    export CCACHE_COMPILERCHECK=/usr/bin/size -A %compiler%
> > > > >
> > > > > to my top-level Makefile. This changes the heuristic that ccache uses
> > > > > to determine whether the plugins are the same after a 'make clean'.
> > > > >
> > > > > However, it also seems that being able to just turn off the plugins is
> > > > > generally useful, at least for build testing it adds noticeable overhead
> > > > > but does not find a lot of bugs additional bugs, and may be easier for
> > > > > ccache users than my workaround.
> > > > >
> > > > > Fixes: 9f671e58159a ("security: Create "kernel hardening" config area")
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > > On Wed, Dec 11, 2019 at 2:59 PM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Thanks! Who would be the best person to pick up the patch?
> > > Should I send it to Andrew?
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > I can take it in my tree, or I'm happy to have Masahiro take it.
> >
> > --
> > Kees Cook
> 
> Kees,
> Please apply it to your tree.

Thanks, applied!

-- 
Kees Cook
