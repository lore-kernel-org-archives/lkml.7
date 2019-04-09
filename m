Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309BDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5FD20663
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cVoTyC8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfDIIIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:08:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37886 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfDIIIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:08:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so13601855ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Eit/w4NkCblkd4Zt520MbW+x9Fgtq9JEmsGvXZKi/TU=;
        b=cVoTyC8ISGBK8QKC1agMZzRhhwNk3WCSeoAkv0SfUwmWFX0jvJAi1E0bvki+JIHIMz
         NhVNulWcFHoglb0t4JUR75dLPkKZstVsryFTPpO4R0pxxGWTYsHpWDgyjv4rI/zitKcf
         GAopx27X75L10B8S4K75s+MUrHcwTDYgnDJr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eit/w4NkCblkd4Zt520MbW+x9Fgtq9JEmsGvXZKi/TU=;
        b=ilrIGujJANMqsR1vZQ90Y9J8n5l+oI0C44VqJMgd/VYiFNAB1bMKHBW+XjNVkNHIvU
         oK0vMAXRcgkP6+nnMsSGgA8yGO63MBA5a+qQSzYTyRw08IR9P0D0fKmWv7bTtVsfsGHc
         AK+g7LuZyypjzfpiwgI9pvvQNoUVWgfaUIe2t/x6VpWdf3teKpq/BXLoagYIdP5MqpmD
         3lznqXui8eMoEC3ruhxS4AoNoOustirYmMo3ThJVRgTAfk4kTYq6mmmharX40vbsqjeE
         fWriKe8EJCW0cbh9rKvq+ofJ3NORu+gJnW7TGIOnnOG5YMg8UcAOZUwBMCrUn72UcnS5
         0f+g==
X-Gm-Message-State: APjAAAU+2e5CbwnAFYZNanBZ+MW5tLcJiKPPSsF70rEHjmXIUcaOxcX0
        KgNmJcDA36iY0j0b6ZmsiwKRsQ==
X-Google-Smtp-Source: APXvYqyRGDZVvWc9b/9JQHPhqDhG7FRG2TVENG8x0vy/MAMwEtVLKCv23dPYLLzEWO1XO5r7AeQbzw==
X-Received: by 2002:a2e:4a09:: with SMTP id x9mr2403472lja.19.1554797300040;
        Tue, 09 Apr 2019 01:08:20 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r77sm6755216ljb.29.2019.04.09.01.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:08:19 -0700 (PDT)
Subject: Re: [PATCH v1 bitops] bitops: Fix UBSAN undefined behavior warning
 for rotation right
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        idosch@mellanox.com, Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <20190407125325.24440-1-vadimp@mellanox.com>
 <20190408155217.3f723554ae7fbcb34eeacb30@linux-foundation.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f38907e5-82a4-1e9f-a3a4-b4e366dbb90b@rasmusvillemoes.dk>
Date:   Tue, 9 Apr 2019 10:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408155217.3f723554ae7fbcb34eeacb30@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 00.52, Andrew Morton wrote:
> (resend, cc Andrey)
> 
> On Sun,  7 Apr 2019 12:53:25 +0000 Vadim Pasternak <vadimp@mellanox.com> wrote:
> 
>> The warning is caused by call to rorXX(), if the second parameters of
>> this function "shift" is zero. In such case UBSAN reports the warning
>> for the next expression: (word << (XX - shift), where XX is
>> 64, 32, 16, 8 for respectively ror64, ror32, ror16, ror8.
>> Fix adds validation of this parameter - in case it's equal zero, no
>> need to rotate, just original "word" is to be returned to caller.
>>
>> The UBSAN undefined behavior warning has been reported for call to
>> ror32():
>> [   11.426543] UBSAN: Undefined behaviour in ./include/linux/bitops.h:93:33
>> [   11.434045] shift exponent 32 is too large for 32-bit type 'unsigned int'
> 
> hm, do we care?
> 
>> ...
>>
> 
>> --- a/include/linux/bitops.h
>> +++ b/include/linux/bitops.h
>> @@ -70,6 +70,9 @@ static inline __u64 rol64(__u64 word, unsigned int shift)
>>   */
>>  static inline __u64 ror64(__u64 word, unsigned int shift)
>>  {
>> +	if (!shift)
>> +		return word;
>> +
>>  	return (word >> shift) | (word << (64 - shift));
>>  }
> 
> Is there any known architecture or compiler for which UL<<64 doesn't
> reliably produce zero?  Is there any prospect that this will become a
> problem in the future?

There's a somewhat obscure platform called x86 which ignores anything
but the low 5 bits in %ecx for a shift instruction for a 32 bit shift
(and in 64 bit mode, the low 6 bits), so there the instruction foo << 64
would yield foo. Which is also ok in this case, of course, except for
the formal UB.

Now, there are other architectures that behave similarly, so one could do

u32 ror32(u32 x, unsigned s)
{
	return (x >> (s&31)) | (x << ((32-s)&31));
}

to make the shifts always well-defined and also work as expected for s
>= 32... if only gcc recognized that the masking is redundant, so that
its "that's a ror" pattern detection could kick in. Unfortunately, it
seems that the above generates

   0:   89 f1                   mov    %esi,%ecx
   2:   89 f8                   mov    %edi,%eax
   4:   f7 d9                   neg    %ecx
   6:   d3 e0                   shl    %cl,%eax
   8:   89 f1                   mov    %esi,%ecx
   a:   d3 ef                   shr    %cl,%edi
   c:   09 f8                   or     %edi,%eax
   e:   c3                      retq

while without the masking one gets

  10:   89 f8                   mov    %edi,%eax
  12:   89 f1                   mov    %esi,%ecx
  14:   d3 c8                   ror    %cl,%eax
  16:   c3                      retq


Rasmus
