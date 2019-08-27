Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6EE206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KsGWP3iJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfH0ECZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 00:02:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42000 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0ECZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 00:02:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id m44so29389417edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 21:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/ISg4lPBXntnhkUlyyoIOqftCgr4zrKHSEP3Z3lTkY=;
        b=KsGWP3iJylxhOlKZ6vSysfwN+OptsHE8knF2cvoVVQessQgg7RCX1qZ1y3ImlXhxl1
         JDPKsbQx+Po9Ard+CtUl/d4YEtNv0VgoA3YwppD2JZlVL7cclGKAQiDh1VuQHSC+lxgK
         6TFvVKK/Vr7H0oMOyO8pbA1TNpEjgQVOpKg2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/ISg4lPBXntnhkUlyyoIOqftCgr4zrKHSEP3Z3lTkY=;
        b=B1/wCA6rueyvFJQMwwnZR2jDWULL4Rfatoqdnva6f7h3JHRnvdDlt4vuEKO72BEfmg
         Xgq1vS6kVTJEZXSONdxeGpH4yt4d5pnJXGaTMHhs77BmJPFcS1WpJpNmDyyG/oW125HO
         3fNBhSC7tTwJ9Cm+ShCRvv+QotdvWvamxMb9GrOZ6Drz0a353yMxWH24G02/Y4ZsZdZu
         GNWove7VawORxpfymOvaMEvXWXGaB1uwuq6XUpoqvBK4qWCOpspyeUSBq/bnfpa9yLTM
         fy9QqZCnGOAUGDmcWDoWTHfF+zU7HWABV+pMmIXZY9flyghlMz2FwvD+pu7X34v6TDAa
         LqgA==
X-Gm-Message-State: APjAAAWyQtclD4valC4ylPtNUgfU+4/3ubF7+aQ/bSMKI+teDh32pK18
        sy12sX2uKDPPYndaz8jdTwaiOu28a8FlfuTNCFsqGQ==
X-Google-Smtp-Source: APXvYqwQv3rm7QX/RLFMVOBjGFGVmWW+JwYQSCTiOgD9zGMF8eVfJWhb3hpe7yBJnMZ/nzsKCyu1B59Xj+dYZD4vhuo=
X-Received: by 2002:a50:9736:: with SMTP id c51mr22130503edb.160.1566878543433;
 Mon, 26 Aug 2019 21:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190814081757.65056-1-yllin@chromium.org> <2dae986a-17c4-f06d-c7c9-47c93132f4aa@collabora.com>
In-Reply-To: <2dae986a-17c4-f06d-c7c9-47c93132f4aa@collabora.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Tue, 27 Aug 2019 12:01:47 +0800
Message-ID: <CANdKZ0dKEHOESHmRpG4e26rFVKsSeGGUqY2AvFv_6ntO=A7WsA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_rpmsg: Add host command AP sleep
 state support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Yilun Lin <yllin@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested that with this patch, SCP does receive host command from AP
while AP goes to suspend and back.

Tested-by: Pi-Hsun Shih <pihsun@chromium.org>

On Fri, Aug 23, 2019 at 3:36 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 14/8/19 10:17, Yilun Lin wrote:
> > Add EC host command to inform EC of AP suspend/resume status.
> >
> > Signed-off-by: Yilun Lin <yllin@chromium.org>
>
> The patch looks good to me but as I don't have the hardware to test this, could
> I get a Tested-by Pi-Hsun if possible before queuing in chrome-platform-5.4
>
> Thanks,
> Enric
>
> > ---
> >
> >  drivers/platform/chrome/cros_ec_rpmsg.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> > index 5d3fb2abad1d..6f34fe629e2c 100644
> > --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> > +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> > @@ -236,6 +236,25 @@ static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
> >       cancel_work_sync(&ec_rpmsg->host_event_work);
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +static int cros_ec_rpmsg_suspend(struct device *dev)
> > +{
> > +     struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> > +
> > +     return cros_ec_suspend(ec_dev);
> > +}
> > +
> > +static int cros_ec_rpmsg_resume(struct device *dev)
> > +{
> > +     struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> > +
> > +     return cros_ec_resume(ec_dev);
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(cros_ec_rpmsg_pm_ops, cros_ec_rpmsg_suspend,
> > +                      cros_ec_rpmsg_resume);
> > +
> >  static const struct of_device_id cros_ec_rpmsg_of_match[] = {
> >       { .compatible = "google,cros-ec-rpmsg", },
> >       { }
> > @@ -246,6 +265,7 @@ static struct rpmsg_driver cros_ec_driver_rpmsg = {
> >       .drv = {
> >               .name   = "cros-ec-rpmsg",
> >               .of_match_table = cros_ec_rpmsg_of_match,
> > +             .pm     = &cros_ec_rpmsg_pm_ops,
> >       },
> >       .probe          = cros_ec_rpmsg_probe,
> >       .remove         = cros_ec_rpmsg_remove,
> >
