Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F6BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AF320823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDg8KG8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfC1RmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:42:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38748 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfC1RmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:42:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id g37so5287102plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1mbX6TtDd3JqGNN21RxAU/l6aiTygvCs2X0+WCtQGVQ=;
        b=IDg8KG8BZ+JDTOffSRUn8bQ09KQf2T7Q5G9AZ9kyXIbOrZF81p0W2RaLU/Rs3221hI
         rLZNJV2LUrid0ww8/wuJWPurXz3IqkqDl7cYJjwvnKRqGJxK5c1fCdK1furZcb5/9F7o
         ImNAKDDhaxl3chHRnHyzDWXP8ANaWaC8ep9eWTErFGQXaRsXeE8/fafAWNFUTqKl0JjO
         PiaL7FQdWQGyRIJmCivp/et72Q3Psq+mvkXxDOtmuFk+WHWg4oXzhLjVSaWAWB/Hkr/s
         bpuSGBoG7SSo6+73mqqAcyzwSDkd+XG7FbJ40QLBaOZRlYst/qEbMsqTCLnJhOhRFpP9
         cCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1mbX6TtDd3JqGNN21RxAU/l6aiTygvCs2X0+WCtQGVQ=;
        b=hdwswZZAALBWLIH6qQmgN7In/MnzotKlxgdtzJIJPGbmyBO93WI2AYv0zgzF2Ofv8q
         34OXqEJHUj7nMVnW9kugTttA1fAXyYAJ9+wu4usW1Z3VgpEqUSYKidLKVcqkpt2yxXB5
         GwieKteTB/YrVQB+1x2w8oYyB9lfq2dwR/F8RcNC3SAcIPtr0a4RzEqLToRT0QalMlCG
         KMwHdKDA/tQe5HrZhTTc4pWcHxqoM7Ev5TpbtD4tQhO0peMP43mNCJ+NNbY3aznEpwlv
         ZyWeymzNB3E9uCpR4C6+HRcqnvMnYCLVVpVYS7LjLjHOM8sxTxSTlWrL/e+4X37rZviA
         OriQ==
X-Gm-Message-State: APjAAAUG5HKQkKMAaYgRgxtEd2U5qAHi67JkSenWIibeKGRWN1hJNg5a
        iZ53n2mZE82Fu1YmYJkLfbYnpDKYSSM=
X-Google-Smtp-Source: APXvYqwys9OPDoMLmoETaVAK0WlB/PfzxVlVp1I6JjJswSHb9DnWnYqPVSmB8Wkhoq6kJkMn9uSLpw==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr44014091plb.325.1553794938940;
        Thu, 28 Mar 2019 10:42:18 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l12sm48438288pgn.83.2019.03.28.10.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:42:18 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:42:16 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
Subject: Re: [PATCH 21/25] coresight: Use fwnode handle instead of device
 names
Message-ID: <20190328174216.GD778@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-22-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553107783-3340-22-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:38PM +0000, Suzuki K Poulose wrote:
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
>  drivers/hwtracing/coresight/coresight-platform.c | 10 ++++------
>  drivers/hwtracing/coresight/coresight-priv.h     |  2 ++
>  drivers/hwtracing/coresight/coresight.c          | 19 +++++++++++--------
>  include/linux/coresight.h                        |  4 ++--
>  4 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 877ed2b..5eee987 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -31,7 +31,7 @@ static int coresight_alloc_conns(struct device *dev,
>  	return 0;
>  }
>  
> -static int coresight_fwnode_handle_match(struct device *dev, void *data)
> +int coresight_match_fwnode_handle(struct device *dev, void *data)
>  {
>  	return dev_fwnode(dev) == data;
>  }
> @@ -46,7 +46,7 @@ coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>  	 * platform bus.
>  	 */
>  	dev = bus_find_device(&platform_bus_type, NULL,
> -			      fwnode, coresight_fwnode_handle_match);
> +			      fwnode, coresight_match_fwnode_handle);
>  	if (dev)
>  		return dev;
>  
> @@ -55,7 +55,7 @@ coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>  	 * looking for the device that matches the endpoint node.
>  	 */
>  	return bus_find_device(&amba_bustype, NULL,
> -			       fwnode, coresight_fwnode_handle_match);
> +			       fwnode, coresight_match_fwnode_handle);
>  }

