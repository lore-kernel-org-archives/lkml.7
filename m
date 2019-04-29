Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0113C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6F920652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVljXjmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfD2Rkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:40:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46032 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbfD2Rkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:40:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id o5so5394256pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yqGrP/Pk5Od/q2uuVdzkrCCm4fxm4ySCvMrxHSCLMNo=;
        b=sVljXjmKJtnEXliXKxkwebq5xKfTy86uAnBoTrm5UVWXLWu8WrQ3SrYgV9EGtIXjtL
         W73E9/Psz+SllzCOMkxV5kZ8dJ0wUPbhyuXPzsmzQhWsmoPyJKcQulOLPk6AlKrKcOud
         jqC3nxlZGeC2LQRiZTV2cyoFv3ql5WS/FVYxxL7z3icYl7Dro6nbsb8Mei8gr/DJ8E6I
         UGfjSoYFgwb5fbJ1LSWwXVM0hQKgbJ9/XAUuP9V3/KY/FnXnayOgBnYSCteYMdg8eTB+
         wRqHnpgR7sJ1bcgGz2JoX/aYnT/SrJxC9euNnSP5LQgG4cx+uEVE7OvHR2R1ZBdLkKfv
         5G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yqGrP/Pk5Od/q2uuVdzkrCCm4fxm4ySCvMrxHSCLMNo=;
        b=lK2XwBfugR/IYF9B9i+CRHtWrH8ozzPjqchRjjDUgZvbfvn44DNjA6YUaNyMZCUteo
         TdJtem7HpWekD5pT/wVqZbiu/Ighk32O468BNLfIxnt3qgS98mmOmRGmgSgniycB0TcH
         mwSjk3L2yX4UAARW8hSy2QxdkMXfEA+9/h+TM2Hok5sH/D8bYiEG6SXEch0MRY7ol4rK
         r9VLIJJbruvYdsZ+HyJp1CS72G2Rl7moFsm6CFvuYlk/r/E6Qbe77saVsojs3XJc/TF0
         Jds2aJq30sw89RSOabO5SMDEqfsx+epQ0jvyu8gvH2it4x2LyPFbZ5wiEwUZTiUTy0k0
         o5eQ==
X-Gm-Message-State: APjAAAXkidJ8pID2IdmTj46DlD3fA0prXa/9fHdeNJcIEmDTsvl/g+Fm
        u/lcvLtB10stVHy99/r5w7hNXw==
X-Google-Smtp-Source: APXvYqyZ9ch1mDN02UpHm9ZqpChoV/x4Wmqk7ltEjarIJPQP5WhnR/4J923deaX6hVmv7nBhjjxS2Q==
X-Received: by 2002:a17:902:e00e:: with SMTP id ca14mr21797793plb.317.1556559648152;
        Mon, 29 Apr 2019 10:40:48 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t5sm43838317pfh.141.2019.04.29.10.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:40:47 -0700 (PDT)
Date:   Mon, 29 Apr 2019 11:40:45 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 34/36] [RFC] coresight: Pass coresight_device for
 coresight_release_platform_data
Message-ID: <20190429174045.GA18807@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-35-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-35-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:17PM +0100, Suzuki K Poulose wrote:
> As we prepare to expose the links between the devices in
> sysfs, pass the coresight_device instance to the
> coresight_release_platform_data in order to free up the connections
> when the device is removed.
> 
> No functional changes as such in this patch.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 2 +-
>  drivers/hwtracing/coresight/coresight-priv.h     | 3 ++-
>  drivers/hwtracing/coresight/coresight.c          | 7 ++++---
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 224f698..6559c49 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -734,7 +734,7 @@ coresight_get_platform_data(struct device *dev)
>  		return pdata;
>  
>  	/* Cleanup the connection information */
> -	coresight_release_platform_data(pdata);
> +	coresight_release_platform_data(NULL, pdata);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(coresight_get_platform_data);
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 61d7f9f..bf28ca9 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -200,6 +200,7 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
>  	return 0;
>  }
>  
> -void coresight_release_platform_data(struct coresight_platform_data *pdata);
> +void coresight_release_platform_data(struct coresight_device *csdev,
> +				     struct coresight_platform_data *pdata);
>  
>  #endif
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index e3b9321..010bc86 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1173,7 +1173,8 @@ postcore_initcall(coresight_init);
>   * coresight_release_platform_data: Release references to the devices connected
>   * to the output port of this device.
>   */
> -void coresight_release_platform_data(struct coresight_platform_data *pdata)
> +void coresight_release_platform_data(struct coresight_device *csdev,
> +				     struct coresight_platform_data *pdata)
>  {
>  	int i;
>  
> @@ -1275,7 +1276,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  	kfree(csdev);
>  err_out:
>  	/* Cleanup the connection information */
> -	coresight_release_platform_data(desc->pdata);
> +	coresight_release_platform_data(NULL, desc->pdata);
>  	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(coresight_register);
> @@ -1285,7 +1286,7 @@ void coresight_unregister(struct coresight_device *csdev)
>  	etm_perf_del_symlink_sink(csdev);
>  	/* Remove references of that device in the topology */
>  	coresight_remove_conns(csdev);
> -	coresight_release_platform_data(csdev->pdata);
> +	coresight_release_platform_data(csdev, csdev->pdata);
>  	device_unregister(&csdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(coresight_unregister);

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
