Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D02C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BB62075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTAlHD1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfCMTBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:01:55 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44466 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCMTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:01:54 -0400
Received: by mail-vs1-f66.google.com with SMTP id b8so1685599vsq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dBZn4GYyMZX/K4m+LAt7gWUi5uCn+rl6eJHOTlNHyVY=;
        b=HTAlHD1kec//MROmxcFTBrKcRRR/5aVPTm7KohV4xOSCARRJd8gbqGUSBNdc0SX+wk
         le0BZEiP4w3qZs/VUAqHOjoHDktACmxnbsrea0APcJl8JjvzcDMaXM03/PSpCdE8kZuk
         QR8luwiu3mRIpUVxaYjuSbgNG4iTEcG2vOJz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dBZn4GYyMZX/K4m+LAt7gWUi5uCn+rl6eJHOTlNHyVY=;
        b=S+8ZCGCdM8jlvSSaeDIwTQ855gQ7frN0eBmDjJA+7rQHVqkB3aAHYzfxhbwT/pJ3BB
         RBCof4PqIEuQrZlzfKwF3injuTT/irzvl2T47og0iKcom/PL0JV/W+lkAVN/ckdU7Tiw
         QwLv3MpxdxfG047aXhlgIgnoMk7qhJa2trj8XMHCiErsdaZ713Dyr8MU046Q7RoRRksk
         AK57t3zPTIb9GT0nwMjBTtJOXVldn8+Gpij0Rrq3HUEMT5cZimpOQZrbj69gFLonmUi0
         Ht3UnVGGKi/y1ybgkH53hHRWmcDVb7exJvWyYQyVz/OFM+sOmoPkJfA807tFfCUxMBbx
         W/1g==
X-Gm-Message-State: APjAAAUw+NGes2VYhcTjZzEjGLi/JUqWv0XWa9yBs6Jn3mfQ2Ex6WLUi
        vhOYRt1iveBCfYt2NH7orimai1b3zmw=
X-Google-Smtp-Source: APXvYqz7X14PESSJfPsaFRZwxYmcwAgsKPNptWMdu9Ta6hCdaxe2xmN7u/tuV9zNuJ5tj03I9DXYxg==
X-Received: by 2002:a67:fa8e:: with SMTP id f14mr23900578vsq.126.1552503712400;
        Wed, 13 Mar 2019 12:01:52 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id q75sm3176909vke.2.2019.03.13.12.01.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:01:51 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id u1so1036111uae.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:01:51 -0700 (PDT)
X-Received: by 2002:ab0:2b0b:: with SMTP id e11mr5095630uar.106.1552503710881;
 Wed, 13 Mar 2019 12:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190212180441.15340-1-keescook@chromium.org> <20190212180441.15340-2-keescook@chromium.org>
 <fe87367b-f196-e8b0-6028-6378b65e5240@linux.com>
In-Reply-To: <fe87367b-f196-e8b0-6028-6378b65e5240@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 13 Mar 2019 12:01:38 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLFWv867UAL+eHoomcHFQNR3erWUChdFWSWPbehzqOzVg@mail.gmail.com>
Message-ID: <CAGXu5jLFWv867UAL+eHoomcHFQNR3erWUChdFWSWPbehzqOzVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gcc-plugins: structleak: Generalize to all variable types
To:     Alexander Popov <alex.popov@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 4:05 PM Alexander Popov <alex.popov@linux.com> wrot=
e:
> Hello Kees, hello everyone,
>
> On 12.02.2019 21:04, Kees Cook wrote:
> > Building with CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL should give the
> > kernel complete initialization coverage of all stack variables passed
> > by reference, including padding (see lib/test_stackinit.c).
>
> I would like to note that new STRUCTLEAK_BYREF_ALL initializes *less* sta=
ck
> variables than STACKINIT, that was introduced earlier:
> https://www.openwall.com/lists/kernel-hardening/2019/01/23/3
>
> Citing the patches:
> - the STACKINIT plugin "attempts to perform unconditional initialization =
of all
> stack variables";
> - the STRUCTLEAK_BYREF_ALL feature "gives the kernel complete initializat=
ion
> coverage of all stack variables passed by reference".

That's true, yes. STACKINIT was a port of Florian's patch to gcc which
looked only for missing initialization. However, this collides with
warnings about missing initialization. :)

So, given the case that the kernel builds with -Wuninitialized and
-Wmaybe-uninitialized, the preferred method of dealing with
non-by-reference missed initializations is to fix the code itself.
(i.e. kernel builds are expected to build without warnings.) It's only
the byref cases that there is no warning (and most authors refuse to
initialize such cases). Have there been security flaws where gcc
failed to warn a missed initialization that wasn't a byref case?

> I.e. stack variables not passed by reference are not initialized by
> STRUCTLEAK_BYREF_ALL.

Correct.

> Kees, what do you think about adding such cases to your lib/test_stackini=
t.c?
> This simple example demonstrates the idea:
>
>
> diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
> index 13115b6..f9ef313 100644
> --- a/lib/test_stackinit.c
> +++ b/lib/test_stackinit.c
> @@ -320,9 +320,18 @@ static noinline __init int leaf_switch_2_none(unsign=
ed long sp, bool fill,
>  DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR);
>  DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR);
>
> +struct x {
> +       int x1;
> +       int x2;
> +       int x3;
> +};
> +
>  static int __init test_stackinit_init(void)
>  {
>         unsigned int failures =3D 0;
> +       struct x _x;
> +
> +       printk("uninitialized struct fields sum: %d\n", _x.x1 + _x.x2 + _=
x.x3);

This would trip the build warnings:

In file included from ./include/linux/kernel.h:15:0,
                 from lib/test_stackinit.c:9:
lib/test_stackinit.c: In function =E2=80=98test_stackinit_init=E2=80=99:
./include/linux/printk.h:309:2: warning: =E2=80=98__x.x1=E2=80=99 is used
uninitialized in this function [-Wuninitialized]
  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~

but those could be silenced for this object specifically if we really
wanted to add it. I think it'd be fine to add this to the test, but
it's a known state, though, so I hadn't bothered with it.

--=20
Kees Cook
