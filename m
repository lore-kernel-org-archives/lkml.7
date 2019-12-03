Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32323C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027912073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbIBHcDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCMEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:04:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38666 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfLCMEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:04:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so2734307lfm.5;
        Tue, 03 Dec 2019 04:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41gz7Pr3bu95rsc2AmP+uk3DRv43sggDSJGl0PUK5A8=;
        b=vbIBHcDr/qXhhDiGkKQDs2V+qghI3vJUjWRJZh+QM0n7WjE7nswn5FuYePJCHdHzT2
         avY0Mreifj3ivibbFeMUjPiHT+tse5RWRK63vnjmUS+IAjcQYfzm2Xx8LcDAK7FAmJRK
         +yUPtu9k6n+mzGGTQF8ICWdPsQnKyju/t4JU96PqX2wlaY8qdTg4pn2QAJeK+icv1Lky
         lfOihAkVdTDKuyvGQSRNZbXxh/DH+GeYqf4cXJLUXlCglkncka1j6IrhzSORGoPely9n
         b+4NVU8DzzaWt+bB8B1RFgwqtyAi3FMrobRFKfA05P2euNq7kzqUr+nm7yEpv8HcnxE1
         NJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41gz7Pr3bu95rsc2AmP+uk3DRv43sggDSJGl0PUK5A8=;
        b=KEZikFOT5XHSrE49BS67wCUC83Nebbl/0p2z7hDnOJ5hz43P2CWxfnWu//cAjzAVMr
         MpIOe/ksmPWNZdiUrXDHw1AmCVaD+4Pj0Wvu40h9Dg9fu4gXmofK/fh3n4yKn3bMU5aQ
         lhhIPh0qrLATwHM61SJ8NBfLd0qmb5s88LvT4O83nFcD9KVBBPV9ZJ0ryxYP5CfgtWE6
         TohlKrtVXPXgYWMwbrNkwQUmY3K5AFymcAGXXREh4KU33kTmumqUpCq1B8uJ3P1INRG0
         Hbjgy3mQRWfiG4Rfg8dUNw1+mIuNSne0idwTNi3O5aDoNvQ8jzgITpIasb3pJCt+Jx7o
         8iRw==
X-Gm-Message-State: APjAAAVj1gx1fk8fAE3VGQZ6CyD+CeazCt/aUbbXkfnTZ0J7wn1r0YH6
        ym88E//GfJurexSNjijlm3C2RKdy1q4GX7IIuZQ=
X-Google-Smtp-Source: APXvYqzfZ00PJpD/WaW2YVAH/ohfpVaLwioqHtBL+vwNMKZqqB4MnjZ7lOePHAJd+K2wIAXl/jgDkhuvxG7sGPwy6Sc=
X-Received: by 2002:ac2:4119:: with SMTP id b25mr2532251lfi.90.1575374683194;
 Tue, 03 Dec 2019 04:04:43 -0800 (PST)
MIME-Version: 1.0
References: <08794fde-cdd0-287c-62bf-e2e3b8c80686@gmail.com> <20191203101509.wte47aad5k4mqu2y@pengutronix.de>
In-Reply-To: <20191203101509.wte47aad5k4mqu2y@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Dec 2019 09:04:58 -0300
Message-ID: <CAOMZO5Cn993y9VeFN6hPO3-cfNnUKiuFd_rqAZ8htz=dO6t6ig@mail.gmail.com>
Subject: Re: Issue with imx_get_temp()
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Igor Plyatov <plyatov@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Tue, Dec 3, 2019 at 7:15 AM Marco Felsch <m.felsch@pengutronix.de> wrote:

> Mh.. it seems that the irq gets enabled before a irq-handler is
> registered. As your backlog shows the thermal_zone_device_register()
> triggers a imx_get_temp() and during boot the irq_enabled is false and
> it seems that your temperature is below the alarm_temp. So in such a
> case the enable_irq() is executed. I don't know what happens if we
> enable a irq without a irq-handler.

I think your analysis makes sense.

Should we move the ' data->irq_enabled = true' just prior to calling
thermal_zone_device_register()?

--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -803,6 +803,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
                goto legacy_cleanup;
        }

+       data->irq_enabled = true;
        data->tz = thermal_zone_device_register("imx_thermal_zone",
                                                IMX_TRIP_NUM,
                                                BIT(IMX_TRIP_PASSIVE), data,
@@ -837,7 +838,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
        regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
                     data->socdata->measure_temp_mask);

-       data->irq_enabled = true;
        data->mode = THERMAL_DEVICE_ENABLED;

        ret = devm_request_threaded_irq(&pdev->dev, data->irq,
