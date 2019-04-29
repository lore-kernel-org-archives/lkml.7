Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58744C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BD720652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKzT/jEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfD2Rog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:44:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45317 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfD2Rog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:44:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id o5so5399040pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k1NomnPWMIfso5x9ImCRSbz25mvLyl8gFIQ8b/bFOKU=;
        b=cKzT/jECdjkEqqAqdqgiVNtmJx5QGXkHirh7YnqVt5rNVYMskoK+zKZQyuFzkPJxno
         5AYGHxgllC2CbVNUdL+mNkm4B4eBeokIMKQHdluM17yqfP+8cg/DoL/6CfkLuBazikHf
         4YpzBUCzq6MTjps7nW/JKehIzwO2k+csB39pgksxnQkbqkPPOLgIPu0h5TigJ8U657Y2
         3ID46ruVukzp+FvgQZ9TeRXWJSKrVSB7dCob3me3OnLA7uFa2WI8OlQGPcxWrVOH8FZ2
         xObdVCMqL9iuJ5+AQW0GvOVU91VwSOKLJ+Fa/ZAVjsma9rHjF1K24K3cb+9UHzAsj5kD
         MsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k1NomnPWMIfso5x9ImCRSbz25mvLyl8gFIQ8b/bFOKU=;
        b=WPTjY3UedJTWV3zZiRmTIGVT6wQ0tZoS9ikYYYEFc6cLo+lta/GLOEVqjX0FIqji3g
         OmIgyWqkKICAKVjSl8V2YtrY0orT0mcJZK54QD3FIxcIPPg/A/uB9qp84fk2/8xyKMVh
         Ini3yddkQ0YEm4yXjGMQY+Ki1o1eqbeYLHmu1zXI+yaU46auydkLmueg+KooOHKB+TAQ
         cFAEplOvX+KwRXPcnq/nyZ8nCxGRC3lsNalpt6PeVryYMH3tS3XehAwqB13RhelI8BKE
         Eu4YjtNTKe43aMrePKvzv4ovoe2QPVJXHmJ46T28lZoNQKmt2QmZLVzfHjleMJ47HGkS
         qwcw==
X-Gm-Message-State: APjAAAWp/SHW2eInquQdZ6/iqdE5WZYfuTVVvMnmiEVcSqvRhpPVFG1l
        G/hqHyx/Vxawm9ilbVFvH5mUtw==
X-Google-Smtp-Source: APXvYqxfDdgpKbi7c5IJfSUSR96PBo3aTr9H2pdfHg77PXLqLz0S0cq3UFVcfj/69GieeS/am76LyA==
X-Received: by 2002:a17:902:bd0c:: with SMTP id p12mr12365704pls.50.1556559875914;
        Mon, 29 Apr 2019 10:44:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c22sm46860290pfn.136.2019.04.29.10.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:44:35 -0700 (PDT)
Date:   Mon, 29 Apr 2019 11:44:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 35/36] [RFC] coresight: add return value for fixup
 connections
Message-ID: <20190429174432.GB18807@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-36-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-36-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:18PM +0100, Suzuki K Poulose wrote:
> Handle failures in fixing up connections for a newly registered
> device. This will be useful to handle cases where we fail to expose
> the links via sysfs for the connections.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 010bc86..4d63063 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1025,18 +1025,18 @@ static int coresight_orphan_match(struct device *dev, void *data)
>  	return 0;
>  }
>  
> -static void coresight_fixup_orphan_conns(struct coresight_device *csdev)
> +static int coresight_fixup_orphan_conns(struct coresight_device *csdev)
>  {
>  	/*
>  	 * No need to check for a return value as orphan connection(s)
>  	 * are hooked-up with each newly added component.
>  	 */
> -	bus_for_each_dev(&coresight_bustype, NULL,
> +	return bus_for_each_dev(&coresight_bustype, NULL,
>  			 csdev, coresight_orphan_match);

After this patch the comment is no longer true - please consider amending.

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  }
>  
>  
> -static void coresight_fixup_device_conns(struct coresight_device *csdev)
> +static int coresight_fixup_device_conns(struct coresight_device *csdev)
>  {
>  	int i;
>  
> @@ -1056,6 +1056,8 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
>  			conn->child_dev = NULL;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static int coresight_remove_match(struct device *dev, void *data)
> @@ -1265,10 +1267,15 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  
>  	mutex_lock(&coresight_mutex);
>  
> -	coresight_fixup_device_conns(csdev);
> -	coresight_fixup_orphan_conns(csdev);
> +	ret = coresight_fixup_device_conns(csdev);
> +	if (!ret)
> +		ret = coresight_fixup_orphan_conns(csdev);
>  
>  	mutex_unlock(&coresight_mutex);
> +	if (ret) {
> +		coresight_unregister(csdev);
> +		return ERR_PTR(ret);
> +	}
>  
>  	return csdev;
>  
> -- 
> 2.7.4
> 
