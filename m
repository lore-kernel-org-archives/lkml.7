Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC52C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9479A20675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p3M8JaA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfDYJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:31:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35234 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfDYJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:31:32 -0400
Received: from pendragon.ideasonboard.com (net-37-182-44-227.cust.vodafonedsl.it [37.182.44.227])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 996005F;
        Thu, 25 Apr 2019 11:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556184689;
        bh=dCKL4HDTRzJsOaoux4wMt3E9K44wWltKS1BFyspNm00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3M8JaA6gMhYajJcWAmLUawZjzb2fq1LyzXBpmOlKIZc2t87zdMTJK5dxPsOGUUvq
         zkB4bkdtd3LvuLTHvCDGKMXAuatJO0yTDsW9Gyx1N14XnL63FqCmlq3mZ2iAsxKWON
         C7kHBqNzhhOL3tiUU8I2BYCxBa1XhyAp7gltyU68=
Date:   Thu, 25 Apr 2019 12:31:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Matt Redfearn <matt.redfearn@thinci.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Archit Taneja <architt@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Allow VPG to be enabled via
 debugfs
Message-ID: <20190425093118.GC4557@pendragon.ideasonboard.com>
References: <20190424142205.26088-1-matt.redfearn@thinci.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424142205.26088-1-matt.redfearn@thinci.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 02:22:18PM +0000, Matt Redfearn wrote:
> The Synopsys MIPI DSI IP contains a video test pattern generator which
> is helpful in debugging video timing with connected displays.
> Add a debugfs directory containing files which allow the VPG to be
> enabled and disabled, and it's orientation to be changed.

s/it's/its/
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
> 
> ---
> 
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 0ee440216b8..a1ee2306382 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/component.h>
> +#include <linux/debugfs.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -86,6 +87,8 @@
>  #define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
>  #define VID_MODE_TYPE_BURST			0x2
>  #define VID_MODE_TYPE_MASK			0x3
> +#define VID_MODE_VPG_ENABLE		BIT(16)
> +#define VID_MODE_VPG_HORIZONTAL		BIT(24)
>  
>  #define DSI_VID_PKT_SIZE		0x3c
>  #define VID_PKT_SIZE(p)			((p) & 0x3fff)
> @@ -234,6 +237,15 @@ struct dw_mipi_dsi {
>  	u32 format;
>  	unsigned long mode_flags;
>  
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *debugfs_root;
> +	struct dentry *debugfs_vpg;
> +	struct dentry *debugfs_vpg_horizontal;
> +
> +	bool vpg;
> +	bool vpg_horizontal;
> +#endif /* CONFIG_DEBUG_FS */
> +
>  	struct dw_mipi_dsi *master; /* dual-dsi master ptr */
>  	struct dw_mipi_dsi *slave; /* dual-dsi slave ptr */
>  
> @@ -525,6 +537,11 @@ static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
>  	else
>  		val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
>  
> +	if (dsi->vpg) {

Won't this break if CONFIG_DDEBUG_FS is not defined ?

> +		val |= VID_MODE_VPG_ENABLE;
> +		val |= dsi->vpg_horizontal ? VID_MODE_VPG_HORIZONTAL : 0;
> +	}
> +
>  	dsi_write(dsi, DSI_VID_MODE_CFG, val);
>  }
>  
> @@ -935,6 +952,41 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
>  	.attach	      = dw_mipi_dsi_bridge_attach,
>  };
>  
> +#ifdef CONFIG_DEBUG_FS
> +
> +static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi)
> +{
> +	struct dentry *d;
> +
> +	d = debugfs_create_dir(dev_name(dsi->dev), NULL);
> +	if (IS_ERR(d)) {
> +		dev_err(dsi->dev, "failed to create debugfs root\n");
> +		return;
> +	}
> +	dsi->debugfs_root = d;
> +
> +	d = debugfs_create_bool("vpg", 0660, dsi->debugfs_root, &dsi->vpg);
> +	dsi->debugfs_vpg = d;

If you don't handle failures here you don't need the intermediate d
variable, you can just assign dsi->debugfs_vpg directly.

> +
> +	d = debugfs_create_bool("vpg_horizontal", 0660, dsi->debugfs_root,
> +				&dsi->vpg_horizontal);
> +	dsi->debugfs_vpg_horizontal = d;

Same here.

> +}
> +
> +static void dw_mipi_dsi_debugfs_remove(struct dw_mipi_dsi *dsi)
> +{
> +	debugfs_remove(dsi->debugfs_vpg_horizontal);
> +	debugfs_remove(dsi->debugfs_vpg);
> +	debugfs_remove(dsi->debugfs_root);
> +}
> +
> +#else
> +
> +static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi) { }
> +static void dw_mipi_dsi_debugfs_remove(struct dw_mipi_dsi *dsi) { }
> +
> +#endif /* CONFIG_DEBUG_FS */
> +
>  static struct dw_mipi_dsi *
>  __dw_mipi_dsi_probe(struct platform_device *pdev,
>  		    const struct dw_mipi_dsi_plat_data *plat_data)
> @@ -1005,6 +1057,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>  		clk_disable_unprepare(dsi->pclk);
>  	}
>  
> +	dw_mipi_dsi_debugfs_init(dsi);
>  	pm_runtime_enable(dev);
>  
>  	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
> @@ -1012,6 +1065,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>  	ret = mipi_dsi_host_register(&dsi->dsi_host);
>  	if (ret) {
>  		dev_err(dev, "Failed to register MIPI host: %d\n", ret);
> +		dw_mipi_dsi_debugfs_remove(dsi);
>  		return ERR_PTR(ret);
>  	}
>  
> @@ -1029,6 +1083,7 @@ static void __dw_mipi_dsi_remove(struct dw_mipi_dsi *dsi)
>  	mipi_dsi_host_unregister(&dsi->dsi_host);
>  
>  	pm_runtime_disable(dsi->dev);
> +	dw_mipi_dsi_debugfs_remove(dsi);
>  }
>  
>  void dw_mipi_dsi_set_slave(struct dw_mipi_dsi *dsi, struct dw_mipi_dsi *slave)

-- 
Regards,

Laurent Pinchart
