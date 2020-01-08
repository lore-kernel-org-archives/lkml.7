Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCCC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECD82067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iGCKP7Ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgAHStE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:49:04 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:47299 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729112AbgAHStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:49:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578509343; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=gTr19O6/h1bieTEtOdTwKJcuvZEZhmSsjFCuP6lT+N4=; b=iGCKP7UtmMdcUFUhlTzqGDLkUbE1FM17DWawY1AttvYvRACjuhOVaDqDhpy4Bllx55O6pl0A
 FMI4T0eBGMGsPiEuMqdV8T1aZ8zw47XJKDp+K/XZBhnc35tyljtFxY0dNelKWY/U6YP7ei/t
 Y5gl0IDHnArPct7XeiKrESuyD3k=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e162418.7f8a0f7f6d50-smtp-out-n01;
 Wed, 08 Jan 2020 18:48:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 021D2C4479C; Wed,  8 Jan 2020 18:48:55 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B59D8C4479F;
        Wed,  8 Jan 2020 18:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B59D8C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 8 Jan 2020 11:48:50 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Masney <masneyb@onstation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/msm: support firmware-name for zap fw
Message-ID: <20200108184850.GA13260@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Masney <masneyb@onstation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
References: <20200108013847.899170-1-robdclark@gmail.com>
 <20200108013847.899170-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108013847.899170-2-robdclark@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 05:38:42PM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Since zap firmware can be device specific, allow for a firmware-name
> property in the zap node to specify which firmware to load, similarly to
> the scheme used for dsp/wifi/etc.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 32 ++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 112e8b8a261e..aa8737bd58db 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -26,6 +26,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  {
>  	struct device *dev = &gpu->pdev->dev;
>  	const struct firmware *fw;
> +	const char *signed_fwname = NULL;
>  	struct device_node *np, *mem_np;
>  	struct resource r;
>  	phys_addr_t mem_phys;
> @@ -58,8 +59,33 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  
>  	mem_phys = r.start;
>  
> -	/* Request the MDT file for the firmware */
> -	fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
> +	/*
> +	 * Check for a firmware-name property.  This is the new scheme
> +	 * to handle firmware that may be signed with device specific
> +	 * keys, allowing us to have a different zap fw path for different
> +	 * devices.
> +	 *
> +	 * If the firmware-name property is found, we bypass the
> +	 * adreno_request_fw() mechanism, because we don't need to handle
> +	 * the /lib/firmware/qcom/* vs /lib/firmware/* case.
> +	 *
> +	 * If the firmware-name property is not found, for backwards
> +	 * compatibility we fall back to the fwname from the gpulist
> +	 * table.
> +	 */
> +	of_property_read_string_index(np, "firmware-name", 0, &signed_fwname);
> +	if (signed_fwname) {
> +		fwname = signed_fwname;
> +		ret = request_firmware_direct(&fw, signed_fwname, gpu->dev->dev);
> +		if (ret) {
> +			DRM_DEV_ERROR(dev, "could not load signed zap firmware: %d\n", ret);
> +			fw = ERR_PTR(ret);
> +		}
> +	} else {
> +		/* Request the MDT file for the firmware */
> +		fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
> +	}
> +

Since DT seems to be the trend for target specific firmware names I think we
should plan to quickly deprecate the legacy name and not require new targets to
set it. If a zap node is going to be opt in then it isn't onerous to ask
the developer to set the additional property for each target platform.

Jordan

>  	if (IS_ERR(fw)) {
>  		DRM_DEV_ERROR(dev, "Unable to load %s\n", fwname);
>  		return PTR_ERR(fw);
> @@ -95,7 +121,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  	 * not.  But since we've already gotten through adreno_request_fw()
>  	 * we know which of the two cases it is:
>  	 */
> -	if (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY) {
> +	if (signed_fwname || (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY)) {
>  		ret = qcom_mdt_load(dev, fw, fwname, pasid,
>  				mem_region, mem_phys, mem_size, NULL);
>  	} else {
> -- 
> 2.24.1
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
