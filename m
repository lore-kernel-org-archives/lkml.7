Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F6C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB88B208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lS3HEhp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfEMWkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:40:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37062 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEMWkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:40:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so7182610pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EdQpkIBMeg4fTDKNyi5MjhyUlXbVXsSFmE+0/z8UItw=;
        b=lS3HEhp3gUZ5YyfTIvZFJnJB013CIBUI0rwppPYyaTsdYh8HDrQxWVPyh+VSkcvm+E
         CWLJkdCkAkvnBs3XXcp+QkX4rNbizoodcDtvNjnglYeqzoQKUk2XBbjV3DmqLbIx9KsH
         ODLdnXEiKPEVaIUV9SHgvcv2Ez9HvoSvRcEj8HtQdHYfmq8bVBlbMxiCEcJp9/ak2Agm
         B+IjyoTJTepX1RXqXG6nL8syvaev3QF0GU6QCzFiSGG6t5ExNL/H8KHDX67oNfO2jAu7
         5PQM1Xb4NRbcEw2rAR47CeiJdHdPYtuyvQyqzuoa4xzNfQ4ji56+OcJL3OzNAd+rEJN5
         7sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EdQpkIBMeg4fTDKNyi5MjhyUlXbVXsSFmE+0/z8UItw=;
        b=WI5QGWcFlLchESPax9TAQZeAhYrPHbF/RzA6nhgLeMBQqyRXT2aLRDf4MHWJmmjY1Z
         Lkh+WtOiZZdRDj7J9Xfpoq73uiAS/lsgFQN+BI9oBWz2vtkdonA/ooUY6EGkrOU31fPG
         SLQesyUxzPClE/kYfN0HMJL883QKpC3RmbEzim8xviVQ+2iJfJxztq8mI36VlzrUeFiB
         tJKByUUFz+3F/iWLvo+8wLppBP2mCOicnBtb2qnWfSBmYcLWiV9gYj+HcLT7bK9+SwQF
         ttGqF0WLllNf6qioWjKC5ZKPIuRaCKaYQmPrRAJkpBPFExS7PZQk/g1Hxd0I0g+/DClj
         i2EA==
X-Gm-Message-State: APjAAAUwcWK4aa3ONdxlCio5y3pcKRHxZyjpDNd/xIuiY7k3qUFXmDX8
        3XWgmT4fvI8uq9+xqN9YZRviU8eunTk=
X-Google-Smtp-Source: APXvYqw0QV9Wrd/7bDYqoV0GRLJZB9DgR5yUeK57Tng47+bb/tycDqkWQ7YQ4sX4tWCofscUrQLR+A==
X-Received: by 2002:a17:902:46a:: with SMTP id 97mr6029286ple.66.1557787248550;
        Mon, 13 May 2019 15:40:48 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n26sm22109920pfi.165.2019.05.13.15.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 15:40:48 -0700 (PDT)
Date:   Mon, 13 May 2019 16:40:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, rjw@rjwysocki.net
Subject: Re: [PATCH v3 23/30] coresight: Add support for releasing platform
 specific data
Message-ID: <20190513224046.GH16162@xps15>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
 <1557226378-10131-24-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557226378-10131-24-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:52:50AM +0100, Suzuki K Poulose wrote:
> Add a helper to clean up the platform specific data provided
> by the firmware. This will be later used for dropping the necessary
> references when we switch to the fwnode handles for tracking
> connections.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 6 +++++-
>  drivers/hwtracing/coresight/coresight-priv.h     | 4 ++++
>  drivers/hwtracing/coresight/coresight.c          | 3 +++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index f500de6..53d6eed 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -17,6 +17,7 @@
>  #include <linux/cpumask.h>
>  #include <asm/smp_plat.h>
>  
> +#include "coresight-priv.h"
>  /*
>   * coresight_alloc_conns: Allocate connections record for each output
>   * port from the device.
> @@ -311,7 +312,7 @@ struct coresight_platform_data *
>  coresight_get_platform_data(struct device *dev)
>  {
>  	int ret = -ENOENT;
> -	struct coresight_platform_data *pdata;
> +	struct coresight_platform_data *pdata = NULL;
>  	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  
>  	if (IS_ERR_OR_NULL(fwnode))
> @@ -329,6 +330,9 @@ coresight_get_platform_data(struct device *dev)
>  	if (!ret)
>  		return pdata;
>  error:
> +	if (!IS_ERR_OR_NULL(pdata))
> +		/* Cleanup the connection information */
> +		coresight_release_platform_data(pdata);
>  	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(coresight_get_platform_data);
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index e0684d0..c216421 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -200,4 +200,8 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
>  	return 0;
>  }
>  
> +static inline void
> +coresight_release_platform_data(struct coresight_platform_data *pdata)
> +{}
> +
>  #endif
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 96e1515..526141c 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1250,6 +1250,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  err_free_csdev:
>  	kfree(csdev);
>  err_out:
> +	/* Cleanup the connection information */
> +	coresight_release_platform_data(desc->pdata);
>  	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(coresight_register);
> @@ -1259,6 +1261,7 @@ void coresight_unregister(struct coresight_device *csdev)
>  	etm_perf_del_symlink_sink(csdev);
>  	/* Remove references of that device in the topology */
>  	coresight_remove_conns(csdev);
> +	coresight_release_platform_data(csdev->pdata);
>  	device_unregister(&csdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(coresight_unregister);

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
