Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B4BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334F92171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rB7uAacH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbfDESAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:00:55 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55315 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbfDESAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:00:54 -0400
Received: by mail-it1-f196.google.com with SMTP id y134so4270572itc.5;
        Fri, 05 Apr 2019 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCaDQmiJL/X47i3bgtEG1syx0kJKWNxdc16W7+zcL20=;
        b=rB7uAacH+iiZtVmotfwFm8/R1+xQrfoB6ODSYqKT5hKThPzccLBDtgswlOt7m7x7d0
         M1O8Nr5hmreTR8Lyo/2SkqGij5hIm0XDGJw7es641cQqDheZ0QDXcVsLyQ1Ek9CF8E+W
         dJ+enrl3TOwOacGepLOrkcJ2NSwMGDe/NYwVfVlK4Q4E+UImBEFMRVjSdlYl3A1Gwilw
         20VLvnVkTwQoI3CnNN9qc6wxg2ADchwnEGL9pGLZmfPyms2G1hXS1X71dBxquhhTwF6P
         jDV4gwgwCmc/mROhMr4PjAm5Xtr9cw8yCXgYaJHbKFw4lHHJqRxY5HKHPZmwZoieco3S
         sRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCaDQmiJL/X47i3bgtEG1syx0kJKWNxdc16W7+zcL20=;
        b=cvwJ20+U3el2p0yEjpICnh+wA1dUR5a/pViRZ/acsXcRVoSAWSULl6NAbfhohhoRiX
         YpE+cZo+/9x6AjQ7LZjIgbqTLAs4MyM7FUuNM9dw4UO1hhNuNpjDHgZyICr2sC1jjEkm
         WEB1CLGChOjP8mMtt8oiyfJR02xcfHACx+zyWS3AsaLrPXf1FW3g+d3f8bz5g5MijKUt
         Rel11JE+gZzFc5KoCV7U5lDuRbeIHV/q+WVtQKobfCI48Mp0o9X/XZRlOA0ApolKfHl5
         2weiKrbeW61VbOkxg+/rv3BvwRGx8IhN46BOQgMM0QPV7G7NAEVxvWmomv5fphP0Dkm3
         oCbg==
X-Gm-Message-State: APjAAAUVf1VegYpK9fzNfaDv0RW6JHec+w3MiCm1DI6qMhRcrkB2W4Hp
        aAJkdQ1PA8Dcq5nN6vpG8rZt6bYkGTlc20kIBvk=
X-Google-Smtp-Source: APXvYqxucVFAaPp/xE9z+oVE7uhoGh0lj+QJID0u26C4aw1OJ90RDfkdL0wmthx0sF+h3ERPrOaDt0pX+RML17wGoUk=
X-Received: by 2002:a02:942c:: with SMTP id a41mr10706212jai.61.1554487253900;
 Fri, 05 Apr 2019 11:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-6-andrew.smirnov@gmail.com> <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
In-Reply-To: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 5 Apr 2019 11:00:42 -0700
Message-ID: <CAHQ1cqEJbXKdoqqwKjkD_yPjv52Y9w+XOOKxqFpPN23q-qnFaw@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] thermal: qoriq: Embed per-sensor data into
 struct qoriq_tmu_data
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 12:57 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Embed per-sensor data into struct qoriq_tmu_data so we can drop the
> > code allocating it. This also allows us to get rid of per-sensor back
> > reference to struct qoriq_tmu_data since now its address can be
> > caluclated using container_of().
>
> This seems to be a repeating pattern, drivers are forced to put a back
> pointer in the thermal sensor structure to regain access to the
> container structure in the get_temp callback.
>
> It would make sense to pass the sensor id to the get_temp callback as we
> register with the sensor id.
>

I'll rebase this series on the two patches you submitted.

> One comment below.
>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index e281bdcfa11f..deb5cb6a0baf 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -59,22 +59,24 @@ struct qoriq_tmu_regs {
> >       u32 ttr3cr;             /* Temperature Range 3 Control Register */
> >  };
> >
> > -struct qoriq_tmu_data;
> > -
> >  /*
> >   * Thermal zone data
> >   */
> >  struct qoriq_sensor {
> > -     struct qoriq_tmu_data           *qdata;
> >       int                             id;
> >  };>
> >  struct qoriq_tmu_data {
> >       struct qoriq_tmu_regs __iomem *regs;
> >       bool little_endian;
>
> Why not replace the little_endian boolean by a couple of callback
> read/write and assign them to ioread32|ioread32be at init time.
>
> That will kill the tmu_read and tmu_write functions and from there you
> can figure out how to remove the qdata backpointer. In addition, it will
> save a few instructions to test the boolean.
>

I am sure you've seen it by now, but little_endian is going away in
this series in regmap conversion patch.

Thanks
Andrey Smirnov
