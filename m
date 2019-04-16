Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DA3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98301217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2TZMUVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfDPNgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:36:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44441 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:36:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so10352683pgj.11;
        Tue, 16 Apr 2019 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IcibeODVwQRTWNYqepcZtyP6d0MqAMXhiyMbyfXFfI4=;
        b=m2TZMUVodZZ8H/E4Gx6zgLNVmZ0xvCUXr9GIIorolC6LJfvePpY/DEo6cxOByoEncU
         Ili73Er8wXGnWLM96M0u+StUXdqeFODBOHR+VnPcokKgWkElqo0yfg2NSzhrLxopdCrM
         urtxV6KsFSFcv5AIjxzQpMm7hc4cGo5yaL7hIJfZ7a4WsxkBKIP/TQregUKRHq9TBnMJ
         yokvJX5GnvQPaP4jDNcUQ+4kZ/om4BNU7xsaGHy4HB3uG7HUJkahHmrXZ2mZdObeQQog
         hZ+3Qx6tuyw2dV4xZQrkMReqQUzJ0FXZAbimDIH89SpuTowm58aSioZjtIGqeBQh2MMo
         Gokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IcibeODVwQRTWNYqepcZtyP6d0MqAMXhiyMbyfXFfI4=;
        b=X2SAQUiR0+2OEYYh2/4i7jrGJcEKj/xwDQY47CRBRaV3H/41fHJa00GKGCFzPcAXJj
         D0Ii/GVkR+i4XKcFxtuThaGfmBunf4A8ROI5LX81JboOviMBXOHc557K54rI3fXisCer
         7wjzCJ+Ewl4tpmFNra06weXgCcrYLcOxGY+kxlohhiqFrEdGiJuqzewgCGcahoaoUiXb
         Ul3AkZ0Ih+qOC7eQIJ9Q/yJ0M2ZLttcP86BK2Gb+5aRtLeaPvX60AIF014TG9CPTq0lK
         OCuCg6FNQZ0oOw3atFZjXQX1aHoLnbFf9s/zkY8QYB9TIzBSgcSXkRqCNClHLyBXNqcw
         OB+w==
X-Gm-Message-State: APjAAAVqlX5dfRjpX9sT54FwzbQIpKEcy5e5kaa6YytwSLn3iXUQG5i4
        +jc2kPPjv6+ZS6sodD9RcZ0=
X-Google-Smtp-Source: APXvYqxcJYv5xDrnjgS+ktUZQnX0mmzeHxDSy9EG6lmUFrecCzY253t6ymz6MJKG3IH6ohvbc+vxeg==
X-Received: by 2002:a62:26c1:: with SMTP id m184mr45575988pfm.102.1555421782329;
        Tue, 16 Apr 2019 06:36:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k186sm75208476pfc.137.2019.04.16.06.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:36:21 -0700 (PDT)
Date:   Tue, 16 Apr 2019 06:36:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: intel_scu_watchdog: fix spelling mistake:
 "set_hearbeat" -> "set_heartbeat"
Message-ID: <20190416133620.GA19699@roeck-us.net>
References: <20190416133318.21045-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416133318.21045-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:33:18PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_debug message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/intel_scu_watchdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
> index 0caab6241eb7..718f7db35bec 100644
> --- a/drivers/watchdog/intel_scu_watchdog.c
> +++ b/drivers/watchdog/intel_scu_watchdog.c
> @@ -224,7 +224,7 @@ static int intel_scu_set_heartbeat(u32 t)
>  		 watchdog_device.timer_tbl_ptr->freq_hz);
>  	pr_debug("set_heartbeat: timer_set is %x (hex)\n",
>  		 watchdog_device.timer_set);
> -	pr_debug("set_hearbeat: timer_margin is %x (hex)\n", timer_margin);
> +	pr_debug("set_heartbeat: timer_margin is %x (hex)\n", timer_margin);
>  	pr_debug("set_heartbeat: threshold is %x (hex)\n",
>  		 watchdog_device.threshold);
>  	pr_debug("set_heartbeat: soft_threshold is %x (hex)\n",
> -- 
> 2.20.1
> 
