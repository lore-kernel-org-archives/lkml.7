Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6396C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCAA21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="XdToCh9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfJHSN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:13:56 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39185 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJHSN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:13:56 -0400
Received: by mail-yb1-f195.google.com with SMTP id v37so6229009ybi.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sANWpf7SbJffFLn8uK1OKsyLQQ9iWrTZx+BSfUSm8I=;
        b=XdToCh9QDRh/H9f0F0QJ8JM3s1eS2l793mLVQUMTji6EAXlMvEeldcEyV/fuVvZLoc
         fAKKXRZtZSv7p8Imt1NUmnovMuGsT14JWFTKx5eGR9RKyWX/cX2CCT1OdXwrDhzs4EzP
         rA/zpzZjRfTOGDXKH4qJUF4MSc/e6O+iUAPD6q1MX3/1EUqb9KxGl5FcMTPQNmdkzj9d
         7OJjElaqUzBKq5D2ASaREPH6vBk4iYNV8abU26HxtOoJePCtQBJij4juPbwkUB0Ze7E1
         wHXz+qI4SsItc2vB/4HtHGS7ttsDcDzhr47nbib+DmwIl3A5RPR2ZAQPhrtieVq91rWr
         QZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sANWpf7SbJffFLn8uK1OKsyLQQ9iWrTZx+BSfUSm8I=;
        b=uMioczE5MgBn21J0wkCWWa2CbI1l87L3QiX4JP8uPJ9ATQwUlnee6YI1/E4Yn+/YN/
         D1UAcAOSv7c0wC5BYC+KuwrQEmK7Z9TcpBNw3sSqsfsUBvmmcilVRdqCn2v3h4CDbdI3
         S2CoLlkHL2T6zEbaNIb7RuXz1RgDUq5XDl8RQmniGdYXivXJCYXCAscKCvzQtNJTUgOM
         LXzP21BnZXUWH6lFn+0OEmCyFZnOrULvrp5e0P83ORhPDzcH7oTLFQRL8kOkjEaxgCqr
         ICG+cqKxpekDJ4Z3YZ5nzbATNQhVVwySnZgECan7z7RyofpW2gA/YJLWziEdMOuYQjuw
         4KPw==
X-Gm-Message-State: APjAAAXTNQ79eUPhHIJcnCkAXejcw2ADvlRmoayn5VzLqCqRpXAql6fd
        kOML+xtSXY8MUBSuLOEBlkheaTN+5FsWv6Zj5OPdBg==
X-Google-Smtp-Source: APXvYqwW44xdPDx8tKlaw0Sjh+0GenowCi2KW4gPCY0jXqeplvaBZKmI0qnfvbnEzjlXTWV0KOHNZKHaitaPLzUw69A=
X-Received: by 2002:a25:9d07:: with SMTP id i7mr14600396ybp.427.1570558432944;
 Tue, 08 Oct 2019 11:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190923015908.26627-1-lowry.li@arm.com> <20191008174753.GC85762@art_vandelay>
