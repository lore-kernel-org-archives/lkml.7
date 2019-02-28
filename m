Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA97BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F502186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA/fguBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfB1EYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:24:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43220 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfB1EYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:24:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id m10so9069446plt.10;
        Wed, 27 Feb 2019 20:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hondb2Ic3gDonFR8/NUO3xcJ7vQ4YJ5I/Ejp68ypJwU=;
        b=XA/fguBjlepNWHzCNeRAsUSys966l5OS//NRnjvm7U7DShRPhMGPzcyhRn09ixrFHO
         Dk+jhpgvyLvaO88QSl5Eu6b/nJu9J7w4uU5Q7pzAi+FkqfT43la37vxbjHl1M59+b6ve
         ZcwDgHmOySseLs2fM6u5uCWE68pZf8/HDzMf4GE6EZqhhyOC7wgRGo2nFuLN5mK0Dnyb
         naXB9RrKUxP0VgUokn8b/yXrdUm2FXKa/d2DGcXyuc+O5YPO8NluxBE7fOEUeCHQ/Nce
         BmaDbgSlUnMqtfyCZtdjAd2jJpOsQaDGG2mT+YODlbNiGbkfh2vxSojkIh6Q2liRwq2B
         Kzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hondb2Ic3gDonFR8/NUO3xcJ7vQ4YJ5I/Ejp68ypJwU=;
        b=kXsksG39gEebMfZOWy9zXjiQowN2vbJb7xZXH9Yy/7od2ZbsGs0RKuu+MzFpUYZnPl
         tJpYHP4vh/R/l9HRozS1i1is/1bmY42Yl0DRDAb2G/UhGNMneIOLJWxfTSOKBTtqwmF0
         tzeIpYmwvzSml6DflekG6oC/pSesHhWlSs0aVVbxIDg0btikrXD4bXRGrdIk2a+ZED6w
         Ckh9bRkvRzB6Dlg5kyPHNJ9htGUVceEQAYRjUk80VMNzIt+9TTcnLdq2EjgVmDzb6Jko
         5Hkw3Vb+7mcRrWUfuEAmMyevUGvOWvX49xRHIQnC3CD5fHmB/N4DbURpjUZfnEVM+yuz
         vGUA==
X-Gm-Message-State: AHQUAuYP5xx39Ugl2WGy27t8NTp9ZvHkZmKXPK0utpFebZwYXauWamQm
        jfNKo6aifVi+e5J3w73dmJs=
X-Google-Smtp-Source: AHgI3IbZ0Ximz7hKP5Ps/GNsOc6jSUV3NrzL414DOHhDFCfSBDKbnscRSsRA2mcKEYcp4nvFxMMIVg==
X-Received: by 2002:a17:902:7686:: with SMTP id m6mr5927778pll.262.1551327849347;
        Wed, 27 Feb 2019 20:24:09 -0800 (PST)
Received: from [10.230.1.150] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h3sm19550105pgv.38.2019.02.27.20.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 20:24:08 -0800 (PST)
Subject: Re: [PATCH net-next 1/6] net: core: dev_addr_lists: add VID to device
 address
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net,
        grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-2-ivan.khoronzhuk@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <462e8b28-fc15-9321-2144-038a18e37170@gmail.com>
Date:   Wed, 27 Feb 2019 20:24:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190226184556.16082-2-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
> Despite this is supposed to be used for Ethernet VLANs, not Ethernet
> addresses with space for VID also can reuse this, so VID is considered
> as virtual ID extension, not belonging strictly to Ethernet VLAN VIDs,
> and overall change can be named individual virtual device filtering
> (IVDF).
> 
> This patch adds VID tag at the end of each address. The actual
> reserved address size is 32 bytes. For Ethernet addresses with 6 bytes
> long that's possible to add tag w/o increasing address size. Thus,
> each address for the case has 32 - 6 = 26 bytes to hold additional
> info, say VID for virtual device addresses.
> 
> Therefore, when addresses are synced to the address list of parent
> device the address list of latter can contain separate addresses for
> virtual devices. It allows to track separate address tables for
> virtual devices if they present and the device can be placed on
> any place of device tree as the address is propagated to to the end
> real device thru *_sync()/ndo_set_rx_mode() APIs. Also it simplifies
> handling VID addresses at real device when it supports IVDF.
> 
> If parent device doesn't want to have virtual addresses in its address
> space the vid_len has to be 0, thus its address space is "shrunk" to
> the state as before this patch. For now it's 0 for every device. It
> allows two devices with and w/o IVDF to be part of same bond device
> for instance.
> 
> The end real device supporting IVDF can retrieve VID tag from an
> address and set it for a given virtual device only. By default, vid 0
> is used for real devices to distinguish it from virtual addresses.
> 
> See next patches to see how it's used.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

[snip]


> @@ -1889,6 +1890,7 @@ struct net_device {
>  	unsigned char		perm_addr[MAX_ADDR_LEN];
>  	unsigned char		addr_assign_type;
>  	unsigned char		addr_len;
> +	unsigned char		vid_len;

Have not compiled or tested this patch series yet, but did you check
that adding this member does not change the structure layout (you can
use pahole for that purpose).

>  	unsigned short		neigh_priv_len;
>  	unsigned short          dev_id;
>  	unsigned short          dev_port;
> @@ -4141,8 +4143,10 @@ int dev_addr_init(struct net_device *dev);
>  
>  /* Functions used for unicast addresses handling */
>  int dev_uc_add(struct net_device *dev, const unsigned char *addr);
> +int dev_vid_uc_add(struct net_device *dev, const unsigned char *addr);
>  int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr);
>  int dev_uc_del(struct net_device *dev, const unsigned char *addr);
> +int dev_vid_uc_del(struct net_device *dev, const unsigned char *addr);
>  int dev_uc_sync(struct net_device *to, struct net_device *from);
>  int dev_uc_sync_multiple(struct net_device *to, struct net_device *from);
>  void dev_uc_unsync(struct net_device *to, struct net_device *from);
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index a6723b306717..e3c80e044b8c 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -545,6 +545,26 @@ int dev_addr_del(struct net_device *dev, const unsigned char *addr,
>  }
>  EXPORT_SYMBOL(dev_addr_del);
>  
> +static int get_addr_len(struct net_device *dev)
> +{
> +	return dev->addr_len + dev->vid_len;
> +}
> +
> +static int set_vid_addr(struct net_device *dev, const unsigned char *addr,
> +			unsigned char *naddr)

Having some kernel doc comments here would be nice to indicate that the
return value is dev->addr_len, it was not obvious until I saw in the
next function how you used it.

> +{
> +	int i;
> +
> +	if (!dev->vid_len)
> +		return dev->addr_len;
> +
> +	memcpy(naddr, addr, dev->addr_len);
> +	for (i = 0; i < dev->vid_len; i++)
> +		naddr[dev->addr_len + i] = 0;

memset(naddr + dev->addr_len, 0, dev->vid_len) would be more compact and
maybe a little less error prone too?
-- 
Florian
