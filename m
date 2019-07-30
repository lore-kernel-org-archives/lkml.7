Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B69C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0742171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bf7rirDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfG3Mn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:43:27 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36257 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfG3Mn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:43:27 -0400
Received: by mail-ua1-f68.google.com with SMTP id v20so25394002uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6wRViYyOWOjPxfwTwpd7ZKAphvKvndXByx/I3gmhgM=;
        b=Bf7rirDHAeuqVazyBmmQahwZ8Kk6uXME/sJ4S1x/1vwaOJ5ZRediYxCNRUUkG6Er/o
         F9QOhQ3wBNT/urZ8xA5XFC3A5TELezJp1B5kPYZLEOKp/J0Pd+yVDPXc6512voXDvZ62
         zWam//JgjoR8OqxSsPzbh4G+5g4frmi+kw4Q0VLaV7a4irCQnNJzzeVdEKS+dwCOlA6Z
         cteFrmYQKDUgVxgl5OTXPDUqh3dNLE1JHymbOckCfvNapPIIWwhhc7DxnFuLsi9/DK2C
         1Kfh/uhzGKafIy23Nky85H2upPfV1vufp6Wmwjyctd4xnIvmL5YWfm46ViWb7VPMREw5
         dndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6wRViYyOWOjPxfwTwpd7ZKAphvKvndXByx/I3gmhgM=;
        b=UrONi5bAZgnL51acgPz/bzSXxbqJhbR84bcMr5wtJg+m2UVde9jdRBZORc9YLljN0t
         eRO1Twx91h1jkSNbtLrmMNezIXmcj0FWY5EMA60pOVoMsIALjDMpyiN6JD8i69FkTPwd
         f3NRlfSX5gD5kMYyRY/THQzMEZ5IbRjt/V5YF0/KyMOGsuvcpJ4BAws9ifIwFPdrK5ui
         R1s45YnstrQm+q7mIhCU/lilLFRy6RwfmXrPJ07MDCvTQm090WInIb+a8p3fZDHhCFmZ
         1xnNYt/t7DAgkj2oq1tgEOdmb93YN59wQtABCtWwbq1o3fQxEpzgQsrCXS02hAaf/I/l
         j4oA==
X-Gm-Message-State: APjAAAWW+kcYN/MwJB8BxdDs+PZiBSbyXU/L4rRiASpclnHrBkbv5QVl
        +U0Os41vgJ4l00NnOtZr5OaCBjmEmxnTY9MgG44=
X-Google-Smtp-Source: APXvYqyznszebTEIVOvBWRKmByIxSG9KV/KSY8D57fHDAS9Mn8/y43rIykBZ+WOH5BYHgErrIAuv7mwSD+zOOvOz/jA=
X-Received: by 2002:ab0:23ce:: with SMTP id c14mr4415317uan.77.1564490606044;
 Tue, 30 Jul 2019 05:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <1564418001-24940-1-git-send-email-thara.gopinath@linaro.org> <1564418001-24940-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1564418001-24940-2-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 30 Jul 2019 18:13:14 +0530
Message-ID: <CAHLCerO_5CUmdfdyogc0GwKPtPU4xYLU-FqzB8a8y07mnipTuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: Extend AOSS QMP driver to support
 resources that are used to wake up the SoC.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:03 PM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> The AOSS QMP driver is extended to communicate with the additional
