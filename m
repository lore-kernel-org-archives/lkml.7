Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FB1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72F320693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfjobO7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfDPK1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:27:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33643 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfDPK1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:27:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so10132521plo.0;
        Tue, 16 Apr 2019 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=71Ay+/zwy6XGeLFqR6I9o/UAfQvlsfkRImmq55N6HYE=;
        b=bfjobO7BODZtTTJtH8FQa62BBjBHo44LqIeIbe5f8evThlje9rN/z++qtiz6o9KIr7
         Xs02giTpx7c2A/EWUDKTDwn3AabXjI/ewknVqNtPp74oseHuwYDAHT5seOwxpLuD0Lgj
         vbhNPh+Ew0QQ4Tj+8rDdsxHSiUHgGcx9E7tZL8rviiYxOtyTKX/U0bpYJpTizLl4qx8T
         M8AfU6cMKDD1GXLSsn+j2ksaow4BrTjw3bDtGqxwOIUqgjY4T1gvyILQf2RpiYyZE4iY
         87JkSWInMHwYhm29X1sJR/iyeublZw9p+tAcsc1bfHxQGMgZowsSgKy0klbN/possTMz
         ByIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=71Ay+/zwy6XGeLFqR6I9o/UAfQvlsfkRImmq55N6HYE=;
        b=kPJChGOf9mKlfbbefoxjui9PkP+I0b7oVJ7E8jkGfjNTApg7RzyxjjCaFlX5jZys89
         Dmnk3TWQcNkuEBVbCYTdxUmAdsqFD7vW8m+F5lcb7/Ofi3itMVI9gTXGnL6WDgGrGy8R
         d9tC5w17D6KAmQp3qegu1s8M0yzpbB4ZQRYcX4YJFKsS3l3BMa+YSg8DTB4OHcgF57BO
         iWkPu4nJorq4Kiy1XGgAce+quUiF13Ktp7FVSS/cV+HVBYhrE6IRyVbqzGQYp6mdgvTY
         HoJYq8FwT4XUOMevUZX1GUTUaqKvb0uzuMHx0ek3mEs8aKuOLpSEkutHE+00koGLfVzx
         f6ew==
X-Gm-Message-State: APjAAAUczXMyujVNYX/0X+xNK4YeqOWqN3qJn0K0Pz1+hyQgwYwX7XOk
        lVNl3Cok6itnPv1Nb1nlbsnPC9vY
X-Google-Smtp-Source: APXvYqzJG64MRiqfSOWxuaFtDytFRUFz5WhqBXJiT1XKDNs0hlrdOs0NmZ2iiYro0oQNl4dZj58Mxw==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr81520527plk.226.1555410465610;
        Tue, 16 Apr 2019 03:27:45 -0700 (PDT)
Received: from icarus ([2001:268:c1c2:6e92:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id q11sm69363540pgs.94.2019.04.16.03.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 03:27:45 -0700 (PDT)
Date:   Tue, 16 Apr 2019 19:28:39 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/16] watchdog: ebc-c384_wdt: drop warning after
 calling watchdog_init_timeout
Message-ID: <20190416102839.GA6046@icarus>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190416102515.12269-6-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:25:04PM +0200, Wolfram Sang wrote:
> The core will print out details now.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/watchdog/ebc-c384_wdt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> index 4c4c8ce78021..c176f59fea28 100644
> --- a/drivers/watchdog/ebc-c384_wdt.c
> +++ b/drivers/watchdog/ebc-c384_wdt.c
> @@ -117,10 +117,7 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>  	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
>  
>  	watchdog_set_nowayout(wdd, nowayout);
> -
> -	if (watchdog_init_timeout(wdd, timeout, dev))
> -		dev_warn(dev, "Invalid timeout (%u seconds), using default (%u seconds)\n",
> -			timeout, WATCHDOG_TIMEOUT);
> +	watchdog_init_timeout(wdd, timeout, dev);
>  
>  	return devm_watchdog_register_device(dev, wdd);
>  }
> -- 
> 2.11.0

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
