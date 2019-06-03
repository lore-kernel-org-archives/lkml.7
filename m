Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD259C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8681F2807A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agZsHnu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfFCKII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:08:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33076 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfFCKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:08:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so8658766qtf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20lifKx9/NjRBCOxPqWlC+JnTIwt3odrmH3LlHTbl1E=;
        b=agZsHnu8Zj/6uLXUE+jJXg1IqtCdweLNoYNsVPvASRgBZeD9x8/9UIan0+otNFOVUx
         ul0NRWJcKgKQG5EJ9jfOqNkJUlOan38dorkZggntK6I1acGyv/Fv5ffquyuNcMaznEsz
         aYrpdo3PiopIiRBMa23wh8BL8Vc9Emp44sBlXY9mpj5N0y0MCGIN8nfQxaHPiZbSKJqD
         BkR3iHFko0dcQxgCkFuVxBEASgjPkrOzeKSx2M/mNDeEHiWd2WRqBpzYIZUrHJE85FEP
         OGUSb6cSN3oo6jkMP3E2ri6giWntEAD/huMAL7LV5NIfuv/e6X1SeXkprKv6u1z7YaY7
         A2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20lifKx9/NjRBCOxPqWlC+JnTIwt3odrmH3LlHTbl1E=;
        b=BQ6gZhlkjui6B1F5YNu39j/RiNipNfE1aqLmGOP7t/f314Nndl+eLT/Fha7nmYHqo0
         FUKEE85tPyokKNDhVhWimWPf/oUYh/JbwLBlJjN8hKuESo+328qMv/GW4Btubz5EDPn3
         Ww9InMBw+XvdZ9QZ5fsYdqWsSQXXc9EnFjiOMeAYGHSxJcvo2VUWuW/+HuMbZSi2iw1Z
         VnkG8rFymlyEb0LmYcRMlW9rgQ9xxFf7zKAslw9UtceAKcXl3JBgaZdOuiCYwRNfkEdA
         /lkRax4xSwFD26LM4TYnBLpb5LdrCWo/PSh8pFkdJie7x5ngLOyBgXXKarBgcCa2Af1I
         FAaA==
X-Gm-Message-State: APjAAAWNxtRt9JCqZ0xrFBn1jnESCHdG38Tl7phkhN5XbBPH7fp/hMVf
        1SJUEHypWO0R6NS73shBpgX3Fl0168gYggkzk7C8fhNO
X-Google-Smtp-Source: APXvYqwDIuo0qdB5oSj9lE+DT+kc4ZMbN/NX3DiYr4g8I3e/AA7b0IpvUI3eG4rthqPiMiLSambUwJrP8Hjpui5v1h8=
X-Received: by 2002:ac8:26dc:: with SMTP id 28mr21560600qtp.88.1559556486585;
 Mon, 03 Jun 2019 03:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com> <1558521304-27469-18-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1558521304-27469-18-git-send-email-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 3 Jun 2019 11:07:55 +0100
Message-ID: <CAJ9a7ViQq-bdAw7HOOkSxinC0jhRjpAr-oJVv5GLHfBRpFu6hw@mail.gmail.com>
Subject: Re: [PATCH v4 17/30] coresight: Make device to CPU mapping generic
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 22 May 2019 at 11:37, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> The CoreSight components ETM and CPU-Debug are always associated
> with CPUs. Replace the of_coresight_get_cpu() with a platform
> agnostic helper, in preparation to add ACPI support.
>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-cpu-debug.c |  3 +--
>  drivers/hwtracing/coresight/coresight-platform.c  | 18 +++++++++++++-----
>  include/linux/coresight.h                         |  7 +------
>  3 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index e8819d7..07a1367 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -572,14 +572,13 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
>         struct device *dev = &adev->dev;
>         struct debug_drvdata *drvdata;
>         struct resource *res = &adev->res;
> -       struct device_node *np = adev->dev.of_node;
>         int ret;
>
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>         if (!drvdata)
>                 return -ENOMEM;
>
> -       drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> +       drvdata->cpu = coresight_get_cpu(dev);
>         if (per_cpu(debug_drvdata, drvdata->cpu)) {
>                 dev_err(dev, "CPU%d drvdata has already been initialized\n",
>                         drvdata->cpu);
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 5d78f4f..ba8c146 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -151,12 +151,14 @@ static void of_coresight_get_ports(const struct device_node *node,
>         }
>  }
>
> -int of_coresight_get_cpu(const struct device_node *node)
> +static int of_coresight_get_cpu(struct device *dev)
>  {
>         int cpu;
>         struct device_node *dn;
>
> -       dn = of_parse_phandle(node, "cpu", 0);
> +       if (!dev->of_node)
> +               return 0;
> +       dn = of_parse_phandle(dev->of_node, "cpu", 0);
>         /* Affinity defaults to CPU0 */
>         if (!dn)
>                 return 0;
> @@ -166,7 +168,6 @@ int of_coresight_get_cpu(const struct device_node *node)
>         /* Affinity to CPU0 if no cpu nodes are found */
>         return (cpu < 0) ? 0 : cpu;
>  }
> -EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>
>  /*
>   * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> @@ -240,8 +241,6 @@ static int of_get_coresight_platform_data(struct device *dev,
>         bool legacy_binding = false;
>         struct device_node *node = dev->of_node;
>
> -       pdata->cpu = of_coresight_get_cpu(node);
> -
>         /* Get the number of input and output port for this component */
>         of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
>
> @@ -300,6 +299,14 @@ of_get_coresight_platform_data(struct device *dev,
>  }
>  #endif
>
> +int coresight_get_cpu(struct device *dev)
> +{
> +       if (is_of_node(dev->fwnode))
> +               return of_coresight_get_cpu(dev);

No of_coresight_get_cpu() will be defined if CONFIG_OF _not_ defined.
This will hit an implicit declaration compile error in this case.

Mike

> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(coresight_get_cpu);
> +
>  struct coresight_platform_data *
>  coresight_get_platform_data(struct device *dev)
>  {
> @@ -318,6 +325,7 @@ coresight_get_platform_data(struct device *dev)
>
>         /* Use device name as sysfs handle */
>         pdata->name = dev_name(dev);
> +       pdata->cpu = coresight_get_cpu(dev);
>
>         if (is_of_node(fwnode))
>                 ret = of_get_coresight_platform_data(dev, pdata);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index e2b95e0..98a4440 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -292,12 +292,7 @@ static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
>
>  #endif
>
> -#ifdef CONFIG_OF
> -extern int of_coresight_get_cpu(const struct device_node *node);
> -#else
> -static inline int of_coresight_get_cpu(const struct device_node *node)
> -{ return 0; }
> -#endif
> +extern int coresight_get_cpu(struct device *dev);
>
>  struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
