Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F49C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA92B2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdm5fSxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfCAGOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:14:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34787 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfCAGOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:14:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so24547127wrg.1;
        Thu, 28 Feb 2019 22:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3hrOvMc/dHsF0cKTdHsaUq5CcAAmDBiIrKb884PG+uo=;
        b=Kdm5fSxQ0ShxSXDg0MH+MMVERjxtsfKIoDySYsnUtfQJEJsDWt/HB5tvP1E8p/OnQx
         d2Rf6GjxXRs7KYbZF2ke8kcODAE6MM5XmOntuMX21lG1nrp5+AOfzOQ25r5r8fmznH89
         NDwMD+1ekhzJ8hkbIe475iRrFo6D9av+mLbHn2q8VxX3nymBahDaSnX5nGLrt5rFWHn9
         3Pd2pWvbWPeC6o46/hrOo1FgaVSBXn/KLV8rcasnlNiJe7sqn3jqLHpo74Ej28aptz9S
         nO32IC+7JB4F11Ip43ESJI8nWUh6jgI7oQkeJlIIMm1sBduRsRjrKH0XWagVRrMR/kNx
         ZTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3hrOvMc/dHsF0cKTdHsaUq5CcAAmDBiIrKb884PG+uo=;
        b=PLpLjefymJMa1d32eFSxRwNgfN+psBoaMM70QUwSUPzex6bA4e29hL5uBQejKElwWo
         v+ZUAY8jLYWwwpRmUmm+rcAHVPecgb6DxhKpX2h//sr3XHtNvyAVyyQqEUqJI//aww6P
         uhh0mQZTafrJsqtPp0f7Ttm0cRNQWxClo+wHHemrjyoBSZIA3IMB6YeT0XzlNQfDYGIC
         85za5PkLJQV+wOhWvkKcHnzHx+NZ0os7/1FEhRDQDClw+3TdM5jBf2CYo3EK9pd1FSZJ
         Hypgoeuclow7fNcHPKP6cVG13GKnkiOS38YQmqtBM44rq6FygjdjQrfqhwQPCO+IpAwh
         nnQg==
X-Gm-Message-State: APjAAAUECEjCu79/1FEzxdaMyYdXoNz5kwjNej6RT8vvSFWdpaAErG6S
        vhRslFyDxwJByH4d02MrxKLWxCVD
X-Google-Smtp-Source: APXvYqyuQuEy0Uacbf/jEwaeASDEIGrprLjfNA3Tr4RkQ0dD14Kz44YxF2cXRLSBW3XQy6XvanXxDg==
X-Received: by 2002:adf:b784:: with SMTP id s4mr2008912wre.155.1551420886169;
        Thu, 28 Feb 2019 22:14:46 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:81e8:1756:4872:e46a? (p200300EA8BF1E20081E817564872E46A.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:81e8:1756:4872:e46a])
        by smtp.googlemail.com with ESMTPSA id v18sm25806193wrr.90.2019.02.28.22.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 22:14:45 -0800 (PST)
Subject: Re: [PATCH net-next] net: dsa: Do not configure VLAN ID 0
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20190228234936.1593-1-f.fainelli@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <fde5e673-6d08-c898-80c9-b4cad9157ded@gmail.com>
Date:   Fri, 1 Mar 2019 07:14:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228234936.1593-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.2019 00:49, Florian Fainelli wrote:
> Because we skip the prepare phase, we would not get a chance to have the
> port_vlan_prepare() callback return -EOPNOTSUPP and tell us about that.
> This causes problems with mv88e6xxx which specifically checks for VLAN
> ID = 0. Turns out we do not actually need to program that VLAN ID since
> it should be the default one for switches anyway.
> 
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Fixes: 061f6a505ac3 ("net: dsa: Add ndo_vlan_rx_{add, kill}_vid implementation")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/dsa/slave.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 1808a2cd6872..ec54d579645a 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -996,6 +996,9 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
>  	struct bridge_vlan_info info;
>  	int ret;
>  
> +	if (vid == 0)
> +		return 0;
> +
>  	/* Check for a possible bridge VLAN entry now since there is no
>  	 * need to emulate the switchdev prepare + commit phase.
>  	 */
> @@ -1029,6 +1032,9 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
>  	struct bridge_vlan_info info;
>  	int ret;
>  
> +	if (vid == 0)
> +		return 0;
> +
>  	/* Check for a possible bridge VLAN entry now since there is no
>  	 * need to emulate the switchdev prepare + commit phase.
>  	 */
> 
Tested-by: Heiner Kallweit <hkallweit1@gmail.com>

The error has gone. New with the original patch is just the following
message in syslog when bringing the device up. I'm not sure there is
benefit in it (at least for VLAN 0 because it's a no-op).

8021q: adding VLAN 0 to HW filter on device eth_cu_1000_2
