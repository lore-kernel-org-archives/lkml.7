Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C491C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700822166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="x4Nmbn64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfH2Po1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:44:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41387 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfH2Po1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:44:27 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so7786065ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f1lRGiNGnAFYa5XXNIGTiXk0hopkLhl9sxqMWlR9OM8=;
        b=x4Nmbn64+hq2nIrU/XYjpm+rG4twyu8Blfcu+IlpzaB+RCSvvti9s0rDB4rNwnSO/g
         pscK8sz+ZlGHQ32SVq8nXpEkr+wi0AEpp8R5SS/jGGuER7Bg35kdcD89wMznt+l+gMQj
         Cqq8g1+duLsJ6kFQpnncA8lJ6BP1byilELhIgm89abTEAFHwyq+GLqm7SU1w2LzkcRRL
         c1uUtfuOyqjcpVGXM5ogwDAvyrzmeOS3kHv6gArmAvGD2+vLtl3cxAjZnEKJcPOmmUoI
         B0CudP+UUSDMcZvils9x3G9sxawpvVVEbHELbdl06bkK98bSuW0huJ11mp16jJ+40Rbd
         M8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f1lRGiNGnAFYa5XXNIGTiXk0hopkLhl9sxqMWlR9OM8=;
        b=WbZ9x78Yl3J3CIjWfkqc8zCVYitO0EoDvl7EW4xXac2Ykps4+FPrg8HPtJ6Qaa8XXB
         EE29YVtgISUHc40ybrjyM/RmFT+uFVVOLxWvpdqJBJXvc3aSQu52Dfh/uu70nqB1rOBK
         HwXF7E2cxNPJZYwErsjXvQ8Dk+HucaSYRvWorNYEBzfve5fgZbm2ngabAttgBv7CRQ6O
         qxOjmc7zCGos54lAiNVu2ZmX50M0jAhcOGStzse3g4j8zD5lYviLFzk/1fHNZFX+rzYM
         dcAKU4u2e5GZdOrUbc3j5dChrbrF8AuufkJwWTjOTFCnaDzAbZHL5OQPO9eqKuj5ZH7z
         nFeQ==
X-Gm-Message-State: APjAAAV69cE2GNfHAzSThd3br2CJC6+ma79E41QD92SepuczWwZ8x4wF
        DDkQKczETuOatESf4lRpKasIikioCGHqqg==
X-Google-Smtp-Source: APXvYqyagCG2rTj4wmQ6PRtEAJ+LqcEKmF5YRjVZwMhX2y+RIf651JoqU7qk3QI3G2Egt69TIKoYaw==
X-Received: by 2002:a5d:87c1:: with SMTP id q1mr8567565ios.291.1567093466029;
        Thu, 29 Aug 2019 08:44:26 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 80sm5740197iou.13.2019.08.29.08.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:44:25 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190829135150.4f0e533a@canb.auug.org.au>
 <20190829140828.39e05c27@canb.auug.org.au>
 <20190829154150.GS2263813@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf6b9cc0-1ae3-d10f-b5d5-7221b0e4a482@kernel.dk>
Date:   Thu, 29 Aug 2019 09:44:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829154150.GS2263813@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/19 9:41 AM, Tejun Heo wrote:
> On Thu, Aug 29, 2019 at 02:08:28PM +1000, Stephen Rothwell wrote:
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Thu, 29 Aug 2019 14:03:43 +1000
>> Subject: [PATCH] blkcg: blk-iocost: predeclare used structs
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 
>> ---
>>   include/trace/events/iocost.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
>> index ec2217dd57ac..7ecaa65b7106 100644
>> --- a/include/trace/events/iocost.h
>> +++ b/include/trace/events/iocost.h
>> @@ -2,6 +2,10 @@
>>   #undef TRACE_SYSTEM
>>   #define TRACE_SYSTEM iocost
>>   
>> +struct ioc;
>> +struct ioc_now;
>> +struct ioc_gq;
>> +
>>   #if !defined(_TRACE_BLK_IOCOST_H) || defined(TRACE_HEADER_MULTI_READ)
>>   #define _TRACE_BLK_IOCOST_H

Added, thanks.

-- 
Jens Axboe

