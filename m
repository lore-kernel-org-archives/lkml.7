Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18652C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E025720879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpJyfpk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfEMRjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:39:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41448 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEMRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:39:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id l132so7564580pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KpsinxBxU2IoS3LCH5T0Ss+1QCWrxYRxntIPJdXby/A=;
        b=xpJyfpk3uJ1PoPj69whnoQXlK2Y6lg+pimlpWmvvoHSrn2GQ9KweickQD26Kijy0kX
         KOUiwHeetbM4coZ/33zlh2JPuIxqM1W55S74AA3gR88OCA4G41cwYMEQa0lLEW5ub0Pj
         XaXCu8Xgq97cSfA/6KMXjJlMvWQHouEQ2+dqVwaCgGO+s6n8Sjox+TsLwpiPL/cqzCZu
         Y5KmVjltLMp1U7C3phaU4GwWGOELUQS00VHails0/YXkwa0Dq3pQHwCQSszlhwPNndip
         bsss2SvctkAcnk8RrH5axLM79eC4qp0i0rhDBIlDyYAvsp5WMfhQKZjdeJevHyiwleHH
         dIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KpsinxBxU2IoS3LCH5T0Ss+1QCWrxYRxntIPJdXby/A=;
        b=t7dqiT21xN2z8M3eiL3az+0LvQZpWiuUA+hedyjD6YcbU5aknbG4lk8dyJxXLribO8
         obd9Y9n4aRtB/jqM+HSccy6jgFYeXM6fSk11Qr0G5QZDl5VMZyr784U0LcoVS0jYjy0P
         2AmMGjJEJmhxqnJNUoLNg7zhIL1vwjf2yIkrrIm8jvzcWXzqVNzEAcV+7gl9zmrUtome
         heUkGkSHaMo18EOwxchdQJbBU3ZqD9cqsaRLyU65IfOPERpW2Qca5+rcPd3roMlEVr4S
         dsUOvrzlLEM8CXN0ZoZuzsgy6PMI37utZrcLpI6tqp/uQTaTCTynmsXJEi10udg+v/Gq
         dM3w==
X-Gm-Message-State: APjAAAVHiyevkd/8sSW4HzHdECDE+6foeItW/c++TtinqYcj3qdRb73F
        TOvQrFGll0w2kps2qPJZz0lgEw==
X-Google-Smtp-Source: APXvYqyEYMG7ado+dLEWJgwVjGXR0xa/HRNzTbQYBvnTChEtAu6bvz0HchUbDOc2x5RW2QQY4I7Vbg==
X-Received: by 2002:a65:6255:: with SMTP id q21mr21702714pgv.211.1557769148012;
        Mon, 13 May 2019 10:39:08 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 17sm21589088pfw.65.2019.05.13.10.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:39:07 -0700 (PDT)
Date:   Mon, 13 May 2019 11:39:05 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, rjw@rjwysocki.net
Subject: Re: [PATCH v3 24/30] coresight: platform: Use fwnode handle for
 device search
Message-ID: <20190513173905.GD16162@xps15>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
 <1557226378-10131-25-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557226378-10131-25-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:52:51AM +0100, Suzuki K Poulose wrote:
> We match of_node while searching for a device. Make this
> more generic in preparation for the ACPI support by using
> fwnode_handle.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Change since v2:
>  - Drop the generic helper. It requires further clean up,
>    and will be dealt with a separate series.
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 53d6eed..4394095 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -36,14 +36,13 @@ static int coresight_alloc_conns(struct device *dev,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
> -static int of_dev_node_match(struct device *dev, void *data)
> +static int coresight_device_fwnode_match(struct device *dev, void *fwnode)
>  {
> -	return dev->of_node == data;
> +	return dev_fwnode(dev) == fwnode;
>  }
>  
>  static struct device *
> -of_coresight_get_endpoint_device(struct device_node *endpoint)
> +coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>  {
>  	struct device *dev = NULL;
>  
> @@ -52,7 +51,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
>  	 * platform bus.
>  	 */
>  	dev = bus_find_device(&platform_bus_type, NULL,
> -			      endpoint, of_dev_node_match);
> +			      fwnode, coresight_device_fwnode_match);
>  	if (dev)
>  		return dev;
>  
> @@ -61,9 +60,10 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
>  	 * looking for the device that matches the endpoint node.
>  	 */
>  	return bus_find_device(&amba_bustype, NULL,
> -			       endpoint, of_dev_node_match);
> +			       fwnode, coresight_device_fwnode_match);
>  }
>  
> +#ifdef CONFIG_OF
>  static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
>  {
>  	return of_property_read_bool(ep, "slave-mode");
> @@ -191,6 +191,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  	struct device_node *rparent = NULL;
>  	struct device_node *rep = NULL;
>  	struct device *rdev = NULL;
> +	struct fwnode_handle *rdev_fwnode;
>  
>  	do {
>  		/* Parse the local port details */
> @@ -209,8 +210,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  		if (of_graph_parse_endpoint(rep, &rendpoint))
>  			break;
>  
> +		rdev_fwnode = of_fwnode_handle(rparent);
>  		/* If the remote device is not available, defer probing */
> -		rdev = of_coresight_get_endpoint_device(rparent);
> +		rdev = coresight_find_device_by_fwnode(rdev_fwnode);
>  		if (!rdev) {
>  			ret = -EPROBE_DEFER;
>  			break;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
