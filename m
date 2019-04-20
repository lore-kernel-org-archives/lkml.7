Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55752C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BB220883
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 17:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciaMH06w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfDTRA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 13:00:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33129 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfDTRA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 13:00:56 -0400
Received: by mail-oi1-f195.google.com with SMTP id e5so5946658oii.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nFV0C6NzVuepMxGAMvbOLxKeRwfdehj2/xTeFsA/hKE=;
        b=ciaMH06wtkcMky3GR7pzKZrRhhlp+o5RovY3gQhpFsQmnCbh1kN4gMgcnlFd2m9gp/
         aTtD5YyIJLosBxqeWjrkLobBbmL6tzoqlQtXK1S8W+g7gSQy6Kp/Wyw1sMh9ujxOqnQ3
         Am9HE3eVmQkYYzBNBkwHzBCo8Ng/5pv4tVNKf7JCFscE3snuC8E9TuX68cO/d/6Mc0w3
         DVv6wCsZVAUYppWvojNjXCyW8p/pUtzsk6z2qpyBEa6F/M9F+/NSE5Y8ZTgGuw8MJmDe
         ZZ30gqcrAK4knGa9zNpzDmgmXdTEfxErX0BDPimPpscYAsVU3F4o1Q7t7UqkIpp6yEYh
         LRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nFV0C6NzVuepMxGAMvbOLxKeRwfdehj2/xTeFsA/hKE=;
        b=eX+Cng+sd1PZ3bv5SGcx58iTxeZAcNBAoJbLmBs1D/dEdm4Q2B6cBY1wZ1cA+3Q0p4
         36GKRUbt45oabNyHKiDHQoYvdrzo8eme3gDZwNjvpHvPvOlZ8Y5VGyrNZB0U5G1qeyiG
         BmSRJWhvWO/ZDCawQ5GqYSvw2sq6xtjeodq8gszig2b4lQHknztjCy9g8ORYqMv9MCp0
         E3OQ5CKuwkIW1uhYMNw2qnR/C9z3B6vNpboeaEh1eMKBwgn5fdlOm0dt8xuWHMXRKLRU
         LEEfyyf6gQdirwBypb4qgsxozFnqZiePxHl9X7b+tFzkZd0otVyn+P068RBlpR9B2D09
         6WwQ==
X-Gm-Message-State: APjAAAX5479SPRoK98O6HvJX/8Yrshge49LxJeCkMLVkOnUPNJcg34/r
        FNH2peX59bZlRAWIVRXv2E9I28Uv
X-Google-Smtp-Source: APXvYqyDwR2vvUu5H5im+YKv13wIeowrWFMgFmp8prRWhzYkH59HJe1qwa2+DVvZ1+efmgOQKE9DLQ==
X-Received: by 2002:aca:43c4:: with SMTP id q187mr5691826oia.45.1555779655069;
        Sat, 20 Apr 2019 10:00:55 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m206sm3382593oif.50.2019.04.20.10.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 10:00:54 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8*: use help instead of ---help--- in Kconfig
To:     MosesChristopher <moseschristopherb@gmail.com>,
        gregkh@linuxfoundation.org, florian.c.schilhabel@googlemail.com,
        insafonov@gmail.com, hdegoede@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190420113731.26160-1-moseschristopherb@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <2b4f1a3d-b5c3-98e6-fd85-32205312e26a@lwfinger.net>
Date:   Sat, 20 Apr 2019 12:00:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420113731.26160-1-moseschristopherb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/19 6:37 AM, MosesChristopher wrote:
> From: Moses Christopher <moseschristopherb@gmail.com>
> 
>    - Resolve the following warning from the Kconfig,
>      "WARNING: prefer 'help' over '---help---' for new help texts"
> 
> Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>

I have never seen this warning, but your Kconfig may be newer than mine. In any 
case, the changes are harmless.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