In-Reply-To: <20191008174753.GC85762@art_vandelay>
From:   Sean Paul <sean@poorly.run>
Date:   Tue, 8 Oct 2019 14:13:17 -0400
Message-ID: <CAMavQKLkEgkts=hqMHXRe=t6DRbRSJO0fC6DJr5e6cXB=XRobA@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Adds power management support
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 1:47 PM Sean Paul <sean@poorly.run> wrote:
>
> On Mon, Sep 23, 2019 at 01:59:25AM +0000, Lowry Li (Arm Technology China) wrote:
> > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> >
> > Adds system power management support in KMS kernel driver.
> >
> > Depends on:
> > https://patchwork.freedesktop.org/series/62377/
> >
> > Changes since v1:
> > Since we have unified mclk/pclk/pipeline->aclk to one mclk, which will
> > be turned on/off when crtc atomic enable/disable, removed runtime power
> > management.
> > Removes run time get/put related flow.
> > Adds to disable the aclk when register access finished.
> >
> > Changes since v2:
> > Rebases to the drm-misc-next branch.
> >
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > ---
> >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  1 -
> >  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 65 +++++++++++++++++--
> >  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +
> >  .../gpu/drm/arm/display/komeda/komeda_drv.c   | 30 ++++++++-
> >  4 files changed, 91 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 38d5cb20e908..b47c0dabd0d1 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -5,7 +5,6 @@
> >   *
> >   */
> >  #include <linux/clk.h>
> > -#include <linux/pm_runtime.h>
> >  #include <linux/spinlock.h>
> >
> >  #include <drm/drm_atomic.h>
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > index bee4633cdd9f..8a03324f02a5 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -258,7 +258,7 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
> >                         product->product_id,
> >                         MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id));
> >               err = -ENODEV;
> > -             goto err_cleanup;
> > +             goto disable_clk;
> >       }
> >
> >       DRM_INFO("Found ARM Mali-D%x version r%dp%d\n",
> > @@ -271,19 +271,19 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
> >       err = mdev->funcs->enum_resources(mdev);
> >       if (err) {
> >               DRM_ERROR("enumerate display resource failed.\n");
> > -             goto err_cleanup;
> > +             goto disable_clk;
> >       }
> >
> >       err = komeda_parse_dt(dev, mdev);
> >       if (err) {
> >               DRM_ERROR("parse device tree failed.\n");
> > -             goto err_cleanup;
> > +             goto disable_clk;
> >       }
> >
> >       err = komeda_assemble_pipelines(mdev);
> >       if (err) {
> >               DRM_ERROR("assemble display pipelines failed.\n");
> > -             goto err_cleanup;
> > +             goto disable_clk;
> >       }
> >
> >       dev->dma_parms = &mdev->dma_parms;
> > @@ -296,11 +296,14 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
> >       if (mdev->iommu && mdev->funcs->connect_iommu) {
> >               err = mdev->funcs->connect_iommu(mdev);
> >               if (err) {
> > +                     DRM_ERROR("connect iommu failed.\n");
> >                       mdev->iommu = NULL;
> > -                     goto err_cleanup;
> > +                     goto disable_clk;
> >               }
> >       }
> >
> > +     clk_disable_unprepare(mdev->aclk);
> > +
> >       err = sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
> >       if (err) {
> >               DRM_ERROR("create sysfs group failed.\n");
> > @@ -313,6 +316,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
> >
> >       return mdev;
> >
> > +disable_clk:
> > +     clk_disable_unprepare(mdev->aclk);
> >  err_cleanup:
> >       komeda_dev_destroy(mdev);
> >       return ERR_PTR(err);
> > @@ -330,8 +335,12 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
> >       debugfs_remove_recursive(mdev->debugfs_root);
> >  #endif
> >
> > +     if (mdev->aclk)
> > +             clk_prepare_enable(mdev->aclk);
> > +
> >       if (mdev->iommu && mdev->funcs->disconnect_iommu)
> > -             mdev->funcs->disconnect_iommu(mdev);
> > +             if (mdev->funcs->disconnect_iommu(mdev))
> > +                     DRM_ERROR("disconnect iommu failed.\n");
> >       mdev->iommu = NULL;
> >
> >       for (i = 0; i < mdev->n_pipelines; i++) {
> > @@ -359,3 +368,47 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
> >
> >       devm_kfree(dev, mdev);
> >  }
> > +
> > +int komeda_dev_resume(struct komeda_dev *mdev)
> > +{
> > +     int ret = 0;
> > +
> > +     clk_prepare_enable(mdev->aclk);
> > +
> > +     if (mdev->iommu && mdev->funcs->connect_iommu) {
> > +             ret = mdev->funcs->connect_iommu(mdev);
> > +             if (ret < 0) {
> > +                     DRM_ERROR("connect iommu failed.\n");
> > +                     goto disable_clk;
> > +             }
> > +     }
> > +
> > +     ret = mdev->funcs->enable_irq(mdev);
> > +
> > +disable_clk:
> > +     clk_disable_unprepare(mdev->aclk);
> > +
> > +     return ret;
> > +}
> > +
> > +int komeda_dev_suspend(struct komeda_dev *mdev)
> > +{
> > +     int ret = 0;
> > +
> > +     clk_prepare_enable(mdev->aclk);
> > +
> > +     if (mdev->iommu && mdev->funcs->disconnect_iommu) {
> > +             ret = mdev->funcs->disconnect_iommu(mdev);
> > +             if (ret < 0) {
> > +                     DRM_ERROR("disconnect iommu failed.\n");
> > +                     goto disable_clk;
> > +             }
> > +     }
> > +
> > +     ret = mdev->funcs->disable_irq(mdev);
> > +
> > +disable_clk:
> > +     clk_disable_unprepare(mdev->aclk);
> > +
> > +     return ret;
> > +}
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > index 8acf8c0601cc..414200233b64 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > @@ -224,4 +224,7 @@ void komeda_print_events(struct komeda_events *evts);
> >  static inline void komeda_print_events(struct komeda_events *evts) {}
> >  #endif
> >
> > +int komeda_dev_resume(struct komeda_dev *mdev);
> > +int komeda_dev_suspend(struct komeda_dev *mdev);
> > +
> >  #endif /*_KOMEDA_DEV_H_*/
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > index 69ace6f9055d..d6c2222c5d33 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/component.h>
> > +#include <linux/pm_runtime.h>
> >  #include <drm/drm_of.h>
> >  #include "komeda_dev.h"
> >  #include "komeda_kms.h"
> > @@ -136,13 +137,40 @@ static const struct of_device_id komeda_of_match[] = {
> >
> >  MODULE_DEVICE_TABLE(of, komeda_of_match);
> >
> > +static int __maybe_unused komeda_pm_suspend(struct device *dev)
> > +{
> > +     struct komeda_drv *mdrv = dev_get_drvdata(dev);
> > +     struct drm_device *drm = &mdrv->kms->base;
> > +     int res;
> > +
> > +     res = drm_mode_config_helper_suspend(drm);
>
> Just noticed this while prepping the -misc pull request.
>
> You should use the atomic helpers instead, drm_atomic_helper_suspend and
> drm_atomic_helper_resume.
>

Hmm, looks like I was mistaken. For some reason, I thought this was
legacy but looking into mode_config_helper_suspend(), that will gets
you kms_helper_poll_disable/enable as well as stashes the state in
mode_config. So less work is better :)

Sean

> > +
> > +     komeda_dev_suspend(mdrv->mdev);
> > +
> > +     return res;
> > +}
> > +
> > +static int __maybe_unused komeda_pm_resume(struct device *dev)
> > +{
> > +     struct komeda_drv *mdrv = dev_get_drvdata(dev);
> > +     struct drm_device *drm = &mdrv->kms->base;
> > +
> > +     komeda_dev_resume(mdrv->mdev);
> > +
> > +     return drm_mode_config_helper_resume(drm);
> > +}
> > +
> > +static const struct dev_pm_ops komeda_pm_ops = {
> > +     SET_SYSTEM_SLEEP_PM_OPS(komeda_pm_suspend, komeda_pm_resume)
> > +};
> > +
> >  static struct platform_driver komeda_platform_driver = {
> >       .probe  = komeda_platform_probe,
> >       .remove = komeda_platform_remove,
> >       .driver = {
> >               .name = "komeda",
> >               .of_match_table = komeda_of_match,
> > -             .pm = NULL,
> > +             .pm = &komeda_pm_ops,
> >       },
> >  };
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
