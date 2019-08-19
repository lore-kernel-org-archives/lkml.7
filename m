Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56080C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A62E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uyh+uiK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfHSH6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:58:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39551 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfHSH6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:58:35 -0400
Received: by mail-vs1-f66.google.com with SMTP id y62so595303vsb.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FY2ZK8jbTU1ozDDRr8vUXsHqK4aXnekG9ru1GMfhss=;
        b=Uyh+uiK8JClxk5NbW6qP4yg7djHjjtMS5906hdZ2wcI9WsqK7bhIsA2KGUdHiMavvS
         MEk6YuncME4pW8B+5dX1MLBVL837L7fZdzZsXCKMmQDffEsZrZdbtVJILnUoUFbwzbyU
         PbaNQH4YhAxb8u15DvaYs7Pyu2c/HvgEhP/qT0eRbyT8R9OiYLJNk2nBF4kf3s2CnEUC
         urhgnaoKmLq9/Vv19XcizK6eAv6rvWMRDF27CrK32gk9k5cUYAMJXF4vM/Izb7yqbL89
         UBxRSTKBhwNtQWSvoQhfv427fgcq7pU0vUB+rHD/eA36vvmdyzPcjijbgGC09vRxdN3r
         RXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FY2ZK8jbTU1ozDDRr8vUXsHqK4aXnekG9ru1GMfhss=;
        b=WO3Hz00TXJ+3lSTYoIeXSTayCZN7pt3G9VUbYIeQ9VWC9Ac26gcM0BU615gBgGjgbK
         r1ni/hiOtE28ysEddTu5MQM9TlqC7ZnbwaK8e0K6df8JvaogIa57Eyig52bvm4Cuwp2/
         DrHfxU+ao6tA+BdhAEQsCtYZBCpr4TUTdy+kbL2JkZmp3EUL+wK4SEIkBf8paWuNFC6c
         umZhbZ1yOxGPaNP9myUSw/ZMUrEmeroqYnSQnjVN3VzPodha2Bms37qsMLhEaesYJaxz
         Sd7rm7F8dXvrmfYPNO1hmh8HFyyclWhe2oOsfnLJgXeRBQqrJS5c3T+oh8DN3atrDeXw
         i34g==
X-Gm-Message-State: APjAAAVk+f5383JkG+jHmSzfwA6hOLisOADJ8ab/03wdwdXmYf7qpbVK
        /A/Smpr10jz6wli42ABurSvILSHgxhS/E9I5VqRumQ==
X-Google-Smtp-Source: APXvYqyKxPz2CxmIKdzi0DiriB6KW6QXt5TbeeA74BFHRyo1yokK3Cf+d6g95NEFzI31kvr5e4xaRZ4hsjI4/jVHieE=
X-Received: by 2002:a05:6102:7d5:: with SMTP id y21mr13140149vsg.9.1566201514268;
 Mon, 19 Aug 2019 00:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <534b5017c2210ba8d541c206dace204d6617b4c9.1564091601.git.amit.kucheria@linaro.org>
 <5d577d77.1c69fb81.b6b07.83e6@mx.google.com>
In-Reply-To: <5d577d77.1c69fb81.b6b07.83e6@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 19 Aug 2019 13:28:23 +0530
Message-ID: <CAHLCerMpWTVquyM3fYQxz-ZhDvnY276hfnZvZOmjV--cgm53UQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] drivers: thermal: tsens: Add debugfs support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 9:37 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-07-25 15:18:39)
> > Dump some basic version info and sensor details into debugfs
> >
>
> Maybe you can put some sample output in the commit text.

Will do.

> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 85 +++++++++++++++++++++++++++++
> >  drivers/thermal/qcom/tsens.c        |  2 +
> >  drivers/thermal/qcom/tsens.h        |  6 ++
> >  3 files changed, 93 insertions(+)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 7437bfe196e5..7ab2e740a1da 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> >   */
> >
> > +#include <linux/debugfs.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/nvmem-consumer.h>
> > @@ -139,6 +140,79 @@ int get_temp_common(struct tsens_sensor *s, int *temp)
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +static int dbg_sensors_show(struct seq_file *s, void *data)
> > +{
> > +       struct platform_device *pdev = s->private;
> > +       struct tsens_priv *priv = platform_get_drvdata(pdev);
> > +       int i;
> > +
> > +       seq_printf(s, "max: %2d\nnum: %2d\n\n",
> > +                  priv->feat->max_sensors, priv->num_sensors);
> > +
> > +       seq_puts(s, "      id   slope  offset\n------------------------\n");
> > +       for (i = 0;  i < priv->num_sensors; i++) {
> > +               seq_printf(s, "%8d%8d%8d\n", priv->sensor[i].hw_id,
>
> Does this not have spaces between the digits on purpose?

Nice catch. The 8-char width above hid the problem. Will add.

> > +                          priv->sensor[i].slope, priv->sensor[i].offset);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int dbg_version_show(struct seq_file *s, void *data)
> > +{
> > +       struct platform_device *pdev = s->private;
> > +       struct tsens_priv *priv = platform_get_drvdata(pdev);
> > +       u32 maj_ver, min_ver, step_ver;
> > +       int ret;
> > +
> > +       if (tsens_ver(priv) > VER_0_1) {
> > +               ret = regmap_field_read(priv->rf[VER_MAJOR], &maj_ver);
> > +               if (ret)
> > +                       return ret;
> > +               ret = regmap_field_read(priv->rf[VER_MINOR], &min_ver);
> > +               if (ret)
> > +                       return ret;
> > +               ret = regmap_field_read(priv->rf[VER_STEP], &step_ver);
> > +               if (ret)
> > +                       return ret;
> > +               seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
> > +       } else {
> > +               seq_puts(s, "0.1.0\n");
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +DEFINE_SHOW_ATTRIBUTE(dbg_version);
> > +DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
> > +
> > +static void tsens_debug_init(struct platform_device *pdev)
> > +{
> > +       struct tsens_priv *priv = platform_get_drvdata(pdev);
> > +       struct dentry *root, *file;
> > +
> > +       root = debugfs_lookup("tsens", NULL);
>
> Does this get created many times? Why doesn't tsens have a pointer to
> the root saved away somewhere globally?
>

I guess we could call the statement below to create the root dir and
save away the pointer. I was trying to avoid #ifdef CONFIG_DEBUG_FS in
init_common() and instead have all of it in a single function that
gets called once per instance of the tsens controller.

> > +       if (!root)
> > +               priv->debug_root = debugfs_create_dir("tsens", NULL);
> > +       else
> > +               priv->debug_root = root;
> > +
> > +       file = debugfs_lookup("version", priv->debug_root);
> > +       if (!file)
> > +               debugfs_create_file("version", 0444, priv->debug_root,
> > +                                   pdev, &dbg_version_fops);
> > +
> > +       /* A directory for each instance of the TSENS IP */
> > +       priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
> > +       debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
> > +
> > +       return;
> > +}
