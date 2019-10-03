Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A26C47404
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5AD222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVAGDgYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfJCBRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:17:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46065 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJCBRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:17:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id q7so657625pgi.12;
        Wed, 02 Oct 2019 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tSZmlKH2BrNCoI7JYxGwdsP9mWHj0/GO7SJu9GifiBw=;
        b=IVAGDgYfR67IlFKtxR5jzwaTBrgZcj4TrbfjF3+hY6QxVbuXrnwaNCyTI8f7n3MX+J
         FAKjW2MNbaCVXm+ItAGpRLoNTnHqsqyEBkr+RIcOBCr/oVlejxRYgj6SaqV5euxDXBey
         6IbBvanUtoL/IsMO/86JS3FnRM0JkYY6U4wD886S0wYvWsI+lVDrrFR2FJJeVMTtyT8P
         9uHrYzeZELX2tU3f0ZoGYl6RixvFAlUCXqhcdb+oM4EJfUm0IZexQL882APGqWMuZRk/
         NzwGPhIKGeVQEtDB2D7MrGanh+442dOLHmMNKLqS/iEPCMgPzpmILB7INbBOzhEK6vJi
         0K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSZmlKH2BrNCoI7JYxGwdsP9mWHj0/GO7SJu9GifiBw=;
        b=aQBOm8Co/ts91BGv1pqdcuW/AKKN3x8E/Fsa1fPmHOj3jmPgBt6j197d4Xoh13V/y5
         CIymbkttxdziN/C2nKujaLVn3Nma8GLvUlnGzPKOoRa8BJxdrWQyOqbFemFvMF3seoIZ
         Sv7xZ0gz9EQMf7U4FoNI16bNZyvkFuuJddYYPiHIAzNwWwIkBy7kdlmJxnh19ry/q1cb
         rg8ecMphaclVCgZfQQTdAZHxj3eXq5T3xTxKxHXHPtUIpxMr+uOsF/YxtuAhddhhlYKF
         c5TAtm0UV2CExWm54SNwcXAAVDGydfmr5o4L6ikgfeio1WXTg7m75HxFI2PGVKMFaaO6
         BNpA==
X-Gm-Message-State: APjAAAWjtbRndKDSvfhY+Cy0gAtD02drN+JX4Ye2aTmpx0/Q9bLrqcin
        iIGsCMWAD6RjKbRbFa/W7BqrT020
X-Google-Smtp-Source: APXvYqwV9iAFUu0o3YMQ4v6zYNZassQaGttK3V+fHWMVMXXgoJ4dBGVmBgmZFv+B4H96JTtHtM/TXw==
X-Received: by 2002:a17:90a:1502:: with SMTP id l2mr7565357pja.140.1570065464619;
        Wed, 02 Oct 2019 18:17:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d20sm709584pfq.88.2019.10.02.18.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 18:17:42 -0700 (PDT)
Subject: Re: [PATCH v2] hwmon: (applesmc) fix UB and udelay overflow
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        jdelvare@suse.com,
        =?UTF-8?Q?Tomasz_Pawe=c5=82_Gajc?= <tpgxyz@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CAKwvOd=GVdHhsdHOMpuhEKkWMssW37keqX5c59+6fiEgLs+Q1g@mail.gmail.com>
 <20190924174728.201464-1-ndesaulniers@google.com>
 <a2e08779-e0ba-2711-9e0d-444d812c0182@roeck-us.net>
 <CAKwvOdnG6tTHHx5aL8oA3ta_mW24aZ37JX+=HQ9YphearL4DOg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bde955d5-bfd4-3e0c-ac45-b999ad1cc96b@roeck-us.net>
Date:   Wed, 2 Oct 2019 18:17:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnG6tTHHx5aL8oA3ta_mW24aZ37JX+=HQ9YphearL4DOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 2:43 PM, Nick Desaulniers wrote:
> On Mon, Sep 30, 2019 at 5:01 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Again, I fail to understand why waiting for a multiple of 20 seconds
>> under any circumstances would make any sense. Maybe the idea was
>> to divide us by 1000 before entering the second loop ?
> 
> Yes, that's very clearly a mistake of mine.
> 
>>
>> Looking into the code, there is no need to use udelay() in the first
>> place. It should be possible to replace the longer waits with
>> usleep_range(). Something like
>>
>>                  if (us < some_low_value)        // eg. 0x80
>>                          delay(us)
> 
> Did you mean udelay here?
> 
Yes

>>                  else
>>                          usleep_range(us, us * 2);
>>
>> should do, and at the same time prevent the system from turning
>> into a space heater.
> 
> The issue would persist with the above if udelay remains in a loop
> that gets fully unrolled.  That's while I "peel" the loop into two
> loops over different ranges with different bodies.
> 

Sorry, you lost me. If calls to udelay() with even small delay
parameters for some compiler-related reason no longer work, trying
to fix the problem with some odd driver code is most definitely not
a real solution.

> I think I should iterate in the first loop until the number of `us` is
> greater than 1000 (us per ms)(which is less of a magical constant and
> doesn't expose internal implementation details of udelay), then start
> the second loop (dividing us by 1000).  What do you think, Guenter?
> 

We should have no second loop, period.

Again, a hot delay loop of 128 ms (actually, more like 245 ms,
adding all delays together) is clearly wrong. Those udelay() calls
in the driver should really be replaced with usleep_range().

Guenter
