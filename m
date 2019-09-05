Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBCBC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6652053B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="vRnmheRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbfIEKNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:13:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42958 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfIEKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:13:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so1821630lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WM4svmPInntGde0Mb4h49CeOyrkMQizTssxeoRTCMZs=;
        b=vRnmheRVRIyNu1yOxwrrhCtj/3kZ1d0t5JyKsRuOscwUyBBy5Pen7wUCNYp6TyopQk
         w2rxw6vPsm17LHzDCBNT332TPFMbfozti2ysHnKH3+7FWmvupoa0+YDyizlOQQkePcy2
         oADtXPAeLdN/7Z84sFKLuro+l6/WEm4W9nHiUTTkcyZ4tUCSlsN9OLzu3ARVvnGjLGaQ
         4rbITO+SdwYFNpYHbiVRAOx2MbYvSIDDhzP0/TIUqIogBHKFiRLNX/Ql0TbNy0woI2Op
         CnnPVM92pl0riCp3TInQGvtHDW9+8kaeObZ1UR58Olez4CoE/d0ZCHLN3BzEYtZBtUH1
         wXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WM4svmPInntGde0Mb4h49CeOyrkMQizTssxeoRTCMZs=;
        b=FcmUQE53+lLERFLWxd9HguUfPxlAYVEwwwD1i8PV7oSY0r29sqIy8k5MJP92dYk1Hy
         o/BoEr1TIjWkCp13GTZOs74zF8GYab7wtGUohLylwxqw3SUnF19PHW5iA7UoHg9bm1J9
         VVP2rn0w2A+y3R/OD1TLRfoLHpKYhI7/XAdu8+NdgmYYSPYxqj5UxfWEtsM/P0UwpoK+
         Vs46COYzsf8r8xoTgd2SstpjqZXsGJz68Rl4hmbJSTS5H1eMl/qgtt+aAUA0FUQum/U1
         JvF0dspiJdTKNtPjcNJzrpuLhW7Fiki+jsOVA3nZLERjZwOZGSijGonHaQN3t54ugxF1
         q/vw==
X-Gm-Message-State: APjAAAVhUY9UjkOoP2gyW6I5bXIXUJzWzWOfRLenoLSbX3O1v0Ulmzt2
        c14IxL1SlilredHS6IRAuj6KNQ==
X-Google-Smtp-Source: APXvYqy3A+azbPbg/1KwTZbN5fOs8mzxKRC4QS8uK+LhfmrAK7TY/oNz5c8RHtwqX0w9skwFxCyxQQ==
X-Received: by 2002:a2e:878a:: with SMTP id n10mr1526787lji.117.1567678381628;
        Thu, 05 Sep 2019 03:13:01 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:413:7297:c53b:e0f7:7608:d21c? ([2a00:1fa0:413:7297:c53b:e0f7:7608:d21c])
        by smtp.gmail.com with ESMTPSA id w1sm349824lfe.67.2019.09.05.03.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 03:13:00 -0700 (PDT)
Subject: Re: [PATCH net-next 4/7] net: hns3: add client node validity judgment
To:     Huazhong Tan <tanhuazhong@huawei.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, jakub.kicinski@netronome.com,
        Peng Li <lipeng321@huawei.com>
References: <1567606006-39598-1-git-send-email-tanhuazhong@huawei.com>
 <1567606006-39598-5-git-send-email-tanhuazhong@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b0aa6da6-cd42-dd31-8ff7-ca3f48de58ff@cogentembedded.com>
Date:   Thu, 5 Sep 2019 13:12:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567606006-39598-5-git-send-email-tanhuazhong@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.2019 17:06, Huazhong Tan wrote:

> From: Peng Li <lipeng321@huawei.com>
> 
> HNS3 driver can only unregister client which included in hnae3_client_list.
> This patch adds the client node validity judgment.
> 
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hnae3.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
> index 528f624..6aa5257 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
> @@ -138,12 +138,28 @@ EXPORT_SYMBOL(hnae3_register_client);
>   
>   void hnae3_unregister_client(struct hnae3_client *client)
>   {
> +	struct hnae3_client *client_tmp;
>   	struct hnae3_ae_dev *ae_dev;
> +	bool existed = false;
>   
>   	if (!client)
>   		return;
>   
>   	mutex_lock(&hnae3_common_lock);
> +
> +	list_for_each_entry(client_tmp, &hnae3_client_list, node) {
> +		if (client_tmp->type == client->type) {
> +			existed = true;
> +			break;
> +		}
> +	}
> +
> +	if (!existed) {
> +		mutex_unlock(&hnae3_common_lock);
> +		pr_err("client %s not existed!\n", client->name);

    Did not exist, you mean?

[...]

MBR, Sergei
