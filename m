Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC6ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8D920867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfJGOLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:11:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbfJGOLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:11:55 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B8358553B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 14:11:54 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s25so3379647wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dds3OvwkpQnHLh7gK9rCz/VJSlfyc8rH9MYu6DcxntY=;
        b=DxFG2cLkmpwoHWJb9X0AZUjna+Mxc8//oeaPTfr/PADQIKoznwFNUSSjic4r6O9cBg
         axzO012tmtfviCTUWfyYhJkBEfuM+3OHhSR4fLf7exEkd+kxkoY1i3MoMI1xBvGdB/yj
         MTApmnZl9pS7FtGPgHdQlUOAs9DsBism/16BFLURV2xYt/ODs9v2OvIJ/jHRRlSM2687
         u1MgyXsZ0Wkeig0iHb5NDKkTXH0xHjiHqFHmSjlFdZhGxFVZNxh67VYS8ba6U5yRQ/wF
         5Gub0SABtmcv6BhN0FnEjS1ddu0ROvEgaFVOeyKmwo+Q44GCEYO86Yv7d/qTMadeA+Db
         ihHg==
X-Gm-Message-State: APjAAAUAf/rqZrZ37ujxPtthyLbCd0vJmBIqISk5DO1PLR3Q1EdHhmak
        uYqJuiQ15Gi1VsfHA/hukh+z/NVCdjDQVZg+nXklsrSwwJtNpekdJc0VbcBYr62/ghwbZgnjJbU
        G/Rs7eK3umkL+ldBtJb9hdHE8
X-Received: by 2002:a1c:7fcc:: with SMTP id a195mr21312089wmd.27.1570457513304;
        Mon, 07 Oct 2019 07:11:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYTyoIwPzDW4aRJHwHWLwU6T2w5yp141GiuUdu7dnGllLKuK8ivHmCc/bBrlABqUO0g39JMA==
X-Received: by 2002:a1c:7fcc:: with SMTP id a195mr21312068wmd.27.1570457513112;
        Mon, 07 Oct 2019 07:11:53 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id z125sm28609038wme.37.2019.10.07.07.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:11:52 -0700 (PDT)
Subject: Re: [PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Stephan Mueller <smueller@chronox.de>
References: <20191007134724.4019-1-hdegoede@redhat.com>
 <20191007140022.GA29008@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1dc3c53d-785e-f9a4-1b4c-3374c94ae0a7@redhat.com>
Date:   Mon, 7 Oct 2019 16:11:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007140022.GA29008@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-10-2019 16:00, Ingo Molnar wrote:
> 
> * Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> The purgatory code now uses the shared lib/crypto/sha256.c sha256
>> implementation. This needs memzero_explicit, implement this.
>>
>> Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
>> Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Add barrier_data() call after the memset, making the function really
>>    explicit. Using barrier_data() works fine in the purgatory (build)
>>    environment.
>> ---
>>   arch/x86/boot/compressed/string.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
>> index 81fc1eaa3229..654a7164a702 100644
>> --- a/arch/x86/boot/compressed/string.c
>> +++ b/arch/x86/boot/compressed/string.c
>> @@ -50,6 +50,12 @@ void *memset(void *s, int c, size_t n)
>>   	return s;
>>   }
>>   
>> +void memzero_explicit(void *s, size_t count)
>> +{
>> +	memset(s, 0, count);
>> +	barrier_data(s);
>> +}
> 
> So the barrier_data() is only there to keep LTO from optimizing out the
> seemingly unused function?

I believe that Stephan Mueller (who suggested adding the barrier)
was also worried about people using this as an example for other
"explicit" functions which actually might get inlined.

This is not so much about protecting against LTO as it is against
protecting against inlining, which in this case boils down to the
same thing. Also this change makes the arch/x86/boot/compressed/string.c
and lib/string.c versions identical which seems like a good thing to me
(except for the code duplication part of it).

But I agree a comment would be good, how about:

void memzero_explicit(void *s, size_t count)
{
	memset(s, 0, count);
	/* Avoid the memset getting optimized away if we ever get inlined */
	barrier_data(s);
}

?

Regards,

Hans
