Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB158C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA74213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PLW0DGXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfCVISN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:18:13 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36992 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfCVISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:18:13 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D135F2DE;
        Fri, 22 Mar 2019 09:18:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553242690;
        bh=u1YD/ec9XrfsgarGSR88KutgfIZwVQ7Gs1zBie686KY=;
        h=Subject:To:Cc:References:From:Reply-To:Date:In-Reply-To:From;
        b=PLW0DGXNhw8/fgpEVPI9liYerUxb1qSSEr9X5DmAVltYwc3TYX2amI0hwQAFV1KMW
         uy0WFGjewFcLtDZ2w0vGJevaAtuuh6c7UVMelA2emYSx3/r2cwGX0YaSCtXmW2n50K
         CYqdEamG0tqeJEkjk8aZ8ZTCttA6mFM31eqBcB7I=
Subject: Re: [PATCH 1/2] drm/msm: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20190319163629.30660-1-wsa+renesas@sang-engineering.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reply-To: kieran.bingham+renesas@ideasonboard.com
Organization: Ideas on Board
Message-ID: <7d66ed6f-1dc4-05ec-567e-939df7d8c94b@ideasonboard.com>
Date:   Fri, 22 Mar 2019 08:18:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319163629.30660-1-wsa+renesas@sang-engineering.com>
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

This looks good to me.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  6 ++----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    | 13 +++++--------
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   |  6 ++----
>  drivers/gpu/drm/msm/dsi/dsi_host.c         |  6 ++----
>  drivers/gpu/drm/msm/msm_drv.c              |  3 +--
>  5 files changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 714ed6505e47..13802af8294c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -412,16 +412,14 @@ static const struct of_device_id dt_match[] = {
>  #ifdef CONFIG_PM
>  static int adreno_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct msm_gpu *gpu = platform_get_drvdata(pdev);
> +	struct msm_gpu *gpu = dev_get_drvdata(dev);

Nice simplification :-)

Do you catch these with Coccinelle?

>  
>  	return gpu->funcs->pm_resume(gpu);
>  }
>  
>  static int adreno_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct msm_gpu *gpu = platform_get_drvdata(pdev);
> +	struct msm_gpu *gpu = dev_get_drvdata(dev);
>  
>  	return gpu->funcs->pm_suspend(gpu);
>  }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 885bf88afa3e..0154eb9b343f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1036,16 +1036,15 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>  
>  static void dpu_unbind(struct device *dev, struct device *master, void *data)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
> +	struct dpu_kms *dpu_kms = dev_get_drvdata(dev);
>  	struct dss_module_power *mp = &dpu_kms->mp;
>  
>  	msm_dss_put_clk(mp->clk_config, mp->num_clk);
> -	devm_kfree(&pdev->dev, mp->clk_config);
> +	devm_kfree(dev, mp->clk_config);


Using the dev to get the pdev to get the dev :-D

>  	mp->num_clk = 0;
>  
>  	if (dpu_kms->rpm_enabled)
> -		pm_runtime_disable(&pdev->dev);
> +		pm_runtime_disable(dev);
>  }
>  
>  static const struct component_ops dpu_ops = {
> @@ -1067,8 +1066,7 @@ static int dpu_dev_remove(struct platform_device *pdev)
>  static int __maybe_unused dpu_runtime_suspend(struct device *dev)
>  {
>  	int rc = -1;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
> +	struct dpu_kms *dpu_kms = dev_get_drvdata(dev);
>  	struct drm_device *ddev;
>  	struct dss_module_power *mp = &dpu_kms->mp;
>  
> @@ -1088,8 +1086,7 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
>  static int __maybe_unused dpu_runtime_resume(struct device *dev)
>  {
>  	int rc = -1;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
> +	struct dpu_kms *dpu_kms = dev_get_drvdata(dev);
>  	struct drm_encoder *encoder;
>  	struct drm_device *ddev;
>  	struct dss_module_power *mp = &dpu_kms->mp;
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 97179bec8902..8f7a01d7a663 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -1063,8 +1063,7 @@ static int mdp5_dev_remove(struct platform_device *pdev)
>  
>  static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
> +	struct mdp5_kms *mdp5_kms = dev_get_drvdata(dev);
>  
>  	DBG("");
>  
> @@ -1073,8 +1072,7 @@ static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
>  
>  static __maybe_unused int mdp5_runtime_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
> +	struct mdp5_kms *mdp5_kms = dev_get_drvdata(dev);
>  
>  	DBG("");
>  
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 610183db1daf..4a158c41ef30 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -485,8 +485,7 @@ static void dsi_bus_clk_disable(struct msm_dsi_host *msm_host)
>  
>  int msm_dsi_runtime_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct msm_dsi *msm_dsi = platform_get_drvdata(pdev);
> +	struct msm_dsi *msm_dsi = dev_get_drvdata(dev);
>  	struct mipi_dsi_host *host = msm_dsi->host;
>  	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>  
> @@ -500,8 +499,7 @@ int msm_dsi_runtime_suspend(struct device *dev)
>  
>  int msm_dsi_runtime_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct msm_dsi *msm_dsi = platform_get_drvdata(pdev);
> +	struct msm_dsi *msm_dsi = dev_get_drvdata(dev);
>  	struct mipi_dsi_host *host = msm_dsi->host;
>  	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>  
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 0bdd93648761..071ad87ce44e 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -251,8 +251,7 @@ static int vblank_ctrl_queue_work(struct msm_drm_private *priv,
>  
>  static int msm_drm_uninit(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct drm_device *ddev = platform_get_drvdata(pdev);
> +	struct drm_device *ddev = dev_get_drvdata(dev);
>  	struct msm_drm_private *priv = ddev->dev_private;
>  	struct msm_kms *kms = priv->kms;
>  	struct msm_mdss *mdss = priv->mdss;
> 

