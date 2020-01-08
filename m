Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC2FC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FF22067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIWqvjWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgAHPiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:38:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60361 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgAHPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578497897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eGeIWiwUf1mluye9R+kVxpOKPsNVjl3zOy6Wq1gu+k=;
        b=HIWqvjWtqPUKjjHa4DVnVG8BYlXg/obFZ6lTD6570V1tkX6Y4u9+ai2eLcghtOoWahc0cL
        caLWvJw8Dvs9xl62uOOJEY9eQcvycJQ0L9w3WwX5V521iEFo6+QOZRjceD2d8YMs9baysy
        MYLfeaaKlq3dJSGxiv5egJWXop18+3Y=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-db7-DKmYNJS5nM6zkS9n2Q-1; Wed, 08 Jan 2020 10:38:16 -0500
X-MC-Unique: db7-DKmYNJS5nM6zkS9n2Q-1
Received: by mail-yb1-f197.google.com with SMTP id s1so2331489ybs.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 07:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1eGeIWiwUf1mluye9R+kVxpOKPsNVjl3zOy6Wq1gu+k=;
        b=C5vV0wYeChPU/O5QNT8Xza2M6/rlIadRjgM2ou6jNSbqLCBJoAM60X/sYt4oCIFdIz
         1RiKEZ5QEjrPH+nmtBhhQ1TnizCdl/ISNaXD8wOnapokOFgd3FdXI/8XZ2MB212lZb5O
         VcY/t1JrhRmR8G/02SlGl0QRYv/YAfmzywQaXDnPx3wGjCwe6Q787RIT4NENtf5Z6ask
         YBzVDJbsRaVR8gu/Xzdc+QNlOo968Tjwtw9cP0ATNA14VxwXiD7caZeP/sy++vO14Kei
         J7kBWueodkLgm/x1/WtOVXKiMYp1EA4ffGHPWEnyylDbjlZGMf/yMj/QBY8fToAZqfCu
         IMNg==
X-Gm-Message-State: APjAAAUWnfTiHGTuixefAw8fnngN9XL8nIMzDAAWuYlEWkvYozqn2jQr
        YtL4k4rXVPyqtR0qmQkhOXNpfGkncEDyxGHJxSOcOXBCVZJlZDPFOElaCtI8VNQWHoKEMrWrOkW
        u8mG+oiEtLNVCrVyz61LIChEV
X-Received: by 2002:a81:1b45:: with SMTP id b66mr3776941ywb.435.1578497895738;
        Wed, 08 Jan 2020 07:38:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQZmJI4VQh+Cl1LLv1EgTRLeZDIIYl7gaRjBgl5k3h96bkDfJduVd+FgdSyHJqPABucCPzYg==
X-Received: by 2002:a81:1b45:: with SMTP id b66mr3776918ywb.435.1578497895426;
        Wed, 08 Jan 2020 07:38:15 -0800 (PST)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n8sm1583723ywh.75.2020.01.08.07.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 07:38:15 -0800 (PST)
Subject: Re: [PATCH 1/3] drm/msm: support firmware-name for zap fw
To:     Rob Clark <robdclark@gmail.com>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
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
References: <20200108013847.899170-1-robdclark@gmail.com>
 <20200108013847.899170-2-robdclark@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <37d0baaa-3f94-9414-88e7-7e849b0c5de5@redhat.com>
Date:   Wed, 8 Jan 2020 07:38:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200108013847.899170-2-robdclark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/20 5:38 PM, Rob Clark wrote:
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
Could adreno_request_fw be called with fwname if request_firmware_direct fails ?
> +			fw = ERR_PTR(ret);
> +		}
> +	} else {
> +		/* Request the MDT file for the firmware */
> +		fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
> +	}
> +
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

