Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287572146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfCaJGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:06:19 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42444 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfCaJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:06:18 -0400
Received: by mail-ua1-f66.google.com with SMTP id s26so2068529uao.9;
        Sun, 31 Mar 2019 02:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izNQb/1ygpt+8nt7bUDtH1W8eYesEfdpXdjxPrhCO6E=;
        b=AqJ9p+lP+96c7eOfmXU12lQVi0jsDUCuhaMbhHB+aKySYn17Mu+SyMRC5xC34LLhyG
         vfOSDugr98eCAlRICXEWgbIepGjKL8a8/stfciNY/Dfgdez+3UfdZkXETgKOJPtRzKAr
         r4vpgXkNyI7EDLFmj7TId/xFmxMa+THldhXPNwqoCG09T6CvQ/CS/tAHFnScM7WJL4BA
         XYC604CL6tF/RtfafuYCaY0uRCq3tZWyo2mrAhNOFXatDnAKFHcbDIJH7cF2BCTYM8su
         Ggdf80RU8qIoq9qVDV6C03dwuwgtMwE/B7mih6ta7V4RKE6ZiGlnmEexoL5ZpfaCNCLX
         xSPg==
X-Gm-Message-State: APjAAAW3kQZUh3fpAbAqPsclGFGbzSFjupSLxXXIce++6pEMb7Xp7QDw
        JNp+mUPNHbgk71l5VlQSEWtmOWBn11JNn6ioY/0=
X-Google-Smtp-Source: APXvYqwvPWN9HpsVZJN6+1gdDUiT9VAXXrijOlUsKAvax6zampPkUkZMs045J1x7IRo2tARQG2bM98uvGNrpzo7pgP8=
X-Received: by 2002:ab0:7797:: with SMTP id x23mr21069168uar.28.1554023177060;
 Sun, 31 Mar 2019 02:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190309060411.29074-1-kjlu@umn.edu> <8c616b91-8f0d-f53b-af10-4d768063c5a0@gmail.com>
In-Reply-To: <8c616b91-8f0d-f53b-af10-4d768063c5a0@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 31 Mar 2019 11:06:05 +0200
Message-ID: <CAMuHMdXELu2tcSB5C1yKUGft6sDGPAy997ApPzy17n0MssfyWA@mail.gmail.com>
Subject: Re: [PATCH] leds: fix a potential NULL pointer dereference
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Riku Voipio <riku.voipio@iki.fi>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On Sun, Mar 10, 2019 at 9:40 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> On 3/9/19 7:04 AM, Kangjie Lu wrote:
> > In case of_match_device cannot find a match, the fixes returns
> > -EINVAL to avoid NULL pointer dereference.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> >   drivers/leds/leds-pca9532.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
> > index 7fea18b0c15d..4b0335591728 100644
> > --- a/drivers/leds/leds-pca9532.c
> > +++ b/drivers/leds/leds-pca9532.c
> > @@ -513,6 +513,7 @@ static int pca9532_probe(struct i2c_client *client,
> >       const struct i2c_device_id *id)
> >   {
> >       int devid;
> > +     const struct of_device_id *of_id;
> >       struct pca9532_data *data = i2c_get_clientdata(client);
> >       struct pca9532_platform_data *pca9532_pdata =
> >                       dev_get_platdata(&client->dev);
> > @@ -528,8 +529,11 @@ static int pca9532_probe(struct i2c_client *client,
> >                       dev_err(&client->dev, "no platform data\n");
> >                       return -EINVAL;
> >               }
> > -             devid = (int)(uintptr_t)of_match_device(
> > -                     of_pca9532_leds_match, &client->dev)->data;
> > +             of_id = of_match_device(of_pca9532_leds_match,
> > +                             &client->dev);
> > +             if (unlikely(!of_id))

Use of unlikey() is frowned upon.
Moreover, this cannot happen, as pca9532_of_populate_pdata() already
contains a similar check.

Kangjie: please stop submitting patches for missing checks, without
investigating if the failures can actually happen. Thanks!

> > +                     return -EINVAL;
> > +             devid = (int)of_id->data;
> >       } else {
> >               devid = id->driver_data;
> >       }
>
>
> Applied to the for-5.2 branch of linux-leds.git.

And also as a fix for v5.1...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
