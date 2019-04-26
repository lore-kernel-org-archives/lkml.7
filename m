Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A9CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F3F20656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKoGLxWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDZJcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:32:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40456 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDZJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:32:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id h11so3375756wmb.5;
        Fri, 26 Apr 2019 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XQjCBJGeVMN1HAGq1KM1VDwJvL2JrNuIukZbKMAyOjU=;
        b=TKoGLxWMY/4fvOzNglpRglOjf+oQzs4VyoXQ6YTaaTEbQTNGpHvR8ZkZiUWTIz6boe
         HfffPZRKDgp0gtPJz9dP35q+QF/OPBc0akxvZMy+EvvB0K7IymFDS35pKPj5SHx+EPCH
         27JZWKQZwzF36CW3MfRScYXXctAT6pXXo4HZQvxe2BD8h1GWvfmAO8ukCCx3HRj7xXuz
         hCBueIF2BeVtYzNts32C4RFLekJcpwN14rj9KufAajGiy+bB0ZBFTO7cik2n6SIcp5us
         MGpvdasSqxq1lIlMsBqwhm5WKVt4Kpi79+qvmoVhAkT6lez3Rejx9+XVUEgA8mHDXo/4
         h1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XQjCBJGeVMN1HAGq1KM1VDwJvL2JrNuIukZbKMAyOjU=;
        b=pBnD9thjmMQ6PXHRhIX7WdbiOCLdM+CMi9rq0t6F6Qz40E/VU6m3V+n64sAUKQGkfV
         etYhGne8+b+FmUqAM6uqXo9t8ZMWbPVIHTo5sbFM0nzW3VDl6c2QPytOM/Optmibn9Ku
         jHF+2CyXuFhpIbwj5q4ydTL9or/UTAgM8xwklRm8siMO+xjwmxwNxEgcd1uZ3DFU6dvS
         C5CK8L8zLo5cUEf+aCG7mh2QpsVTUaxbK3G8QyaNX5ruIkoHqbY3HBPbn+v3uLLZynMB
         ymthn0/WKp0KFstPBPuh8RSExojOUJ74+cHdtJ0rxKmlMmMJEhpy8ccUW0+1OkV4ivT7
         TpGA==
X-Gm-Message-State: APjAAAVb/GYG7tZqh/f41Dgwl4cjc7+WkYJ6iR+HPS/dm8BgWkRAetM6
        W+AUar7Z8N2aX/u0OLyexuWVD5jp
X-Google-Smtp-Source: APXvYqyAbdKzR6hT3z3P3OmSbvrP9qU3IwkhddyCD7DC3c5aQeb5Jbnz5RCb1D2hsmPrdgRBNDpPCQ==
X-Received: by 2002:a1c:e085:: with SMTP id x127mr6876397wmg.87.1556271165747;
        Fri, 26 Apr 2019 02:32:45 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y125sm36574835wmc.39.2019.04.26.02.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 02:32:44 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:32:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Notify also about status
 changes
Message-ID: <20190426093243.zazld4wwv4qybwaf@pali>
References: <1556270808-21331-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556270808-21331-1-git-send-email-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 April 2019 11:26:48 Krzysztof Kozlowski wrote:
> User-space might be interested in receiving uevents when the charging
> starts/stops or if conditions of battery changes (e.g.
> over-temperature).  Notify about changes in battery also when the flags
> change, not only SoC.

This looks like a good idea.

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 29b3a4056865..cb9306160c14 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1612,7 +1612,8 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  			di->charge_design_full = bq27xxx_battery_read_dcap(di);
>  	}
>  
> -	if (di->cache.capacity != cache.capacity)
> +	if ((di->cache.capacity != cache.capacity) || \
                                                      ^^
                                      You have there an extra backslash

> +	    (di->cache.flags != cache.flags))
>  		power_supply_changed(di->bat);
>  
>  	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)

-- 
Pali Rohár
pali.rohar@gmail.com
