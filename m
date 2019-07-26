Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C00C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF6921951
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Qiwh1Jd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfGZQGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:06:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46153 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfGZQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:06:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so24901648plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHON1nH6ApNYulEeI4MQrYQT7JZ4z53kVY1K132PFRs=;
        b=Qiwh1Jd1kb/5Vlo9Rc8U7P/Tq79cqEo6XipidsPbuYcLD0EH+gnQicBMdS75tfBWF0
         1tqzCB/vtph8QuGQv2VVHVbw+210vfXgXrI8RBKsSIK4P7eiU3s74k2Evg0vhn1NNYBG
         pbpKOLPc8yLdL52jRN5bfhIrAQAyJCcvhrg7dCbxIEuuQXeRhfMu/XvNEaGxcJQq6r2F
         VP4txtBb+MchTGX/0hk+U/HhkTGJWc4IHBJTv47k/YX7Y3jSHT6wpZL4fRJZjd302bKC
         zp2oSegrl5WsGMXndRDO3SIf/q2G3HV0+Y1hOcjNInPY541c9XgApE+MUBYCAjmg5JHN
         b4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHON1nH6ApNYulEeI4MQrYQT7JZ4z53kVY1K132PFRs=;
        b=jSypbynEjO93KVPOo5e1CVsWQDWyHJXrzxPfYUPHzok2HK2kqHEjvSJXntZ8UuVvBB
         9mDqr2kuOmQPuYby1cGcvrPlR2ygj+CG1E/zKtWkpVsXd85qTQ13mfu0FdC0IJmut0De
         au0Mt+fu8OqP3YTTE+fBPqGe5FsOmVG58F83GtvEm9Bv5AU+U8v9c3nkLbdVWl2OXtAj
         m5mxo2c2Au7rsKiJNzuQmUNvYgi1qKFdL46vCVhQn4n/e/5s43zuH3vvnbjwiOfWl/e2
         23p6+tXqSy6q7XoGVCHj+2vx/gZuW12Y5CIkzFa3QHc8aiJ0fDoFIJZPBnASDqfKLya+
         swuQ==
X-Gm-Message-State: APjAAAVTi5l6kC3UUvST5rtSNFUJsalnNhfjVpg39UYu3VEM17CNZnuU
        vk78WH9mwes81vN4IzGHHx0=
X-Google-Smtp-Source: APXvYqyJ/5zjLMX4clx7iTtWzW9coVoBjAfvFt4UQ4cDn/fxmOcd1CN2LbdbGe9iLph9ntk8Gt0F/g==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr43603616plm.306.1564157174117;
        Fri, 26 Jul 2019 09:06:14 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id i124sm101011798pfe.61.2019.07.26.09.06.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 09:06:14 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:06:05 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Himadri Pandya" <himadrispandya@gmail.com>
Cc:     "Michael Kelley" <Michael.H.Kelley@microsoft.com>,
        "KY Srinivasan" <kys@messages.microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <sashal@kernel.org>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "himadri18.07" <himadri18.07@gmail.com>
Subject: Re: [PATCH 2/2] Drivers: hv: util: Specify ring buffer size using
 Hyper-V page size
Message-ID: <20190726090605.5026de8c@hermes.lan>
In-Reply-To: <20190725050315.6935-3-himadri18.07@gmail.com>
References: <20190725050315.6935-1-himadri18.07@gmail.com>
        <20190725050315.6935-3-himadri18.07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 22:03:15 -0700
"Himadri Pandya" <himadrispandya@gmail.com> wrote:

> VMbus ring buffers are sized based on the 4K page size used by
> Hyper-V. The Linux guest page size may not be 4K on all architectures
> so use the Hyper-V page size to specify the ring buffer size.
> 
> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
> ---
>  drivers/hv/hv_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index c2c08f26bd5f..766bd8457346 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -413,8 +413,9 @@ static int util_probe(struct hv_device *dev,
>  
>  	hv_set_drvdata(dev, srv);
>  
> -	ret = vmbus_open(dev->channel, 4 * PAGE_SIZE, 4 * PAGE_SIZE, NULL,
> 0,
> -			srv->util_cb, dev->channel);
> +	ret = vmbus_open(dev->channel, 4 * HV_HYP_PAGE_SIZE,
> +			 4 * HV_HYP_PAGE_SIZE, NULL, 0, srv->util_cb,
> +			 dev->channel);
>  	if (ret)
>  		goto error;
>  

hv_util doesn't need lots of buffering. Why not define a fixed
value across all architectures. Maybe with some roundup to HV_HYP_PAGE_SIZE.
