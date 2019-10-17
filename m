Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B8ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26032089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrnfU3QJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394652AbfJQRsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:48:10 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39465 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfJQRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:48:08 -0400
Received: by mail-yw1-f68.google.com with SMTP id k127so4282ywc.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kEBrFsENgcN61lOs9AAz0c8wQaRYi7TYeszZxNnhUsM=;
        b=lrnfU3QJ7otQlwWjO4pAUFcP9Ivd0EezGXjOZGgwJsaUn3vMWY0n0vZdhD/O8rwgnW
         UApMMVA3HxJRbEEWHpuHh0/uNk44uWdYySDwUcdqQQvfvhD5wofSacQxnzvwhxseGzIf
         a4XbOkOQ44NlrlXWhg65xSFMWVtxejYcxnrU3B5KpA1urKff0jXY2NkxGjGM/2PQscBn
         /xDJLf4bHORqiVwmDhacdSuBFM4z1p1qGu+MVuNYslsFVPbD9obU6vBFXiJRtwfaEhe4
         jtdBv+evbrAlruOhvrNIwg7Ycla4ED8hMIZT7SbpueT6yf8HOE6ihSj7UyZxAZ7dhndt
         u2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kEBrFsENgcN61lOs9AAz0c8wQaRYi7TYeszZxNnhUsM=;
        b=Df2kqM1P/tR13t+0PR2meP3uBsoLwWExESwHX/ONsKnl9oZrN68VizA1nixDJivNbq
         jmT/nYC8emVld8iKfHU/kXNfhUlaWvU+lQSbDLy1KsppJJ3vDwjTb6dql3+rWAoMPH8T
         ZNb4VkptfJrZ4R8MOa1pSqzVr7Deq4oqE2q0nZDqz1tmBpzmgn/tWE0IHh41nieWe04G
         hu35kcj/38MdJSWgE/weBH7HGTW1v6mxWK87uucnDQsyNEzIDGslm/wM7l3FNzXTMcR9
         g/zMrJ0js6Uf7cMEvzhVj4sc5F5sBBL+u+FeohdFhIM0nzifpXYkmnt+9hcSUrNJatHV
         kj/w==
X-Gm-Message-State: APjAAAVFyJDLv6m2CZjXpOqvEPvqGSzo1BvfST0RKMpRVpqQ01C1XK1Q
        fdW32k1vTNYooP/Xmr+sjIA=
X-Google-Smtp-Source: APXvYqypEkDpkpvJLvwo0RW9wv/cB4PSe6I1y5z0kWxQNb7G9m1qNvmjUZ6BwuTg4EpQgxBhgvkvQQ==
X-Received: by 2002:a81:6d57:: with SMTP id i84mr3762089ywc.417.1571334487239;
        Thu, 17 Oct 2019 10:48:07 -0700 (PDT)
Received: from [192.168.1.62] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id p10sm660977ywc.19.2019.10.17.10.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 10:48:06 -0700 (PDT)
Subject: Re: [PATCH 10/10] of/device: Don't NULLify match table in
 of_match_device() with CONFIG_OF=n
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
 <20191004214334.149976-11-swboyd@chromium.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6ce47827-55e4-dd15-6a05-f25a2f8a8bb7@gmail.com>
Date:   Thu, 17 Oct 2019 12:47:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191004214334.149976-11-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2019 16:43, Stephen Boyd wrote:
> This effectively reverts 1db73ae39a97 ("of/device: Nullify match table
> in of_match_device() for CONFIG_OF=n") because that commit makes it more
> surprising to users of this API that the arguments may never be
> referenced by any code. This is because the pre-processor will replace
> the argument with NULL and then the match table will be left unreferenced
> by any code but the compiler optimizer doesn't know to drop it. This can
> lead to compilers warning that match tables are unused, when we really
> want to pass the match table to the API but have the compiler see that
> it's all inlined and not used and then drop the match table while
> silencing the warning. We're being too smart here and not giving the
> compiler the chance to do dead code elimination.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please ack or pick for immediate merge so the last patch can be merged.
> 
>  include/linux/of_device.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 8d31e39dd564..3f8ca55bc693 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -93,13 +93,11 @@ static inline int of_device_uevent_modalias(struct device *dev,
>  
>  static inline void of_device_node_put(struct device *dev) { }
>  
> -static inline const struct of_device_id *__of_match_device(
> +static inline const struct of_device_id *of_match_device(
>  		const struct of_device_id *matches, const struct device *dev)
>  {
>  	return NULL;
>  }
> -#define of_match_device(matches, dev)	\
> -	__of_match_device(of_match_ptr(matches), (dev))
>  
>  static inline struct device_node *of_cpu_device_node_get(int cpu)
>  {
> 


Acked-by: Frank Rowand <frowand.list@gmail.com>
