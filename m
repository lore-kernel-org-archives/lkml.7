Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52796C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB9720820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhHe0wFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbfDJNi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:38:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34170 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731712AbfDJNiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:38:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so1474923plt.1;
        Wed, 10 Apr 2019 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3+JdCobsNiuvhStXURSUWsE466w9N2kR66KtnO8B6oA=;
        b=bhHe0wFafijtfCcpgMrL1xmkfkfiYVQACKM+kOccifatfZAeklSTvzL4ZiSTpdvdDc
         kxmYtwfgvFTQUo3XJdIw6CxpV5pLPpR5nFz5g5XeTTMnOGrDJ1xhTw6uPRwXY+D/9HLi
         xYV4t8nvbwp2y3O5uiO6OYEp/2cpkKtVUdtg3V2+ISUz6ZOJOYdI9UuZkzktqNj2uUF5
         spHIn1/iTTKhdATMm+uKfiBYSPlK30IQ1TFOcgr0EQ46ZaHwUBMKlUzeyEOf8RwYRsZA
         3RVewaal6m9qoDP4aDTpvV1YC6txjz1o7++MThQmetqhNzr/H+qWLnXk5ozZ0N+mas1f
         OQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+JdCobsNiuvhStXURSUWsE466w9N2kR66KtnO8B6oA=;
        b=RmFML5ToqxPVCChS/9Yp245zFm2iYrpjAp0Kiv56W7X2uVUKHWAgW1NecbF8QF/xXD
         saVWLb3cA8yC3ekPUmI0NU1hg40NuVb5t3C5ct1qsu/4DscHw2/kc7zQIrZf9CgCAhsI
         IfyjPt+xc+k/ESzZmJXxB5hjWpRg7nbAcz2wwEz8qFP1fdy1hghoQYK9W0N+6xntbSrA
         Ro9OJ3HRFMi8BWPyb//ai9pgE7kHfWitE4vtbNho/UvQMJZVDmyEQxn7WKlFvhf9K7Hn
         zWceshZe2PPx5sv0izbGMdxxNJkaI8MKe1dBvdxbFTGxgu9sX27Jtzg2hARwxcBfbfjR
         3mTQ==
X-Gm-Message-State: APjAAAVu3QPJ3+BAykZk0Pa9m6s593uDNVoKDX8j2BgnU2jz2npOgxiX
        ieWx76nWzFC/J2yKZHkEL9u5Smas
X-Google-Smtp-Source: APXvYqy0y3Z1xXD0E+bwKdrB1G5G2VqDGL8Rmp0xdcFwMwmJDvcoXOBDlKzOdeHAU73maTmR2ap5ng==
X-Received: by 2002:a17:902:7883:: with SMTP id q3mr43996539pll.60.1554903532981;
        Wed, 10 Apr 2019 06:38:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d187sm41355514pgc.43.2019.04.10.06.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 06:38:52 -0700 (PDT)
Subject: Re: [PATCH] watchdog: wdat_wdt: fix get_timeleft call for wdat_wdt
To:     Bryan Tan <bryantan@vmware.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190410124813.86892-1-bryantan@vmware.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <eae7116e-ead0-dafe-d552-411da83211a7@roeck-us.net>
Date:   Wed, 10 Apr 2019 06:38:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410124813.86892-1-bryantan@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 5:49 AM, Bryan Tan wrote:
> The get_timeleft call for wdat_wdt was using ACPI_WDAT_GET_COUNTDOWN
> when running an action on the device, which would return the configured
> countdown, instead of ACPI_WDAT_GET_CURRENT_COUNTDOWN, which returns the
> time left before the watchdog will fire. This change corrects that.
> 
> Signed-off-by: Bryan Tan <bryantan@vmware.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/wdat_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 56ad196..387892f 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -287,7 +287,7 @@ static unsigned int wdat_wdt_get_timeleft(struct watchdog_device *wdd)
>   	struct wdat_wdt *wdat = to_wdat_wdt(wdd);
>   	u32 periods = 0;
>   
> -	wdat_wdt_run_action(wdat, ACPI_WDAT_GET_COUNTDOWN, 0, &periods);
> +	wdat_wdt_run_action(wdat, ACPI_WDAT_GET_CURRENT_COUNTDOWN, 0, &periods);
>   	return periods * wdat->period / 1000;
>   }
>   
> 

