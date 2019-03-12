Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82DBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B0A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="R0bxI7J4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCLHbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:31:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46079 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfCLHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:31:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id d24so1318431ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wu6L4WNkDUdJ2bZyEPwpMZl8FPCX7Ucq/JNEsZeW9Ns=;
        b=R0bxI7J4+LN2nvQ/GRDb2uFOE1ehhqJajANZYMP1mJ/uQKRc6owzfDpc+qcgMBXqWV
         Yq6D6JGHhvOOdWWUAm6PBTq8Egkk993wgwm1a0j2h2hQn5GW7ERCW93Ypn1I9AUCQuj+
         ikXpqT+XKD8b2zTUqhnYonk2LlgB+pAEfMQumLFAcxidWRDsRjwXOSq0wLqfWbKEJI+w
         OTPmrQdRzn8yKaBWcB1BDLj6Qzmh+QcMMA65PNTfVUbK8/2YKZ+75xs8Wa3TlZ4wyGo/
         gnJdNCzZMAL15BJamINR5IuAxRIrcQw3d10nV+OAW6EK50aQ49D3tbuTrbow287Leq0P
         q6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wu6L4WNkDUdJ2bZyEPwpMZl8FPCX7Ucq/JNEsZeW9Ns=;
        b=Vln4+y9q8eLry1iDqHC4R4bhoLNHtXmDfY8PYLi9sn49Wn9yISJrZntaMd/UfKMA77
         R+ZMHm46ybQMgqZBTLUEOOgqTg+DKqcsLBVPOp7PrX/oUtQ5vXWIFWbY8dA206JirRxl
         biaE6DBZU1cw6y+lfKAfvLifKduT5pZDoUWDYAWk+5ejIiJ2XFGX6ceSMUPdehgbdekf
         GD80gVmW7/J0CSOR/isAgTkVpuRgHMmroTsDvkYOt/I+yamZTu28EwQbCO5eX6Io+DwV
         2JQBeIE8seerjXxGxQNZPKwDc/UbMoGGQrIsn3RV+ts5B783E/pWv8OogzuzTKWvId+K
         tCBA==
X-Gm-Message-State: APjAAAWOUCng7Iiha+PH416ussDhXgYuY016mN+ySJ3+j0HOztfVzCVo
        Pw3JV2qjIP4AtTcEplB+bZkGpyJwcmk=
X-Google-Smtp-Source: APXvYqw19Ml7WdFfVWHJ4vJ1B+rl9a07a+suFR/10BdLoeqc1PyWz6MWtzQoisFrbi1+wye00kg/lQ==
X-Received: by 2002:a2e:3211:: with SMTP id y17mr18036523ljy.88.1552375873447;
        Tue, 12 Mar 2019 00:31:13 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.87.174])
        by smtp.gmail.com with ESMTPSA id k23sm1244227ljk.69.2019.03.12.00.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:31:12 -0700 (PDT)
Subject: Re: [PATCH v2] net: sh_eth: fix a missing check of of_get_phy_mode
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c205461c-edb1-c9c1-a928-8068374aef2b@cogentembedded.com>
 <20190312063026.15083-1-kjlu@umn.edu>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <902bc3a0-94b5-cf00-6b41-f2724744fbe6@cogentembedded.com>
Date:   Tue, 12 Mar 2019 10:31:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190312063026.15083-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12.03.2019 9:30, Kangjie Lu wrote:

> of_get_phy_mode may fail and return a negative error code;
> the fix checks the return value of of_get_phy_mode and
> returns NULL of it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/net/ethernet/renesas/sh_eth.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index 239eeafe1b2d..e33af371b169 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -3181,14 +3181,16 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
>   	struct device_node *np = dev->of_node;
>   	struct sh_eth_plat_data *pdata;
>   	const char *mac_addr;
> +	int ret;
>   
>   	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>   	if (!pdata)
>   		return NULL;
>   
> -	pdata->phy_interface = of_get_phy_mode(np);
> -	if (pdata->phy_interface < 0)

    Please generate your patch against the pristine net.git, not atop
of your previous version.

> +	ret = of_get_phy_mode(np);
> +	if (ret < 0)
>   		return NULL;
> +	pdata->phy_interface = ret;
>   
>   	mac_addr = of_get_mac_address(np);
>   	if (mac_addr)
> 

MBR, Sergei
