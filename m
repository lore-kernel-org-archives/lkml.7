Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF7C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02975208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5UWY1gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfFYOGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:06:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35813 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFYOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:06:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so16429908ljh.2;
        Tue, 25 Jun 2019 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gwp5TPT2ciji6ZbRTS8ylz/3kQtDNDOoQTxqYxzhue4=;
        b=B5UWY1gddbzn9ZLIi8SZCis+WjCApR9XfktQCcFIAjw0Qdpn1tYHBslBg6Fm0bv5M9
         Fihue0aKzZs/rPMWqLdluURhozdqsw46dLIgG2qxPeuLs2zBx5md0t3mp7D/ZS1FgK05
         hR/B9zbdpyMY0pPE4xbbwUwQwdfQc1m7T4SKUSy71cJ8s4QOGQ6xvmP/seeu/1haYNix
         RWFBcSbGirNkGljtsf4Whr5xFTrL2BY+exlqkypZAYlhMmCa43IKbiGa6ggbDMkYImBH
         tAi7qTRfAbThUZ9xxVKCjN3J2fOGOa+7RvQB70odU2vMpPgGt9hq8IlnbbhqDUpUncef
         SGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gwp5TPT2ciji6ZbRTS8ylz/3kQtDNDOoQTxqYxzhue4=;
        b=kG4+dkEjZ7aIKsIZJP4/o9UnKvaxwZb81oUT8MWNYKLMUxfGcHDjqGg1xahaPo+QY6
         8CdsE5U2OzKqJi9F1mmrkQhoFSWZm0NNKK32v2tTHqszh+EyZ0cJ3CVJSo/zoVEPS4OC
         7gktZjNd60GsJaZsRLOl/6EHIPDLRhGdsGRDa84oBZKaPvVi4SgHEM8a2dWhfUaPJJAO
         OV+Rs1JpoLuzyKvrkRl30iptj5Yp8K3y04JP5ocT+74RjGRe5q4vbB9TuVygPAGbevkP
         Jk5HfKV0PwomNocol2c0fCEUmYdx9N1hExtGLZvkLQuF+EseBq99z7/OUUpLcb2HuVFp
         16FQ==
X-Gm-Message-State: APjAAAVZUs5ZZIQvph0ejLuF3TSZdfqsakqn9vpmT9lD9dZMdpfzjjQU
        hvJfBzHmLVvKMp/Bevc4k1t29woNPPum2uEgUQWeyxOw
X-Google-Smtp-Source: APXvYqyD9vbCXVj03O4VOu4s63qOdHOwOoitgDj9Psv2kO0edfMrJWar0ZJjhTNy7ix+aZWgLSVPOZL/wDQHhlDtods=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr24948199lji.115.1561471572106;
 Tue, 25 Jun 2019 07:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <1561446674-25084-1-git-send-email-robert.chiras@nxp.com> <1561446674-25084-3-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1561446674-25084-3-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 Jun 2019 11:06:00 -0300
Message-ID: <CAOMZO5C2syuzyGcpjVOvSvDghaA-ifc8oL-pqhivP49wBf=GSw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/panel: Add support for Raydium RM67191 panel driver
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Tue, Jun 25, 2019 at 4:28 AM Robert Chiras <robert.chiras@nxp.com> wrote:

> +static int rad_bl_get_brightness(struct backlight_device *bl)
> +{
> +       struct mipi_dsi_device *dsi = bl_get_data(bl);
> +       struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
> +       struct device *dev = &dsi->dev;
> +       u16 brightness;
> +       int ret;
> +
> +       if (!rad->prepared)
> +               return 0;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "\n");

Please remove this debug line.

> +       if (!rad->prepared)
> +               return 0;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "New brightness: %d\n", bl->props.brightness);

Please remove it.

> +       ret = of_property_read_u32(np, "dsi-lanes", &dsi->lanes);
> +       if (ret) {
> +               dev_err(dev, "Failed to get dsi-lanes property (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       panel->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);

Even it is optional, you still need to check for error and propagate
it in the case of error.

Otherwise defer probe will not work.

> +       ret = drm_panel_add(&panel->panel);
> +       if (ret)
> +               return ret;
> +
> +

One blank line is enough.
