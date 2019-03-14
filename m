Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C530B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrOfyGKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCNLho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:37:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42896 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfCNLho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:37:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id i5so4761022oto.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikSAkPyvUTod3oziqkat1xRtIOJqBDrwsQpYrWpG5aw=;
        b=RrOfyGKj3js/d3IZfuVv2on/dP2Jsu/Uu8A6EqvGxmWHHQJreBgVBLA3Zn84EFYFAj
         WjQ5jtRkJD3w1qKMTUGYwavwgB4rZ2KID8rwyydJAnxoer+MIYW3gAZkE1FvwmELuQHR
         fvNIcdz5OvlVuVL+FdV4vUyG3mWlYBMmnUGrPpBt8oq8V8SjUtGrkdbEDps3ooYNXDvf
         gs2hjrx8jYd6V3SK0oPn0R5ancwBq82KvuQYqXJgnzan6KOMEHn/LavefzIsDLp6J6wG
         4OJE2LAUGfpYvdhXY2TJjTs0Uq4/FVjcrHftZV7JlVq4t1F7bMWZz51Yp5jTYS5McFOT
         ymCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikSAkPyvUTod3oziqkat1xRtIOJqBDrwsQpYrWpG5aw=;
        b=Xj9YNTe4GniGx0vKFmHgz5HXFnVWBD8D3M5i5qx0ERhXjFme/pubPai3C+ozarPqEg
         yIwbn5FVcnl4Jrx7dC7umv+qDtr5VnXd0pRPVna+SWm8g8CkCVWTmIKzgYJNdVt4HQo5
         IApVnamgni4OwtdYVZoKTrxfkogX3vdPtZTEjEk4aUS+nHff3ypBLgZLx6iOgSwaY1ix
         9yCbEqYglcIRaJftuKYuKTYR1GzoEy+YkWAbSbUVYH29WVVc2Ifp6VMpvKrfjJvjjZTg
         R+9cQzepkjhAU74dviWKWaLLzpqXKtzPXKQIpW738ZNLdAsKQO7ECmwXbWiyfxUflTpD
         aJpQ==
X-Gm-Message-State: APjAAAXUGRh0dDdH9Bmt68hET9e5sdnpmLYMs6T8WWEmdtj4NJ8G5KE9
        maVevxhBfWTPatJWqYAI4xZE2n51KI3St1dyKog=
X-Google-Smtp-Source: APXvYqxyM0NP4XObvzj1IK4lcVsFMMq2xJFYx+MOzZuAf5iqIoIGxB/DZHY8H6Q1OW64Z/0D4uRMbpFUFO+8JBNh8tQ=
X-Received: by 2002:a9d:63d4:: with SMTP id e20mr8861900otl.243.1552563462556;
 Thu, 14 Mar 2019 04:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190313122403.248873-1-armax@google.com> <20190313123454.GB2202@kadam>
 <20190314111313.GB8034@google.com> <f620e4ef-3d9e-4230-30e8-5cc608710695@denx.de>
In-Reply-To: <f620e4ef-3d9e-4230-30e8-5cc608710695@denx.de>
From:   Armando Miraglia <arma2ff0@gmail.com>
Date:   Thu, 14 Mar 2019 12:37:31 +0100
Message-ID: <CAOcbMd3tfFiVjvPE+mvCjP22-a6oY2LJRig05PJPRAL4DvpCMA@mail.gmail.com>
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in spi-mt7621.c
To:     Stefan Roese <sr@denx.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Neil Brown <neil@brown.name>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Sankalp Negi <sankalpnegi2310@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Absolutely!

Cheers,
A.

