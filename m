Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0964AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F4521019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiXIHfU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfEMR7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45845 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfEMR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so7581869pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zUdov0OQ/NW5Sijd1/dCa6E7OCrJGBQr3YA7lcDOxE=;
        b=AiXIHfU+bKoH6/kAMNQE6cB+9Wt2xEWh+iiznkXopa00ut+DUJxXUGTn0RaiPfOJAl
         sHFT+MrLgZbfROwJxnZMBOWoNkqoLtwY70D4HPsuVOVzTbBb7sR8kpVGC0TvhVUkICXG
         B9/3eH7ypimaWmaDi0OCUQFS5OTJnVYKMq89DdylRD5B6v4W5Uq4kkX0GTA3jt/qsYKQ
         IClEc2EmhDYbB44SMtegVLHu2aIN8tT7WEsaDLbof7fYKW4chEOmrOHFBoKCT89XBSFl
         zjXsEFUnoeQvh+1NVbK5R59l1YN9BRAMUz6iTV2d6ITjIBGZevyrhxwJO2o3bvJEXJPy
         GPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zUdov0OQ/NW5Sijd1/dCa6E7OCrJGBQr3YA7lcDOxE=;
        b=X+vPB3ztQ/pqqVfpIgRKerXKkftftZKHsCQ6W5taodxV+jNfVNyid0entLkKWwYDoQ
         O7LpuQlcirdalf8Rzy6gJbpsMUWNnJQVcwVUfsgN2rfPsM//qdOwLzgLyThht774YpFY
         RE1dociLrJeuzV3v8EXcRMBqbZvMqAq523mlvFn/OJaO5wS+eoJLeWouNoI//7NgTy1/
         Mw1DzDqnywCIQeTgqRmUsHSXuwrdixTb4hgXXACElMdgf2RlZX3f1RGZSicOjoxgtR+Z
         j/rlrWbhoVWEeILynZ/Yumb30R+/dtMGsPKlxL7VWvgNyYDhfe7b0mWRvKDuWKFoc7R0
         o4vg==
X-Gm-Message-State: APjAAAXS5oO+Z9HUZ492D7niovXmuJVh8ypTw8IbS8bCR1lDXnExqWvs
        Ft2+AHynbJJwyntYQXXGZyHHTw==
X-Google-Smtp-Source: APXvYqydg+uvznchvEzBdRbjqRXnmTIVJS5PDCV9rpk5KxlLCGyj13QJso3eM+zXoFH5ZyTBjnWExA==
X-Received: by 2002:aa7:8251:: with SMTP id e17mr14647963pfn.147.1557770346959;
        Mon, 13 May 2019 10:59:06 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z7sm4109471pfr.23.2019.05.13.10.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:59:06 -0700 (PDT)
Date:   Mon, 13 May 2019 11:59:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, rjw@rjwysocki.net
Subject: Re: [PATCH v3 25/30] coresight: Use fwnode handle instead of device
 names
Message-ID: <20190513175904.GE16162@xps15>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
 <1557226378-10131-26-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557226378-10131-26-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:52:52AM +0100, Suzuki K Poulose wrote:
