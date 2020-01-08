Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C56FC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FA920720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578514191;
	bh=HMpUUI05u881FivDVXx8p23Q4WPCIib06475xNf1c9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ycbZUF5PL8EEWOBzvyqvYH1O7eDC8BzEBc9cq/wH1ySRKV9KJpyueQatvq0ikqyXu
	 6JFxgrq8Rhh+KBSoMLn5+4ZIK8DZO9nQGmOToqs2uae236Qn86L2i1CkQjq9NXQaPt
	 xTlhZg+Y24/2jjrAiK/Kwtulv4JEd4H+aKikOmQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAHUJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgAHUJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:09:49 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDAA2072A;
        Wed,  8 Jan 2020 20:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578514189;
        bh=HMpUUI05u881FivDVXx8p23Q4WPCIib06475xNf1c9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lbfmSdy+Wrg1cKLMM72tdGc41LpdFrJUC2MTXQSvs+CnZr9rnij5xj4uZvm0y+nXr
         uzzUOtubqbF077jeXhjPh2tR+aoy7gSUi3nr+OAOKX0TZIp0AvFQiRu6NJmMm8pThE
         5hrTN+D0LmCaARPP6yREK0FbcXzEPtNzLzbmSfgc=
Received: by mail-qk1-f177.google.com with SMTP id t129so3824148qke.10;
        Wed, 08 Jan 2020 12:09:48 -0800 (PST)
X-Gm-Message-State: APjAAAWCcEiPGevYZqCXDNSyAuP5ztv1p9omMdzvEmaN6He/qoG2p+dL
        LTyIcP8wEVTSah3o9U0HaBK673KfL8KKy0+rEQ==
X-Google-Smtp-Source: APXvYqyBzM8hpEjCqsN8vXLIaQ3o5cj0NDc/Yz3b1xjFrRbEN7LH8SmrAR3PWRfmz+8M9gI0InsycHS1b2WLHCaGWPY=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr6192361qkd.223.1578514187969;
 Wed, 08 Jan 2020 12:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20200108052337.65916-1-drinkcat@chromium.org> <20200108052337.65916-8-drinkcat@chromium.org>
In-Reply-To: <20200108052337.65916-8-drinkcat@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Jan 2020 14:09:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jWtrV8-iDzqsefRxr_21jzf7AdSLap8k4hstqK3MBvQ@mail.gmail.com>
Message-ID: <CAL_Jsq+jWtrV8-iDzqsefRxr_21jzf7AdSLap8k4hstqK3MBvQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7, RFC]: drm/panfrost: devfreq: Add support for 2 regulators
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 11:24 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> The Bifrost GPU on MT8183 uses 2 regulators (core and SRAM) for
> devfreq, and provides OPP table with 2 sets of voltages.
>
> TODO: This is incomplete as we'll need add support for setting
> a pair of voltages as well.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_device.h  |  2 ++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 413987038fbfccb..5eb0effded7eb09 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -79,6 +79,22 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>         struct devfreq *devfreq;
>         struct thermal_cooling_device *cooling;
>
> +       /* If we have 2 regulator, we need an OPP table with 2 voltages. */
> +       if (pfdev->regulator_sram) {
> +               const char * const reg_names[] = { "mali", "sram" };
> +
> +               pfdev->devfreq.dev_opp_table =
> +                       dev_pm_opp_set_regulators(dev,
> +                                       reg_names, ARRAY_SIZE(reg_names));
> +               if (IS_ERR(pfdev->devfreq.dev_opp_table)) {
> +                       ret = PTR_ERR(pfdev->devfreq.dev_opp_table);
> +                       pfdev->devfreq.dev_opp_table = NULL;
> +                       dev_err(dev,
> +                               "Failed to init devfreq opp table: %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
>         ret = dev_pm_opp_of_add_table(dev);
>         if (ret == -ENODEV) /* Optional, continue without devfreq */
>                 return 0;
> @@ -119,6 +135,8 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>         if (pfdev->devfreq.cooling)
>                 devfreq_cooling_unregister(pfdev->devfreq.cooling);
>         dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
> +       if (pfdev->devfreq.dev_opp_table)
> +               dev_pm_opp_put_regulators(pfdev->devfreq.dev_opp_table);
>  }
>
>  void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 92d471676fc7823..581da3fe5df8b17 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -91,10 +91,12 @@ struct panfrost_device {
>         struct {
>                 struct devfreq *devfreq;
>                 struct thermal_cooling_device *cooling;
> +               struct opp_table *dev_opp_table;
>                 ktime_t busy_time;
>                 ktime_t idle_time;
>                 ktime_t time_last_update;
>                 atomic_t busy_count;
> +               struct panfrost_devfreq_slot slot[NUM_JOB_SLOTS];

?? Left over from some rebase?

Rob
