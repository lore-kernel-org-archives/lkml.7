Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E22C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710D521873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WzHuWEvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCVIT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:19:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37028 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfCVITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:19:55 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6633F54A;
        Fri, 22 Mar 2019 09:19:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553242792;
        bh=IGmNaFv/zdqBKoP5UGSjTxu4tPrnpkMcq1X/ILUw060=;
        h=Subject:To:Cc:References:From:Reply-To:Date:In-Reply-To:From;
        b=WzHuWEvGsj743TW8WvfyCiOSN/5NoMHSyNWhhRwg6syR3b+ArL+Qj++Qwl++kRDQZ
         /feoEsi8c11ncAtuKFzoPFGWkESHYOPmyx+1J4LVO3yJU6LQLLZZBgxbWFkzdvVL4L
         3mSpWdCJSPvJAt5tu55gXesQ2Muok1NPtAhHriFU=
Subject: Re: [PATCH 2/2] drm/omap: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <20190319163629.30660-1-wsa+renesas@sang-engineering.com>
 <20190319163629.30660-2-wsa+renesas@sang-engineering.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reply-To: kieran.bingham+renesas@ideasonboard.com
Organization: Ideas on Board
Message-ID: <4eadd46f-f436-6b81-5a84-df3428c7301e@ideasonboard.com>
Date:   Fri, 22 Mar 2019 08:19:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319163629.30660-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thank you for the patch,


On 19/03/2019 16:36, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

As with the other in this series, looks good to me.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> index 29692a5217c5..88d4b0c60689 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> @@ -412,8 +412,7 @@ static const struct backlight_ops dsicm_bl_ops = {
>  static ssize_t dsicm_num_errors_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	struct omap_dss_device *src = ddata->dssdev.src;
>  	u8 errors = 0;
>  	int r;
> @@ -444,8 +443,7 @@ static ssize_t dsicm_num_errors_show(struct device *dev,
>  static ssize_t dsicm_hw_revision_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	struct omap_dss_device *src = ddata->dssdev.src;
>  	u8 id1, id2, id3;
>  	int r;
> @@ -476,8 +474,7 @@ static ssize_t dsicm_store_ulps(struct device *dev,
>  		struct device_attribute *attr,
>  		const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	struct omap_dss_device *src = ddata->dssdev.src;
>  	unsigned long t;
>  	int r;
> @@ -511,8 +508,7 @@ static ssize_t dsicm_show_ulps(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	unsigned int t;
>  
>  	mutex_lock(&ddata->lock);
> @@ -526,8 +522,7 @@ static ssize_t dsicm_store_ulps_timeout(struct device *dev,
>  		struct device_attribute *attr,
>  		const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	struct omap_dss_device *src = ddata->dssdev.src;
>  	unsigned long t;
>  	int r;
> @@ -558,8 +553,7 @@ static ssize_t dsicm_show_ulps_timeout(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	unsigned int t;
>  
>  	mutex_lock(&ddata->lock);
> 

