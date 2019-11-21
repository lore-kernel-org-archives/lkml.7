Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF54C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB122088F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SLYBtyri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUHA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:00:59 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:36906 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKUHA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:00:58 -0500
Received: by mail-il1-f174.google.com with SMTP id s5so2259878iln.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 23:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70XhVJoIf0CSjHrTRztFdyaZcM5N+1vNz44dhwcRPXw=;
        b=SLYBtyriQY7seuHEQlL2JSt3ilAFTLCs46gN0dKVPB6PjkBZRqNh7NltQlrIcE52WM
         NS1NEPu5eptOkKJvpE2HSpv/lFbdetda9B7b5w8JK7jknek+pKEqkv06FYxZ3lzN0R6J
         Cwg+Cbs8vlomam8/SjUZutICyodcTjUUrT+50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70XhVJoIf0CSjHrTRztFdyaZcM5N+1vNz44dhwcRPXw=;
        b=K2ikpfv2gtIEH6fx55b3AZ+BkkJXQpspzKlPCaSGWh9IjxgCT9FPbl+kP9b6qBXJxa
         H98oGTpOMzBnU3YA5hR/Xm4Aw7zAqRLykSV7g1BePl7S5u5QQGVo8F1+rn1xXQBO10qg
         n6/vzgqw+hrTXhoXI93CwqhGDwmg7DiriIk46ABSld3PJml3RK39G0psRdkaIUE6uTkZ
         shKf0SpqLcTV7WTx2ANDk9SvHyX1oNJzcNGu6V4dNny6mVR92podb1lz/uS39Jh62nna
         S4wnAXmLq4ZYgBtt0AwBb8Pw3U+/iLDU/XqqDG0bHd21C1C3U2FbM1SswLGFyC7Lej+K
         Whxg==
X-Gm-Message-State: APjAAAXAkwNTKrZ3ivEq6skn1HvkaxS+FIaprhhnDSiML4hNd7883Nu2
        IPPJ7W/MfVISJapOvOLu7r7L1znEo5cLtHSLaid+mQ==
X-Google-Smtp-Source: APXvYqz3PHqe/dC8SrMLZ7oJb4SyckZc5EJzgX4VS4wAMnE4d3D2dWe3D5r10a6CIdA4f7qoQvzM2VsFlosI14iwemI=
X-Received: by 2002:a92:5d08:: with SMTP id r8mr8154845ilb.283.1574319657713;
 Wed, 20 Nov 2019 23:00:57 -0800 (PST)
MIME-Version: 1.0
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com> <1557494826-6044-8-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1557494826-6044-8-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 21 Nov 2019 15:00:31 +0800
Message-ID: <CAJMQK-ivho3T1hnD9axV2EMKT3Srs_5zAXLqwts8nojY15fBGg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 9:27 PM michael.kao <michael.kao@mediatek.com> wrote:

> -       tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
> -                                                    &mtk_thermal_ops);
> -       if (IS_ERR(tzdev)) {
> -               ret = PTR_ERR(tzdev);
> -               goto err_disable_clk_peri_therm;
> +       for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +               tz = kmalloc(sizeof(*tz), GFP_KERNEL);
> +               if (!tz)
> +                       return -ENOMEM;
> +
> +               tz->mt = mt;
> +               tz->id = i;
> +
> +               tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i,
> +                               tz, (i == 0) ?
> +                               &mtk_thermal_ops : &mtk_thermal_sensor_ops);
> +
> +               if (IS_ERR(tzdev)) {
> +                       if (IS_ERR(tzdev) != -EACCES) {
                                PTR_ERR(tzdev)

> +                               ret = PTR_ERR(tzdev);
> +                               goto err_disable_clk_peri_therm;
> +                       }
> +               }

This for loop adding thermal zone sensors will not work for mt8173. It
assumes that thermal-zones in dts have subnodes (eg. cpu_thermal,
tzts..) amount equal to num_sensors+1. Otherwise tzdev would be
-ENODEV and thermal failed to be probed.
In mt8183 this is fine, since each thermal zone only has one sensor,
but in mt8173, some sensor appears in multiple thermal zones.

In order to let the change also works for 8173, I think if the error
is -ENODEV, and the id is not 0 (0 is cpu_thermal), prompt a warning
instead of failing. Eg.

                if (IS_ERR(tzdev)) {
+                       if (i > 0 && PTR_ERR(tzdev) == -ENODEV) {
+                               dev_warn(&pdev->dev, "can't find
thermal sensor %d\n", i);
+                               continue;
+                       }
                        if (PTR_ERR(tzdev) != -EACCES) {
