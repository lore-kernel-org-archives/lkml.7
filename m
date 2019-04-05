Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA33DC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED5D2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQmvzlSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfDEWuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:50:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41178 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDEWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:50:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so4039441pfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WZyhCqqHVZgZD5mC+F681yCOX1N1HxcM8DUVwE70YdU=;
        b=qQmvzlSj13+4WjjF4FulxWOd4AqkIpbBLYq+x5xoHzacVUHBQVX1SuxsSfnswUO6iG
         2xGiQ7EZBoa8jGsNgxHafxilBaix5OjIhGx1Fop6oVWkdUZjQtxMhKnVaNl67KuZVthj
         jLrKJ+i1g2atA6hFeia3AmJSIjSTxkzannh0GUuZL2Y+XVukGsmDqHuRUOnLGGzljbj2
         IW8A08BmXXy7UJW/5ku7UUQ1uNbupiQOV7GTEcC3v35il8wv6DZiayQxipQXMRuEzsC8
         B2buMe0LDFg26vmYhab2Pu3zQ2roe4y7kc4slIj6r1r1i8ygtrY77SVBpn67B+M8OwCx
         BNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZyhCqqHVZgZD5mC+F681yCOX1N1HxcM8DUVwE70YdU=;
        b=czU46iJMR/BUicXUx0jpxF35neIJx/ejetYhLPt1ELNg7v6Z9vYpFQrRr7BC8XJJzc
         OlSk43zxv+pXv3L73xvUZd+HE9WVklT0ROEYlPahQMe1m1dsFVMfBpjpJ1ekQyM9XBZC
         dXZHmU625oVGjIto1ybmlr5bVRccayM06xVj3DJYyI/zEV0I9pZ4qF2ktC9mnaEw213T
         RI3WXNpwjVbWWZhc09bYpSDRn7pgOok79rVumiWUlQ/ygxOn/CRKKuYFVirRvNdXj+G4
         1vE4vN2lItSQY9sRYzS0rWeFEqtUamqmqUpiD1OQXfTPn9nZeDtEPnyHT4olWyoUlIaG
         WK/A==
X-Gm-Message-State: APjAAAX5bu6u2VZIdxDM6jgqj843KU23FhJEieGxaUhePkSubbLqx1rd
        65I+xzHXaCgtyu9fwW/qTt6MkQ==
X-Google-Smtp-Source: APXvYqz55cY4lXzprdh1MLetOKDbsPZYYuSOc9z70wD8yC+TlKBPaP/2h5zd6BA2gTQ8c9VlEJsLTA==
X-Received: by 2002:a63:6f0a:: with SMTP id k10mr14373126pgc.78.1554504614814;
        Fri, 05 Apr 2019 15:50:14 -0700 (PDT)
Received: from [10.156.37.38] ([116.84.217.55])
        by smtp.googlemail.com with ESMTPSA id m7sm35159407pgg.62.2019.04.05.15.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:50:14 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] Staging: greybus: Fix spinlock_t definition
 without comment
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     devel@driverdev.osuosl.org, elder@kernel.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20190405200046.20600-1-madhumithabiw@gmail.com>
 <20190405205304.GS32590@kadam>
From:   Alex Elder <elder@linaro.org>
Message-ID: <fd59f7d5-84a0-35ca-b096-a1d2c7e30336@linaro.org>
Date:   Fri, 5 Apr 2019 17:50:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405205304.GS32590@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 3:53 PM, Dan Carpenter wrote:
> On Fri, Apr 05, 2019 at 03:00:46PM -0500, Madhumitha Prabakaran
> wrote:
>> Fix spinlock_t definition without comment.
>> 
>> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>

Madhumitha, the reason one would want a comment associated with
a lock field in a structure is to get some understanding of why
it's needed.  Saying "protect structure fields" is not enough,
because that can pretty much be assumed, so a comment like that
adds no value.

Looking at the code, you can see the lock field protects the
connection's operations list.  It also appears to be needed
for accessing the state field (reading or updating).

Given that, a better comment might be:

        spinlock_t                      lock;	/* operations list and state */

>> --- drivers/staging/greybus/connection.h | 2 +- 1 file changed, 1
>> insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/staging/greybus/connection.h
>> b/drivers/staging/greybus/connection.h index
>> 5ca3befc0636..0aedd246e94a 100644 ---
>> a/drivers/staging/greybus/connection.h +++
>> b/drivers/staging/greybus/connection.h @@ -47,7 +47,7 @@ struct
>> gb_connection { unsigned long			flags;
>> 
>> struct mutex			mutex; -	spinlock_t			lock; +	spinlock_t			lock; /*
>> Protect structure fields */ enum gb_connection_state	state;
> 
> What does the mutex do then?  Why can't we just use the spinlock for 
> everything?

The mutex needs to be held during enable and disable of a connection.
Johan might be able to give you a more complete answer but these
operations (or at least the enable) need to block, so can't hold a
spinlock.

					-Alex

> I did glance at the code and it wasn't immediately obvious to me.
> 
> regards, dan carpenter
> 
> _______________________________________________ greybus-dev mailing
> list greybus-dev@lists.linaro.org 
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 