> ---
>   drivers/staging/rtl8188eu/Kconfig | 4 ++--
>   drivers/staging/rtl8192e/Kconfig  | 8 ++++----
>   drivers/staging/rtl8712/Kconfig   | 4 ++--
>   drivers/staging/rtl8723bs/Kconfig | 2 +-
>   4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/Kconfig b/drivers/staging/rtl8188eu/Kconfig
> index ff7832798a77..3f8c655856bf 100644
> --- a/drivers/staging/rtl8188eu/Kconfig
> +++ b/drivers/staging/rtl8188eu/Kconfig
> @@ -7,7 +7,7 @@ config R8188EU
>   	select LIB80211
>   	select LIB80211_CRYPT_WEP
>   	select LIB80211_CRYPT_CCMP
> -	---help---
> +	help
>   	This option adds the Realtek RTL8188EU USB device such as TP-Link TL-WN725N.
>   	If built as a module, it will be called r8188eu.
>   
> @@ -16,7 +16,7 @@ if R8188EU
>   config 88EU_AP_MODE
>   	bool "Realtek RTL8188EU AP mode"
>   	default y
> -	---help---
> +	help
>   	This option enables Access Point mode. Unless you know that your system
>   	will never be used as an AP, or the target system has limited memory,
>   	"Y" should be selected.
> diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
> index 4602a47cdb4a..aa571c12678f 100644
> --- a/drivers/staging/rtl8192e/Kconfig
> +++ b/drivers/staging/rtl8192e/Kconfig
> @@ -3,7 +3,7 @@ config RTLLIB
>   	depends on WLAN && m
>   	default n
>   	select LIB80211
> -	---help---
> +	help
>   	  If you have a wireless card that uses rtllib, say
>   	  Y. Currently the only card is the rtl8192e.
>   
> @@ -16,7 +16,7 @@ config RTLLIB_CRYPTO_CCMP
>   	depends on RTLLIB
>   	select CRYPTO_AES
>   	default y
> -	---help---
> +	help
>   	  CCMP crypto driver for rtllib.
>   
>   	  If you enabled RTLLIB, you want this.
> @@ -27,7 +27,7 @@ config RTLLIB_CRYPTO_TKIP
>   	select CRYPTO_ARC4
>   	select CRYPTO_MICHAEL_MIC
>   	default y
> -	---help---
> +	help
>   	  TKIP crypto driver for rtllib.
>   
>   	  If you enabled RTLLIB, you want this.
> @@ -37,7 +37,7 @@ config RTLLIB_CRYPTO_WEP
>   	select CRYPTO_ARC4
>   	depends on RTLLIB
>   	default y
> -	---help---
> +	help
>   	  TKIP crypto driver for rtllib.
>   
>   	  If you enabled RTLLIB, you want this.
> diff --git a/drivers/staging/rtl8712/Kconfig b/drivers/staging/rtl8712/Kconfig
> index f160eee52f09..b377d90742db 100644
> --- a/drivers/staging/rtl8712/Kconfig
> +++ b/drivers/staging/rtl8712/Kconfig
> @@ -4,14 +4,14 @@ config R8712U
>   	select WIRELESS_EXT
>   	select WEXT_PRIV
>   	select FW_LOADER
> -	---help---
> +	help
>   	This option adds the Realtek RTL8712 USB device such as the D-Link DWA-130.
>   	If built as a module, it will be called r8712u.
>   
>   config R8712_TX_AGGR
>   	bool "Realtek RTL8712U Transmit Aggregation code"
>   	depends on R8712U && BROKEN
> -	---help---
> +	help
>   	This option provides transmit aggregation for the Realtek RTL8712 USB device.
>   
>   
> diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
> index deae0427ba6c..41ad6ed24860 100644
> --- a/drivers/staging/rtl8723bs/Kconfig
> +++ b/drivers/staging/rtl8723bs/Kconfig
> @@ -4,7 +4,7 @@ config RTL8723BS
>   	depends on m
>   	select WIRELESS_EXT
>   	select WEXT_PRIV
> -	---help---
> +	help
>   	This option enables support for RTL8723BS SDIO drivers, such as
>   	the wifi found on the 1st gen Intel Compute Stick, the CHIP
>   	and many other Intel Atom and ARM based devices.
> 

