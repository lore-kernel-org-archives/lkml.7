Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3636CC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CB521783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN5eqIrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfJBOoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:44:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34166 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfJBOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:44:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so12981964lfm.1;
        Wed, 02 Oct 2019 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqyokYNuh7XeiDwR5TApscfdY5kDA0ywkq0qPbxNN/4=;
        b=BN5eqIrbAhF3Xd1ilfyvnUwzzY2YJMZNblpODfIZGUMj/LUgGCjn+GrQrIsnmv4GRh
         CqwpraU+OSTbs8b/9HdTuvEkOYvgqZ83NzA+oq4ij8PEHJFdLnTxXByPz5ZXyn/00kvj
         rO8FORmUDqHWZZd0U1SBw3rUIaVaWoEveDbX60bgb8aztGzfsk9RZyVSEbe5la8z+R8M
         kIwl0W17RGz0zTpCJFzWV6XXaRGSUHU6HA/2utaQgRqkGHcHyqNhNVSlzWSiDeGAuirY
         R6G687BlT6tM+DDECvHFOfOTR9T/3RqhJWN6lpzN19wXVSziC6ZXfsWvOBxOqaruwkI2
         iLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqyokYNuh7XeiDwR5TApscfdY5kDA0ywkq0qPbxNN/4=;
        b=HmTridyrJxIkMtURuiocBUoEJtsm+F9FaJmURqwL2rMMdWDBTr8VQl2DGaLqSQVoy1
         z6JTlf4z9vGLQGJ92Rst4HuoNGfax4GTHf/tw3kbKxpubHwdiUN6fvsEubrF5iCu5q3b
         2aGtjO4RvWa2E1ITbHA/PQn/UEBORDF5LjaEgFEcc5twACUJh2Qfp4vQC0USpXwFUSBA
         EoilNYuIVjPxs94vZ9QSCgEi8BXM5YXiIdewv2kKmsOe6wVIqY3yTJfAbyrFv666D8Xj
         pfZSnGqp25Vv7OKLZSkMvK4pL+sMHc0IbF3rkbOpJP8T3X7AgMuamA+/6ZBzGzYdfKo8
         pihQ==
X-Gm-Message-State: APjAAAXQj7nc2AWiZyKiOJhRUZ0oVYvYFwVMo6RI2/NYTVJGY7TniTpv
        9LJcFnAtWAvMx633loa0F62dgGjiLt8ZJNt0PZo=
X-Google-Smtp-Source: APXvYqxrSYF80vXhfEnReaHamLf9jV/T8e/xlk+9n/Akcvwq4XiYqhZbUNDyqJIoj4k9YIcPPvD3wlGrhAmpwrfhAgE=
X-Received: by 2002:ac2:46d2:: with SMTP id p18mr2595003lfo.140.1570027475826;
 Wed, 02 Oct 2019 07:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191001205203.4b1a5fb6@coco.lan> <20191002141359.30166-1-gonsolo@gmail.com>
 <20191002141359.30166-2-gonsolo@gmail.com> <20191002142744.GA3475@gofer.mess.org>
In-Reply-To: <20191002142744.GA3475@gofer.mess.org>
From:   Gonsolo <gonsolo@gmail.com>
Date:   Wed, 2 Oct 2019 16:44:24 +0200
Message-ID: <CANL0fFS9TGKJH2rfkXzak78BaLazTNO7GoZhSb4vLBsDrmz3FQ@mail.gmail.com>
Subject: Re: [PATCH] si2157: Add support for Logilink VG0022A.
To:     Sean Young <sean@mess.org>
Cc:     mchehab+samsung@kernel.org, crope@iki.fi,
        linux-media@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You need a message and a Signed-off-by: here.

Ok, I'll try to get that right the next time.

> > +     ret = si2157_power_up(dev, client);
> > +     if (ret)
> > +             goto err;
> > +     /* query chip revision */
> > +     /* hack: do it here because after the si2168 gets 0101, commands will
> > +      * still be executed here but no result
>
> I don't understand. What problem are you seeing here? Why can't you do a
> query chip revision first?

This was explained here: https://lkml.org/lkml/2017/3/15/778. To quote:

If the si2157 is behind a e.g. si2168, the si2157 will at least in
some situations not be readable after the si268 got the command 0101.
It still accepts commands but the answer is just ffffff. So read the
chip id before that so the information is not lost.

The following line in kernel output is a symptome of that problem:
si2157 7-0063: unknown chip version Si21255-\xffffffff\xffffffff\xffffffff

> This needs resolving of course.

I hope so. :)

g
