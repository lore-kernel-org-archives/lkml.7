Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB16C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05B32087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557232020;
	bh=tFaw7PLFFMnBD2d8LMpuF3sAy7zQewD/xapRJv5td7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yYxP3fGKKdF1TEKuA7EXZqgC2b89VXAz2bORHzdazV70nmzfOt357i1GRfNBYnJ0Y
	 scHTNnTiOION5qHXxMmOztVGaqunIwGH1+kwNc8Y1kNJPOsjhm2FwtxyFhb7KkdcwL
	 X2SK6E+cCSsAq9ryma6rZB90nX8/5b7Srrk36yt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfEGM06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfEGM06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:26:58 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95ECC206A3;
        Tue,  7 May 2019 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557232017;
        bh=tFaw7PLFFMnBD2d8LMpuF3sAy7zQewD/xapRJv5td7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9dlocE/TXIqwbSJEwFuisgfwTKdQL8aB0AdxYZ5EpShK/drxMcTLVpxvGRW41ZCh
         Me4N4Ha6jq/tQUjJCz/pTCTiobrLr/JD8/WR6xt57qjbq6bCSIUFOUwb2PoZwWQCqQ
         2WAM6o0z3lvbRCELOX3zgOmSunz6eXjz78eSGorQ=
Date:   Tue, 7 May 2019 17:56:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/8] soundwire: intel: filter SoundWire controller device
 search
Message-ID: <20190507122651.GO16052@vkoul-mobl>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504002926.28815-2-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-19, 19:29, Pierre-Louis Bossart wrote:
> The convention is that the SoundWire controller device is a child of
> the HDAudio controller. However there can be more than one child
> exposed in the DSDT table, and the current namespace walk returns the
> last device.
> 
> Add a filter and terminate early when a valid _ADR is provided,
> otherwise keep iterating to find the next child.

So what are the other devices in DSDT here..

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel_init.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> index d3d6b54c5791..f85db67d05f0 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -150,6 +150,12 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
>  {
>  	struct sdw_intel_res *res = cdata;
>  	struct acpi_device *adev;
> +	acpi_status status;
> +	u64 adr;
> +
> +	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
> +	if (ACPI_FAILURE(status))
> +		return AE_OK; /* keep going */
>  
>  	if (acpi_bus_get_device(handle, &adev)) {
>  		pr_err("%s: Couldn't find ACPI handle\n", __func__);
> @@ -157,7 +163,18 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
>  	}
>  
>  	res->handle = handle;
> -	return AE_OK;
> +
> +	/*
> +	 * On some Intel platforms, multiple children of the HDAS
> +	 * device can be found, but only one of them is the SoundWire
> +	 * controller. The SNDW device is always exposed with
> +	 * Name(_ADR, 0x40000000) so filter accordingly
> +	 */
> +	if (adr != 0x40000000)

I do not recall if 4 corresponds to the links you have or soundwire
device type, is this number documented somewhere is HDA specs?

Also it might good to create a define for this
 
> +		return AE_OK; /* keep going */
> +
> +	/* device found, stop namespace walk */
> +	return AE_CTRL_TERMINATE;
>  }
>  
>  /**
> -- 
> 2.17.1

-- 
~Vinod
