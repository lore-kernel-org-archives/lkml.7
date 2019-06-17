Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4431BC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109F120657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY49b7Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfFQWP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:15:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40488 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfFQWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:15:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so11707490wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOxrv4Z+duhzHk+Vvgki6wKRY9I+T3teV7bGXJE2hg4=;
        b=aY49b7WkuTfBi9s+q3YkqPFoksMYySMOhjBU6L7c9cc3C7zQp4p2+UV4mY95F/0+JH
         tL2UKDIzzhClKL9WqK/0Xcgf5BKsw0fpZTFv4wGWckmU7Bj/9XiimGYc94tZJV6KoFnl
         beS12Vz7LfpA7sRaj1tu2a0eGRfqM+Vka0dXZ83xvafIRlOdvEhQIXWECXaxI/fR6zaA
         hwTrx3seR9v6J6808XBpeexTzC0DeRJO3yWEKo945ztZeW0s/8p43ED0XsQdd7h3kqk5
         acZlzLfwvorsKhYzrGPaUSAchILthJH/N4thVd/F5xGt6QCD91vonSWuuI5keLuP7Dab
         6okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOxrv4Z+duhzHk+Vvgki6wKRY9I+T3teV7bGXJE2hg4=;
        b=n6dAvSt9M3XpaqQgYtfLkihjNUGz36wqp8yZQZ5IyRaIlQDvAQ3hUS/DHoVB8O+GPm
         qxffCzIsFJc9f9jGxj4IeHUUUMS0UgoRb7c0uAL1H1S8daAkcNNsSXrT7nYeaGKaA5l9
         SEPUPvcRpZcli3qPkFJtAH96b+G4CSkBulvB6JTgWb4rbEoZ+5Ea4ZSzvFdfLiU55wYC
         wQi1odk6m34GCYvDWPGKwNJurcGTLAqHe/zCl0La85lR1mN09Vw9zinXnJHUIMdBiwfp
         qpOclgrI6TJvs6NhcAGnzunUUI8jZR/YT55fEgNcKoeVwrLwE1QpxDDGlyfYVeIHpSFO
         nx0g==
X-Gm-Message-State: APjAAAXkklEHwLsJs8xuDm10tea7EU6pYMsHXLVSC4f/Zu/uuHTP6RRa
        e+GvE1ceK3HklLlIUqnFfFpNiJtpXByfCnZo0D8=
X-Google-Smtp-Source: APXvYqzIRENvbCsYIcq6eR/PMaPMcy9DkvAWKBfar8wlTlCUFzrbGjxFQHJKL/sWdXUH34woXRKOQ0zdzM7JxnWZL1U=
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr33675436wrm.100.1560809726001;
 Mon, 17 Jun 2019 15:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com> <CAFLxGvwjqo27VQ092WV9=6N5RJr-M7aL0HYVWkeaCYbY3XWa1w@mail.gmail.com>
In-Reply-To: <CAFLxGvwjqo27VQ092WV9=6N5RJr-M7aL0HYVWkeaCYbY3XWa1w@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 18 Jun 2019 00:15:14 +0200
Message-ID: <CAFLxGvyGFtacE3mgZ03zrOeF2S24KdtGj+Qy-3kmA2wbRhNJYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mtd: Add flag to indicate panic_write
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:08 AM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Thu, May 16, 2019 at 6:42 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> >
> > Added a flag to indicate a panic_write so that low level drivers can
> > use it to take required action where applicable, to ensure oops data
> > gets written to assigned mtd device.
> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  drivers/mtd/mtdcore.c   | 3 +++
> >  include/linux/mtd/mtd.h | 6 ++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index 76b4264..a83decd 100644
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -1138,6 +1138,9 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
> >                 return -EROFS;
> >         if (!len)
> >                 return 0;
> > +       if (!mtd->oops_panic_write)
> > +               mtd->oops_panic_write = true;
> > +
>
> You can set the flag unconditionally.
> If it is set, it will stay so, and setting it again, won't hurt.
>
> >         return mtd->_panic_write(mtd, to, len, retlen, buf);
> >  }
> >  EXPORT_SYMBOL_GPL(mtd_panic_write);
> > diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> > index 677768b..791c34d 100644
> > --- a/include/linux/mtd/mtd.h
> > +++ b/include/linux/mtd/mtd.h
> > @@ -330,6 +330,12 @@ struct mtd_info {
> >         int (*_get_device) (struct mtd_info *mtd);
> >         void (*_put_device) (struct mtd_info *mtd);
> >
> > +       /*
> > +        * flag indicates a panic write, low level drivers can take appropriate
> > +        * action if required to ensure writes go through
> > +        */
> > +       bool oops_panic_write;
> > +
>
> Maybe we find a better name for it.
> panic_write_triggered?

ping?
I'm happy with the overall approach.
So let's target the upcoming merge window.
Can you please sort my two comments out? :-)

-- 
Thanks,
//richard
