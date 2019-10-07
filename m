Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72F4ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984D0217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfJGJGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:06:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfJGJGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:06:09 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E136710A1B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 09:06:08 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w10so7227159wrl.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 02:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fBRIbgMq9EJ++XGIGImx8CYxss1cJwECLlupsXLpmYY=;
        b=kSgqFLFM0GzzrnzfWUMtl4PTdXm/Qf/pTiwg4OFRYu4IhUxUXk/XaOhUpU46tTyeRw
         jizpLcWOvaLbk4rjBCV7Ht2xizCbuDTzej53gUvlSb51r+iHADcKOMCEspyc0Pg8NW0y
         xFNu8z5mICtRwAhAum/TTP6Md545lwkfQ05/xq79gQNo1dyCS5ZGYjHZx7uzRrqmxgUZ
         pqVQSGh6s/78+FYq8qNHe+SkFaHJKut1koabGT/n46tsIce5Ysy4irm422QsLS85W39r
         bwwgqeInldUOQZ9JfEeAwovG7KEykxMyfWt9ncTW1dNK3AEBumudm5JnFsKn3ryt4Ivm
         6SsQ==
X-Gm-Message-State: APjAAAUp7OV9bI6GJa8gcc6Mj4gTrO6+uPCXZoz5CvSbyviPB52Yuo5o
        sCeWWpIU3SnKnZmfZqGb6nfOFOO73nzDPechaqS35eyG+u4731hQEc26wZfyNrvCjlXs92xLSO2
        bQPZi476dDXx/G/UswXd3UhQL
X-Received: by 2002:a1c:9e46:: with SMTP id h67mr19896518wme.48.1570439166279;
        Mon, 07 Oct 2019 02:06:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIB/mpa2f+0YDVQB+ZQ2wugqID9zQ0k8tNxBi2ZQC4pNdIS/WqtuyQ7J2IzdZR/nu3g5Y8dg==
X-Received: by 2002:a1c:9e46:: with SMTP id h67mr19896501wme.48.1570439166078;
        Mon, 07 Oct 2019 02:06:06 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id z5sm26075756wrs.54.2019.10.07.02.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 02:06:05 -0700 (PDT)
Subject: Re: [PATCH 5.4 regression fix] x86/boot: Provide memzero_explicit
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>
References: <20191007085501.23202-1-hdegoede@redhat.com>
 <65461301.CAtk0GNLiE@tauon.chronox.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <284b70dd-5575-fee4-109f-aa99fb73a434@redhat.com>
Date:   Mon, 7 Oct 2019 11:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <65461301.CAtk0GNLiE@tauon.chronox.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On 07-10-2019 10:59, Stephan Mueller wrote:
> Am Montag, 7. Oktober 2019, 10:55:01 CEST schrieb Hans de Goede:
> 
> Hi Hans,
> 
>> The purgatory code now uses the shared lib/crypto/sha256.c sha256
>> implementation. This needs memzero_explicit, implement this.
>>
>> Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
>> Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get
>> input, memzero_explicit") Signed-off-by: Hans de Goede
>> <hdegoede@redhat.com>
>> ---
>>   arch/x86/boot/compressed/string.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/boot/compressed/string.c
>> b/arch/x86/boot/compressed/string.c index 81fc1eaa3229..511332e279fe 100644
>> --- a/arch/x86/boot/compressed/string.c
>> +++ b/arch/x86/boot/compressed/string.c
>> @@ -50,6 +50,11 @@ void *memset(void *s, int c, size_t n)
>>   	return s;
>>   }
>>
>> +void memzero_explicit(void *s, size_t count)
>> +{
>> +	memset(s, 0, count);
> 
> May I ask how it is guaranteed that this memset is not optimized out by the
> compiler, e.g. for stack variables?

The function and the caller live in different compile units, so unless
LTO is used this cannot happen.

Also note that the previous purgatory private (vs shared) sha256 implementation had:

         /* Zeroize sensitive information. */
         memset(sctx, 0, sizeof(*sctx));

In the place where the new shared 256 code uses memzero_explicit() and the
new shared sha256 code is the only user of the arch/x86/boot/compressed/string.c
memzero_explicit() implementation.

With that all said I'm open to suggestions for improving this.

Regards,

Hans
