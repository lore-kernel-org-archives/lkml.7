Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E1FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7B72075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toZAEs7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfCDNmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:42:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37745 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:42:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id q206so3139389pgq.4;
        Mon, 04 Mar 2019 05:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y9/FuZn/xSNSu2RD4k/9tZpluYFjb3nzrKMrqPIU0GI=;
        b=toZAEs7b2doiOqLEI1nInZyHrQLniEprTPHJYy5lLKqI5ZLgIMbqrQO0YrK4pu61WG
         SFY/3NUnZwl3C+iB8PmH0YhI9P6UYLsin6oS75GuC5vntvQBtxwMBlqLtE5wqd2f9gVg
         PY+mNDqALPO81DLTKRIrGXwXhk5u8Yp4mYP1k6VCY5x6ybV3MRIVc95mNk4k1Ir9VfFr
         B3HPWieITS0fnnvM12/ODJ38/ww6jKHXp9EaX5PnB3FPJ9UG7SEy1zkcPet9CxUmCpA0
         +DBXPxSQt6rXza9vWj3ggtT+pGzOpT5Y7EvOfwYBAVsH+HjGLfjwxaVlsCfEPSe8tNhA
         knIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y9/FuZn/xSNSu2RD4k/9tZpluYFjb3nzrKMrqPIU0GI=;
        b=BJFNdoSoBwsmJP2ZPcK7iON0RZsDFQdUX2YnfGS5CgknsSalgVam4HUWU0vZ/GeVwl
         EfLEH3jIjzgd7FC/HNeQCL5WgqiGDItQNnO5jDHp8hJ0w8uqtDIROSjqv6/LWkVx/Kw2
         1FeOU4QsG6HR6QZFOZFBsNvzMeAZ33tTUd/m68/RYg73l4ywD6jI0ZBmB7ZGi2tIFug4
         /SYZ3icuzoMvO6ULcH7hFw+mSb7MV8m1iwTLLFagF1yhr5wbIL455+5WLGmzkk3e3cAp
         JuVsEw2rlG+isTcVIpnP8ZgVu332A+qYZbGC0zn8jx+0JP8Imyx05WPHOK3cp8iKjiNv
         MINA==
X-Gm-Message-State: APjAAAWKdXO3eK59xsCtay3kl7sfQFZ+9fXbndJBr+0wOSVDzRHDZiLi
        l7JrZhB7rZoPzQ6UuBEFSRMy6au1
X-Google-Smtp-Source: APXvYqzri0fMXZETVX4MZf8VQ43dJQD9PZAr5sHaAgkMwABho8/F2bnLxH0W29XY/8N8hNrECQJ/xg==
X-Received: by 2002:a63:80c7:: with SMTP id j190mr17840476pgd.357.1551706940653;
        Mon, 04 Mar 2019 05:42:20 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id a184sm8900798pge.68.2019.03.04.05.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:42:19 -0800 (PST)
Subject: Re: [PATCH RE-SEND] clk: tegra: Don't enable already enabled PLLs
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190224153222.8142-1-digetx@gmail.com>
 <b64760b5-0d37-ae05-9c8e-9e6d47293c92@gmail.com>
 <20190304081857.GE21084@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9171e4f6-1ede-ab3a-caa6-83a2d9033650@gmail.com>
Date:   Mon, 4 Mar 2019 16:42:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304081857.GE21084@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.03.2019 11:18, Peter De Schrijver пишет:
> On Wed, Feb 27, 2019 at 06:15:04PM +0300, Dmitry Osipenko wrote:
>> 24.02.2019 18:32, Dmitry Osipenko пишет:
>>> Initially Common Clock Framework isn't aware of the clock-enable status,
>>> this results in enabling of clocks that were enabled by bootloader. This
>>> is not a big deal for a regular clock-gates, but for PLL's it may have
>>> some unpleasant consequences. Thus re-enabling PLLX (the main CPU parent
>>> clock) may result in extra long period of PLL re-locking.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>
>> Peter (and everyone else), yours r-b and ACK will be appreciated since you kinda already took a look at this patch in the past and were okay with it (IIRC, we had some brief discussion on the #tegra IRC a few months ago), thanks. 
>>
> 
> Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
> 

Awesome, thanks again!
