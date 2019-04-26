Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DDAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3C1206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0nJ6y2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfDZKrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:47:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35192 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:47:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so3824849wrs.2;
        Fri, 26 Apr 2019 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/pbcIW7QnJiZfFklPKadIDJKCNmi1ZkDCWDwjtzVuRY=;
        b=B0nJ6y2KjS3Fuw0MyXQaG++majxQlDmyF0DQhrfqFLzf4LF4Ff54hy3NS36ZxTtLrn
         I7CeCvUixCdzsBMJNCGitQoCu7hlUeLKw3y/Kb3qUs80P7iCG081FwomO2Pt9oPwzx4s
         Ep1sh5ZrfvW/p8R3NxcUh2oHCSHJC+kx7BBBoPx9p89P6AhZBpSCnxcHEDJn+0PWJmUR
         MaA8x0GjTI3GFd9IvOUqMXFgiAteWLystHBquqOjzwuUJEVeWxoas+nguRk2Wc3P5TD8
         JrcPAwiDY1pig6HXx42RDV2hcUb+oTTtqGTxtECwlCUJX4I+ymRpofLxXutyzHKwzTeC
         /1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/pbcIW7QnJiZfFklPKadIDJKCNmi1ZkDCWDwjtzVuRY=;
        b=IpiBD7mqoL/ecd6/qyamzogD7DLuDD8jrS2K1y8VxFI7vsYIQdkxbpL/6rBrvoaQF1
         yv3F+Yf9Dw1jOh6GCFEgG9kWC/Z19MpgtiEWpAw+k7T6Ai10PsXy/nPdv2V3TayGBSli
         UL24o9yomILDct+khFlKfPBQjlq+ab23AdkNGtoMcd5N9l20A+KkYcpCqAF/HAEL6Ul0
         BVBgXuG+UiAysA/5Uy2AiY/TPuCPEFt84qZjuZFKw9KrQPPZlWSG/OYcSgRrc52h9Xv7
         O1XRS0zGjHFO7Qlhb6bEK7faCwhAldswa3bNtk6Qt+F1usE8AA3lASL8Pq7gIcaS+/bp
         geyg==
X-Gm-Message-State: APjAAAWieheoIGngs4tD6So2sq1mxxplXig77HJNnLEkCL8zt0OQDQuc
        Oyr56R1/VU60zojUtovxi5s=
X-Google-Smtp-Source: APXvYqxotNEsnRMvpEYOH/0Wt4MH2xIiejxZicij7LanI1Bewg9lnlkNLI5LGhddZWkvPGVpb0196w==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr9818769wrp.242.1556275641060;
        Fri, 26 Apr 2019 03:47:21 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 10sm23085339wmd.23.2019.04.26.03.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 03:47:20 -0700 (PDT)
Date:   Fri, 26 Apr 2019 12:47:19 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: bq27xxx_battery: Notify also about
 status changes
Message-ID: <20190426104719.t6gyo3no7l4wjesz@pali>
References: <1556272742-17232-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556272742-17232-1-git-send-email-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 April 2019 11:59:02 Krzysztof Kozlowski wrote:
> User-space might be interested in receiving uevents when the charging
> starts/stops or if conditions of battery changes (e.g.
> over-temperature).  Notify about changes in battery also when the flags
> change, not only SoC.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Ok, you can add my
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

> ---
> 
> Changes since v1:
> 1. Remove unneeded backslash (pointed by Pali).
> ---
>  drivers/power/supply/bq27xxx_battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 29b3a4056865..195c18c2f426 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1612,7 +1612,8 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  			di->charge_design_full = bq27xxx_battery_read_dcap(di);
>  	}
>  
> -	if (di->cache.capacity != cache.capacity)
> +	if ((di->cache.capacity != cache.capacity) ||
> +	    (di->cache.flags != cache.flags))
>  		power_supply_changed(di->bat);
>  
>  	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)

-- 
Pali Rohár
pali.rohar@gmail.com
