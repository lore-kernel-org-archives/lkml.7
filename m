Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B26C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CCC206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5NTEAng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLUUUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 15:20:43 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53480 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfLUUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 15:20:43 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so5660850pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 12:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hlfv7lgkbhZZ3SIc3UgNPE6Boampe7OtyYVE0MQkMSA=;
        b=a5NTEAngDx1EoqJzthzVt4uROhz0Vyn8HAS8ScRGRkah+cuhPoYbuGVHLgoGj/Kxw/
         ER3N84SQvXHcpZaTMmPY9o0SoIGsgVuvGbG2IbqVB+0YsxlwU0rvcHVznDRh8y14Kw5h
         oPDRhUfuGDQG6e4tuEXp5bpInZReAGQ1QQcIMWv+80EpgS1gNQFPVWRmcMnL/L7S+pYF
         JnUTw86bn2OflW+M8U5hmhRKQq7Ghw3w1C5OkSnpITAFkEJABmnuyNU7qHIgXd2o8EGn
         Ux5+sGiWJndyi3NX19arm4VFRiy6+xNNPlqH6oU91vI4Kva5xe/qS9+AAaohc3N2lmys
         yu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hlfv7lgkbhZZ3SIc3UgNPE6Boampe7OtyYVE0MQkMSA=;
        b=FAN3CMZMQTHTzi2vailspqxQf2SIRtGOJ1mXXqTppexNwdo0aTMXPDXIeuE0Rya8Ld
         i9F0Tr2LOwtwff9mzDa+gLrgTDM8RfACJ/f/ebNpZua4L9rhIbLnvpZb/z8Y6WtsS179
         6I+iY4QmRgyqntxMijH26NxEIMXwBwmucIc+O+eg+NwYDRGV1oa+DrAsE6vHTcNV4ttk
         5mTWJ3ILccZpWm5Dl8Cc0uDnOuoIixlcWdzRQWWxqwi2BdeVb2BpurDgb3B5EqPoFl8s
         PpdOyCC6vwxw5Svag5N3ulEFcYx/dvxKTKMDMNlLUohEJN4/6mgeBTO9fXGTQj5b7qXv
         ALRQ==
X-Gm-Message-State: APjAAAUisCoT5QZmOJGbmCPQj1HAgERnGwKpfXIOLJhGYYmwQ/zb5uaP
        AHTvWG1rHUgPxdSlIygl1H6vYA==
X-Google-Smtp-Source: APXvYqyQX0g/TRTJDsUTfUwZCKafU5aMcUF3r0SEXFOfDSiADSPnB2M6SwfytxMAz834jQERA25NCA==
X-Received: by 2002:a17:90a:d682:: with SMTP id x2mr24626885pju.44.1576959642249;
        Sat, 21 Dec 2019 12:20:42 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a13sm17946953pfc.40.2019.12.21.12.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 12:20:41 -0800 (PST)
Date:   Sat, 21 Dec 2019 12:20:39 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] remoteproc: Add prepare/unprepare callbacks
Message-ID: <20191221202039.GG549437@yoga>
References: <20191210164014.50739-1-paul@crapouillou.net>
 <20191210164014.50739-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210164014.50739-3-paul@crapouillou.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Dec 08:40 PST 2019, Paul Cercueil wrote:

> The .prepare() callback is called before the firmware is loaded to
> memory. This is useful for instance in the case where some setup is
> required for the memory to be accessible.
> 

Would it make sense to somehow tie this prepare/unprepare to the actual
struct rproc_mem_entry that needs the resource enabled?

Regards,
Bjorn

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2-v4: No change
> 
>  drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
>  include/linux/remoteproc.h           |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 0a9fc7fdd1c3..3ea5f675a148 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1299,11 +1299,19 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> +	if (rproc->ops->prepare) {
> +		ret = rproc->ops->prepare(rproc);
> +		if (ret) {
> +			dev_err(dev, "Failed to prepare rproc: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	/* load the ELF segments to memory */
>  	ret = rproc_load_segments(rproc, fw);
>  	if (ret) {
>  		dev_err(dev, "Failed to load program segments: %d\n", ret);
> -		return ret;
> +		goto unprepare_rproc;
>  	}
>  
>  	/*
> @@ -1354,6 +1362,9 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	rproc_unprepare_subdevices(rproc);
>  reset_table_ptr:
>  	rproc->table_ptr = rproc->cached_table;
> +unprepare_rproc:
> +	if (rproc->ops->unprepare)
> +		rproc->ops->unprepare(rproc);
>  
>  	return ret;
>  }
> @@ -1483,6 +1494,9 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  
>  	rproc->state = RPROC_OFFLINE;
>  
> +	if (rproc->ops->unprepare)
> +		rproc->ops->unprepare(rproc);
> +
>  	dev_info(dev, "stopped remote processor %s\n", rproc->name);
>  
>  	return 0;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 5f201f0c86c3..a6272d1ba384 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -355,6 +355,8 @@ enum rsc_handling_status {
>  
>  /**
>   * struct rproc_ops - platform-specific device handlers
> + * @prepare:	prepare the device for power up (before the firmware is loaded)
> + * @unprepare:	unprepare the device after it is stopped
>   * @start:	power on the device and boot it
>   * @stop:	power off the device
>   * @kick:	kick a virtqueue (virtqueue id given as a parameter)
> @@ -371,6 +373,8 @@ enum rsc_handling_status {
>   * @get_boot_addr:	get boot address to entry point specified in firmware
>   */
>  struct rproc_ops {
> +	int (*prepare)(struct rproc *rproc);
> +	void (*unprepare)(struct rproc *rproc);
>  	int (*start)(struct rproc *rproc);
>  	int (*stop)(struct rproc *rproc);
>  	void (*kick)(struct rproc *rproc, int vqid);
> -- 
> 2.24.0
> 
