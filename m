Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A58C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E042082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554217799;
	bh=oSfSahT8udwHOdLqcJ2gw46lne0RBwkGVdr3fUvAfcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zOcoQ+OFV38aNu4p4A+hSeaQ6c22SyWP2qHMRFCLdaSzzqrM6CCl1+nL1XKhmYcki
	 W4jegpjB8lpgOY5ffMR2DEWTXGYKzhTDbDMQVcZqZZM9atcKcmnHzGALNj6eU482FI
	 5K+f1x2N+QsVzY0Am22Xipkf1I1MIp/6HzNInjE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbfDBPJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:09:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43850 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfDBPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:09:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id u15so12286868otq.10;
        Tue, 02 Apr 2019 08:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vqAUdXHLIV2kbkCIVCL/INDvdDarlNDJeWQtZPNOV3E=;
        b=mwtPxeNJAV5NDr1ljorzRMgHpVY/PSM3PMVeb90XLujy8MOzFQQYyUrDZdStfuzTgj
         nlYLp7vUtosv3+wAJI1/pa69sP27ycojjGNLlIbF/yZ/xWtrtV95UxEybY2EXuT3uSFz
         kDnHBFw9QtqecxcGCjx/k/eGI0jIW0xIyWJR3WwxifUFRapUa0KS5b4inFR5xMV+hSJS
         XaL+Cxwlwshqyfz/5iwGe6323wU7PqzdLyeWpBiC3XP+rTSGZGq9QoFOsyK0p9E6r9U4
         TqfxRvff93uko2a/PpMA/sZNYw2X0afZy18Gdkoj/ce6OabYQODjfDLFrX1mM2ZxWZiu
         65dg==
X-Gm-Message-State: APjAAAU8tGo0k5tqiGwc8DK4OruZxBkQZue12ao9kodJ6kIim2zAb8x0
        4rwtyL953Edcgo4ghmAGpnw=
X-Google-Smtp-Source: APXvYqymVjFytVjqjzxvoXmktRE1z7m71mofuCV4Fo4hleC0Nxnzu9SYbsOYgnTV/QhWtcxjQFQWig==
X-Received: by 2002:a9d:186:: with SMTP id e6mr43121015ote.258.1554217797611;
        Tue, 02 Apr 2019 08:09:57 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id h26sm4700296oih.22.2019.04.02.08.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:09:56 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:09:56 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 09/17] fpga: dfl: add id_table for dfl private feature
 driver
Message-ID: <20190402150956.GC15773@archbook>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-10-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553483264-5379-10-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wu,