On Thu, Mar 14, 2019 at 12:36 PM Stefan Roese <sr@denx.de> wrote:
>
> Hi Armando,
>
> On 14.03.19 12:13, Armando Miraglia wrote:
> > My answers are in-line below. BTW bare with me as this is my attempt to get my
> > feet wet in how to contribute to the linux kernel for my own pleasure and
> > interest :)
> >
> > On Wed, Mar 13, 2019 at 03:34:54PM +0300, Dan Carpenter wrote:
> >> On Wed, Mar 13, 2019 at 01:24:04PM +0100, Armando Miraglia wrote:
> >>> Running Lindent on the mt7621-spi.c file in drivers/staging I noticed that the
> >>> file contained style issues. This change attempts to address such style
> >>> problems.
> >>>
> >>
> >> Don't run lindent.  I think checkpatch.pl has a --fix option that might
> >> be better, but once the code is merged then our standard become much
> >> higher for follow up patches.
> >>
> >>> Signed-off-by: Armando Miraglia <armax@google.com>
> >>> ---
> >>> NOTE: resend this patch to include all mainteners listed by get_mantainers.pl.
> >>>   drivers/staging/mt7621-spi/spi-mt7621.c | 27 +++++++++++++------------
> >>>   1 file changed, 14 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
> >>> index b509f9fe3346..03d53845f8c5 100644
> >>> --- a/drivers/staging/mt7621-spi/spi-mt7621.c
> >>> +++ b/drivers/staging/mt7621-spi/spi-mt7621.c
> >>> @@ -52,14 +52,14 @@
> >>>   #define MT7621_LSB_FIRST  BIT(3)
> >>>
> >>>   struct mt7621_spi {
> >>> -   struct spi_master       *master;
> >>> -   void __iomem            *base;
> >>> -   unsigned int            sys_freq;
> >>> -   unsigned int            speed;
> >>> -   struct clk              *clk;
> >>> -   int                     pending_write;
> >>> -
> >>> -   struct mt7621_spi_ops   *ops;
> >>> +   struct spi_master *master;
> >>> +   void __iomem *base;
> >>> +   unsigned int sys_freq;
> >>> +   unsigned int speed;
> >>> +   struct clk *clk;
> >>> +   int pending_write;
> >>> +
> >>> +   struct mt7621_spi_ops *ops;
> >>
> >> The original is fine.  I don't encourage people to do fancy indenting
> >> with their local variable declarations inside functions but for a struct
> >> the declarations aren't going to change a lot so people can get fancy
> >> if they want.
> >>
> > Is there an explicit intent to deprecate Lindent in favor of checkpatch.pl
> > --fix? If one would like to contribute to fixing the tooling for linting which
> > of the two would be the right target for such an effort?
> >
> >> The problem with a local is if you need to add a new variable then you
> >> have to re-indent a bunch of unrelated lines or have one out of
> >> alignment line.  Most people know this intuitively so they don't get
> >> fancy.
> >>
> >>>   };
> >>>
> >>>   static inline struct mt7621_spi *spidev_to_mt7621_spi(struct spi_device *spi)
> >>> @@ -303,7 +303,7 @@ static int mt7621_spi_setup(struct spi_device *spi)
> >>>     struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
> >>>
> >>>     if ((spi->max_speed_hz == 0) ||
> >>> -           (spi->max_speed_hz > (rs->sys_freq / 2)))
> >>> +       (spi->max_speed_hz > (rs->sys_freq / 2)))
> >>
> >> Yeah.  Lindent is correct here.
> >
> > Funny enough, this is something I adjusted manually :)
> >
> >>>             spi->max_speed_hz = (rs->sys_freq / 2);
> >>>
> >>>     if (spi->max_speed_hz < (rs->sys_freq / 4097)) {
> >>> @@ -316,9 +316,10 @@ static int mt7621_spi_setup(struct spi_device *spi)
> >>>   }
> >>>
> >>>   static const struct of_device_id mt7621_spi_match[] = {
> >>> -   { .compatible = "ralink,mt7621-spi" },
> >>> +   {.compatible = "ralink,mt7621-spi"},
> >>
> >> The original was better.
> >>
> >>>     {},
> >>>   };
> >>> +
> >>>   MODULE_DEVICE_TABLE(of, mt7621_spi_match);
> >>
> >> No need for a blank.  These are closely related.
> >
> > Ack.
> >
> >>>
> >>>   static int mt7621_spi_probe(struct platform_device *pdev)
> >>> @@ -408,9 +409,9 @@ MODULE_ALIAS("platform:" DRIVER_NAME);
> >>>
> >>>   static struct platform_driver mt7621_spi_driver = {
> >>>     .driver = {
> >>> -           .name = DRIVER_NAME,
> >>> -           .of_match_table = mt7621_spi_match,
> >>> -   },
> >>> +              .name = DRIVER_NAME,
> >>> +              .of_match_table = mt7621_spi_match,
> >>> +              },
> >>
> >> The new indenting is very wrong.
> >
> > Ack. In fact, I was thinking this could be one target to fix the logic in
> > Lindent to do this appropriately.
> >
> > I have a process question here: to post a change for the only accepted change I
> > have in this patch should I send out a new patch?
>
> Would it be possible for you to wait a bit with this minor cleanup?
> As I'm preparing a patch to move this driver out of staging right
> now. You can definitely follow-up with your cleanup, once this move
> is done. Otherwise the move might be delayed even more.
>
> Thanks,
> Stefan
