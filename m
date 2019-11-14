Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0675C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9928A2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijf4t7dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKNSTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37347 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfKNSTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:19:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so4818549pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wyk4KJjderVkyJv8jW+hlPmwUBgxY2V/mVNctLCR9Ow=;
        b=ijf4t7dVYEb1OA4t94tKguoTQINdHNQfZ3AWgU61iTrqpzii9bh/Ahxlbw80p/apHH
         sbZMfRH8ASFk500eabsjl8L85FLqiJweRSGbIMFLuoJ3U+NEHJVMyx5vFMLKUMoAZBXL
         f7/c3h+zrjtU41qsn1KWObAB7xCKrU5AtBxlXObZ9yE7uMmFH2o/1Mke5iDDK9dFbZWo
         yj2mUBxLyPYD/R9A7BQO8aOY588SZg7UWqqoo+75nif01GcgNRssKJWPswYompCndnPj
         LgdNaGYwB4JhZVCAg4IhMcoUE4nTnalkyoOTezggcWknOaV6RIkJiy5HmWnvtSw3ZO9z
         a+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wyk4KJjderVkyJv8jW+hlPmwUBgxY2V/mVNctLCR9Ow=;
        b=n18v6vY1wc7e6FfGKqtgMmN+x+EMd1zq7Z3sB3IcRblnzw3iCDwozGfCwDJBAWg8g3
         G2+P67H59aIg7mb1MrvJZt3v5FdqZwVSevI6QLOH9ryc0sgdc1lGiRNFCKXQ6dLYHdiM
         uDfhAaPrSawVX9Ho8U4tT1PNkS5W+JzDhG057M793+e2yOTL1VXm9JH8p7gHLsKRekFm
         FuFJHylDziGnGrOepFZbWTVN0h1SHMkFc8NQC/scisZo9tZvdeow5/8JTcvGLiy8TF3+
         7b37++tqwzoYIyWor5uLRzfAm7+EarOFXQomObo+O4y0/8L2v37iXhWx/gxCLQ9wtmAj
         isTA==
X-Gm-Message-State: APjAAAUynGgNB/BlLddEq3aU1RL/doQDdzvtUNwN/RzZED8A5lm2jRwP
        /CjGsq9iJKEqtvt5i4jRYgkiyQ==
X-Google-Smtp-Source: APXvYqwSsSibKPWmLyY4huZnbRLauH9G/TmbBV0vD+DyeC3zqZO9AkPvZYtHtC+gdHCZhNmtOCl7vg==
X-Received: by 2002:a63:7b5c:: with SMTP id k28mr12125525pgn.442.1573755551568;
        Thu, 14 Nov 2019 10:19:11 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k17sm4293181pgb.64.2019.11.14.10.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 10:19:11 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:19:09 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org,
        fabien.dessenne@st.com, s-anna@ti.com
Subject: Re: [PATCH v3 1/1] remoteproc: add support for co-processor loaded
 and booted before kernel
Message-ID: <20191114181909.GA21402@xps15>
References: <1573680543-39086-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573680543-39086-1-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On Wed, Nov 13, 2019 at 10:29:03PM +0100, Loic Pallardy wrote:
> Remote processor could boot independently or be loaded/started before
> Linux kernel by bootloader or any firmware.
> This patch introduces a new property in rproc core, named skip_fw_load,
> to be able to allocate resources and sub-devices like vdev and to
> synchronize with current state without loading firmware from file system.
> It is platform driver responsibility to implement the right firmware
> load ops according to HW specificities.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> 
> ---
> Change from v2:
> - rename property into skip_fw_load
> - update rproc_boot and rproc_fw_boot description
> - update commit message
> Change from v1:
> - Keep bool in struct rproc
> ---
>  drivers/remoteproc/remoteproc_core.c | 51 +++++++++++++++++++++++++++---------
>  include/linux/remoteproc.h           |  2 ++
>  2 files changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 3c5fbbbfb0f1..585cdca8b241 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1360,7 +1360,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  }
>  
>  /*
> - * take a firmware and boot a remote processor with it.
> + * Handle resources defined in resource table and start a remote processor.
>   */
>  static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  {
> @@ -1372,7 +1372,11 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	if (ret)
>  		return ret;
>  
> -	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
> +	if (fw)
> +		dev_info(dev, "Booting fw image %s, size %zd\n", name,
> +			 fw->size);
> +	else
> +		dev_info(dev, "Synchronizing with preloaded co-processor\n");

Here we assume that if @fw is NULL then the image is already loaded.  The first
question that comes to mind is if that means the ELF image has already been
copied to the coprocessor's boot address.  If that is the case it would be nice
to make it explicit with a comment in the code.

Following the earlier comments made on the thread for this serie, I understand
the rproc_ops fed to the core should provision for @fw being NULL.  In
this case though st_rproc_ops[1] reference a number of core operations that
aren't tailored to handled a NULL @fw parameter. 

I am pretty sure you're well aware of this and you have more patches to go with
this one or said patches have already been published and I'm looking at the
wrong tree. If that is the case would you mind making those patches public or
pointing me to a repository somewhere?

I have other concerns about the specifics shared between the application and co
processors using the ELF image but I'll wait for your reply to the above before
addressing those.

Regards,
Mathieu

[1]. https://elixir.bootlin.com/linux/v5.4-rc7/source/drivers/remoteproc/stm32_rproc.c#L470 

>  
>  	/*
>  	 * if enabling an IOMMU isn't relevant for this rproc, this is
> @@ -1719,16 +1723,22 @@ static void rproc_crash_handler_work(struct work_struct *work)
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
> @@ -1759,11 +1769,17 @@ int rproc_boot(struct rproc *rproc)
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
> +		/* set firmware name to null as unknown */
> +		kfree(rproc->firmware);
> +		rproc->firmware = NULL;
>  	}
>  
>  	ret = rproc_fw_boot(rproc, firmware_p);
> @@ -1917,8 +1933,17 @@ int rproc_add(struct rproc *rproc)
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
