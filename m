Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF28FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 05:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975F3207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 05:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ou3nMtnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfL2Fal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 00:30:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36779 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfL2Fal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 00:30:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so16527846pgc.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 21:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YKA7jqHo+9DQYEy+jk/EKI8yvTo8Pi6uy76g8MyFKHg=;
        b=Ou3nMtnUWpFwTwm9gooqIoQ7I7TrjEd0GXnMn/3KkKAny2R6akMk3d7Oenm9m+Zdih
         5IO/+RNgEC5Bi/Of9hjKscgB94oHhGLMKwSBAuxLQETIPgE61UJPAnLRwfhV6AeMFmsP
         WH0XiT3KtGZhXdvJfykbQa5VPiq4R3GDEr2MyUREBAyD/ZRE5EcO4MrR4THBkIZAHdeX
         3tW7OSLm/4yFjt38cixHIgCHpnMcTnvfCe19mABnVSs8VXHdYlSWl9eUnHy6wLL0G+HB
         F11Ho3cVpIjqf8NFvbkRTz1xx+iV0Fd8BPrhWBJGvybIXwNvYd8XihEsQQAVK38QjFkL
         GJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YKA7jqHo+9DQYEy+jk/EKI8yvTo8Pi6uy76g8MyFKHg=;
        b=hm2RH23qhehG2odrakoZIIJrvSiDjHD2v7y4UDE5lBk/a5dwZIHhu0DP3pxvdr7+2i
         HWPztOe7j/07nKoqre5ypbd+6ybHSh4Z5MIUwxPzaiY37UChgbvR4U8hXp0ADK9cIlGI
         oq2tz3z+kMXD9tV3Cn/cNfKwJjgPZQCr49QryeRQMNzUImEugfdqBvG0QFDUrwrRvdo0
         YaHmMQFkuP8Jg2lHk5IaINyn+eZlj0rRLFv5tOaBRVUzTFyQfzJ30tb4EP62ZtKsLJ4E
         JZjmnIOoaXNzATo9X3vCk4PhRaHCEmuNARBA7pZlJqD1KwBFFc1COGrW3dwchl8hqQYG
         Gm7A==
X-Gm-Message-State: APjAAAWoFJVxQrDFBGeoqqd7c4nBjNBC+hVl3qgus58iaobdE2IajTx/
        B0XWHEJGkzLTdEvJ3JZrP3Dhig==
X-Google-Smtp-Source: APXvYqwpIXYAT5RetHmzsDwHWz7dAQNZs73663TBZiltbpoDJvtK1BcCoYNLdK+k5TzlQnjDD1KowQ==
X-Received: by 2002:a63:480f:: with SMTP id v15mr63361821pga.201.1577597440088;
        Sat, 28 Dec 2019 21:30:40 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i8sm31099934pfa.109.2019.12.28.21.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 21:30:39 -0800 (PST)
Date:   Sat, 28 Dec 2019 21:30:37 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@linaro.org, fabien.dessenne@st.com, s-anna@ti.com
Subject: Re: [PATCH v4 1/1] remoteproc: add support for co-processor loaded
 and booted before kernel
Message-ID: <20191229053037.GU3108315@builder>
References: <1574940831-7433-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574940831-7433-1-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28 Nov 03:33 PST 2019, Loic Pallardy wrote:

> Remote processor could boot independently or be loaded/started before
> Linux kernel by bootloader or any firmware.
> This patch introduces a new property in rproc core, named skip_fw_load,
> to be able to allocate resources and sub-devices like vdev and to
> synchronize with current state without loading firmware from file system.
> It is platform driver responsibility to implement the right firmware
> load ops according to HW specificities.
> 

I was going to apply the patch, as I like what it actually does. But I'm
concerned about how you're going to use it (which you fail to show in
this single patch). Just two things below.

> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> ---
> Change from v3:
> - add comment about firmware NULL pointer
> - add Mathieu Poirier Ack
> Change from v2:
> - rename property into skip_fw_load
> - update rproc_boot and rproc_fw_boot description
> - update commit message
> Change from v1:
> - Keep bool in struct rproc
> ---
>  drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++++++++--------
>  include/linux/remoteproc.h           |  2 ++
>  2 files changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 307df98347ba..367a7929b7a0 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1358,8 +1358,19 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	return ret;
>  }
>  
> -/*
> - * take a firmware and boot a remote processor with it.
> +/**
> + * rproc_fw_boot() - boot specified remote processor according to specified
> + * firmware
> + * @rproc: handle of a remote processor
> + * @fw: pointer on firmware to handle
> + *
> + * Handle resources defined in resource table, load firmware and
> + * start remote processor.
> + *
> + * If firmware pointer fw is NULL, firmware is not handled by remoteproc
> + * core, but under the responsibility of platform driver.
> + *
> + * Returns 0 on success, and an appropriate error value otherwise.
>   */
>  static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  {
> @@ -1371,7 +1382,11 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	if (ret)
>  		return ret;
>  
> -	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
> +	if (fw)
> +		dev_info(dev, "Booting fw image %s, size %zd\n", name,
> +			 fw->size);
> +	else
> +		dev_info(dev, "Synchronizing with preloaded co-processor\n");

This log line implies that ops->start() doesn't actually start the
remoteproc, but it sounds like a remote proc with skip_fw_load actually
would boot the remote processor, but with some pre-existing firmware.

As such it makes more sense, in this patch, to print "Booting\n" here.


But I presume you have a platform driver with a nop start()
implementation and no ability to reload the firmware on a crash?

>  
>  	/*
>  	 * if enabling an IOMMU isn't relevant for this rproc, this is
> @@ -1718,16 +1733,22 @@ static void rproc_crash_handler_work(struct work_struct *work)
>   * rproc_boot() - boot a remote processor
>   * @rproc: handle of a remote processor
>   *
> - * Boot a remote processor (i.e. load its firmware, power it on, ...).
> + * Boot a remote processor (i.e. load its firmware, power it on, ...) from
> + * different contexts:
> + * - power off
> + * - preloaded firmware
> + * - started before kernel execution
> + * The different operations are selected thanks to properties defined by
> + * platform driver.
>   *
> - * If the remote processor is already powered on, this function immediately
> - * returns (successfully).
> + * If the remote processor is already powered on at rproc level, this function
> + * immediately returns (successfully).
>   *
>   * Returns 0 on success, and an appropriate error value otherwise.
>   */
>  int rproc_boot(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
> +	const struct firmware *firmware_p = NULL;
>  	struct device *dev;
>  	int ret;
>  
> @@ -1758,11 +1779,20 @@ int rproc_boot(struct rproc *rproc)
>  
>  	dev_info(dev, "powering up %s\n", rproc->name);
>  
> -	/* load firmware */
> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> -	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> -		goto downref_rproc;
> +	if (!rproc->skip_fw_load) {
> +		/* load firmware */
> +		ret = request_firmware(&firmware_p, rproc->firmware, dev);
> +		if (ret < 0) {
> +			dev_err(dev, "request_firmware failed: %d\n", ret);
> +			goto downref_rproc;
> +		}
> +	} else {
> +		/*
> +		 * Set firmware name pointer to null as remoteproc core is not
> +		 * in charge of firmware loading
> +		 */
> +		kfree(rproc->firmware);
> +		rproc->firmware = NULL;

Why do this on every boot? Why don't you change rproc_alloc() to never
populate rproc->firmware?

Regards,
Bjorn

>  	}
>  
>  	ret = rproc_fw_boot(rproc, firmware_p);
> @@ -1916,8 +1946,17 @@ int rproc_add(struct rproc *rproc)
>  	/* create debugfs entries */
>  	rproc_create_debug_dir(rproc);
>  
> -	/* if rproc is marked always-on, request it to boot */
> -	if (rproc->auto_boot) {
> +	if (rproc->skip_fw_load) {
> +		/*
> +		 * If rproc is marked already booted, no need to wait
> +		 * for firmware.
> +		 * Just handle associated resources and start sub devices
> +		 */
> +		ret = rproc_boot(rproc);
> +		if (ret < 0)
> +			return ret;
> +	} else if (rproc->auto_boot) {
> +		/* if rproc is marked always-on, request it to boot */
>  		ret = rproc_trigger_auto_boot(rproc);
>  		if (ret < 0)
>  			return ret;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad66683ad0..4fd5bedab4fa 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -479,6 +479,7 @@ struct rproc_dump_segment {
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>   * @auto_boot: flag to indicate if remote processor should be auto-started
> + * @skip_fw_load: remote processor has been preloaded before start sequence
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
>   */
> @@ -512,6 +513,7 @@ struct rproc {
>  	size_t table_sz;
>  	bool has_iommu;
>  	bool auto_boot;
> +	bool skip_fw_load;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  };
> -- 
> 2.7.4
> 
