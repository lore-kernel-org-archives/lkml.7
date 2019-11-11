Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2BEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D73821925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcidApTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKKOQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:16:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41815 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfKKOQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:16:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id p26so10783924pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=febfKlWJi5gGxYdmeWZw4Fi5Cx8ThIzR9wUIWuDizCE=;
        b=dcidApTOUPNVuSFDYFLRSDVmUaujchonwjxB3OPh3A8fUBSMjJ1VijN6wTxjziztJ3
         mMfB+A9a6kbau0dpDL15pcCI4gsrXB3ITA0mQ+ZxnFb/ql20jhYY1ZjqWVhp40kaQz1o
         8H+YWXud1Pd6HQhbT4SSOQ59OQr6M6n7rRbikjvv632blP/8RGM70rCTdDkAkRz7JV7k
         oJ3LCt9MvQRCX3Ut75e0mjcdhtthxh1zH9G9yPxpFLLLtLPi+rkRWwqKnQmvV/fhXquy
         +mvPG8CnJL7MNS40XwnttmrXtPzkbUwiSwsP3IZtdFZ6ni2BfmvE42ABruSG65PYhbh6
         VgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=febfKlWJi5gGxYdmeWZw4Fi5Cx8ThIzR9wUIWuDizCE=;
        b=EMvx5/vm32vkjMl0OViVq6ciQo+RMNjg1CTgoMLe11Tky2g7sR4vDNO7bWoA8LWj8R
         LFA/g63q35zmRXv6D1Mu2zwQ0EM7bEhlmnUE+ecN4rLiMMrncexIqqXmi2gn99ykrG34
         Rcm9+/sumtH8pXYe4ViBxe05rsPP3ShshfAdfDy4njAWHFue8tu90RC/ka7VjGJivyxA
         v1Oke2oCktqqjpAkLe3pXQH9Mnbix+mTyLb9BPxCLygtYxcMrtTRDnkQP2CWVOqGTqkm
         srEZE+b+OBxD60Vti5A4fquV36dKzh4jefnttbxEcNIXTrX7IVo9443unN7Xa3xLvhPI
         se8Q==
X-Gm-Message-State: APjAAAXOjbAjNzajK0i0SK6HFAvpykWEiAj9J2h6+V5vM4FD/cYB/QYN
        rMyDgdfc7Yq7s2NkCn9sEQADsvNt
X-Google-Smtp-Source: APXvYqwKi/pjpY+1q9oCaxglZOH6Jtmslpke/PA4yi6SHCxe0djIH9S8SnYfqxtXvP4AihM0ZUNDpg==
X-Received: by 2002:a17:90a:9741:: with SMTP id i1mr35005987pjw.41.1573481768634;
        Mon, 11 Nov 2019 06:16:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u8sm3700134pga.47.2019.11.11.06.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:16:07 -0800 (PST)
Subject: Re: [PATCH -next] fsi: aspeed: Use devm_kfree in
 aspeed_master_release()
To:     YueHaibing <yuehaibing@huawei.com>, jk@ozlabs.org, joel@jms.id.au,
        eajames@linux.ibm.com, andrew@aj.id.au
Cc:     linux-aspeed@lists.ozlabs.org, alistair@popple.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
References: <20191109033209.45244-1-yuehaibing@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <62eacd00-300c-bc3e-b680-605bd0b7a983@roeck-us.net>
Date:   Mon, 11 Nov 2019 06:16:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191109033209.45244-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/19 7:32 PM, YueHaibing wrote:
> 'aspeed' is allocted by devm_kfree(), it should not be
> freed bt kfree().
> 
> Fixes: 1edac1269c02 ("fsi: Add ast2600 master driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/fsi/fsi-master-aspeed.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 3dd82dd..0f63eec 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -361,7 +361,7 @@ static void aspeed_master_release(struct device *dev)
>   	struct fsi_master_aspeed *aspeed =
>   		to_fsi_master_aspeed(dev_to_fsi_master(dev));
>   
> -	kfree(aspeed);
> +	devm_kfree(dev, aspeed);
>   }
>   
>   /* mmode encoders */
> 
The memory is attached to the device, and will thus be freed once the device
is released. Why is the release function needed in the first place ?

Guenter
