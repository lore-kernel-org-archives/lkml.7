Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48684C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F342147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="mIkQUt1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDCJNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:13:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40710 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:12:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id a28so11132967lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BnRtfcT6zKvNfhofYVfHOWh/d+GSo8EARhAmF6DG0Zk=;
        b=mIkQUt1Vz7sPiJYa8eWvQlzxwyge1RDca8ANYwrDfVgNbznP375pESy5a2KzjZPsJB
         74lwVPdF2rPU6oF9/1IqeuVre75N3PUn7fyeVEuVwxBNtRWOy/WgIaKXSrkwxQob9NmB
         RsRQxxfcRrLvHcKPRhjMzvfYi1Dmq8zSMpRzmGvMO9ZZQmEe3P88VWKKhEr356OwM0eY
         3TMCIvCwi3OyhZ7REjioD38dtsZBuKcsL3RCIW5uiEev888zqvhI2Lsx6YXWWjP2OGij
         ppXdfvE0zPKKNAWam7qlkfegGBIeHx1vG1u7vPoq/FJ/UsP97bbHuXGD1auEopQ8JEKg
         3mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BnRtfcT6zKvNfhofYVfHOWh/d+GSo8EARhAmF6DG0Zk=;
        b=p/r/DV9p8qtmpyOCuNNnXOS9czMmz3aWK9qTcFTTpqifJln47Ah3/0FfYqF/SX6vp2
         eaaqk0HXGj3fbiwdJtMDDgAjhMmHKGeSFANK9xhJcbB1G+UWC7tuGWsc8T1rTeNbv0f2
         d1To9ytWHDUf5/ZBjWgny/llvOffoo4G32EtCum3B6rlGnnU2lhNjxOQvBn/bWoE8pBQ
         A3iUNU57bDU2wRqb2L6eDbzjQY3jEq5DgV1tlIMwka/4RIan5pnfZhixbrfQIsy5WSYg
         mYoKMkKMimL3UEumxqW9nGzKphZR4ViNMxvjOVW5vtcYT0GMLNgNSVHBbS0m833zhzAp
         lKuw==
X-Gm-Message-State: APjAAAW+fme/4WSUW+eIo6mP2XnIP1XplWgu98tBBVFImOp5Z5/51Hu5
        RTpvUp8mrtsSpnAycadHjlqt2w==
X-Google-Smtp-Source: APXvYqw8lOvTaCzebhIqXPp768h8GHIwPB7Q1wr4X+2w27u4DeNHjeYt7H6+1pfhcWrP1T+LVRW/EQ==
X-Received: by 2002:a19:c101:: with SMTP id r1mr40502156lff.81.1554282777640;
        Wed, 03 Apr 2019 02:12:57 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.84.175])
        by smtp.gmail.com with ESMTPSA id w1sm2863765lfn.79.2019.04.03.02.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:12:56 -0700 (PDT)
Subject: Re: [PATCH net-next 01/12] net: hns3: check 1000M half for
 hns3_ethtool_ops.set_link_ksettings
To:     Huazhong Tan <tanhuazhong@huawei.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, Peng Li <lipeng321@huawei.com>
References: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
 <1554260881-44948-2-git-send-email-tanhuazhong@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <dd51c598-c4df-f10f-91ca-2f5081bead68@cogentembedded.com>
Date:   Wed, 3 Apr 2019 12:12:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554260881-44948-2-git-send-email-tanhuazhong@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03.04.2019 6:07, Huazhong Tan wrote:

> From: Peng Li <lipeng321@huawei.com>
> 
> Hip08 SOC does not support 1000M half, this patch adds 1000M half
> check for hns3_ethtool_ops.set_link_ksettings, so the user can not
> set 1000M half by ethtool.
> 
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 359d473..0c05807 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -648,6 +648,10 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
>   static int hns3_set_link_ksettings(struct net_device *netdev,
>   				   const struct ethtool_link_ksettings *cmd)
>   {
> +	/* Chip don't support this mode. */

    Doesn't.

[...]

MBR, Sergei
