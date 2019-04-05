Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9269C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A42063F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcwySHN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbfDER6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:58:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39132 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDER6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:58:01 -0400
Received: by mail-io1-f68.google.com with SMTP id e13so5722298ioq.6;
        Fri, 05 Apr 2019 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egTiXCXiQ1O/ExB4llJHyFm8YeNMSgrX1oRfrGnnTzI=;
        b=NcwySHN4F1UQaDoJcXENI1rPKjDGQO/wGdRs30Ntto93fxsYrbUOeaR9MbrxaHMzty
         PgncKptu8AeKXv0csSobp0Z1l/VSC/00qJxa3h28H0w4t65VQY39Ho2KjCV1X0rP4xHB
         V4n84o1f7jERbnyN2ZzGugOj+qF/gcx7BDMp/F6dprpk0yF8wejafnrGGHn93b9+ejCt
         Ve9tj4rOejx6ezkFUOiWrcw1N9Kx5ov5EZokRS54A0bzkIEuV4wkrRE0Q/MH1Tf/8F41
         v7UXIJI2Dy9qBCgWvvoLA/RbGjJCL84JxqTYQHLL1EjRGOf5m7sY81dDpy0TaO9Tffth
         b5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egTiXCXiQ1O/ExB4llJHyFm8YeNMSgrX1oRfrGnnTzI=;
        b=pw22+2UyDu6m6ymJIihoMtWpzLTR4lg1EdK60GB1HUO3gps6HgjF8pSxD7DpfK8OVa
         jYfHBYr8IWX4GK7ru/J1/VDh3PfWg1wwCPoY1499U17eEMv9dRp7QD97tVMMcT1I9By2
         GClqDEBWsxbfx0+yr8p85B0SLICYeRCBOgFeQ0CpWhjUAXyPJvu7dzakOuUDv4d5DbV9
         /M4ezDnGCxXOpnZOUjXvWBB5I9BTyvK7aJr2Vxuxfhu//ywypxqZTUhJBgcg48hrdYbb
         u7BuW4ohVyt3nxgCEgEC03oZtL4MwcfTUKfIfnW/6VlnbxkUsjyltzOPEAo2AZ4dqihn
         rN2g==
X-Gm-Message-State: APjAAAVyhQ5iwe89myCIsShD+QZwGafm1etI3D/pY7pQJcLna/bHR3wY
        RakaAG95FnRuVOTqop/jVQtbD6c++65MoV1G+QU=
X-Google-Smtp-Source: APXvYqxE7jX0GpSpe7hiztml0B9WD1alvsRbo6ksqsv8kGn+fKgFFUnUdnCoKNVawoX7sDxm5nZZQXUmUadp/QPFHvc=
X-Received: by 2002:a6b:c981:: with SMTP id z123mr8795454iof.123.1554487079883;
 Fri, 05 Apr 2019 10:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-5-andrew.smirnov@gmail.com> <02822a7c-ae86-8c00-093e-665b603b1430@linaro.org>
In-Reply-To: <02822a7c-ae86-8c00-093e-665b603b1430@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 5 Apr 2019 10:57:48 -0700
Message-ID: <CAHQ1cqF3VBn9UTQvY5f3ySz9Q-zeZHcb5ojMt8suDPTfcJbZLw@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] thermal: qoriq: Add local struct qoriq_sensor pointer
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

On Wed, Apr 3, 2019 at 8:28 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Add local struct qoriq_sensor pointer in qoriq_tmu_register_tmu_zone()
> > for brevity.
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
> >  drivers/thermal/qoriq_thermal.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 6d40b9788266..e281bdcfa11f 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -114,18 +114,18 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
> >
> >       for (id = 0; id < SITES_MAX; id++) {
> >               struct thermal_zone_device *tzd;
> > +             struct qoriq_sensor *s;
> >
> > -             qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> > +             s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> >                               sizeof(struct qoriq_sensor), GFP_KERNEL);
>
> I would not recommend this, especially if you use a variable helper for
> clarity. Keep using the 's' variable and then assign qdata->sensor[id] =
> s at the end when everything is ok. May be rename it 'sensor'?
>

Sure, I'll move the assignment in v4.

Thanks,
Andrey Smirnov
