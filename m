Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED1EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B852921852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jurQ5SnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfDERv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:51:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55577 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbfDERv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:51:27 -0400
Received: by mail-it1-f195.google.com with SMTP id y134so4227009itc.5;
        Fri, 05 Apr 2019 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pLt+v812zAQ1Eq0dfJtxELVupjTeMeNtDAgindcFhzc=;
        b=jurQ5SnJbmEVWOv2+37JCGoOtnxLMy/DJCIfK5jEopHTA++9MGRr9GN+F+qho2FwFg
         cFQ+OY/hBKKuXbjkHRGAmcjE3rlTdvAhsqu6ojhhH0SMylSvY+HWVFZSoVH4K25ZDxYG
         9rKv5/MiSuKbNt4eM53XKhd0V2q0yaKyZnbIGriExRWzZbTMglTf39U2sQ13ZNbZPeLl
         80CrA4qThtgRFwuoAh1o8P80H1X3IGj2GL/uc+lpGrK9AiF3dzQjZu/WS5tbWXhn5sGT
         epbr017NfrOz01f2Hwe+/N/xLpl3g3/4tujT80SJca2/CH16uqdix0NzpbkeMs8/Lyqy
         HzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pLt+v812zAQ1Eq0dfJtxELVupjTeMeNtDAgindcFhzc=;
        b=Oufb020RmYFMsmtLTkqvmXZUXouel94g9Np3i1iSM55HrJqq7bQjDmLrObhDKRIxod
         Sd/U7hjoN3wLtyFU9nNoaTnVJA8cnbb+iCB/Z83QBWBujaYj/RsmHroA2a7+TljwUge+
         rm7fjmnWd8o1+GHN2hB4eucKdQ0J3JDEs5zGoQpusppkp9Vb+sFcYXm+OQ0v6BuwVw7B
         MI/wYaWcPs5NV6tPZ/TAX9+vvLsLnSV/Wlgy3JtZI2bNT3j/A6VumItTMv7ajFjTRir3
         OiBdoxxxnfApr+0xxZt4im6OT20QF9+5U6ajSoBXFwxrDUY4Tegk342x69ipcHZCEkse
         7ABA==
X-Gm-Message-State: APjAAAWT4bj2Hnyd4/PQR3SD69BIraYAMZooEz/dfuaqrW2EMUdCQdFU
        INvpxQFk0z5Qu9oEfPFPHuKepBm++eplZyU25wY=
X-Google-Smtp-Source: APXvYqzuClokSRDlQvHWXNGOxoF0fmneEp8CXPqFxWoeEg8k2sgiGIxz4hKIZzTezJYJXvU7tRDJ0W9fFJGgrJbpNtU=
X-Received: by 2002:a24:9a86:: with SMTP id l128mr9967479ite.126.1554486686213;
 Fri, 05 Apr 2019 10:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-2-andrew.smirnov@gmail.com> <22f0c6d4-842e-bb91-a684-6edb6345e036@linaro.org>
In-Reply-To: <22f0c6d4-842e-bb91-a684-6edb6345e036@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 5 Apr 2019 10:51:14 -0700
Message-ID: <CAHQ1cqEDiqn3KJeG62zqLm0tLv=+dgVHxSafm9_TYoi=VOMNhA@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] thermal: qoriq: Remove unnecessary DT node is
 NULL check
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 8:21 PM Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > This driver is meant to be used with Device Tree and there's no
> > use-case where device's DT node is going to be NULL. Remove code
> > protecting against that.
>
> May be elaborate why is never going to be NULL?
>

Hmm, I am not sure what can be elaborated further than what's already
there. The driver is written to be instantiated via DT and there's no
code that tries to do that via board code or anything like that. I am
guessing you maybe read the description differently. Can you help me
by giving an example of what you think needs clarifying?

Thanks,
Andrey Smirnov

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
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> > ---
> >  drivers/thermal/qoriq_thermal.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_th=
ermal.c
> > index 3b5f5b3fb1bc..7b364933bfb1 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -193,11 +193,6 @@ static int qoriq_tmu_probe(struct platform_device =
*pdev)
> >       struct qoriq_tmu_data *data;
> >       struct device_node *np =3D pdev->dev.of_node;
> >
> > -     if (!np) {
> > -             dev_err(&pdev->dev, "Device OF-Node is NULL");
> > -             return -ENODEV;
> > -     }
> > -
> >       data =3D devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
> >                           GFP_KERNEL);
> >       if (!data)
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
