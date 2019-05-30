Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BF1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6F72544D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="z9gMudh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfE3JWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:22:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34702 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfE3JWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:22:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so5391349ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MZLYGTyIcU65t5L2uyp6Otqtskjo+juH9YbDeDOrWoQ=;
        b=z9gMudh7d9JcCGlrp8eWDNV2yJxcWLzjkU8oQz0Dg0eByjAW1m0O38+oMguoLKRC/T
         s9zVhaIawSMhlsxObZ/J08tyjEfJWbD+Hmj9VWnbCGr7t23kteJSTuqJZNSFeG1DRkQ+
         c5wM4s2VYLG7vMSnohAP/Bqy6NkCGL3cbrNe+ggkBCOUxa7zIHpELT96fmR3MZP9wDLJ
         r3QkGtnNIgZFOjgqWVTVaG8fJUXQ/HIeqbXgyY4ZiimZZ+4CkuWcQ14Xj7JBTcEoneOd
         SwGXPfjZuCeec5/tQYe9wj2ccqIB1uAmG9eTS7SgVmrBGF8p6nNh2LOYTZiKFwmSRU/k
         30lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MZLYGTyIcU65t5L2uyp6Otqtskjo+juH9YbDeDOrWoQ=;
        b=MbBGSbuo3TTn2lWM7DNOVDdGfIUQDDU7zxHNMOxEi9Q7CwN0b4OlYQIzpLBCPHWG9w
         Ohp2/MvbyatcEhex15xUl8W45EpMWm+Hf9vcjRYDsiFf+YuvYiuutKn4nro3FiVlGpxT
         bPtXtczGtE4hCbMdnVHgITI+f1Et+eWXSbSRncbloTURUPLMGloQVfvKaWHcxvqoU6ey
         pirkeRTjNxq3gLl+s7sRAxVazbnVzsFw48KvtKXYUHWEKRgMicCw0DaNc/dxvYu3dYKh
         W9MqHcUDPPlglQnjlN3BiucnoeVaPSYi/nk8r17WnZPI45GKEFYdyl05WVcNec2sjbTp
         G+OA==
X-Gm-Message-State: APjAAAXCWmu2ZEvEoYVVIqk8sCOSwZUT2PpFYbedT5cxE90JUKo5UOi5
        yksV1SnpBNPA5VSgJpF8r2a6zQ==
X-Google-Smtp-Source: APXvYqyHeVE+PGHkoaUgjK/ZO4PctnMSdwN6Cw2za6u3NMAMmvxeQ7DeKjPAN0omhfrQEbdTmJs9BQ==
X-Received: by 2002:a2e:b0d0:: with SMTP id g16mr1460905ljl.132.1559208161804;
        Thu, 30 May 2019 02:22:41 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.85.229])
        by smtp.gmail.com with ESMTPSA id j5sm367557ljc.67.2019.05.30.02.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:22:41 -0700 (PDT)
Subject: Re: [PATCH] hooks: fix a missing-check bug in selinux_add_mnt_opt()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        ccross@android.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190530080602.GA3600@zhanggen-UX430UQ>
 <e92b727a-bf5f-669a-18d8-7518a248c04c@cogentembedded.com>
 <20190530091848.GA3499@zhanggen-UX430UQ>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <236195a3-b607-5cf6-ac60-8c5ea2e95b41@cogentembedded.com>
Date:   Thu, 30 May 2019 12:22:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530091848.GA3499@zhanggen-UX430UQ>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.2019 12:18, Gen Zhang wrote:

>> On 30.05.2019 11:06, Gen Zhang wrote:
>>
>>> In selinux_add_mnt_opt(), 'val' is allcoted by kmemdup_nul(). It returns
>>
>>     Allocated?

> Thanks for your reply, Sergei. I used 'allocated' because kmemdup_nul()
> does some allocation in its implementation. And its docs descrips:

    Describes?

> "Return: newly allocated copy of @s with NUL-termination or %NULL in
> case of error". I think it is proper to use 'allocated' here. But it
> could be 'assigned', which is better, right?

    I was only trying to point out the typos in this word. :-)

> Thanks
> Gen
>>
>>> NULL when fails. So 'val' should be checked.
>>>
>>> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>> [...]

MBR, Sergei