> resources. These resources are then registered as cooling devices
> with the thermal framework.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/soc/qcom/qcom_aoss.c | 129 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index 5f88519..010877e 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -10,6 +10,8 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/thermal.h>
> +#include <linux/slab.h>
>
>  #define QMP_DESC_MAGIC                 0x0
>  #define QMP_DESC_VERSION               0x4
> @@ -40,6 +42,16 @@
>  /* 64 bytes is enough to store the requests and provides padding to 4 bytes */
>  #define QMP_MSG_LEN                    64
>
> +#define QMP_NUM_COOLING_RESOURCES      2
> +
> +static bool qmp_cdev_init_state = 1;
> +
> +struct qmp_cooling_device {
> +       struct thermal_cooling_device *cdev;
> +       struct qmp *qmp;
> +       bool state;
> +};
> +
>  /**
>   * struct qmp - driver state for QMP implementation
>   * @msgram: iomem referencing the message RAM used for communication
> @@ -69,6 +81,7 @@ struct qmp {
>
>         struct clk_hw qdss_clk;
>         struct genpd_onecell_data pd_data;
> +       struct qmp_cooling_device *cooling_devs;
>  };
>
>  struct qmp_pd {
> @@ -385,6 +398,117 @@ static void qmp_pd_remove(struct qmp *qmp)
>                 pm_genpd_remove(data->domains[i]);
>  }
>
> +static int qmp_cdev_get_max_state(struct thermal_cooling_device *cdev,
> +                                 unsigned long *state)
> +{
> +       *state = qmp_cdev_init_state;
> +       return 0;
> +}
> +
> +static int qmp_cdev_get_cur_state(struct thermal_cooling_device *cdev,
> +                                 unsigned long *state)
> +{
> +       struct qmp_cooling_device *qmp_cdev = cdev->devdata;
> +
> +       *state = qmp_cdev->state;
> +       return 0;
> +}
> +
> +static int qmp_cdev_set_cur_state(struct thermal_cooling_device *cdev,
> +                                 unsigned long state)
> +{
> +       struct qmp_cooling_device *qmp_cdev = cdev->devdata;
> +       char buf[QMP_MSG_LEN] = {};
> +       bool cdev_state;
> +       int ret;
> +
> +       /* Normalize state */
> +       cdev_state = !!state;
> +
> +       if (qmp_cdev->state == state)
> +               return 0;
> +
> +       snprintf(buf, sizeof(buf),
> +                "{class: volt_flr, event:zero_temp, res:%s, value:%s}",
> +                       qmp_cdev->name,

This won't compile, there is no member "name" in qmp_cooling_device.

> +                       cdev_state ? "off" : "on");
> +
> +       ret = qmp_send(qmp_cdev->qmp, buf, sizeof(buf));
> +
> +       if (!ret)
> +               qmp_cdev->state = cdev_state;
> +
> +       return ret;
> +}
> +
> +static struct thermal_cooling_device_ops qmp_cooling_device_ops = {
> +       .get_max_state = qmp_cdev_get_max_state,
> +       .get_cur_state = qmp_cdev_get_cur_state,
> +       .set_cur_state = qmp_cdev_set_cur_state,
> +};
> +
> +static int qmp_cooling_device_add(struct qmp *qmp,
> +                                 struct qmp_cooling_device *qmp_cdev,
> +                                 struct device_node *node)
> +{
> +       char *cdev_name = (char *)node->name;
> +
> +       qmp_cdev->qmp = qmp;
> +       qmp_cdev->state = qmp_cdev_init_state;
> +       qmp_cdev->cdev = devm_thermal_of_cooling_device_register
> +                               (qmp->dev, node,
> +                               cdev_name,
> +                               qmp_cdev, &qmp_cooling_device_ops);
> +
> +       if (IS_ERR(qmp_cdev->cdev))
> +               dev_err(qmp->dev, "unable to register %s cooling device\n",
> +                       cdev_name);
> +
> +       return PTR_ERR_OR_ZERO(qmp_cdev->cdev);
> +}
> +
> +static int qmp_cooling_devices_register(struct qmp *qmp)
> +{
> +       struct device_node *np, *child;
> +       int count = QMP_NUM_COOLING_RESOURCES;
> +       int ret;
> +
> +       np = qmp->dev->of_node;
> +
> +       qmp->cooling_devs = devm_kcalloc(qmp->dev, count,
> +                                        sizeof(*qmp->cooling_devs),
> +                                        GFP_KERNEL);
> +
> +       if (!qmp->cooling_devs)
> +               return -ENOMEM;
> +
> +       for_each_available_child_of_node(np, child) {
> +               if (!of_find_property(child, "#cooling-cells", NULL))
> +                       continue;
> +               ret = qmp_cooling_device_add(qmp, &qmp->cooling_devs[count++],
> +                                            child);
> +               if (ret)
> +                       goto uroll_cooling_devices;

unroll?

> +       }
> +
> +       return 0;
> +
> +uroll_cooling_devices:
> +       while (--count >= 0)
> +               thermal_cooling_device_unregister
> +                       (qmp->cooling_devs[count].cdev);
> +
> +       return ret;
> +}
> +
> +static void qmp_cooling_devices_remove(struct qmp *qmp)
> +{
> +       int i;
> +
> +       for (i = 0; i < QMP_NUM_COOLING_RESOURCES; i++)
> +               thermal_cooling_device_unregister(qmp->cooling_devs[i].cdev);
> +}
> +
>  static int qmp_probe(struct platform_device *pdev)
>  {
>         struct resource *res;
> @@ -433,6 +557,10 @@ static int qmp_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_remove_qdss_clk;
>
> +       ret = qmp_cooling_devices_register(qmp);
> +       if (ret)
> +               dev_err(&pdev->dev, "failed to register aoss cooling devices\n");
> +
>         platform_set_drvdata(pdev, qmp);
>
>         return 0;
> @@ -453,6 +581,7 @@ static int qmp_remove(struct platform_device *pdev)
>
>         qmp_qdss_clk_remove(qmp);
>         qmp_pd_remove(qmp);
> +       qmp_cooling_devices_remove(qmp);
>
>         qmp_close(qmp);
>         mbox_free_channel(qmp->mbox_chan);
> --
> 2.1.4
>
