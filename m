Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAF5C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBB12084D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="zES1kZIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfIKKRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:17:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38780 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfIKKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:17:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so19089806ljn.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HHRzzoV7NRJaC+wX9s9V5DTVizkcpByr53r0dhYAcVg=;
        b=zES1kZIBhS+m6Od2zZhR/Mlgf0dY5jo8KGsZEBvuEjAthjBQ7XUGs0GLBpD52SRwnA
         7X6S6ZwHKhD/0vQDlDzvAcq3/3XR3JYzJFp1IzjadZ+7Bjle6lgClvuuyLkWU5JJvw7t
         l8uGP8egnLL7qoQBh80zpWU074HQr/PsNg1y8iiONO/yujMGG9Pj46hnsnFuK867abQl
         Tek4xwVtLw4Kv+UFD58gUHF9DkL5ESiEN7+QXmZLjuVlCDb1j+szyTjg3cZbjAgV1UCo
         IKVktML2E6s/mQPCYHzPZGd5EzkDHzqjuPRNXkEQhTpV/BHyYcodekv/ZprVV3VVW80U
         pPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HHRzzoV7NRJaC+wX9s9V5DTVizkcpByr53r0dhYAcVg=;
        b=K/9QZQ0x2KzqvCrQKKHDYoNOtV/M2jn9ao5IM5sB8xX1U++fORbHVhaU2744Yocw6i
         Vr1aZKyxQbo4urLhonmbz08R/AIAn1ggfJSwXtAU66LLk58lcX9SRiht/yGjlOM7/El8
         fYPEO25r+k3CbZ8GFTts4d4ptaiusZw1Ytgq7V19rMKY5Aw5ehm+TP64C7xXsCP3tAnl
         HQOHRnuX+cuIP5bYqZc6iXCckp43147YhXCpDnBE0+j/WxPiIveCa87Lf6VoirlpfweW
         fmIADxksc71DsB+V7tQGKkzV1R2c/AGbg5iq8HjfkU6MTe1GdEQ/luetkWnZH+x4D8hz
         Y4ow==
X-Gm-Message-State: APjAAAXt/iBifiSG4a0Y4qhsQ7YK0s6G0sim8gGGNSHMbnhqMk2qiBHh
        yUm84zNfN7iVhASuxIbBqxLPGxQBliTHng==
X-Google-Smtp-Source: APXvYqz0W9Akn44DPfRBMCBm6kmYIVFmDE5tpxWtOxVdc9UMk+fDn9oEq5xC5iLNSIul/dinpdxt4g==
X-Received: by 2002:a2e:91d9:: with SMTP id u25mr22758502ljg.85.1568197026734;
        Wed, 11 Sep 2019 03:17:06 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8e6:86de:79c0:860e:c175:7d39? ([2a00:1fa0:8e6:86de:79c0:860e:c175:7d39])
        by smtp.gmail.com with ESMTPSA id h5sm4760682ljf.83.2019.09.11.03.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 03:17:06 -0700 (PDT)
Subject: Re: [PATCH V2 net-next 4/7] net: hns3: fix port setting handle for
 fibre port
To:     Huazhong Tan <tanhuazhong@huawei.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, jakub.kicinski@netronome.com
References: <1568169639-43658-1-git-send-email-tanhuazhong@huawei.com>
 <1568169639-43658-5-git-send-email-tanhuazhong@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <011fc0e2-1116-37d5-f10b-cb9cbb1b41a2@cogentembedded.com>
Date:   Wed, 11 Sep 2019 13:17:01 +0300
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

    Can't parse that. "For hardware that does not support using", perhaps?

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
