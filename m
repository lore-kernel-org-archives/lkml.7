Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B565FC17441
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861DA20869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQ1pCojt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfKIAue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 19:50:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37905 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfKIAue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 19:50:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so5224409pgh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 16:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J+Il3CqOlkgJ9jbyw0skF8ncR6HEn2y/bfd1fkR+U30=;
        b=zQ1pCojt1fMY9k2FaV/n2Qre5Z5/d/3+xc792IJ8C84W/wstmtnfBQrFd9764OzKPM
         62+Bhhkln8UR7BgEcKtb/jpfgXFnbqtpZzmJtdNtZg/svJ1EWAqRm33yyIfXlhOUVcVw
         A4X84aXgBBKVdAFAZcduvMpMG+6pmuIc1CM9BCgy1rugKgKa8htbgGh6uphdh29XymMX
         6uHRTRSPd+ayR+rBlK0ul4uYfbIX6+SNfjLQfG7TRlSTwNqzKDAgK2+NCYRedEIGlWqn
         d6cOeA1eqIOHaybTkf3gkMwCDhYCwPC7TKUuLAMgehuajLtoRinTbwKSMHz5ajjo2A40
         UsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J+Il3CqOlkgJ9jbyw0skF8ncR6HEn2y/bfd1fkR+U30=;
        b=UIuzPOw5U53Tkkfm5SiXtzgDG2f/i2ugvu9M16PrArAGW3E9mbHGob9AVXR8BFqZ48
         MKC72Ea3jbnOalio+RpmTYBuBmm7jqcqXpaO4DTQyOas8SXPcFzkeIs4G6xJix3kZeqY
         S2TrdII8gaO+6tSnuMizOPrqJwbl/6iFXkZt4p+cfcP/1nlaonh9+4zYLyAdUN+V/cWq
         AQx0lLX37WR2qsqHwqSsp9TUTjdAQMorAV3lC7DVNGpBIeNGBNnRobV5MtxRI0CEEwKA
         2SCtREoW5G4xdDcuIyKuWFTaWo3PUpD+2o4zO+khhdZj8FYNvVicAOzQu/QCCMle850d
         yTbA==
X-Gm-Message-State: APjAAAX/YvxLFXc0ZBF2iQDC4IxgvItAWQukObKkgVdC6r+fO3+tZRiv
        F/C/vawBiieJ1Liw4KjV8YlTsQ==
X-Google-Smtp-Source: APXvYqzIQXy/c1i779vJHnrwCwQBsV4k5o27A5cSDQKFiiAudpJf8Emy4IdsiereSYuZFuJfZQh9eA==
X-Received: by 2002:a63:4615:: with SMTP id t21mr6442949pga.365.1573260633269;
        Fri, 08 Nov 2019 16:50:33 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i2sm7108331pgt.34.2019.11.08.16.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 16:50:32 -0800 (PST)
Date:   Fri, 8 Nov 2019 16:50:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rpmsg: char: Simplify 'rpmsg_eptdev_release()'
Message-ID: <20191109005030.GA5662@tuxbook-pro>
References: <20191029060915.3650-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029060915.3650-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Oct 23:09 PDT 2019, Christophe JAILLET wrote:

> Use 'skb_queue_purge()' instead of re-implementing it.
> 

Applied, thanks.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/rpmsg/rpmsg_char.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 507bfe163883..0c3a340db7d1 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -146,7 +146,6 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  {
>  	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
>  	struct device *dev = &eptdev->dev;
> -	struct sk_buff *skb;
>  
>  	/* Close the endpoint, if it's not already destroyed by the parent */
>  	mutex_lock(&eptdev->ept_lock);
> @@ -157,10 +156,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  	mutex_unlock(&eptdev->ept_lock);
>  
>  	/* Discard all SKBs */
> -	while (!skb_queue_empty(&eptdev->queue)) {
> -		skb = skb_dequeue(&eptdev->queue);
> -		kfree_skb(skb);
> -	}
> +	skb_queue_purge(&eptdev->queue);
>  
>  	put_device(dev);
>  
> -- 
> 2.20.1
> 
