Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1309C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E442148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfDXIiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:38:20 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45176 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfDXIiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:38:20 -0400
Received: by mail-ua1-f68.google.com with SMTP id o33so541450uae.12;
        Wed, 24 Apr 2019 01:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eti/tTB27Ml+YHh2VBfgUmyRk/nhT5Vw5BKmsSU8uxE=;
        b=W0jmzlD/NTfwVcuThjURHIcb3U1aBM6b/29ixS+GjCgSFNM4Q91Rt2BNqL7P+pchlg
         5uq9a9kc8XxZ/wFo+bH6q4dqzmhhuEdo4lFcnv6T90HyRHDVnwRrPgAc+zSYyj6xHiQd
         zxGyrMkP4P3n8vWpDtg+lPxE9RBBFGZ9GJg31XZHk06p4WKGjmlE4Jfmiwj9mfKPtRka
         j5aIzeWKcABCubxEjk4HANSo21ah7tWObFjuOH4BJcg3BpdvmEquklMt6cnr8W4N5ygR
         bt6mtO4wBBoZBNRUgtZ1/20ZvHPAYZcTqaHMhiumOnDu17IckomrXal/pbkgPBTTH8/T
         E2SA==
X-Gm-Message-State: APjAAAVlYH23dFfQ2cJhYwS3WfQ7LO0w300m4TTjE2vCCak0U3/J0M1F
        OhT3T20TmblyXy1hZ4s9y78tkwms/JptvwW99DY=
X-Google-Smtp-Source: APXvYqwyn3fomGe6IEvIz9EH52DaziJReAbKpW7CjoihP4HDHMjgS7Xm12qusaci4tELxB6oFz9iLg6MY+nhkzVNofM=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr15670661uao.86.1556095099247;
 Wed, 24 Apr 2019 01:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com> <20190416203431.GA20072@anatevka>
 <20190416204814.GA26442@roeck-us.net> <20190416205533.GB8268@kunai>
 <20190416212046.GC26442@roeck-us.net> <20190416221702.GC8268@kunai>
 <20190416223813.GA744@roeck-us.net> <20190417194528.xwivkyubhxyfrx4m@ninjato>
In-Reply-To: <20190417194528.xwivkyubhxyfrx4m@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Apr 2019 10:38:07 +0200
Message-ID: <CAMuHMdVuZH86bOBsymuPj+68o+exAtao9509XUjoXkozyi1Hvg@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling watchdog_init_timeout
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Apr 17, 2019 at 9:46 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > Yes, that works as well. Note that it will actually print something like
> > "watchdog: <device>: ..." due to the pr_fmt() at the top of watchdog_core.c.
> > I guess that should be ok.
>
> I have the following diff applied on top of patch 2. Works with and
> without a parent device. I am not super happy casting 'identity' but
> since its u8-type is exported to userspace, I think we can't avoid it.
> Guenter, is this cast safe? Here is the diff:
>
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index cd3ca6b366ef..62be9e52a4de 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -115,6 +115,8 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>  int watchdog_init_timeout(struct watchdog_device *wdd,
>                                 unsigned int timeout_parm, struct device *dev)
>  {
> +       const char *dev_str = wdd->parent ? dev_name(wdd->parent) :
> +                             (const char *)wdd->info->identity;

    struct watchdog_info {
            ...
            __u8  identity[32];     /* Identity of the board */
    };

Is identity[] guaranteed to be NUL-terminated?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
