Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD2F2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightbitslabs-com.20150623.gappssmtp.com header.i=@lightbitslabs-com.20150623.gappssmtp.com header.b="E5hs2xxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDCVNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:13:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35919 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCVNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:13:17 -0400
Received: by mail-oi1-f195.google.com with SMTP id l203so94238oia.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jx7BQxj/9NIW9ENsjqJTFShbMOWL9yi8n3RIdurySWE=;
        b=E5hs2xxbgQhMKJHwgZ6fr9VcBN2RUBa725vetMCg/wW7OhjpiikXpYDA5r26OWkzaP
         qPcZJympFo62BmEfuYs6VamsmGLuoRdBUgUR0BKKX8M4U7RpQCdRj7XdEpt9tyMTAxNK
         dDWVYO8ApXRdBcJMAxmgnqsz/QSXVH6G249iWXF/5bDvE8v+DetkHLxaem8pzbFIUNC3
         colp7fWZYQwU8kyS3t7Q8U3EPDJSEG+RxteFfnGZ38mbAx5GknZtGr4nV7Kcr4/zq9L7
         saFpt+Lt0lByhEx++HSLTzy9zptSqORWTvf4lmTIcWkfuDm4YiOlEJ0ARdwU5xuqiITV
         d8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jx7BQxj/9NIW9ENsjqJTFShbMOWL9yi8n3RIdurySWE=;
        b=lOUezg6ho8v/DOR5m74tVli0TnId1XnrJDn+ZVnYz7yowCB3iqs8wuLHnw2Uq4382y
         6JhSOlHoUmO2w1MknREsVPpu2HjYWifzIvSrLLbLq9yPF5+FEkek6QAJ0Px7YEbAO+SK
         VoTfyxFM66UOZY+xuRoUA56+ehyHn6CjstnIJBtJ1yAYrXoh4qWJ9c4XztzaBkALLqMj
         yyBfJKfu7CUW4xWi0Vr03ZPmlBaec4lMjXhbQBO/2A5dCwwrSMKf8UOUN4hUrRtXQxuO
         1z9m4a+ZGnP6r7QgufhSFmCitKDch5QPr5OX25ADiDmt96FQ9VQtizjUjCFth7b7zO6C
         m1Wg==
X-Gm-Message-State: APjAAAW1N8UfAfhecrgc2NL/I609OlMPxmXs9HlgUvoDLS1hPxaXbxG9
        vi2UDUoXeemzxjEPTntFsf4KiQ==
X-Google-Smtp-Source: APXvYqw0GrgJ4wdWG7uguUYpQpjJTUTSpIOapUsRYAYOjuWJy4tAS6HL2IxehC/nuzzgAYKxYtA6IA==
X-Received: by 2002:aca:5686:: with SMTP id k128mr1034542oib.64.1554325997199;
        Wed, 03 Apr 2019 14:13:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o203sm593903oia.20.2019.04.03.14.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 14:13:16 -0700 (PDT)
Subject: Re: [PATCH] iov_iter: Fix build error without CONFIG_CRYPTO
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, willemb@google.com, edumazet@google.com,
        fw@strlen.de, hch@lst.de, pabeni@redhat.com, pctammela@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190403095031.11720-1-yuehaibing@huawei.com>
 <20190403165215.GQ2217@ZenIV.linux.org.uk>
From:   Sagi Grimberg <sagi@lightbitslabs.com>
Message-ID: <1e24c406-b1cb-cd03-d482-a6f95554f90d@lightbitslabs.com>
Date:   Wed, 3 Apr 2019 14:13:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403165215.GQ2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> If CONFIG_CRYPTO is not set or set to m,
>> gcc building warn this:
>>
>> lib/iov_iter.o: In function `hash_and_copy_to_iter':
>> iov_iter.c:(.text+0x9129): undefined reference to `crypto_stats_get'
>> iov_iter.c:(.text+0x9152): undefined reference to `crypto_stats_ahash_update'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: d05f443554b3 ("iov_iter: introduce hash_and_copy_to_iter helper")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> I'm not sure it's the right fix; might be better to have something like
> 
> size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
>                  struct iov_iter *i)
> {
> #ifdef CONFIG_CRYPTO
>          struct ahash_request *hash = hashp;
>          struct scatterlist sg;
>          size_t copied;
> 
>          copied = copy_to_iter(addr, bytes, i);
>          sg_init_one(&sg, addr, copied);
>          ahash_request_set_crypt(hash, &sg, NULL, copied);
>          crypto_ahash_update(hash);
>          return copied;
> #else
> 	return 0;
> #endif
> }
> EXPORT_SYMBOL(hash_and_copy_to_iter);
> 
> instead.  Objections?

Looks better to me.
