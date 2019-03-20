Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE829C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C762186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d2y7Zmg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCTPpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:45:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43008 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCTPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:45:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so2200264pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UVDXc+lEJ2QHVXWNhubXjC/FHnN1snDnwLNu2MjSfE4=;
        b=d2y7Zmg3IHoZNub0XfK61x/FGMtEBZcLgjUq/kBNHEwbAznfhRIJwp69KEHqxNTc4/
         7MPPgVv4fHYaoscMHNR6GvUNEScZ4qfEwhvTriDEl1GZglK0HX42pmMeQhhihIWGZANB
         +Vu9Rbiht+hYnNYJqDDaUy7z94FhHf8UR6tZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UVDXc+lEJ2QHVXWNhubXjC/FHnN1snDnwLNu2MjSfE4=;
        b=nabYwE0C0opROtWZbBpDTijim4IS1wF71Twm8Rexks1rTIAiHIC2p8OBWgCLUf/gla
         VioNnC7qBxgsisWWj7OrX/rlAvPvblagFC2mnXAzyc3wY4BWlsNF6mihkQhcF9yF51s+
         yl4O0CbgGSITjvFQo1XDr1WoymZbx1jXuOfC/6MHndHcAqhTFIl95ATnf+Y8kdWFceLP
         3i1MNyDVUDP6ABF12LIsbHQhGCcY1L00RQYFy1ELj0omGvUoYEtKDZ17sRGtO4TxFQqq
         t8uDnYcDCx6NU7EDXfNxHxW3xwDybcHJ0jlAkQ3ArculSNHtuK5NYQOOwdMIklf1BSe+
         aX7A==
X-Gm-Message-State: APjAAAXk5knJUsehg4+4NFSYtS8UdzmJpokhCh3++Qu/2ZfTX5YLv6F5
        BxTWQ7g8qEpAeoI/ArNnDENDfA==
X-Google-Smtp-Source: APXvYqxW29k4bWofxWbS51hD3RsboLntzrBxjN2tjLhtb+JfqB9CL7wv6gWDPo/Kd+PMFuS0FdMllA==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr8985589pla.178.1553096703442;
        Wed, 20 Mar 2019 08:45:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y68sm3074633pgy.67.2019.03.20.08.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 08:45:01 -0700 (PDT)
Date:   Wed, 20 Mar 2019 08:45:01 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
Message-ID: <20190320154501.GO112750@google.com>
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
 <CAK7LNASv1BybFUDZ0KippC216i4k51iX42DL-HCHHxZWM2oz+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNASv1BybFUDZ0KippC216i4k51iX42DL-HCHHxZWM2oz+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:55:06PM +0900, Masahiro Yamada wrote:
> On Sat, Mar 16, 2019 at 4:55 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Building the 32-bit vDSO with a recent clang version fails due
> > to undefined symbols:
> >
> > arch/x86/entry/vdso/vdso32.so.dbg: undefined symbols found
> >
> > The undefined symbol in this case is __lshrdi3, which is part of
> > the compiler runtime library, however the vDSO isn't linked against
> > this library.
> >
> > Include the kernel version of __lshrdi3 in the 32-bit vDSO build.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > diff --git a/lib/lshrdi3.c b/lib/lshrdi3.c
> > index 99cfa5721f2d..8a4fc6bcf3a4 100644
> > --- a/lib/lshrdi3.c
> > +++ b/lib/lshrdi3.c
> > @@ -16,7 +16,7 @@
> >   * to the Free Software Foundation, Inc.
> >   */
> >
> > -#include <linux/module.h>
> > +#include <linux/export.h>
> >  #include <linux/libgcc.h>
> >
> >  long long notrace __lshrdi3(long long u, word_type b)
> > @@ -42,4 +42,6 @@ long long notrace __lshrdi3(long long u, word_type b)
> >
> >         return w.ll;
> >  }
> > +#ifndef BUILD_VDSO
> >  EXPORT_SYMBOL(__lshrdi3);
> > +#endif
> 
> 
> I picked up
> https://patchwork.kernel.org/patch/10858565/

Great, thanks!

> I do not know if this patch is still needed.

no, with the change to -Os the patch isn't needed anymore.

> FYI, just a tip to turn EXPORT_SYMBOL into no-op cleanly.
> 
> You can use __DISABLE_EXPORTS
> as drivers/firmware/efi/libstub/Makefile does.
> 
> See commit f922c4abdf76.

Good to know, thanks for the pointer!
