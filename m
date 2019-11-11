Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8088C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B022196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgMKb3pN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKKORu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:17:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38086 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKKORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:17:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id w8so7874550plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=93RdXzsIh7XerKQ70G4SgAWwA1RTqVLA4QVQaE+nVeA=;
        b=vgMKb3pNimrdFifDzpVs92F8cm3CtbjmJ2qeSxmnYx+db60ceBU5VEo+4rWeupA3VS
         P7xdTsj6iT6ndJL+tS06LB9fAN+o/r1NRurzphtvYLN/9dhWkWbFTVmMZLPHCOVbtawN
         0hJcB07YNPifUoYxkiNgd1AEyQWdYcIDPo2yfaLCAuIqDMvNS3QodnGfVC5+mLZOUeQz
         yV1hd9jlOfEIJZ/dhknd+GFtb6an6m+dJBpayVm83blb1+GJyTd+hZCZcZT4r5oRn78l
         nNW4qSeLvRm37RIfygsxJ45JQJBDnlD0zoUUI90Tdbc7HeRz0YKbXoFNTEA2KtU/6sZE
         +xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=93RdXzsIh7XerKQ70G4SgAWwA1RTqVLA4QVQaE+nVeA=;
        b=iE0ZvWg5nw9hUJQri9l2i8eTOq4Egpnj+jnpDQKIBnmld6fzLXqUwVLM4mQLvR91ht
         kDYmSUlAoik4+htw8SoSFtd3W0grXENAVNbF5I8IxGZqHVjGqtfQdnXIjLm8KqWjrzBg
         UVJA42kfUFuZZ678LtNPQItENjVNjnEJS5ZRNjaUduag669DTekw7J4maXBoHv3uW4x/
         hiVb1HIKH26i0JUxivgiDXjvUHr1AnqHQ5B4QbRqiCeYdVZNHnnF1Tfik8hD+Ul9ACoq
         nSmaY0U8MXldm1R7cc9/yGtVLACN6ZgmZQnw2F66i8nZGPqkYykfG1c8xwzzqVfklIMY
         aOHQ==
X-Gm-Message-State: APjAAAWGzv4z++CyJmJ0n1GaNOoicggxaHv8VBxqoDGFAaz0A5HKBHAs
        9N4GJGlVAUFKkydIH/sUBto=
X-Google-Smtp-Source: APXvYqyFfD/d/to91cD9Js7V+sQl7S4aV/n6ouG+pxNMxCkhYGyZqnTZZqlJUPWaVA7Ql+w78/EpqQ==
X-Received: by 2002:a17:902:b40b:: with SMTP id x11mr24314029plr.252.1573481869532;
        Mon, 11 Nov 2019 06:17:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n5sm622739pgg.80.2019.11.11.06.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:17:48 -0800 (PST)
Subject: Re: [PATCH v2 -next] fsi: aspeed: Use devm_kfree in
 aspeed_master_release()
To:     YueHaibing <yuehaibing@huawei.com>, jk@ozlabs.org, joel@jms.id.au,
        eajames@linux.ibm.com, andrew@aj.id.au
Cc:     linux-aspeed@lists.ozlabs.org, alistair@popple.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
References: <20191109033209.45244-1-yuehaibing@huawei.com>
 <20191109033634.30544-1-yuehaibing@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c2b2ca4c-d164-5c16-d518-f9040b81c5ea@roeck-us.net>
Date:   Mon, 11 Nov 2019 06:17:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191109033634.30544-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/19 7:36 PM, YueHaibing wrote:
> 'aspeed' is allocated by devm_kzalloc(), it should not be
> freed by kfree().
> 
> Fixes: 1edac1269c02 ("fsi: Add ast2600 master driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: fix log typos
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
Same question as before: Why is there a release function in the first place ?

Guenter

