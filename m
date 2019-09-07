Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA63C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED7A21835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFUzc9Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbfIGRb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:31:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34660 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfIGRb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:31:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id r12so6614724pfh.1;
        Sat, 07 Sep 2019 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YetYHJUHNVn/RWo99UYn2JfBZO2FhjtEM31luhQA6Gs=;
        b=kFUzc9Cl0Uc48kvfJYux52vwcBjX11wQOufve/8FETes3y3F9eqoSXmq7wbbTMpFmj
         Lu2N71aRSXZT+h645Jb0QNvXEMnYOUbfMw0vKx5EBd5glc25uZ0HhWz+ScwnRTfu736f
         ZC5ioJNPAn4djbo+Ql24uBYN4huLZ9PXfZUBnnEdqTLk/n92/KHqCOWJKOgijR/bWniY
         WaRwX+g+dVznAmVESMBscUFHTGPx10zvHig246oZzD2b4xeCJFr74YVBoKx4wZ64mzQR
         H2q82OombYM6rt5NrD4WdJyBnWJVhKSWvtC2rAtBhFrK0ykRU7RcxK/OUhNRLzi8fqk2
         6oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YetYHJUHNVn/RWo99UYn2JfBZO2FhjtEM31luhQA6Gs=;
        b=mMspy+ejUHHu96ufJqWdHF9Ouhh9RpoVhG9tf+8U0nuvBAZkg3PB/ESzHkTPsSy9cq
         SNoPtYngpFYLGXqE9UxOshYycV7ZbtWEaPGx5ICI/I1HE7FQsiPOV6B8xdaNcPIRZvxc
         iczaeNB2imlHt2A6TV9NVZ7ijddBZxU4SAQ4KpGqFVLCT9NSgQ/0ZgOQU5vpzfH/6EpK
         LLrlMMhZUiCVStV4yACaVMynVF/rZFEa0Uk7edOlBGjQ+nTOcJEYxahP1IOUvLfmOE9x
         NSzPByf+mxarWZ1Q7JjMTihpmSahB8xz1J8JwkUu0jrqXR3eYIid+ZOW2y5hpidlOYo9
         eZIA==
X-Gm-Message-State: APjAAAXiR9rOPcQLDK8DtID2kX/7MqG0e/VTwUEmwMGMoxdZutucIMF7
        Cc23pqQEPI/D+B8ngin++mAu0wBPF+PUqbwXKUo=
X-Google-Smtp-Source: APXvYqwhEaWhgxhN4HWgW/eaASlELh8D7Hy8dww3kL8x+92LXM8YSyPEP2O5ytINpg3MVUNRv5Q2Rk22twOvQK4gREk=
X-Received: by 2002:a17:90a:a881:: with SMTP id h1mr2973061pjq.20.1567877515359;
 Sat, 07 Sep 2019 10:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <1566294992-703-1-git-send-email-info@metux.net>
 <CAHp75VfFf7y5iLHSgS+mXa4cE78BC=maF6PWtwEGfgyi2pXKCg@mail.gmail.com> <8e9ee2a1-3731-9427-bd04-2d4327913aa3@metux.net>
In-Reply-To: <8e9ee2a1-3731-9427-bd04-2d4327913aa3@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Sep 2019 20:31:44 +0300
Message-ID: <CAHp75Vd_fW7Vb39u2efjt02+M50MDfvOJTrqkJ98CGwmSQORRw@mail.gmail.com>
Subject: Re: [PATCH] platform: x86: pcengines-apuv2: detect apuv4 board
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 2:37 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 22.08.19 21:47, Andy Shevchenko wrote:
>
> >> Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe
> >
> > Wrong format.
> >
> > W/o SoB tag I can't take it.
>
> What's the correct format (what command shall I use to
> create it correctly ?)

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Section 11

And for this one Fixes is not needed. The APUv4 never worked before, correct?


-- 
With Best Regards,
Andy Shevchenko
