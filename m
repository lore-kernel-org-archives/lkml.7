Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A04C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634520663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfCGCON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:14:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41006 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfCGCOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:14:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so10150525pfn.8;
        Wed, 06 Mar 2019 18:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dFcQUHAwUz1kBG0aYRd/AwmoFOVz0y0c3AHqYJXM+X4=;
        b=qgVBu12VWieebVYquSnin26l7es/R4xi8rIM8Pjkp8ZOjLsDj3ODy5Qs1BLvN9iWAf
         ggGxfvQ4z65iN9ZFNcwwr2t0+fEB9M393/Mdg/xoDiUao11cXyfYww/rimWKl2BQrljc
         ZFp4vrYMdzp0KuEkhr9hZDiWcbd7sYE/visUxAY/7GAKbIA03DsX34fi133tnlNKcxPn
         eAXZSYbniFikeYaLuCuGQv4pbol4OPJr6VWXtux7rn13QehJum1/tnUDhO34J7LwpTOI
         7OKuyoQDWQtUaODJezsLfYYgtfasBrEhWEEmbOchzZiW3EqX7369f6SC455tiwcVdbwB
         VyVA==
X-Gm-Message-State: APjAAAXFDbubr55tY1E7OO73IGVA2wAM/Fj9zXk8s6ntFWZ/Tx1g9Ab5
        xlADz47Q9G66TvlLfrwLkOQ=
X-Google-Smtp-Source: APXvYqwxqb+wT8GhTnjDMxEs5yHP2Wp0SfXs7bFajlFMIt82fSfiV3MfxqqerVc3ZTChlj2+ZL33eQ==
X-Received: by 2002:a63:8d42:: with SMTP id z63mr9277447pgd.414.1551924851199;
        Wed, 06 Mar 2019 18:14:11 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id p5sm4663841pfn.154.2019.03.06.18.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 18:14:10 -0800 (PST)
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
Date:   Wed, 6 Mar 2019 18:14:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307012417.GU1758@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 5:24 PM, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2019 at 05:01:53PM -0800, Bart Van Assche wrote:
>> This patch avoids that the following warning is reported when building
>> the mlx5 driver with W=1:
>>
>> drivers/infiniband/hw/mlx5/qp.c: In function set_user_rq_size:
>> ./include/linux/overflow.h:230:6: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>>     _s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;  \
>>        ^
>> drivers/infiniband/hw/mlx5/qp.c:5820:6: note: in expansion of macro check_shl_overflow
>>    if (check_shl_overflow(rwq->wqe_count, rwq->wqe_shift, &rwq->buf_size))
>>        ^~~~~~~~~~~~~~~~~~
>>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>> Cc: Leon Romanovsky <leonro@mellanox.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Fixes: 0c66847793d1 ("overflow.h: Add arithmetic shift helper") # v4.19
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>   include/linux/overflow.h | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>> index 40b48e2133cb..8afe0c0ada6f 100644
>> +++ b/include/linux/overflow.h
>> @@ -202,6 +202,24 @@
>>   
>>   #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
>>   
>> +/*
>> + * Evaluate a >= 0 without triggering a compiler warning if the type of a
>> + * is an unsigned type.
>> + */
>> +#define is_positive(a) ({					\
>> +	typeof(a) _minus_one = -1LL;				\
>> +	typeof((a) + 0U) _sign_mask = _minus_one > 0 ? 0 :	\
> 
> This is probably just is_signed_type(a)

Hi Jason,

I don't think that gcc accepts something like is_signed_type(typeof(a)) 
so I'm not sure that the is_signed_type() macro is useful in this context.

>> +				1ULL << (8 * sizeof(a) - 1);	\
>> +								\
>> +	((a) & _sign_mask) == 0;				\
>  
> This is the same sort of obfuscation that Leon was building, do you
> think the & is better than his ==, >  version?
> 
> Will gcc shortcircuit the warning if we write it as
> 
> (is_signed_type(a) && a < 0)
> 
> ?

I have tested this patch. With this patch applied no warnings are 
reported while building the mlx5 driver and the tests in 
lib/test_overflow.c pass.

Thanks,

Bart.
