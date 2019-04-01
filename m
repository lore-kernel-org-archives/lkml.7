Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6C520830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfDAHIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:08:36 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41226 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAHIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:08:36 -0400
Received: by mail-vk1-f194.google.com with SMTP id d15so1842355vka.8;
        Mon, 01 Apr 2019 00:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCE0zaAZHEOAH7iEJCVPoZN7b7228diU0il4MiydsUk=;
        b=b7WvQN2DX761q/3yIO24tEGTp+cQRaGI950AN04uikBIA2bkE6qEDtHQh7lLdPlqWT
         xo4m/b4OHciMfpx31CduzvnEVfHGAKTvoJSseQDY2ARmMmqSd0z+g5/4WmWEbw2j4W1B
         R6hoeYsoauwEHkC125Ly3Llv/u/+kL8KqOMKtTXxUdEqT9ifqUW9TNS/xL2em10APwRR
         Oj3myPlSZx6nPAVj/yYIHzTNvZSVKFZGh2xVblAKLvG1X6dquRJrdhLNVVvZrdr8yF1f
         GMICVqFvOKDJN/MEflYwGXU97Ws/sKokchqJIjYSzgjOgj9nZd7ypd9yP3vzXkVHRamz
         k+TA==
X-Gm-Message-State: APjAAAVVE6WDSdIvP3wZBjwZ4+AWcsIZu4xhYQfO6lpJldxUQ1YUFUl7
        WrnAMYRdRRGlOouT2RP7050rKm7rYOKzOi6Jdbo=
X-Google-Smtp-Source: APXvYqxN6/jGG//lfNqZrZWbPOtny/XvW24WIr5AmMxIWmvZ6Lq8q/DaTqMPxHB/GFSldHcsxxzuM3pVv31QdETA1VM=
X-Received: by 2002:a1f:711:: with SMTP id 17mr37706647vkh.65.1554102515314;
 Mon, 01 Apr 2019 00:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190309060411.29074-1-kjlu@umn.edu> <8c616b91-8f0d-f53b-af10-4d768063c5a0@gmail.com>
 <CAMuHMdXELu2tcSB5C1yKUGft6sDGPAy997ApPzy17n0MssfyWA@mail.gmail.com> <46573cc8-1666-d0a4-dadd-2b2f81e026fe@gmail.com>
In-Reply-To: <46573cc8-1666-d0a4-dadd-2b2f81e026fe@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Apr 2019 09:08:23 +0200
Message-ID: <CAMuHMdU9X2ah6q-RhqbAZnyaw9PHOsD5Q=Y9wmTU_uzJ0MLyuA@mail.gmail.com>
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

On Sun, Mar 31, 2019 at 1:01 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> On 3/31/19 11:06 AM, Geert Uytterhoeven wrote:
> On Sun, Mar 10, 2019 at 9:40 PM Jacek Anaszewski
> > <jacek.anaszewski@gmail.com> wrote:
> >> On 3/9/19 7:04 AM, Kangjie Lu wrote:
> >>> In case of_match_device cannot find a match, the fixes returns
> >>> -EINVAL to avoid NULL pointer dereference.
> >>>
> >>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> >>> ---
> >>>    drivers/leds/leds-pca9532.c | 8 ++++++--
> >>>    1 file changed, 6 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
> >>> index 7fea18b0c15d..4b0335591728 100644
> >>> --- a/drivers/leds/leds-pca9532.c
> >>> +++ b/drivers/leds/leds-pca9532.c
> >>> @@ -513,6 +513,7 @@ static int pca9532_probe(struct i2c_client *client,
> >>>        const struct i2c_device_id *id)
> >>>    {
> >>>        int devid;
> >>> +     const struct of_device_id *of_id;
> >>>        struct pca9532_data *data = i2c_get_clientdata(client);
> >>>        struct pca9532_platform_data *pca9532_pdata =
> >>>                        dev_get_platdata(&client->dev);
> >>> @@ -528,8 +529,11 @@ static int pca9532_probe(struct i2c_client *client,
> >>>                        dev_err(&client->dev, "no platform data\n");
> >>>                        return -EINVAL;
> >>>                }
> >>> -             devid = (int)(uintptr_t)of_match_device(
> >>> -                     of_pca9532_leds_match, &client->dev)->data;
> >>> +             of_id = of_match_device(of_pca9532_leds_match,
> >>> +                             &client->dev);
> >>> +             if (unlikely(!of_id))
> >
> > Use of unlikey() is frowned upon.
>
> What do you mean? Can you give some reference?

I have more memories of this being discussed, but I could find only
https://lwn.net/Articles/420019/

It may be useful for some heavily used core code, but not in most drivers
or uncritical code like probe paths, due to:
  - many people getting it wrong,
  - usually it doesn't make any difference at all.

> >> Applied to the for-5.2 branch of linux-leds.git.
> >
> > And also as a fix for v5.1...
>
> Yes, but it had been in linux-next for almost two weeks before that.

Sorry, I only noticed when it got upstream.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
