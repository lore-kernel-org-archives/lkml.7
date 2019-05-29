Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC20C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BC420B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfH181h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfE2JdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:33:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32936 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfE2JdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:33:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id 14so1739010qtf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7e/n9MQO+MPQMx1/3utWKhXUce7ensfT1IkKRwayMs=;
        b=mfH181h95/b1VFsfoLdIi1zqvh5gCqZFtKTDUrAhads42BIalR5Sw4FNOeUbCLNeGh
         2og9BNDKRE0ZIMzVI5LfFSb/ROsVIApnJJmZ4eIjgZvgW6fmMuKjCxaPIsanyTrPYqeh
         DK9VXBFKzxy4lWT+w/IZ3nzPs3yPL2TH3VEOYgDDhJJpUJHxNVWJ3vTBwoIZdt3/vURf
         PQPTHqAqkEDIZl1F83Ptyq5D5vCI899B2a6aPNf3OYfpX80za6FPbg8Ybuai4Eh65NEZ
         OcV+ucf+T9mVWhLvmMq1Yv4ta9qrAoic0LOx8FMbdFBce1I3eDQvCLk4LdbOaRqqmhq1
         FE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7e/n9MQO+MPQMx1/3utWKhXUce7ensfT1IkKRwayMs=;
        b=cJODWD9pX4VhAgLo+ZQYgN/jqRCTn/FX6gGVd9Qf/+/8ThhEImfqGNi1x9WJrNphXi
         ZbFAykXHmhrMJbLINemhkHARTXsHdI9d3Bs+tlimdyHll/YZ5ngaE2C0CtF1Cqm6h4yI
         d3TZbBLa7j9iXcZCdo6lygfm70CtqVkulhs6cX7q2/l09KJpZrw+JPtAo/B9caWREuMn
         joAGW1H/hIEeTmBNa7X8DVMCHFj+1e7D1kkSXvxJdoMjk0MfG56WJexiXcFZk0ncopNE
         xIkVwawJkbG6pw379ZZobq5T7pfGRDg6hHuXn/ZN3Ia/EqZPdLre/ij6Zq/rs+Z1w4x8
         y+HA==
X-Gm-Message-State: APjAAAWg8NaHBB6Qmnx24uiY/eKKlqY01euhNaTpIq1vUNWQP2jRXLZE
        IvPmwwGc7yWI2rLcEdO+RIpohM8UVKJIUO3K/vcpZ+ZS
X-Google-Smtp-Source: APXvYqxjruBYTDHIG+EpJ5vstfjHASR0nbu2CcbP+9180ThdGo76O/POFINevhY8WsyFhCISJ/+PTBLhyDLNRuNMA0A=
X-Received: by 2002:ac8:3221:: with SMTP id x30mr9094402qta.176.1559122389003;
 Wed, 29 May 2019 02:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com> <1558521304-27469-27-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1558521304-27469-27-git-send-email-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 29 May 2019 10:32:57 +0100
Message-ID: <CAJ9a7VhwHeN5uSEwDhLVR=CL=vgCfKHtWZ3o8NnLnxw_=mYBOg@mail.gmail.com>
Subject: Re: [PATCH v4 26/30] coresight: Use platform agnostic names
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

Why am I not seeing references to coresight-cpu-debug in here? In
other places in this patchset CPU debug has been changed, but there
appears to be no platform agnostic name here, nor any ACPI type name
either. Is cpu-debug remaining device tree only? Should CPU debug not
be treated like ETM and get a cpu centric name?

Mike

