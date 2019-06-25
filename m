Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE04C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480E321655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agXIyohE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfFYNFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:05:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50209 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfFYNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:05:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so2770088wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4nNfIWXsbuWkXABqorH5/YWxe2eUXvASoBcY3Q4IT0Q=;
        b=agXIyohEeL5aSmsFK9/eZQnM28H5O3wLADo6asi/edUROUp+gkzSdzX6RNudO0KgEM
         4sZzwU1LtPNYA6EmdBk5UNG9IRRbPPcBnBX0qay3q0RF0gJompYL15QmlEDh+ZeMr4EK
         Wzs9ayvC4DuMYPOfw970JsaBe815uHC8oaD+Vz3n0wL5rH94JbgliM6GWDVBjwXuTrBi
         mvS8T0i+SaLgmcMqowaF0jIrJKRnJ7nO3sLMK7MR0dSwIVTENAjbCh9InX82Wr58pBF5
         mdLCNR1qN0vwZa35CT1VI4xPeb3N+AJZRPydZj0/eSul9EjkhAGXZ81ejFbCdhk6h+WI
         LHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4nNfIWXsbuWkXABqorH5/YWxe2eUXvASoBcY3Q4IT0Q=;
        b=m1NfW3LBbn/FlhmiaYXCpNUHNL/ple/ttjduXwzhl711A2ATvUW80EL6f3Pqg9PY8M
         VefTaOZvLmop5tk8GuVu1M9vGXYQviDj+brhktW45/tx80kPaIadR0TX5Ld6N795GQLA
         xctYaWFo7edGtHzGdptaDzjTp1UzKGj8j2QnCl4cmqge4s4RVTlNDJjZThukAuW5Nvr9
         v1u2FI3XLWRWqHncxzSddIOG3tGb2aaFUgM0HJ2QlvignL/iWhqHY3sGiPBpKjBWJqHv
         4w9rVdGHyvbGHNNQyypbqWW0FiQyfMEDfEpF8OvNpaX7CUnWzuRx+pdRYdK48AV5daNe
         Qj8A==
X-Gm-Message-State: APjAAAWKKQuJuwnpN25VqoP/XJREj8yo9wa9CuNBFOuTb4gF3BjJd5md
        ey6HmiY5UzfkbEg/hQJdwFqWmg==
X-Google-Smtp-Source: APXvYqxCiqTFDYEkNUUTS0hbWVxoN5bHMwTOYhwVDRdm+Z7NoLq0W9pFMznZLhmGIeMli9qpwdAsfA==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr19442330wmh.70.1561467917292;
        Tue, 25 Jun 2019 06:05:17 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id h1sm13430752wrt.20.2019.06.25.06.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 06:05:16 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:05:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: Re: [PATCH v2] platform/chrome: Expose resume result via debugfs
Message-ID: <20190625130515.GJ21119@dell>
References: <20190617215234.260982-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190617215234.260982-1-evgreen@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Evan Green wrote:

> For ECs that support it, the EC returns the number of slp_s0
> transitions and whether or not there was a timeout in the resume
> response. Expose the last resume result to usermode via debugfs so
> that usermode can detect and report S0ix timeouts.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

This still needs a platform/chrome Ack.

> ---
> 
> Changes in v2:
>  - Moved from sysfs to debugfs (Enric)
>  - Added documentation (Enric)
> 
> 
> ---
>  Documentation/ABI/testing/debugfs-cros-ec | 22 ++++++++++++++++++++++
>  drivers/mfd/cros_ec.c                     |  6 +++++-
>  drivers/platform/chrome/cros_ec_debugfs.c |  7 +++++++
>  include/linux/mfd/cros_ec.h               |  1 +
>  4 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> index 573a82d23c89..008b31422079 100644
> --- a/Documentation/ABI/testing/debugfs-cros-ec
> +++ b/Documentation/ABI/testing/debugfs-cros-ec
> @@ -32,3 +32,25 @@ Description:
>  		is used for synchronizing the AP host time with the EC
>  		log. An error is returned if the command is not supported
>  		by the EC or there is a communication problem.
> +
> +What:		/sys/kernel/debug/cros_ec/last_resume_result
> +Date:		June 2019
> +KernelVersion:	5.3
> +Description:
> +		Some ECs have a feature where they will track transitions to
> +		the (Intel) processor's SLP_S0 line, in order to detect cases
> +		where a system failed to go into S0ix. When the system resumes,
> +		an EC with this feature will return a summary of SLP_S0
> +		transitions that occurred. The last_resume_result file returns
> +		the most recent response from the AP's resume message to the EC.
> +
> +		The bottom 31 bits contain a count of the number of SLP_S0
> +		transitions that occurred since the suspend message was
> +		received. Bit 31 is set if the EC attempted to wake the
> +		system due to a timeout when watching for SLP_S0 transitions.
> +		Callers can use this to detect a wake from the EC due to
> +		S0ix timeouts. The result will be zero if no suspend
> +		transitions have been attempted, or the EC does not support
> +		this feature.
> +
> +		Output will be in the format: "0x%08x\n".
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 5d5c41ac3845..2a9ac5213893 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -102,12 +102,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>  
>  	/* For now, report failure to transition to S0ix with a warning. */
>  	if (ret >= 0 && ec_dev->host_sleep_v1 &&
> -	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
> +	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> +		ec_dev->last_resume_result =
> +			buf.u.resp1.resume_response.sleep_transitions;
> +
>  		WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
>  			  EC_HOST_RESUME_SLEEP_TIMEOUT,
>  			  "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
>  			  buf.u.resp1.resume_response.sleep_transitions &
>  			  EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index cd3fb9c22a44..663bebf699bf 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -447,6 +447,13 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>  	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
>  			    &cros_ec_uptime_fops);
>  
> +	if (!strcmp(ec->class_dev.kobj.name, CROS_EC_DEV_NAME)) {
> +		debugfs_create_x32("last_resume_result",
> +				   0444,
> +				   debug_info->dir,
> +				   &ec->ec_dev->last_resume_result);
> +	}
> +
>  	ec->debug_info = debug_info;
>  
>  	dev_set_drvdata(&pd->dev, ec);
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index 5ddca44be06d..45aba26db964 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -155,6 +155,7 @@ struct cros_ec_device {
>  	struct ec_response_get_next_event_v1 event_data;
>  	int event_size;
>  	u32 host_event_wake_mask;
> +	u32 last_resume_result;
>  };
>  
>  /**

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
