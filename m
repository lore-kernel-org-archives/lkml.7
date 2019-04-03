Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5455C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F56620830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="VxB1WByo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDCJQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:16:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38121 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:16:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id a6so11165676lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4NRHrwD8OfEj2OriyZsAce/RXryE17FV/2DoIYmW/uU=;
        b=VxB1WByoBY2oHz4sb27RF2dBGHfIwQR71NqPLQnhUI2vRXPdyAu8IronZR4/ibGPRE
         hdkwMJXlF9+U+aPDMHToYHu5mAbKZ4tW6/HPa7O2b0jMfn5jz4yd0+A/n3zWQwGd0IPx
         1rHKPANKARbh1s+4z2mVEBGFnNKupDoyTNouCogDQm6aeqDCgv1i6l1NsV5yKxdzJkMB
         bAyHcmecvvvDVPXV6zD3aqzIo2PkQ/FT6DuD25TtsaOs1cFVG/S+/QV1Qdsn1wb390aW
         AEV4++bBReKrbPiTM9i7GOK+C0w0LqPH/ws5hVKosq7lIdn2Elf81A+1eapv8PIh3Hvm
         EnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4NRHrwD8OfEj2OriyZsAce/RXryE17FV/2DoIYmW/uU=;
        b=sDDb1lJeKAvTrGKHal/W81tMqqQoges/owXEQkOlHJfqn25FFQPaMacXd/MWOaMZJp
         YxjpQbVhoAH7gKeIkggHdmsJd7GWv74qdwXlqMBNSyjHVK1eaPcG/b7TgzvrhXrEnxez
         4JE5lyUJDbaXMilUeGwZAxbR3DLe86lqWgkcd8VLNqnrGyHvGbzyZRB+kII6tXMmrb4J
         VCbou3bKRvhmqz64Gzlx60uDA/+pbA5wIZekDI6ORaPU8hTp+tJSeoq/3WvwWIrc4Ge8
         X7VlLgJeyJwdK6NNYqug2MkZdwxr965NbZcTy0LeH2tO4qn4FFiOYgFp1HVVk5j/91ha
         +Yjg==
X-Gm-Message-State: APjAAAWPS00eJs9TWsWhT0H+kEDPu8SXfXDvtOdoGtdsJ2S48iJMI+6m
        +lt9RqDhAbKL4GY5cxN+LAxZxQ==
X-Google-Smtp-Source: APXvYqxfT+QcKs9T7IOfT3eHWhUNUiBheTe7uwUg0RsgaLnHe4yLPGoerv8fl7EtAT4tnGfQDR27bA==
X-Received: by 2002:ac2:4561:: with SMTP id k1mr33847684lfm.95.1554282980031;
        Wed, 03 Apr 2019 02:16:20 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.84.175])
        by smtp.gmail.com with ESMTPSA id e2sm2851712lfc.75.2019.04.03.02.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:16:19 -0700 (PDT)
Subject: Re: [PATCH net-next 04/12] net: hns3: return 0 and print warning when
 hit duplicate MAC
To:     Huazhong Tan <tanhuazhong@huawei.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, Peng Li <lipeng321@huawei.com>
References: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
 <1554260881-44948-5-git-send-email-tanhuazhong@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <4b40bd6e-a732-bc8b-4085-56520677b6ea@cogentembedded.com>
Date:   Wed, 3 Apr 2019 12:15:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554260881-44948-5-git-send-email-tanhuazhong@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.2019 6:07, Huazhong Tan wrote:

> From: Peng Li <lipeng321@huawei.com>
> 
> When set 2 same MAC to different function of one port, IMP
> will return error as the later one may modify the origin one.
> This will cause bond fail for 2 VFs of one port.
> 
> Driver just print warning and return 0 with this patch, so
> if set same MAC address, it will return 0 but do not really
> configure to HW.

    "To" not needed here.

> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index e742a05..d45789e 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -5962,8 +5962,11 @@ int hclge_add_uc_addr_common(struct hclge_vport *vport,
>   	}
>   
>   	/* check if we just hit the duplicate */
> -	if (!ret)
> -		ret = -EINVAL;
> +	if (!ret) {
> +		dev_warn(&hdev->pdev->dev, "VF %d mac(%pM) has been existed\n",

    Maybe just "exists"? The grammar is certainly wrong as is. :-)

> +			 vport->vport_id, addr);
> +		return 0;
> +	}
>   
>   	dev_err(&hdev->pdev->dev,
>   		"PF failed to add unicast entry(%pM) in the MAC table\n",

MBR, Sergei
