Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92527C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53ADD20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpYtswht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfDQVkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:40:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46055 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:40:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so96356plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MConUnIDofKdP9/LKRQO9enfwB2tflTa4i6eF064n+E=;
        b=LpYtswhtzAnN9/OmBZ9Uw7y3vra4vyZyVP4S7xrrD6JjbcR0U9FhN1pcX6F1l9MPKC
         RPvzCW5t3XT/4wzdOg4qv6m7Rrpt22pDQwHPu89zYMLDnzNpLejLer6SngXOKAqUGHum
         AE61ivem6y7pgzFEpqc4YsMcWT+n0SpEc0GaSYqRQkJSjpN3/P9G+Y2T1rU/rexHRL9z
         hlnzbWC04QhuFUyWmbQWyb1xKaCVLGTBOnlAMwVMaZR0EJIvVQ/wJJ1On54RmlxbzXne
         rbPSn7lZBOb1bkwofm+jJwvOhJaYT50yoDZKqTLyr7wpxLCPRVtAquckLe7ZvD/iU/YH
         xWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MConUnIDofKdP9/LKRQO9enfwB2tflTa4i6eF064n+E=;
        b=tNH6nTmQEZR/G+64jPlGB4rDXx5YVJi4PuRqrRdgqspAesEHT7tSG4KKihd5vjzpIN
         LtP0/Y64aslm0LEOKpPDWFVBthFlAqQGaI4Ey2b7HodsUtk7WpCXXsGV8HxCvf/QGxTV
         W9qteH1sgf+/ZU4l9e3c6BUQiGoV8uEmK6dEP/AjK4TUxJUATLb5z8fT8OmKOvYRas+9
         eLTQhR8/xcuybymb8ncn73aTGAJfk2hZyWg8CcVZ5IrZ+ptfUeygTqvLoKnFn20F2leR
         HlDk1hTglwGVaQYhS9/LGIuh2hkB2flpUyUnG3dvE7dayhKvRPFzGLaInekQwWUoVzGN
         Zt3g==
X-Gm-Message-State: APjAAAXypswqzJbS31GPIaRYbY3z1d1CO3GjGir7sXH412XPmEyQYycV
        VbY2e43D/+WLpG7YILIJGt1HOQ==
X-Google-Smtp-Source: APXvYqwYHC0jsOIkLvpmHhjZMw4P4Nd3XzTucVvy6DXPiWcTSIhYvtEJoQUJ8nS9c/DPT3TXU1EVNQ==
X-Received: by 2002:a17:902:364:: with SMTP id 91mr78552321pld.72.1555537245019;
        Wed, 17 Apr 2019 14:40:45 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t5sm163668pfh.141.2019.04.17.14.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 14:40:43 -0700 (PDT)
Date:   Wed, 17 Apr 2019 15:40:41 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 09/36] coresight: catu: Cleanup device specific data
Message-ID: <20190417214041.GD14163@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-10-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-10-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:03:52PM +0100, Suzuki K Poulose wrote:
> Switch to using the CoreSight device instead of the real
> amba device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c | 13 +++++++------
>  drivers/hwtracing/coresight/coresight-catu.h |  1 -
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index ba3c005..14d1cf5 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -408,13 +408,14 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>  	int rc;
>  	u32 control, mode;
>  	struct etr_buf *etr_buf = data;
> +	struct device *dev = &drvdata->csdev->dev;
>  
>  	if (catu_wait_for_ready(drvdata))
> -		dev_warn(drvdata->dev, "Timeout while waiting for READY\n");
> +		dev_warn(dev, "Timeout while waiting for READY\n");
>  
>  	control = catu_read_control(drvdata);
>  	if (control & BIT(CATU_CONTROL_ENABLE)) {
> -		dev_warn(drvdata->dev, "CATU is already enabled\n");
> +		dev_warn(dev, "CATU is already enabled\n");
>  		return -EBUSY;
>  	}
>  
> @@ -440,7 +441,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>  	catu_write_irqen(drvdata, 0);
>  	catu_write_mode(drvdata, mode);
>  	catu_write_control(drvdata, control);
> -	dev_dbg(drvdata->dev, "Enabled in %s mode\n",
> +	dev_dbg(dev, "Enabled in %s mode\n",
>  		(mode == CATU_MODE_PASS_THROUGH) ?
>  		"Pass through" :
>  		"Translate");
> @@ -461,15 +462,16 @@ static int catu_enable(struct coresight_device *csdev, void *data)
>  static int catu_disable_hw(struct catu_drvdata *drvdata)
>  {
>  	int rc = 0;
> +	struct device *dev = &drvdata->csdev->dev;
>  
>  	catu_write_control(drvdata, 0);
>  	coresight_disclaim_device_unlocked(drvdata->base);
>  	if (catu_wait_for_ready(drvdata)) {
> -		dev_info(drvdata->dev, "Timeout while waiting for READY\n");
> +		dev_info(dev, "Timeout while waiting for READY\n");
>  		rc = -EAGAIN;
>  	}
>  
> -	dev_dbg(drvdata->dev, "Disabled\n");
> +	dev_dbg(dev, "Disabled\n");
>  	return rc;
>  }
>  
> @@ -519,7 +521,6 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>  		goto out;
>  	}
>  
> -	drvdata->dev = dev;
>  	dev_set_drvdata(dev, drvdata);
>  	base = devm_ioremap_resource(dev, &adev->res);
>  	if (IS_ERR(base)) {
> diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
> index 1b281f0..96ea8c4 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.h
> +++ b/drivers/hwtracing/coresight/coresight-catu.h
> @@ -61,7 +61,6 @@
>  #define CATU_IRQEN_OFF		0x0
>  
>  struct catu_drvdata {
> -	struct device *dev;
>  	void __iomem *base;
>  	struct coresight_device *csdev;
>  	int irq;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