On Wed, 22 May 2019 at 11:39, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> So far we have reused the name of the "platform" device for
> the CoreSight device. But this is not very intuitive when
> we move to ACPI. Also, the ACPI device names have ":" in them
> (e.g, ARMHC97C:01), which the perf tool doesn't like very much.
> This patch introduces a generic naming scheme, givin more intuitive
> names for the devices that appear on the CoreSight bus.
> The names follow the pattern "prefix" followed by "index" (e.g, etm5).
> We maintain a list of allocated devices per "prefix" to make sure
> we don't allocate a new name when it is reprobed (e.g, due to
> unsatisifed device dependencies). So, we maintain the list
> of "fwnodes" of the parent devices to allocate a consistent name.
> All devices except the ETMs get an index allocated in the order
> of probing. ETMs get an index based on the CPU they are attached to.
>
> TMC devices are named using "tmc_etf", "tmc_etb", and "tmc_etr"
> prefixes depending on the configuration of the device.
>
> The replicators and funnels are not classified as dynamic/static
> anymore. One could easily figure that out by checking the presence
> of "mgmt" registers under sysfs.
>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c       |  7 ++-
>  drivers/hwtracing/coresight/coresight-etb10.c      |  7 ++-
>  drivers/hwtracing/coresight/coresight-etm3x.c      |  4 +-
>  drivers/hwtracing/coresight/coresight-etm4x.c      |  4 +-
>  drivers/hwtracing/coresight/coresight-funnel.c     |  7 ++-
>  drivers/hwtracing/coresight/coresight-replicator.c |  7 ++-
>  drivers/hwtracing/coresight/coresight-stm.c        | 12 +++--
>  drivers/hwtracing/coresight/coresight-tmc.c        | 15 +++++-
>  drivers/hwtracing/coresight/coresight-tpiu.c       |  7 ++-
>  drivers/hwtracing/coresight/coresight.c            | 58 ++++++++++++++++++++++
>  include/linux/coresight.h                          | 25 +++++++++-
>  11 files changed, 141 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 1c1ad12..16ebf38 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -28,6 +28,8 @@
>  #define catu_dbg(x, ...) do {} while (0)
>  #endif
>
> +DEFINE_CORESIGHT_DEVLIST(catu_devs, "catu");
> +
>  struct catu_etr_buf {
>         struct tmc_sg_table *catu_table;
>         dma_addr_t sladdr;
> @@ -505,6 +507,10 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>         struct device *dev = &adev->dev;
>         void __iomem *base;
>
> +       catu_desc.name = coresight_alloc_device_name(&catu_devs, dev);
> +       if (!catu_desc.name)
> +               return -ENOMEM;
> +
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>         if (!drvdata) {
>                 ret = -ENOMEM;
> @@ -551,7 +557,6 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>         catu_desc.type = CORESIGHT_DEV_TYPE_HELPER;
>         catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
>         catu_desc.ops = &catu_ops;
> -       catu_desc.name = dev_name(dev);
>
>         drvdata->csdev = coresight_register(&catu_desc);
>         if (IS_ERR(drvdata->csdev))
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 09df827..bdd4fd5 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -63,6 +63,8 @@
>  #define ETB_FFSR_BIT           1
>  #define ETB_FRAME_SIZE_WORDS   4
>
> +DEFINE_CORESIGHT_DEVLIST(etb_devs, "etb");
> +
>  /**
>   * struct etb_drvdata - specifics associated to an ETB component
>   * @base:      memory mapped base address for this component.
> @@ -726,6 +728,10 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>         struct resource *res = &adev->res;
>         struct coresight_desc desc = { 0 };
>
> +       desc.name = coresight_alloc_device_name(&etb_devs, dev);
> +       if (!desc.name)
> +               return -ENOMEM;
> +
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>         if (!drvdata)
>                 return -ENOMEM;
> @@ -770,7 +776,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>         desc.ops = &etb_cs_ops;
>         desc.pdata = pdata;
>         desc.dev = dev;
> -       desc.name = dev_name(dev);
>         desc.groups = coresight_etb_groups;
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev))
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index f2d4616..bed7291 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -815,6 +815,9 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>         }
>
>         drvdata->cpu = coresight_get_cpu(dev);
> +       desc.name  = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
> +       if (!desc.name)
> +               return -ENOMEM;
>
>         cpus_read_lock();
>         etmdrvdata[drvdata->cpu] = drvdata;
> @@ -856,7 +859,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>         desc.ops = &etm_cs_ops;
>         desc.pdata = pdata;
>         desc.dev = dev;
> -       desc.name = dev_name(dev);
>         desc.groups = coresight_etm_groups;
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev)) {
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 1609da1..7fe2661 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1101,6 +1101,9 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>         spin_lock_init(&drvdata->spinlock);
>
>         drvdata->cpu = coresight_get_cpu(dev);
> +       desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
> +       if (!desc.name)
> +               return -ENOMEM;
>
>         cpus_read_lock();
>         etmdrvdata[drvdata->cpu] = drvdata;
> @@ -1144,7 +1147,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>         desc.pdata = pdata;
>         desc.dev = dev;
>         desc.groups = coresight_etmv4_groups;
> -       desc.name = dev_name(dev);
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev)) {
>                 ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 75fa2d3..5867fcb 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -29,6 +29,8 @@
>  #define FUNNEL_HOLDTIME                (0x7 << FUNNEL_HOLDTIME_SHFT)
>  #define FUNNEL_ENSx_MASK       0xff
>
> +DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
> +
>  /**
>   * struct funnel_drvdata - specifics associated to a funnel component
>   * @base:      memory mapped base address for this component.
> @@ -192,6 +194,10 @@ static int funnel_probe(struct device *dev, struct resource *res)
>             of_device_is_compatible(dev->of_node, "arm,coresight-funnel"))
>                 pr_warn_once("Uses OBSOLETE CoreSight funnel binding\n");
>
> +       desc.name = coresight_alloc_device_name(&funnel_devs, dev);
> +       if (!desc.name)
> +               return -ENOMEM;
> +
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>         if (!drvdata)
>                 return -ENOMEM;
> @@ -231,7 +237,6 @@ static int funnel_probe(struct device *dev, struct resource *res)
>         desc.ops = &funnel_cs_ops;
>         desc.pdata = pdata;
>         desc.dev = dev;
> -       desc.name = dev_name(dev);
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev)) {
>                 ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 64dfde7..c0e4225 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -22,6 +22,8 @@
>  #define REPLICATOR_IDFILTER0           0x000
>  #define REPLICATOR_IDFILTER1           0x004
>
> +DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
> +
>  /**
>   * struct replicator_drvdata - specifics associated to a replicator component
>   * @base:      memory mapped base address for this component. Also indicates
> @@ -183,6 +185,10 @@ static int replicator_probe(struct device *dev, struct resource *res)
>             of_device_is_compatible(dev->of_node, "arm,coresight-replicator"))
>                 pr_warn_once("Uses OBSOLETE CoreSight replicator binding\n");
>
> +       desc.name = coresight_alloc_device_name(&replicator_devs, dev);
> +       if (!desc.name)
> +               return -ENOMEM;
> +
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>         if (!drvdata)
>                 return -ENOMEM;
> @@ -222,7 +228,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
>         desc.ops = &replicator_cs_ops;
>         desc.pdata = dev->platform_data;
>         desc.dev = dev;
> -       desc.name = dev_name(dev);
>
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev)) {
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 03528f3..e3e2b00 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -107,6 +107,8 @@ struct channel_space {
>         unsigned long           *guaranteed;
>  };
>
> +DEFINE_CORESIGHT_DEVLIST(stm_devs, "stm");
> +
>  /**
>   * struct stm_drvdata - specifics associated to an STM component
>   * @base:              memory mapped base address for this component.
> @@ -810,6 +812,10 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>         size_t bitmap_size;
>         struct coresight_desc desc = { 0 };
>
> +       desc.name = coresight_alloc_device_name(&stm_devs, dev);
> +       if (!desc.name)
> +               return -ENOMEM;
> +
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>         if (!drvdata)
>                 return -ENOMEM;
> @@ -854,11 +860,12 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>         spin_lock_init(&drvdata->spinlock);
>
>         stm_init_default_data(drvdata);
> -       stm_init_generic_data(drvdata, dev_name(dev));
> +       stm_init_generic_data(drvdata, desc.name);
>
>         if (stm_register_device(dev, &drvdata->stm, THIS_MODULE)) {
>                 dev_info(dev,
> -                        "stm_register_device failed, probing deferred\n");
> +                        "%s : stm_register_device failed, probing deferred\n",
> +                        desc.name);
>                 return -EPROBE_DEFER;
>         }
>
> @@ -874,7 +881,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>         desc.ops = &stm_cs_ops;
>         desc.pdata = pdata;
>         desc.dev = dev;
> -       desc.name = dev_name(dev);
>         desc.groups = coresight_stm_groups;
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev)) {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 212630e..be37aff 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -27,6 +27,10 @@
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>
> +DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
> +DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
> +DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
> +
>  void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  {
>         /* Ensure formatter, unformatter and hardware fifo are empty */
> @@ -397,6 +401,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>         struct tmc_drvdata *drvdata;
>         struct resource *res = &adev->res;
>         struct coresight_desc desc = { 0 };
> +       struct coresight_dev_list *dev_list = NULL;
>
>         ret = -ENOMEM;
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> @@ -429,13 +434,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>
>         desc.dev = dev;
>         desc.groups = coresight_tmc_groups;
> -       desc.name = dev_name(dev);
>
>         switch (drvdata->config_type) {
>         case TMC_CONFIG_TYPE_ETB:
>                 desc.type = CORESIGHT_DEV_TYPE_SINK;
>                 desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>                 desc.ops = &tmc_etb_cs_ops;
> +               dev_list = &etb_devs;
>                 break;
>         case TMC_CONFIG_TYPE_ETR:
>                 desc.type = CORESIGHT_DEV_TYPE_SINK;
> @@ -447,11 +452,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>                         goto out;
>                 idr_init(&drvdata->idr);
>                 mutex_init(&drvdata->idr_mutex);
> +               dev_list = &etr_devs;
>                 break;
>         case TMC_CONFIG_TYPE_ETF:
>                 desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
>                 desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
>                 desc.ops = &tmc_etf_cs_ops;
> +               dev_list = &etf_devs;
>                 break;
>         default:
>                 pr_err("%s: Unsupported TMC config\n", desc.name);
> @@ -459,6 +466,12 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>                 goto out;
>         }
>
> +       desc.name = coresight_alloc_device_name(dev_list, dev);
> +       if (!desc.name) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
>         pdata = coresight_get_platform_data(dev);
>         if (IS_ERR(pdata)) {
>                 ret = PTR_ERR(pdata);
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index b699d61..f8583e4 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -47,6 +47,8 @@
>  #define FFCR_FON_MAN           BIT(6)
>  #define FFCR_STOP_FI           BIT(12)
>
> +DEFINE_CORESIGHT_DEVLIST(tpiu_devs, "tpiu");
> +
>  /**
>   * @base:      memory mapped base address for this component.
>   * @atclk:     optional clock for the core parts of the TPIU.
> @@ -125,6 +127,10 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>         struct resource *res = &adev->res;
>         struct coresight_desc desc = { 0 };
>
> +       desc.name = coresight_alloc_device_name(&tpiu_devs, dev);
> +       if (!desc.name)
> +               return -ENOMEM;
> +
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>         if (!drvdata)
>                 return -ENOMEM;
> @@ -157,7 +163,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>         desc.ops = &tpiu_cs_ops;
>         desc.pdata = pdata;
>         desc.dev = dev;
> -       desc.name = dev_name(dev);
>         drvdata->csdev = coresight_register(&desc);
>
>         if (!IS_ERR(drvdata->csdev)) {
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 1287778..86d1fc2 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1291,3 +1291,61 @@ void coresight_unregister(struct coresight_device *csdev)
>         device_unregister(&csdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(coresight_unregister);
> +
> +
> +/*
> + * coresight_search_device_idx - Search the fwnode handle of a device
> + * in the given dev_idx list. Must be called with the coresight_mutex held.
> + *
> + * Returns the index of the entry, when found. Otherwise, -ENOENT.
> + */
> +static inline int coresight_search_device_idx(struct coresight_dev_list *dict,
> +                                             struct fwnode_handle *fwnode)
> +{
> +       int i;
> +
> +       for (i = 0; i < dict->nr_idx; i++)
> +               if (dict->fwnode_list[i] == fwnode)
> +                       return i;
> +       return -ENOENT;
> +}
> +
> +/*
> + * coresight_alloc_device_name - Get an index for a given device in the
> + * device index list specific to a driver. An index is allocated for a
> + * device and is tracked with the fwnode_handle to prevent allocating
> + * duplicate indices for the same device (e.g, if we defer probing of
> + * a device due to dependencies), in case the index is requested again.
> + */
> +char *coresight_alloc_device_name(struct coresight_dev_list *dict,
> +                                 struct device *dev)
> +{
> +       int idx;
> +       char *name = NULL;
> +       struct fwnode_handle **list;
> +
> +       mutex_lock(&coresight_mutex);
> +
> +       idx = coresight_search_device_idx(dict, dev_fwnode(dev));
> +       if (idx < 0) {
> +               /* Make space for the new entry */
> +               idx = dict->nr_idx;
> +               list = krealloc(dict->fwnode_list,
> +                               (idx + 1) * sizeof(*dict->fwnode_list),
> +                               GFP_KERNEL);
> +               if (ZERO_OR_NULL_PTR(list)) {
> +                       idx = -ENOMEM;
> +                       goto done;
> +               }
> +
> +               list[idx] = dev_fwnode(dev);
> +               dict->fwnode_list = list;
> +               dict->nr_idx = idx + 1;
> +       }
> +
> +       name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
> +done:
> +       mutex_unlock(&coresight_mutex);
> +       return name;
> +}
> +EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index b40544b..a2b6882 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -168,6 +168,28 @@ struct coresight_device {
>         struct dev_ext_attribute *ea;
>  };
>
> +/*
> + * coresight_dev_list - Mapping for devices to "name" index for device
> + * names.
> + *
> + * @nr_idx:            Number of entries already allocated.
> + * @pfx:               Prefix pattern for device name.
> + * @fwnode_list:       Array of fwnode_handles associated with each allocated
> + *                     index, upto nr_idx entries.
> + */
> +struct coresight_dev_list {
> +       int                     nr_idx;
> +       const char              *pfx;
> +       struct fwnode_handle    **fwnode_list;
> +};
> +
> +#define DEFINE_CORESIGHT_DEVLIST(var, dev_pfx)                         \
> +static struct coresight_dev_list (var) = {                             \
> +                                               .pfx = dev_pfx,         \
> +                                               .nr_idx = 0,            \
> +                                               .fwnode_list = NULL,    \
> +}
> +
>  #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
>
>  #define source_ops(csdev)      csdev->ops->source_ops
> @@ -261,7 +283,8 @@ extern int coresight_claim_device_unlocked(void __iomem *base);
>
>  extern void coresight_disclaim_device(void __iomem *base);
>  extern void coresight_disclaim_device_unlocked(void __iomem *base);
> -
> +extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
> +                                        struct device *dev);
>  #else
>  static inline struct coresight_device *
>  coresight_register(struct coresight_desc *desc) { return NULL; }
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
