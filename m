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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204DFECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9F921835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h34txVx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440703AbfJQRXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:23:46 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37177 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440691AbfJQRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:23:46 -0400
Received: by mail-yb1-f193.google.com with SMTP id z125so949112ybc.4;
        Thu, 17 Oct 2019 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g4SwHxHxwUtGIc9mmokYvDhJJMdlpqG1ecdzFzwqRlU=;
        b=h34txVx8ucMiFbmTWddJEkas2yAoXSC+13vmb2G7hCUvp4vaspUU8vFRYqLjm53tDo
         BDApU8qS7TCyQPBy07RCc5/bDa74S6v04Q8LOgEOGhepumRdKgO1ITXMm1KgGCQrxo9b
         iw3dQYbeGZjBnw3TBQBm4ZrhAyYpMQrSC5HLNOLSTynKQTH8Dm8zcrcj8+ouR5x89ybV
         8oKMZ5R+hZBRNAr/4ym7c6DLevjD9+tTVr1wXZ4GflQsIrxU/lS+JXUfL4AVfUJ7nlyO
         3EJ4Pm2O0/BU9eh5VWtHrP4FBu1J17eVgB9LLCCvOuxapGHx1A71n6QyKHVZ/87TItdb
         Glzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g4SwHxHxwUtGIc9mmokYvDhJJMdlpqG1ecdzFzwqRlU=;
        b=TTQoxDUubLwyGyDulhB08IjAtmK/vX6jc+Yw79cItd6YGXylUkw1S4ZqWOes6PL040
         lRSJoJdUiRTuoCGd/HFecKcva8r78iM8n2XVn9dcje0i83r/8bW1B+WdWd6D+8rX+48B
         hQMLuV/+eRwisANcIYkSOaAZWFtM7HfyKABkPUgWPQi7ENJwIJc3lxIbO3Yrky/sPbds
         B6nnZQZ2NEvRwaLK8beLt5X82sjT3PGV1ZEVYWz6L1oORhPTVYgraUFocv45y5tiXrhl
         TMSofkK9GVYNRfYvRNPJONx8/GHftUZVbC/aaKxNW0QU58XIIxa0a4UlddL9EWgV/cr4
         +szg==
X-Gm-Message-State: APjAAAWdC6rTTU4d2u0d3Q/J1RHc4LKx87J0eyqCFqgHvY46BC9nDkyj
        2qjeakI4CJ+EGLCEfLq8x4I=
X-Google-Smtp-Source: APXvYqz4/M/zkk0eMGkkmtOXHiC9/m0GHu5KKeC6Y5Iqeve3J9W6tXgs+D8krka7J8mVpWRhc+ApsA==
X-Received: by 2002:a25:da02:: with SMTP id n2mr2997587ybf.115.1571333025368;
        Thu, 17 Oct 2019 10:23:45 -0700 (PDT)
Received: from [192.168.1.62] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id l24sm658196ywh.108.2019.10.17.10.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 10:23:44 -0700 (PDT)
Subject: Re: [PATCH] libfdt: reduce the number of headers included from
 libfdt_env.h
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>
References: <20190617162123.24920-1-yamada.masahiro@socionext.com>
 <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com>
 <CAK7LNASMwqy0ZUZ=kTJ7MJ6OJNa=+vbj5444xzmubJ8+6vO=sg@mail.gmail.com>
 <CAK7LNAS=9yGqMQ9eoM4L0hhvuFRYhg6S4i6J3Ou9vcB1Npj4BQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <57c33deb-651b-3357-0e5a-95379be8a965@gmail.com>
Date:   Thu, 17 Oct 2019 12:23:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS=9yGqMQ9eoM4L0hhvuFRYhg6S4i6J3Ou9vcB1Npj4BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2019 06:01, Masahiro Yamada wrote:
> Hi Andrew,
> 
> Could you pick up this to akpm tree?
> https://lore.kernel.org/patchwork/patch/1089856/
> 
> I believe this is correct, and a good clean-up.
> 
> I pinged the DT maintainers, but they did not respond.

Sorry for the delay in responding.

libfdt_env.h is imported from an upstream project, using
the script scripts/dtc/update-dtc-source.sh.  Inside
that script are some 'sed' commands to modify the
imported files before committing them.  Please add
a sed command to make the change that the proposed
patch makes.

Thanks,

Frank

> 
> Thanks.
> 
> 
> 
> 
> On Mon, Aug 19, 2019 at 1:36 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> On Thu, Aug 1, 2019 at 11:30 AM Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>>
>>> On Tue, Jun 18, 2019 at 1:21 AM Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>>
>>>> Currently, libfdt_env.h includes <linux/kernel.h> just for INT_MAX.
>>>>
>>>> <linux/kernel.h> pulls in a lots of broat.
>>>>
>>>> Thanks to commit 54d50897d544 ("linux/kernel.h: split *_MAX and *_MIN
>>>> macros into <linux/limits.h>"), <linux/kernel.h> can be replaced with
>>>> <linux/limits.h>.
>>>>
>>>> This saves including dozens of headers.
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>
>>> ping?
>>
>> ping x2.
>>
>>
>>
>>
>>>
>>>
>>>>  include/linux/libfdt_env.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
>>>> index edb0f0c30904..2231eb855e8f 100644
>>>> --- a/include/linux/libfdt_env.h
>>>> +++ b/include/linux/libfdt_env.h
>>>> @@ -2,7 +2,7 @@
>>>>  #ifndef LIBFDT_ENV_H
>>>>  #define LIBFDT_ENV_H
>>>>
>>>> -#include <linux/kernel.h>      /* For INT_MAX */
>>>> +#include <linux/limits.h>      /* For INT_MAX */
>>>>  #include <linux/string.h>
>>>>
>>>>  #include <asm/byteorder.h>
>>>> --
>>>> 2.17.1
>>>>
>>>
>>>
>>> --
>>> Best Regards
>>> Masahiro Yamada
>>
>>
>>
>> --
>> Best Regards
>> Masahiro Yamada
> 
> 
> 

