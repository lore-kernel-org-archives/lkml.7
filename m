Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9081C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5002133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DYvtsrHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfHNQfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:35:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40140 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfHNQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:35:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so53343139pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sgLlHTTuUxU1TwC5AIX4GAGBSYyQo1G2RL+k215Pzxc=;
        b=DYvtsrHoh73ChIryiTu79IhXFnVOAtXr5wkwZiRRnzDdis6DamABae4iW6mpD/Fb/6
         yPGE0qFEUwZOAzpMocMUZV/qSweQ0rHQufN3k5O8RCl9t/lmPwqMziy5+ghKCB7aTm0a
         i7ooEZZpP9E075iTqWpM83ggynQh3YHQjwLcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sgLlHTTuUxU1TwC5AIX4GAGBSYyQo1G2RL+k215Pzxc=;
        b=KMw7XZ/H3n9j9ChSHaKl4YYSX6GI35FQOKP4LTrqHfSVcogRCxympR21MblVhJeagF
         ikxTdNTvC3dgw62YBY7rsNA0+tGAOCEQ5CX3ZCSGxXgki+n57oIAuUWdYEicxTJagB0u
         6ywv6WIrs8UkJXYLlVE6pl16U+HI+CsVFBd9hhuLXSDVgCZ+Vzg99CWEhvW5GQmib5ei
         bXAVwV0vLwjk7R8N2rjg+avsGbHFZIA+QbXwBIDpag6AQ/RO4i9TzuW8biTgn8etYMAd
         jaSD2yg5a9aTBaJABDmoinMHJ/m6HCuYBSG1j/fJfKuc1/XBOJRalBdRIYJUFM1LQ2Bl
         IkEQ==
X-Gm-Message-State: APjAAAUEHuY+8EdF8Nx5tFCgn83RqC2LjFbhzh85+kVRaKJ/HDSSxo2v
        Wa3/kUQLmGhsRSpo34xI5wczJQ==
X-Google-Smtp-Source: APXvYqycw/abNQyrJ20WHTvnYMXT+MiGHrimEtScjwcWEsjxA1Y1OxrMod0D7w4jf+K0gJ5a4ygZ9w==
X-Received: by 2002:a65:49cc:: with SMTP id t12mr57952pgs.83.1565800519967;
        Wed, 14 Aug 2019 09:35:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 3sm261591pfg.186.2019.08.14.09.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 09:35:19 -0700 (PDT)
Date:   Wed, 14 Aug 2019 09:35:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@linaro.org>
Subject: Re: [PATCH] arm64/efi: Move variable assignments after SECTIONS
Message-ID: <201908140934.C3F1F7151E@keescook>
References: <201908131602.6E858DEC@keescook>
 <CAKv+Gu9fEAG3CqmORyO2X_Uqse09nnXEQiB1kTL-xBqLWsy8Xg@mail.gmail.com>
 <20190814161904.55jgaxnhd4ujyh2h@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814161904.55jgaxnhd4ujyh2h@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:19:04PM +0100, Will Deacon wrote:
> On Wed, Aug 14, 2019 at 07:14:42PM +0300, Ard Biesheuvel wrote:
> > On Wed, 14 Aug 2019 at 02:04, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > It seems that LLVM's linker does not correctly handle variable assignments
> > > involving section positions that are updated during the SECTIONS
> > > parsing. Commit aa69fb62bea1 ("arm64/efi: Mark __efistub_stext_offset as
> > > an absolute symbol explicitly") ran into this too, but found a different
> > > workaround.
> > >
> > > However, this was not enough, as other variables were also miscalculated
> > > which manifested as boot failures under UEFI where __efistub__end was
> > > not taking the correct _end value (they should be the same):
> > >
> > > $ ld.lld -EL -maarch64elf --no-undefined -X -shared \
> > >         -Bsymbolic -z notext -z norelro --no-apply-dynamic-relocs \
> > >         -o vmlinux.lld -T poc.lds --whole-archive vmlinux.o && \
> > >   readelf -Ws vmlinux.lld | egrep '\b(__efistub_|)_end\b'
> > > 368272: ffff000002218000     0 NOTYPE  LOCAL  HIDDEN    38 __efistub__end
> > > 368322: ffff000012318000     0 NOTYPE  GLOBAL DEFAULT   38 _end
> > >
> > > $ aarch64-linux-gnu-ld.bfd -EL -maarch64elf --no-undefined -X -shared \
> > >         -Bsymbolic -z notext -z norelro --no-apply-dynamic-relocs \
> > >         -o vmlinux.bfd -T poc.lds --whole-archive vmlinux.o && \
> > >   readelf -Ws vmlinux.bfd | egrep '\b(__efistub_|)_end\b'
> > > 338124: ffff000012318000     0 NOTYPE  LOCAL  DEFAULT  ABS __efistub__end
> > > 383812: ffff000012318000     0 NOTYPE  GLOBAL DEFAULT 15325 _end
> > >
> > > To work around this, all of the __efistub_-prefixed variable assignments
> > > need to be moved after the linker script's SECTIONS entry. As it turns
> > > out, this also solves the problem fixed in commit aa69fb62bea1, so those
> > > changes are reverted here.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/634
> > > Link: https://bugs.llvm.org/show_bug.cgi?id=42990
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Although it is slightly disappointing that we need to work around this
> > kind of bugs when adding support for a new toolchain, I don't see
> > anything wrong with this patch, so
> > 
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Yup, it's gross, but I'll queue it with your ack.

Thanks, and agreed. :)

-- 
Kees Cook
