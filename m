Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACCEC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09F12146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5xUR7sT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfDESFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:05:02 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54107 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDESFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:05:01 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so10862718itf.3;
        Fri, 05 Apr 2019 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Rs6lvFuWDLjGHtZaPICXxNnL6/JM32AelCBVVvSRrk=;
        b=E5xUR7sTpZvwpcgRp+7J0ZpyBoP/K0uYR3RLKDvauWWv06VG0YBOuVBS7mjsAoLqCf
         VXjWMbsTBs7UCSk7kb3WPj9gY/k+uWHJYZCgfWkULbd/jE/HpTmzBBseMFnMdBFL0ErE
         Yh1qlwrPuk54zxTXXv9hkW3ihVaUKpgzi/zwQ4rAn7GSMvIfIDlvYMi21l2JPwv/NM63
         DVV+c0v0tUFb5Apdw2fGzsFp9NEk5fCuwc8hA9C1miRKGdDt0AiGWyvcQmB5acVvOASn
         DIhlfOB/aDCS/N5d7nzCK0gXWOOW32EymsnqGog+wbzilGNZUHi1z/c5XRxPi0MIsuSv
         9z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Rs6lvFuWDLjGHtZaPICXxNnL6/JM32AelCBVVvSRrk=;
        b=Su1m8rfqnC0Le6fzoiDBivgvjNgGTQF5NQICtYcLCCWKBAmJFjhS/c8ZHDN6ULQbOM
         8NNLsGEfn9eY8OiJrz7aYMYf1Np3oWxmI6ffZ5n4ykX+jmTuwiByou2J5edUm1ol1gEL
         TeEqBdQSF3Vuj+RN/d4swS1SBxBCfIteCk2UM/b9bKV+yXdPW4H1K/q0Q3P53rO2WwQi
         jeLcXwSCJu3Ago4M/LpfBIf+I7lFxQUj3VhriT/A+/0qYdD5aoOYWvV+7H5A1lVDjeuB
         H8dE0pzK4DWAlQjK/VHZAAxjbUg5+nZqCT3m2tKVFuD8EyuWLe8Ug9wwYjYMeFLGxSN9
         Xv7g==
X-Gm-Message-State: APjAAAWFbO/0OFaYtzMARQ7Ew6QUp0DD5FSOar8d7ETH6FYptGWP29wz
        AILp0JWlsCasLNGme0xZU9DT/jPATTkTVhL2gFY=
X-Google-Smtp-Source: APXvYqzakkL66QnnGutHg4bQVznJQJ0uonaMO2QG03u06xsK3ITZSsCQlZIr4R7y2fpDyrNTPLDZQhpIwezyOEYLPTU=
X-Received: by 2002:a24:4702:: with SMTP id t2mr9988913itb.105.1554487500644;
 Fri, 05 Apr 2019 11:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-8-andrew.smirnov@gmail.com> <fa3cf0ac-1015-4031-8cd4-cd5270e39fc7@linaro.org>
In-Reply-To: <fa3cf0ac-1015-4031-8cd4-cd5270e39fc7@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 5 Apr 2019 11:04:49 -0700
Message-ID: <CAHQ1cqGfSS0PHaM+QcEMzhxXN5F9vQEE=nWseSoRKbrEmkFHag@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] thermal: qoriq: Pass data to qoriq_tmu_calibration()
 directly
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

On Thu, Apr 4, 2019 at 1:12 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > We can simplify error cleanup code if instead of passing a "struct
> > platform_device *" to qoriq_tmu_calibration() and deriving a bunch of
> > pointers from it, we pass those pointers directly. This way we won't
> > be force to call platform_set_drvdata() as early in qoriq_tmu_probe()
> > and consequently would be able to drop the "err_iomap" error path.
> >
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
> >  drivers/thermal/qoriq_thermal.c | 22 +++++++++-------------
> >  1 file changed, 9 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 24a2a57f61c9..a3ddb55740e4 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -139,16 +139,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
> >       return 0;
> >  }
> >
> > -static int qoriq_tmu_calibration(struct platform_device *pdev)
> > +static int qoriq_tmu_calibration(struct device *dev,
> > +                              struct qoriq_tmu_data *data)
> >  {
> >       int i, val, len;
> >       u32 range[4];
> >       const u32 *calibration;
> > -     struct device_node *np = pdev->dev.of_node;
> > -     struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
> > +     struct device_node *np = dev->of_node;
> >
> >       if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
> > -             dev_err(&pdev->dev, "missing calibration range.\n");
> > +             dev_err(dev, "missing calibration range.\n");
> >               return -ENODEV;
> >       }
> >
> > @@ -160,7 +160,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
> >
> >       calibration = of_get_property(np, "fsl,tmu-calibration", &len);
> >       if (calibration == NULL || len % 8) {
> > -             dev_err(&pdev->dev, "invalid calibration data.\n");
> > +             dev_err(dev, "invalid calibration data.\n");
> >               return -ENODEV;
> >       }
> >
> > @@ -198,20 +198,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >       if (!data)
> >               return -ENOMEM;
> >
> > -     platform_set_drvdata(pdev, data);
> > -
> >       data->little_endian = of_property_read_bool(np, "little-endian");
> >
> >       data->regs = of_iomap(np, 0);
> >       if (!data->regs) {
> >               dev_err(dev, "Failed to get memory region\n");
> > -             ret = -ENODEV;
> > -             goto err_iomap;
> > +             return -ENODEV;
> >       }
> >
> >       qoriq_tmu_init_device(data);    /* TMU initialization */
> >
> > -     ret = qoriq_tmu_calibration(pdev);      /* TMU calibration */
> > +     ret = qoriq_tmu_calibration(dev, data); /* TMU calibration */
> >       if (ret < 0)
> >               goto err_tmu;
> >
> > @@ -222,14 +219,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >               goto err_iomap;
>
> s/goto err_iomap/goto err_tmu/ ?
>

Ugh, not sure how I missed this. Will fix. Thanks for catching this!

Thanks,
Andrey Smirnov