Please change the name to coresight_match_fwnode_handle() in the previous patch
so that it is set only once.

>  
>  #ifdef CONFIG_OF
> @@ -214,9 +214,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  		}
>  
>  		conn->outport = endpoint.port;
> -		conn->child_name = devm_kstrdup(dev,
> -						dev_name(rdev),
> -						GFP_KERNEL);
> +		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);

I think it is worth adding a comment saying the refcount on the handle is
decremented in coresight_remove_match().  It is quite obvious when looking at
this patch but I suspect it won't be so in 1 year from now when trying to
understand this code again, especially since the increment/decrement are in
different files.

>  		conn->child_port = rendpoint.port;
>  		/* Connection record updated */
>  		ret = 1;
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index e0684d0..8fb1243 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -153,6 +153,8 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
>  				       struct coresight_device *sink);
>  void coresight_release_path(struct list_head *path);
>  
> +int coresight_match_fwnode_handle(struct device *dev, void *data);
> +
>  #ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
>  extern int etm_readl_cp14(u32 off, unsigned int *val);
>  extern int etm_writel_cp14(u32 off, u32 val);
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 29cef89..9cdedab 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1005,13 +1005,11 @@ static int coresight_orphan_match(struct device *dev, void *data)
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
> @@ -1043,9 +1041,9 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
>  		struct coresight_connection *conn = &csdev->conns[i];
>  		struct device *dev = NULL;
>  
> -		if (conn->child_name)
> -			dev = bus_find_device_by_name(&coresight_bustype, NULL,
> -						      conn->child_name);
> +		dev = bus_find_device(&coresight_bustype, NULL,
> +				      (void *)conn->child_fwnode,
> +				      coresight_match_fwnode_handle);
>  		if (dev) {
>  			conn->child_dev = to_coresight_device(dev);
>  			/* and put reference from 'bus_find_device()' */
> @@ -1080,9 +1078,11 @@ static int coresight_remove_match(struct device *dev, void *data)
>  		if (conn->child_dev == NULL)
>  			continue;
>  
> -		if (!strcmp(dev_name(&csdev->dev), conn->child_name)) {
> +		if (csdev->dev.fwnode == conn->child_fwnode) {
>  			iterator->orphan = true;
>  			conn->child_dev = NULL;
> +			/* Drop the reference to the handle for connection */

Same as above, please comment where this gets incremented.

> +			fwnode_handle_put(conn->child_fwnode);
>  			/* No need to continue */
>  			break;
>  		}
> @@ -1198,6 +1198,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  	csdev->dev.parent = desc->dev;
>  	csdev->dev.release = coresight_device_release;
>  	csdev->dev.bus = &coresight_bustype;
> +	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
> +
>  	dev_set_name(&csdev->dev, "%s", desc->pdata->name);
>  
>  	ret = device_register(&csdev->dev);
> @@ -1247,6 +1249,7 @@ void coresight_unregister(struct coresight_device *csdev)
>  	etm_perf_del_symlink_sink(csdev);
>  	/* Remove references of that device in the topology */
>  	coresight_remove_conns(csdev);
> +	fwnode_handle_put(csdev->dev.fwnode);
>  	device_unregister(&csdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(coresight_unregister);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index a48cd9b..76c31b2 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -128,14 +128,14 @@ struct coresight_desc {
>  /**
>   * struct coresight_connection - representation of a single connection
>   * @outport:	a connection's output port number.
> - * @chid_name:	remote component's name.
> + * @chid_fwnode: remote component's fwnode handle.
>   * @child_port:	remote component's port number @output is connected to.
>   * @child_dev:	a @coresight_device representation of the component
>  		connected to @outport.
>   */
>  struct coresight_connection {
>  	int outport;
> -	const char *child_name;
> +	struct fwnode_handle *child_fwnode;

Please drop this one line to group all the struct together.

>  	int child_port;
>  	struct coresight_device *child_dev;
>  };
> -- 
> 2.7.4
> 
