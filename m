Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C685BC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B8207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="EJ0U3t+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfIKKRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:17:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43055 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfIKKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:17:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id u3so860578lfl.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a2Y/6nQhmbjCYM6INFKB83UDY8cfiNqLZZ65oB1VAN8=;
        b=EJ0U3t+QcOcSKiPM6djC6Fs1w7rmDTqEIqiCs2Fb5RYK/ti+qyPKe8K9hqCx2Qx9VK
         amN8HRc3FOkCPNpTOnAMjUimmaB7c9cl3Bpr7joltgtKR/nXvSllc9cYncRN69fNRY8g
         PRBiLF6XYsZUcvFucSz7TLtQ3sI+e/E95uZVg1s5EN9aDhFHlePXCpr8UDEPx2PjO/lE
         BUp4wsrrJRFkbV5iAxkc7YWe/Y3onxxuETh5MIgVMOGet/0q2fMXBv3NLfwMJuaIeL4a
         23uSowgv/iHEd+2yhG6jIRWeBvu7oXLIQ4gdOHlSBc4u7PrdR1o+jiNkuXHjBIhHH+f2
         D2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2Y/6nQhmbjCYM6INFKB83UDY8cfiNqLZZ65oB1VAN8=;
        b=RU3gQ4RMZyjSO+YS4ANbDmm015p8H6Qo+3qVhdtQQn3o59i9ozK2DuMok3i9Zk/hbk
         guWKS81yNcmHzizyNoLbAF0s5dAlwtJf/+hpB1wsz5uMZhHgkX1P7H1ey4c0EeWIYc9Y
         p0qw6iHeCU6CK5rY+jwvXBSOsB6+BBSYtwvYZ+KKRJlcT3m0biK1SicOucQDOnRY4z/x
         Ib4scI8c+4qklwdzOdnDhFHu2MgfJZO8QFI1ezMjaLkibv/uDO2MaV64bW52HAZQVte3
         b7KYnkmIiO28ItAK8YbFhdOOlj2jzuMNmZk5UZDwoI+Uw5Bok90CsP63J/T8csSq93BH
         3TcQ==
X-Gm-Message-State: APjAAAXvgyMZi0m1AvWvRuiOXkbQYdR7M6vnFXWpDUhUjCHTc7JIq9yD
        wD5OU0OR00TPUmTSzzOL9yRNVQ==
X-Google-Smtp-Source: APXvYqz+Md79E0HPoC6Of1z/8S0vb5X0xR7NuEQx2fmlklAsDJKb6cezcxADEwx7B+c/EKr25xMc5g==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr23451254lff.103.1568197018465;
        Wed, 11 Sep 2019 03:16:58 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8e6:86de:79c0:860e:c175:7d39? ([2a00:1fa0:8e6:86de:79c0:860e:c175:7d39])
        by smtp.gmail.com with ESMTPSA id l9sm4610655ljg.79.2019.09.11.03.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 03:16:57 -0700 (PDT)
Subject: Re: [PATCH V2 net-next 4/7] net: hns3: fix port setting handle for
 fibre port
To:     Huazhong Tan <tanhuazhong@huawei.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, jakub.kicinski@netronome.com
References: <1568169639-43658-1-git-send-email-tanhuazhong@huawei.com>
 <1568169639-43658-5-git-send-email-tanhuazhong@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7f914173-a2fc-08d8-e2b1-48fa3da4e29c@cogentembedded.com>
Date:   Wed, 11 Sep 2019 13:16:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1568169639-43658-5-git-send-email-tanhuazhong@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11.09.2019 5:40, Huazhong Tan wrote:

> From: Guangbin Huang <huangguangbin2@huawei.com>
> 
> For hardware doesn't support use specified speed and duplex

    Can't pasre that. "For hardware that does not support using", perhaps?

> to negotiate, it's unnecessary to check and modify the port
> speed and duplex for fibre port when autoneg is on.
> 
> Fixes: 22f48e24a23d ("net: hns3: add autoneg and change speed support for fibre port")
> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index f5a681d..680c350 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -726,6 +726,12 @@ static int hns3_check_ksettings_param(const struct net_device *netdev,
>   	u8 duplex;
>   	int ret;
>   
> +	/* hw doesn't support use specified speed and duplex to negotiate,

    I can't parse that, did you mean "using"?

> +	 * unnecessary to check them when autoneg on.
> +	 */
> +	if (cmd->base.autoneg)
> +		return 0;
> +
>   	if (ops->get_ksettings_an_result) {
>   		ops->get_ksettings_an_result(handle, &autoneg, &speed, &duplex);
>   		if (cmd->base.autoneg == autoneg && cmd->base.speed == speed &&
> @@ -787,6 +793,15 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
>   			return ret;
>   	}
>   
> +	/* hw doesn't support use specified speed and duplex to negotiate,

    Here too...

> +	 * ignore them when autoneg on.
> +	 */
> +	if (cmd->base.autoneg) {
> +		netdev_info(netdev,
> +			    "autoneg is on, ignore the speed and duplex\n");
> +		return 0;
> +	}
> +
>   	if (ops->cfg_mac_speed_dup_h)
>   		ret = ops->cfg_mac_speed_dup_h(handle, cmd->base.speed,
>   					       cmd->base.duplex);

MBR, Sergei
