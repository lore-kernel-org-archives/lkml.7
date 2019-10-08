Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E4C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4344C206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkRMuuut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfJHIrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:47:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35035 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfJHIrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:47:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so16636558lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 01:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8gpydJYA0YDgp2JmqFlI7k3M5woSWANVYThPnzBSyg=;
        b=BkRMuuut74Tg4ql3czpGBiGETKQ47t0yfFGj9qUtoNECtFLrPq7patqxRQTIKUPosJ
         e5ij5XG6gLCR9aH2tMBlyg4nicWRgSUUeguPdBLCGj5e+fmO4WBOWHqbIrjN23GcV9X+
         9UiM5zuZ8kUOjmbmakyLfk3DNm7gDqehMEcBVhaBie4GaVJqRz5rpcUAluJLllJOF3Mf
         +y7BzcB/eQ1ZrGH8gN2u8Rxxi+fzSaghOC5xViRMArZNRSxn2csNz/W1bUfwb6lH8tnt
         yTgKoyASrJ8JwI3YQxZpWYMIBXyHXAIoXg2BD9qf9M9BjKJeDzu0rw7W+YgoKaSJzGqP
         eNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8gpydJYA0YDgp2JmqFlI7k3M5woSWANVYThPnzBSyg=;
        b=Hek0fmge9nfx+mCShDVw4VYn1Q9v0/LAKZOm2F4BqNAadmFXuOWKU1b49kUhlXNJbD
         tHubP+z2BZJJ8NCzIgfxqofh6uZb2ph8y7HjW/YWeJfW/kUbwMoxOEvx2d+LMAYG0rzl
         Earix/ijlBU8xApamwoYOAC4I5SOxfCfxY6IDbnXKOpNfoe5V4HgcKv6I1wk0gvvWM+L
         kQpNZNAnqYIABvE77tRM/W2m4xbAzAiCEzjKOgOKVlPeNdqI2DpEzhYdcVOFECibdl6H
         LTZi3YoYdorNHOXY5bADo/4Razn+hL4y3T8nDarUSl6xbeQLpHcdlPrb2+ftm1XIb8bV
         Xgfw==
X-Gm-Message-State: APjAAAV9xk+ELKfye+mEg28ESRM7ojStG3QGZi1lFdk3d43Xn6No7HBU
        OiunQV7nDfwvQACESlJVzdPsIjiEKINPgCsgE2P3vA==
X-Google-Smtp-Source: APXvYqxbNM71HM7CPR6QRsIgEbU3UU9U/CSiMXaA2SIbIfrQl+rWLBRuuYXoBIaSEvilchXKRH21ww7tus0XXj0qkXw=
X-Received: by 2002:a2e:63da:: with SMTP id s87mr20899729lje.79.1570524436968;
 Tue, 08 Oct 2019 01:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190617221134.9930-1-f.fainelli@gmail.com> <CACRpkdbqW2kJNdPi6JPupaHA_qRTWG-MsUxeCz0c38MRujOSSA@mail.gmail.com>
 <0ba50ae2-be09-f633-ab1f-860e8b053882@broadcom.com> <CAK8P3a2QBQrBU+bBBL20kR+qJfmspCNjiw05jHTa-q6EDfodMg@mail.gmail.com>
 <fbdc3788-3a24-2885-b61b-8480e8464a51@gmail.com> <CAK8P3a1E_1=_+eJXvcFMLd=a=YW_WGwjm3nzRZV7SzzZqovzRw@mail.gmail.com>
In-Reply-To: <CAK8P3a1E_1=_+eJXvcFMLd=a=YW_WGwjm3nzRZV7SzzZqovzRw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Oct 2019 10:47:05 +0200
Message-ID: <CACRpkdbuwn-YBYd324OsfC4efBU_1pfnyS+N=+3DmrYOEKKFJw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] KASan for arm
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Hocko <mhocko@suse.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        David Howells <dhowells@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Abbott Liu <liuwenliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        drjones@redhat.com, Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Landley <rob@landley.net>, philip@cog.systems,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Garnier <thgarnie@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 12:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Oct 7, 2019 at 11:35 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> > > 053555034bdf kasan: disable CONFIG_KASAN_STACK with clang on arm32
> >
> > This one I did not take based on Linus' feedback that is breaks booting
> > on his RealView board.
>
> That likely means that there is still a bigger problem somewhere.

I will try to look into it. I got pretty puzzled by this, it makes no sense.

One possible problem is that some of the test chips on the RealViews
are not that stable, especially with caches. The plan is to test in QEMU
and hardware in parallel.

Yours,
Linus Walleij
