Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ACCC2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A18020700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLOUGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:06:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44113 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:06:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id x3so6163150oto.11;
        Sun, 15 Dec 2019 12:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xp/csttZXysouE5r2d8VrjHUVDN87UbLOURq7DDwLA=;
        b=hLAVN4WkYeu6I00PxA1+fpLc7La5z5RDigcIJRS7IwqxG0T5xwSeLWTPxGLhb9pQ7c
         oY36cSaysMZg2wE6yPLo32I0AkoOmt+P3jpetWRxmSMuTa1tSRK14GpVQQH7lHczqUHY
         ggS9Ec8IChLlPlEFaLpQklwAPKn3yebUrN9tMq2dlzQ1lkC3203lujdq9anTgDFH/wM9
         FZXJ/J8TYy2zjeTtObV37yx3ZG7IkrN9S26aRKEKo/aylCPBjs6XqoykHk3HZ9+BpMTi
         Doy4eQ4zUHJcZDMm1FIztawz/doR1sdLh2UwJ/sPPP25zIL3HbazsxYwhUDH+Ap8VzET
         Qvxg==
X-Gm-Message-State: APjAAAUInsi9J4r7tqVMb5VmmA1/yK5IA8ZGnCfbgOpftvla0zXksLOu
        BTcplVP1Q0Dj87hsMOSya2kLmobW1ib6obo3FGwKJw==
X-Google-Smtp-Source: APXvYqxTnkedDl3WfOaTYc5zPvQzy8kthpkpkpBSqhN6gZHv/BspJZ7NO7Rg1+s2VLYZDUBSdjj/t55S8xtLQ87up3w=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr28456355ots.250.1576440398617;
 Sun, 15 Dec 2019 12:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20191124195225.31230-1-jongk@linux-m68k.org> <CAMuHMdVv9FU+kTf7RDd=AFKL12tJxzmGbX4jZZ8Av3VCZUzwhA@mail.gmail.com>
 <20191126144121.kzkujr27ga36gqnf@wittgenstein> <CACz-3riWp1fWCaAJtMgRx9VRVAJ+ktdbAqHBobQUXR9XpHrVcQ@mail.gmail.com>
 <CAMuHMdVLQF_KyWDn=HxmLAp6Vy3jyw=JLDQWryLt809sCecosA@mail.gmail.com> <009ee46a-eb51-f76f-915d-baa883f0be24@physik.fu-berlin.de>
In-Reply-To: <009ee46a-eb51-f76f-915d-baa883f0be24@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 15 Dec 2019 21:06:27 +0100
Message-ID: <CAMuHMdWFuiFMzYe4L5JY6iRfwzbGW4BH5MVCGrSuuXZHrzKGpw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Sun, Dec 15, 2019 at 6:01 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 12/15/19 5:48 PM, Geert Uytterhoeven wrote:
> > With Ubuntu's libc6-m68k-cross installed, the selftest binaries cross-build
> > fine.  Running them on a very old Debian requires some hackery:
> >
> >   1. Copy ld.so.1, ld-2.27.so, libc.so.6, and libc-2.27.so from
> >      /usr/m68k-linux-gnu/lib/ to /tmp/lib on the m68k target,
> >   2. mkdir /tmp/proc && mount proc /tmp/proc -t proc,
> >   3. chroot /tmp /tmp/<test-binary>.
> Why not use a recent environment?
>
> > https://wiki.debian.org/M68k/QemuSystemM68k

Yeah, I will give that a try... one day...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
