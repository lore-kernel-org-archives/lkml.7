Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6716C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3AF2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3OkogeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfGYS5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:57:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45097 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYS5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:57:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so23469649pgp.12;
        Thu, 25 Jul 2019 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfRsbfKjlbRjCKWjcvvv1UnYzfCDCkJeFmboNeFgmwo=;
        b=k3OkogeECdRkYQBdG29C54EqVkAqeH3fQEAweqO3b6SrtO3qS/QXHoLN4agcqfaiEb
         gdSjzIrhZOQ8g1hcXIFZKjJmWHe2zgulfHNvcBFUxVN2lhpi1Qebo7pSayp91LNnVlbL
         d3B+ILCoSZ5rLv53plB1RAPCkSGHnTrsq16OoIsTrctUKUnYuH4XUGeO274Np6GEj135
         munuuoXX94uXTs85yCHPF/GnSJNy5FNCbnUB2gsjhwozrb/bjdfxz6kNlmhj1dDOhS1H
         4OgNFbPsXSE7E5VEu6EN9XXUkXe4gCXRKVZXOuYWAwRGNQB0uWRJc51WHkDgoVmbQELb
         uqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfRsbfKjlbRjCKWjcvvv1UnYzfCDCkJeFmboNeFgmwo=;
        b=J1LZ9Nh7z/QqL3L/9+yVru4EgtNBieIH9KDfyRswpnkebRh0xO81xxwof6YC5Ui+Hq
         oSxZrzgRkmslAU1yw/p3XFWJ4bUmfxWueUr9MN3OU2sBJzFHF6RMZCT50i73uebn33oT
         mqs0xRW1SOnaPa+EcFDrDKVX8IGZQgYbd90ukz4y/pBi8b07/m5LBdPOqBeRic7cbPuR
         H241+5ahyz2+2ce2hZzSxAEYOyRPqLjmulLBH1A+HiIkxgt7kw4IfOn9KNPWvxffUTBj
         lSKjOR3Vuu/E2arjfNw2qvF25ovGLeHPkqhkresitg86gIegT7l4ciPjB2QfxXo8V9wU
         U3ZQ==
X-Gm-Message-State: APjAAAW45c6ppjaqSgf/s6Ot7BX4rNlSIkzr+HA+PwjxgLgv7M3B1Qlw
        saAiwStQ8qgSUtzTrQ1upPvQR/wjLCKWC/PvGD0=
X-Google-Smtp-Source: APXvYqzGaw1ubEE+cNWmgus0kKUaWB8XQzNl4KJQPoBCFSFVOuftrYs3LVfuHcWf1maicgZeYxkC4+Mf1hXkKE8nc08=
X-Received: by 2002:a62:14c4:: with SMTP id 187mr17644712pfu.241.1564081072772;
 Thu, 25 Jul 2019 11:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <1563795379-7521-1-git-send-email-info@metux.net>
 <CAHp75Vch3KNCkwp69a_fBtMy3B3k=NEbAmPZE2cn5HSn577HOw@mail.gmail.com> <332c666b-1bb3-d4bb-ad1b-98b36992de71@metux.net>
In-Reply-To: <332c666b-1bb3-d4bb-ad1b-98b36992de71@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 21:57:40 +0300
Message-ID: <CAHp75Vf1pyWjK6hbrNqDjk4v=H0nZLzwKHNK51XteTCo4-QJLA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86/pcengines-apuv2: use KEY_RESTART for front button
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

On Thu, Jul 25, 2019 at 9:50 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 25.07.19 19:17, Andy Shevchenko wrote:
> > On Mon, Jul 22, 2019 at 2:36 PM Enrico Weigelt, metux IT consult
> > <info@metux.net> wrote:
> >>
> >> From: Enrico Weigelt <info@metux.net>
> >>
> >> The keycode KEY_RESTART is more appropriate for the front button,
> >> as most people use it for things like restart or factory reset.
> >>
> >
> > Should it go as Fixes?
>
> I think so. Technically, the feature already worked, but the keycode
> wasn't semantically fine.

Can you provide a Fixes tag?

-- 
With Best Regards,
Andy Shevchenko
