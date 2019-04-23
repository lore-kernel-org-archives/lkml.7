Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B94C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189F9208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1A3JZzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfDWQO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:14:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35664 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfDWQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:14:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so7859987pgf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3sn7KqiGW30dkQKXr6QVLij/1FoqIHbldIq/02XidKw=;
        b=M1A3JZzHiArlOJub7vpLZFmeS0SpQa4YdZCJPFDTM+xz8gAPxVdsKkTHTXht6hzoO2
         0Mzmy4nIRehQU/f1TVn96iYucuLKDbn5qK996Fai0xu/nr6Af9DpOQ2j2ZJkFwsPTKyN
         xTcUveaVGLDEH//tVXhgI+q2Et7tgwuw87XAMiC1mtyhLJGDiZBfNJ2o3G0kj/o7ksY0
         DeDfxqC4Rw2uqDWoxqRI1vbxrcffaZbK9Gzn2wVemvqilYOVitpMiomSF7pah6T0GmY/
         B38NEqzctKe2aHDJDhUS9GzQntbIWA/mPXlKj3lU4k7pFtqJpbg4WFXLFths52KdtUEa
         6GCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3sn7KqiGW30dkQKXr6QVLij/1FoqIHbldIq/02XidKw=;
        b=KHL6aOVXK7pxXAdebVfzp+GZYjeGLBhRacojFhdjnE12Ezu9AvhkY5GOqq/i3HrzyD
         Ar8bDJbUtcKodxB1/Yoi79J9LUJ00UH8g0JJF1glc7MTRG2kG5pVn1NJqMEFWTs/Jhsm
         TbyWU2uCGDERDZYzJXaBREyXaJr01WPnHn3+u7hmuFlQxy/Vt6YLqakzWEDv9SjMUtQu
         FZZ4h/YPIEOG21WA9qq2SzhuNX9CibJWxmJ5aWjRLYt7zt8L6C3u2FyxuYfdPIgE6+WF
         RBEijEi5J0o49U1qiutcX8ubuWeiBH4DMintjkaDibWqFx62nJYoKO9RjwUapmD51+G6
         1t9Q==
X-Gm-Message-State: APjAAAWSP+SyoxqpZc7HIzCvZ+fotL8oSTcwdaW08bHBapnW6WKERweL
        F4EmnmNGfiaVWxTGGLvtcYatfg==
X-Google-Smtp-Source: APXvYqzeHHOioGKfVmk2VQ7/tIhElI8+8hXk8VcQbQ2tgiTIMrjk8HPTGxnrZauiAB7uiApGypWwgw==
X-Received: by 2002:a65:6414:: with SMTP id a20mr1663736pgv.217.1556036067164;
        Tue, 23 Apr 2019 09:14:27 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d69sm32358413pfg.24.2019.04.23.09.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:14:25 -0700 (PDT)
Date:   Tue, 23 Apr 2019 10:14:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 29/36] coresight: Use fwnode handle instead of device
 names
Message-ID: <20190423161423.GA21070@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-30-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-30-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:12PM +0100, Suzuki K Poulose wrote:
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
>  drivers/hwtracing/coresight/coresight-platform.c | 12 +++++--
>  drivers/hwtracing/coresight/coresight-priv.h     |  4 +--
>  drivers/hwtracing/coresight/coresight.c          | 42 +++++++++++++++++++-----
>  include/linux/coresight.h                        |  4 +--
>  4 files changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 318a6ff..c9a59fb 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -214,9 +214,15 @@ static int of_coresight_parse_endpoint(struct device *dev,
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

Many thanks for the documentation - not only does it help me but it also makes
it easier for other people to contribute to the subsystem.

> +		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
>  		conn->child_port = rendpoint.port;
>  		/* Connection record updated */
>  		ret = 1;
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index c216421..61d7f9f 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -200,8 +200,6 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
>  	return 0;
>  }
>  
> -static inline void
> -coresight_release_platform_data(struct coresight_platform_data *pdata)
> -{}
> +void coresight_release_platform_data(struct coresight_platform_data *pdata);

Now that we have fixed of_get_coresight_platform_data() I think patch 26 should
be rolled into this one.  That way everything related to
coresight_release_platform_data() is done in the same patch and the function
doesn't have to be modified twice. 

>  
>  #endif
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 82fb411..5169ce1 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -976,6 +976,7 @@ static void coresight_device_release(struct device *dev)
>  {
>  	struct coresight_device *csdev = to_coresight_device(dev);
>  
> +	fwnode_handle_put(csdev->dev.fwnode);
>  	kfree(csdev->refcnt);
>  	kfree(csdev);
>  }
> @@ -1007,13 +1008,11 @@ static int coresight_orphan_match(struct device *dev, void *data)
>  		/* We have found at least one orphan connection */
>  		if (conn->child_dev == NULL) {
>  			/* Does it match this newly added device? */
> -			if (conn->child_name &&
> -			    !strcmp(dev_name(&csdev->dev), conn->child_name)) {
> +			if (conn->child_fwnode ==  csdev->dev.fwnode)
>  				conn->child_dev = csdev;
> -			} else {
> +			else
>  				/* This component still has an orphan */
>  				still_orphan = true;
> -			}
>  		}
>  	}
>  
> @@ -1045,9 +1044,9 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
>  		struct coresight_connection *conn = &csdev->pdata->conns[i];
>  		struct device *dev = NULL;
>  
> -		if (conn->child_name)
> -			dev = bus_find_device_by_name(&coresight_bustype, NULL,
> -						      conn->child_name);
> +		dev = bus_find_device(&coresight_bustype, NULL,
> +				      (void *)conn->child_fwnode,
> +				      device_fwnode_match);
>  		if (dev) {
>  			conn->child_dev = to_coresight_device(dev);
>  			/* and put reference from 'bus_find_device()' */
> @@ -1082,9 +1081,15 @@ static int coresight_remove_match(struct device *dev, void *data)
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
> @@ -1164,6 +1169,22 @@ static int __init coresight_init(void)
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

                        pdata->conns[i].child_fwnode = NULL;
> +		
> +	}
> +}
> +
>  struct coresight_device *coresight_register(struct coresight_desc *desc)
>  {
>  	int ret;
> @@ -1208,6 +1229,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
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
> index 8c10def..188e759 100644
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
> -- 
> 2.7.4
> 
