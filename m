Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E8A21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N3aQiQMq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GtLpU+LW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfDEOKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:10:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60652 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEOKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:10:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A1C0760D35; Fri,  5 Apr 2019 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554473441;
        bh=0j2oBoPTkl1c274QrQCPG0BUhrgL5HaoP2NObWBnJwg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N3aQiQMqGA7EwxNYkM7pGSUwJhjx4EWpghNwjh65e7McvVdwSMjXPGvUJR0KgjhWf
         PLiz2LxjTuzAdoXBrSV+Wtkqrbh0axJsOQPSvLbIz/TTbdBj+b6HH8UW9p85qR3xFF
         YchE/1olDU1mvFV9oyMlru7n3n4Kv3lJcLcFDILU=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11FD36030E;
        Fri,  5 Apr 2019 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554473437;
        bh=0j2oBoPTkl1c274QrQCPG0BUhrgL5HaoP2NObWBnJwg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GtLpU+LW+HNYmNG7t1L3flN0+FlvLws9eGq10bnag9+5qbheYnxtT1VpbinkM0Nn/
         bFgnmv+A88pSbwMZiUyXxF/IxXEXjjCHMxLr4PTcf91B3UYHrlfmn+wai4On6MHjxO
         9pn6vvQ7u35Dh35izoWg2JhnnvLcBe7XeUPGAPg0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11FD36030E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH][next] net: hns: fix unsigned comparison to less than zero
To:     Colin King <colin.king@canonical.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yonglong Liu <liuyonglong@huawei.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190405135916.1621-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ec5863a5-ab4a-7dca-0188-adb8a1dc4889@codeaurora.org>
Date:   Fri, 5 Apr 2019 19:40:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405135916.1621-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/2019 7:29 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently mskid is unsigned and hence comparisons with negative
> error return values are always false. Fix this by making mskid an
> int.
>
> Fixes: f058e46855dc ("net: hns: fix ICMP6 neighbor solicitation messages discard problem")
> Addresses-Coverity: ("Operands don't affect result")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> index 61eea6ac846f..e05d2095d09b 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> @@ -2769,7 +2769,7 @@ static void set_promisc_tcam_enable(struct dsaf_device *dsaf_dev, u32 port)
>   	struct hns_mac_cb *mac_cb;
>   	u8 addr[ETH_ALEN] = {0};
>   	u8 port_num;
> -	u16 mskid;
> +	int mskid;
>   
>   	/* promisc use vague table match with vlanid = 0 & macaddr = 0 */
>   	hns_dsaf_set_mac_key(dsaf_dev, &mac_key, 0x00, port, addr);
