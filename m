Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A438EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7039720651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byeOH0yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfDZQMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:12:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45334 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:12:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id o5so1785386pls.12;
        Fri, 26 Apr 2019 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+bbsuKoR24YMuDr33VKXl7Q82tkl1CzMT//eb9+9c84=;
        b=byeOH0yWYnFhUFa3PDaM4zPwagrPHA4B9aTN2i8AfkXKGtsWkP4vVLk5f9QmcMkOnR
         lbdbKAgipyqOSYtbCSDvEpdFbDVytkJvjBMGgkVQbQgWnIm+uj/yNz8W1uEcDVi+D7UU
         wYxLEy6/dalZnYRDC+vTmSswhZI8T+9Mtcg9g9wZFW0rC+1mPat5lWB4v0WZlj0xVMQS
         v9A12KP1KHwy1Qp1VkK7FSn+WKg5Dpu5TPXsJ5TaoQ72dRFe0vopyPusjaexa+GXVfui
         NA6PmlAbaHBMrCja6BJTh5RQwQavXuU38TxNwG8cC21fB56tsQC/hXFtlMqVZ85GWL8A
         cOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+bbsuKoR24YMuDr33VKXl7Q82tkl1CzMT//eb9+9c84=;
        b=MG6QdNs1VsWtXKp4ohQviVxQmJahsP1zYGV+hQUDzzklmPgwxCQaWCx1PIzEL9czLe
         0JRXqVzxUJ72LZAPOwU6hih2D2Ic6+TTX97q48+zUNEtVF/P95jl7lF2LDAXkopvDSGk
         V8URKrhLOzJZ08SK31Uh7ljKi9zBKkXfEOz7G91CJ1vYSDlEx+pH4DbQ/KuKdUzKsxmk
         P7r4P5/SvwC/iiRg2kFY3bdESo7omUZ4jR+VBM3sG3xM/b+L8cURdA+S1qGieVO5S60P
         q68AvvkYE3VHlHUcXgRdmSSisbtoGCYcnagC04VXp3IPlSuBDvcJBG/x3jOo8SqhdF7H
         tX2g==
X-Gm-Message-State: APjAAAWrS1Wk82D6o7q0MMvhj1COmH23MID2ypPXj47oU51G2rYmGtbq
        VlBw0BJ+RgGyByXU+FZlU1g=
X-Google-Smtp-Source: APXvYqyRlOkdUezbiG6JC9t9RbxBOlSK9+zh6qqP6l26TaJFo2GNCtKfK1mv0h99q79Yq4Ze3Lx5Yw==
X-Received: by 2002:a17:902:a503:: with SMTP id s3mr42597997plq.16.1556295160638;
        Fri, 26 Apr 2019 09:12:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s19sm32646630pfe.74.2019.04.26.09.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:12:40 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:12:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Health <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: core: Add
 POWER_SUPPLY_HEALTH_OVERCURRENT constant
Message-ID: <20190426161239.GA7128@roeck-us.net>
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
 <20190417084457.28747-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417084457.28747-2-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 01:44:55AM -0700, Andrey Smirnov wrote:
> Add POWER_SUPPLY_HEALTH_OVERCURRENT constant in order to allow
> singalling overcurrent condition via power supply health information.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Health <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/power/supply/power_supply_sysfs.c | 2 +-
>  include/linux/power_supply.h              | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 5e91946731fd..464f4e837601 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -62,7 +62,7 @@ static const char * const power_supply_charge_type_text[] = {
>  static const char * const power_supply_health_text[] = {
>  	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
>  	"Unspecified failure", "Cold", "Watchdog timer expire",
> -	"Safety timer expire"
> +	"Safety timer expire", "Over current"
>  };
>  
>  static const char * const power_supply_technology_text[] = {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 2f9c201a54d1..bdab14c7ca4d 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -57,6 +57,7 @@ enum {
>  	POWER_SUPPLY_HEALTH_COLD,
>  	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
>  	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
> +	POWER_SUPPLY_HEALTH_OVERCURRENT,
>  };
>  
>  enum {
> -- 
> 2.20.1
> 