On Mon, Mar 25, 2019 at 11:07:36AM +0800, Wu Hao wrote:
> This patch adds id_table for each dfl private feature driver,
> it allows to reuse same private feature driver to match and support
> multiple dfl private features.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-afu-main.c | 14 ++++++++++++--
>  drivers/fpga/dfl-fme-main.c | 11 ++++++++---
>  drivers/fpga/dfl-fme-pr.c   |  7 ++++++-
>  drivers/fpga/dfl-fme.h      |  3 ++-
>  drivers/fpga/dfl.c          | 21 +++++++++++++++++++--
>  drivers/fpga/dfl.h          | 21 +++++++++++++++------
>  6 files changed, 62 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 82fd80a..2916876 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -440,6 +440,11 @@ port_hdr_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
>  	return ret;
>  }
>  
> +static const struct dfl_feature_id port_hdr_id_table[] = {
> +	{.id = PORT_FEATURE_ID_HEADER,},
> +	{0,}
> +};
> +
>  static const struct dfl_feature_ops port_hdr_ops = {
>  	.init = port_hdr_init,
>  	.uinit = port_hdr_uinit,
> @@ -500,6 +505,11 @@ static void port_afu_uinit(struct platform_device *pdev,
>  	sysfs_remove_files(&pdev->dev.kobj, port_afu_attrs);
>  }
>  
> +static const struct dfl_feature_id port_afu_id_table[] = {
> +	{.id = PORT_FEATURE_ID_AFU,},
> +	{0,}
> +};
> +
>  static const struct dfl_feature_ops port_afu_ops = {
>  	.init = port_afu_init,
>  	.uinit = port_afu_uinit,
> @@ -507,11 +517,11 @@ static const struct dfl_feature_ops port_afu_ops = {
>  
>  static struct dfl_feature_driver port_feature_drvs[] = {
>  	{
> -		.id = PORT_FEATURE_ID_HEADER,
> +		.id_table = port_hdr_id_table,
>  		.ops = &port_hdr_ops,
>  	},
>  	{
> -		.id = PORT_FEATURE_ID_AFU,
> +		.id_table = port_afu_id_table,
>  		.ops = &port_afu_ops,
>  	},
>  	{
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 8b2a337..38c6342 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -158,6 +158,11 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
>  	return -ENODEV;
>  }
>  
> +static const struct dfl_feature_id fme_hdr_id_table[] = {
> +	{.id = FME_FEATURE_ID_HEADER,},
> +	{0,}
> +};
> +
>  static const struct dfl_feature_ops fme_hdr_ops = {
>  	.init = fme_hdr_init,
>  	.uinit = fme_hdr_uinit,
> @@ -166,12 +171,12 @@ static const struct dfl_feature_ops fme_hdr_ops = {
>  
>  static struct dfl_feature_driver fme_feature_drvs[] = {
>  	{
> -		.id = FME_FEATURE_ID_HEADER,
> +		.id_table = fme_hdr_id_table,
>  		.ops = &fme_hdr_ops,
>  	},
>  	{
> -		.id = FME_FEATURE_ID_PR_MGMT,
> -		.ops = &pr_mgmt_ops,
> +		.id_table = fme_pr_mgmt_id_table,
> +		.ops = &fme_pr_mgmt_ops,
>  	},
>  	{
>  		.ops = NULL,
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index 8a0e46a..b054ac6 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -482,7 +482,12 @@ static long fme_pr_ioctl(struct platform_device *pdev,
>  	return ret;
>  }
>  
> -const struct dfl_feature_ops pr_mgmt_ops = {
> +const struct dfl_feature_id fme_pr_mgmt_id_table[] = {
> +	{.id = FME_FEATURE_ID_PR_MGMT,},
> +	{0}
> +};
> +
> +const struct dfl_feature_ops fme_pr_mgmt_ops = {
>  	.init = pr_mgmt_init,
>  	.uinit = pr_mgmt_uinit,
>  	.ioctl = fme_pr_ioctl,
> diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
> index de20755..7a021c4 100644
> --- a/drivers/fpga/dfl-fme.h
> +++ b/drivers/fpga/dfl-fme.h
> @@ -35,6 +35,7 @@ struct dfl_fme {
>  	struct dfl_feature_platform_data *pdata;
>  };
>  
> -extern const struct dfl_feature_ops pr_mgmt_ops;
> +extern const struct dfl_feature_ops fme_pr_mgmt_ops;
> +extern const struct dfl_feature_id fme_pr_mgmt_id_table[];
>  
>  #endif /* __DFL_FME_H */
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index c5aa287..65f91ef 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -14,6 +14,8 @@
>  
>  #include "dfl.h"
>  
> +#define DRV_VERSION	"0.8"
> +
>  static DEFINE_MUTEX(dfl_id_mutex);
>  
>  /*
> @@ -274,6 +276,21 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static bool dfl_feature_drv_match(struct dfl_feature *feature,
> +				  struct dfl_feature_driver *driver)
> +{
> +	const struct dfl_feature_id *ids = driver->id_table;
> +
> +	if (ids) {
> +		while (ids->id) {
> +			if (ids->id == feature->id)
> +				return true;
> +			ids++;
> +		}
> +	}
> +	return false;
> +}
> +
>  /**
>   * dfl_fpga_dev_feature_init - init for sub features of dfl feature device
>   * @pdev: feature device.
> @@ -294,8 +311,7 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
>  
>  	while (drv->ops) {
>  		dfl_fpga_dev_for_each_feature(pdata, feature) {
> -			/* match feature and drv using id */
> -			if (feature->id == drv->id) {
> +			if (dfl_feature_drv_match(feature, drv)) {
>  				ret = dfl_feature_instance_init(pdev, pdata,
>  								feature, drv);
>  				if (ret)
> @@ -1164,3 +1180,4 @@ module_exit(dfl_fpga_exit);
>  MODULE_DESCRIPTION("FPGA Device Feature List (DFL) Support");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_LICENSE("GPL v2");
> +MODULE_VERSION(DRV_VERSION);
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 3c5dc3a..fbc57f0 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -30,8 +30,8 @@
>  /* plus one for fme device */
>  #define MAX_DFL_FEATURE_DEV_NUM    (MAX_DFL_FPGA_PORT_NUM + 1)
>  
> -/* Reserved 0x0 for Header Group Register and 0xff for AFU */
> -#define FEATURE_ID_FIU_HEADER		0x0
> +/* Reserved 0xfe for Header Group Register and 0xff for AFU */
> +#define FEATURE_ID_FIU_HEADER		0xfe
>  #define FEATURE_ID_AFU			0xff
>  
>  #define FME_FEATURE_ID_HEADER		FEATURE_ID_FIU_HEADER
> @@ -169,13 +169,22 @@ void dfl_fpga_port_ops_put(struct dfl_fpga_port_ops *ops);
>  int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
>  
>  /**
> - * struct dfl_feature_driver - sub feature's driver
> + * struct dfl_feature_id - dfl private feature id
>   *
> - * @id: sub feature id.
> - * @ops: ops of this sub feature.
> + * @id: unique dfl private feature id.
>   */
> -struct dfl_feature_driver {
> +struct dfl_feature_id {
>  	u64 id;
> +};
> +
> +/**
> + * struct dfl_feature_driver - dfl private feature driver
> + *
> + * @id_table: id_table for dfl private features supported by this driver.
> + * @ops: ops of this dfl private feature driver.
> + */
> +struct dfl_feature_driver {
> +	const struct dfl_feature_id *id_table;
>  	const struct dfl_feature_ops *ops;
>  };
>  
> -- 
> 2.7.4
> 
