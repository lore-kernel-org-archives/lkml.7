Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01232C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFD520657
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoJ6xso6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404658AbfFKJhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:37:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41136 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404137AbfFKJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:37:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so6639735pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9agf1wB19p+J83b1VsLOfSDCvk5Iwih8vT9zIEbIhto=;
        b=uoJ6xso6aov+5DAxvyb5o40wrZU1FXY+1+wAIyp/jryKLjiHMMBNtAgYzTdICid9EW
         go3OVPwipJhta6jl7ptE0/WhIkeZiCfooS6SSugO1LaOXqML8eCmYzkZdul2b2Xfpmz+
         gclHl8JJUL6HWpk8WO5AKmqkx5Q1wz6C8BWINY5aO24OO68z5tpL9w7ehYBSCWOO7PTd
         psldWcpkoLBpx8667PB9lQ7Hl4xkX/Et3VKXKqqbb6JSkBTLLyJxb8Owby/IighLuBP6
         QryTlp/APxF2h1MpIYTj0IxAOJH3NZ9/aeDzKcKsBH1oE2YkS2KFjvJfoqVePF3HWsAP
         5xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9agf1wB19p+J83b1VsLOfSDCvk5Iwih8vT9zIEbIhto=;
        b=SJ4z0UKKsC/CXA+kMGJXBAgOJVpqRwRrpjiCBKBXqxsJfD1ZSZO0csCLXS+YuFOeE3
         1rv1+zOnxNw0REJRbCBpFPbU1/KS+3hoSzpGurlUq2ow8fdWGOZX7axVQbqn3/cMoMgw
         ACdvf/hBfy+ozQT/tsbTbKBuIsoiw58l/rnpwrHVc0zPMABQUWZsBuuqoVbiwOOcDS09
         /3x7D7VCbTGibzDcQBxBHJMqxXfQLZPxRckfkU1X53E+KoO+w/65fG08ZhI63blOXEHL
         Jq3LqWlOW8pCGKBcHf6KzkPnIuFC9LJmuMfSYeqcQxyhIMeqTsO+DYkRgjotFUboBKCh
         +goA==
X-Gm-Message-State: APjAAAXUS4PCLC5yiR2g/YUrLgQrwPJSEBfVdESun7viLMnWViUZailp
        4dkGQr5XSp2gGicxTGf2BD4=
X-Google-Smtp-Source: APXvYqwW7A1WbJwAEbMJSnf3kHqZzSWeA7fnuPpsGxWy3rdDIeIaKarnUVnZCU2Z96HhMWgjooUtYg==
X-Received: by 2002:a65:5688:: with SMTP id v8mr19726836pgs.138.1560245871063;
        Tue, 11 Jun 2019 02:37:51 -0700 (PDT)
Received: from ubuntu ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id y22sm8563571pfm.70.2019.06.11.02.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 02:37:50 -0700 (PDT)
Date:   Tue, 11 Jun 2019 02:37:44 -0700
From:   Gen Zhang <blackgod016574@gmail.com>
To:     ssantosh@kernel.org, marc.zyngier@arm.com, olof@lixom.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] knav_qmss_queue: fix a missing-check bug in
 knav_pool_create()
Message-ID: <20190611093744.GA9783@ubuntu>
References: <20190530033949.GA8895@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530033949.GA8895@zhanggen-UX430UQ>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:39:49AM +0800, Gen Zhang wrote:
> In knav_pool_create(), 'pool->name' is allocated by kstrndup(). It
> returns NULL when fails. So 'pool->name' should be checked. And free
> 'pool' when error.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index 8b41837..0f8cb28 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -814,6 +814,12 @@ void *knav_pool_create(const char *name,
>  	}
>  
>  	pool->name = kstrndup(name, KNAV_NAME_SIZE - 1, GFP_KERNEL);
> +	if (!pool->name) {
> +		dev_err(kdev->dev, "failed to duplicate for pool(%s)\n",
> +			name);
> +		ret = -ENOMEM;
> +		goto err_name;
> +	}
>  	pool->kdev = kdev;
>  	pool->dev = kdev->dev;
>  
> @@ -864,6 +870,7 @@ void *knav_pool_create(const char *name,
>  	mutex_unlock(&knav_dev_lock);
>  err:
>  	kfree(pool->name);
> +err_name:
>  	devm_kfree(kdev->dev, pool);
>  	return ERR_PTR(ret);
>  }
Can anyone look into this patch?

Thanks
Gen