> We rely on the device names to find a CoreSight device on the
> coresight bus. The device name however is obtained from the platform,
> which is bound to the real platform/amba device. As we are about
> to use different naming scheme for the coresight devices, we can't
> rely on the platform device name to find the corresponding
> coresight device. Instead we use the platform agnostic
> "fwnode handle" of the parent device to find the devices.
> We also reuse the same fwnode as the parent for the Coresight
> device we create.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 14 +++++---
>  drivers/hwtracing/coresight/coresight-priv.h     |  6 ++--
>  drivers/hwtracing/coresight/coresight.c          | 42 +++++++++++++++++++-----
>  include/linux/coresight.h                        |  4 +--
>  4 files changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 4394095..49112a5 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -36,7 +36,7 @@ static int coresight_alloc_conns(struct device *dev,
>  	return 0;
>  }
>  
> -static int coresight_device_fwnode_match(struct device *dev, void *fwnode)
> +int coresight_device_fwnode_match(struct device *dev, void *fwnode)
>  {
>  	return dev_fwnode(dev) == fwnode;
>  }
> @@ -219,9 +219,15 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  		}
>  
>  		conn->outport = endpoint.port;
> -		conn->child_name = devm_kstrdup(dev,
> -						dev_name(rdev),
> -						GFP_KERNEL);
> +		/*
> +		 * Hold the refcount to the target device. This could be
> +		 * released via:
> +		 * 1) coresight_release_platform_data() if the probe fails or
> +		 *    this device is unregistered.
> +		 * 2) While removing the target device via
> +		 *    coresight_remove_match()
> +		 */
> +		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
>  		conn->child_port = rendpoint.port;
>  		/* Connection record updated */
>  		ret = 1;
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index c216421..8b07fe5 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -200,8 +200,8 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
>  	return 0;
>  }
>  
> -static inline void
> -coresight_release_platform_data(struct coresight_platform_data *pdata)
> -{}
> +void coresight_release_platform_data(struct coresight_platform_data *pdata);
> +
> +int coresight_device_fwnode_match(struct device *dev, void *fwnode);
>  
>  #endif
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 526141c..c9c8a8c 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -978,6 +978,7 @@ static void coresight_device_release(struct device *dev)
>  {
>  	struct coresight_device *csdev = to_coresight_device(dev);
>  
> +	fwnode_handle_put(csdev->dev.fwnode);
>  	kfree(csdev->refcnt);
>  	kfree(csdev);
>  }
> @@ -1009,13 +1010,11 @@ static int coresight_orphan_match(struct device *dev, void *data)
>  		/* We have found at least one orphan connection */
>  		if (conn->child_dev == NULL) {
>  			/* Does it match this newly added device? */
> -			if (conn->child_name &&
> -			    !strcmp(dev_name(&csdev->dev), conn->child_name)) {
> +			if (conn->child_fwnode ==  csdev->dev.fwnode)

There is one space too mnay after the '=='. 

>  				conn->child_dev = csdev;
> -			} else {
> +			else
>  				/* This component still has an orphan */
>  				still_orphan = true;
> -			}
>  		}
>  	}
>  
> @@ -1047,9 +1046,9 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
>  		struct coresight_connection *conn = &csdev->pdata->conns[i];
>  		struct device *dev = NULL;
>  
> -		if (conn->child_name)
> -			dev = bus_find_device_by_name(&coresight_bustype, NULL,
> -						      conn->child_name);
> +		dev = bus_find_device(&coresight_bustype, NULL,
> +				      (void *)conn->child_fwnode,
> +				      coresight_device_fwnode_match);
>  		if (dev) {
>  			conn->child_dev = to_coresight_device(dev);
>  			/* and put reference from 'bus_find_device()' */
> @@ -1084,9 +1083,15 @@ static int coresight_remove_match(struct device *dev, void *data)
>  		if (conn->child_dev == NULL)
>  			continue;
>  
> -		if (!strcmp(dev_name(&csdev->dev), conn->child_name)) {
> +		if (csdev->dev.fwnode == conn->child_fwnode) {
>  			iterator->orphan = true;
>  			conn->child_dev = NULL;
> +			/*
> +			 * Drop the reference to the handle for the remote
> +			 * device acquired in parsing the connections from
> +			 * platform data.
> +			 */
> +			fwnode_handle_put(conn->child_fwnode);
>  			/* No need to continue */
>  			break;
>  		}
> @@ -1166,6 +1171,22 @@ static int __init coresight_init(void)
>  }
>  postcore_initcall(coresight_init);
>  
> +/*
> + * coresight_release_platform_data: Release references to the devices connected
> + * to the output port of this device.
> + */
> +void coresight_release_platform_data(struct coresight_platform_data *pdata)
> +{
> +	int i;
> +
> +	for (i = 0; i < pdata->nr_outport; i++) {
> +		if (pdata->conns[i].child_fwnode) {
> +			fwnode_handle_put(pdata->conns[i].child_fwnode);
> +			pdata->conns[i].child_fwnode = 0;

I know there isn't a set standard for using '0' or NULL but since the latter is
used throughout the file I'd like to avoid an hybrid scheme.

> +		}
> +	}
> +}
> +
>  struct coresight_device *coresight_register(struct coresight_desc *desc)
>  {
>  	int ret;
> @@ -1210,6 +1231,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  	csdev->dev.parent = desc->dev;
>  	csdev->dev.release = coresight_device_release;
>  	csdev->dev.bus = &coresight_bustype;
> +	/*
> +	 * Hold the reference to our parent device. This will be
> +	 * dropped only in coresight_device_release().
> +	 */
> +	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>  	dev_set_name(&csdev->dev, "%s", desc->name);
>  
>  	ret = device_register(&csdev->dev);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index b67d507..b40544b 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -126,15 +126,15 @@ struct coresight_desc {
>  /**
>   * struct coresight_connection - representation of a single connection
>   * @outport:	a connection's output port number.
> - * @chid_name:	remote component's name.
>   * @child_port:	remote component's port number @output is connected to.
> + * @chid_fwnode: remote component's fwnode handle.
>   * @child_dev:	a @coresight_device representation of the component
>  		connected to @outport.
>   */
>  struct coresight_connection {
>  	int outport;
> -	const char *child_name;
>  	int child_port;
> +	struct fwnode_handle *child_fwnode;
>  	struct coresight_device *child_dev;
>  };
> 

With the above: 

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 
> -- 
> 2.7.4
> 
