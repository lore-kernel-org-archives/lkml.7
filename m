Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCD3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A7E20818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxZ0DuLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDKMou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:44:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35565 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:44:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so3485696pgf.2;
        Thu, 11 Apr 2019 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZCs5u5VnlqfwDCZ4HxTCsq0J822J/J91sR95fvRC9Vc=;
        b=QxZ0DuLUY8MjYAmCW3X/FiV5QBEMKs3dyHgIcAcPaMrlFpVQUt932NkctnFvsnY1X6
         IQ5JzU4q4Rs+DbsWJlb/mLKXQ1xOZxlonvgMfh+TlAWBSbsoo8n/vwRni2nWSs3dEdvK
         1baS4S0Z46kkXUcHHYEef9tPatsUt+zqUZnTTsliPTpFlpkrRz7/qYE/YUsOLHcq3TRG
         hJP291K7D6VzY/fYpioPDFz7frqW/xrpKrLrImxfwDg0EfSgqz59Epe2c4v6Q3LFOUFQ
         iOBL9+edoGfrr/1l8Lpa37P6P7XLpCwT5ght0uqQ3TPoRya8IDoXD3Kx6LfLRr5yN9dN
         as0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZCs5u5VnlqfwDCZ4HxTCsq0J822J/J91sR95fvRC9Vc=;
        b=BJNKQF/dZhr+PrhsIlHkn0NFM87MCAWdeKvajjkPvvpzv93VjEY97170lI4dPU537X
         HZZKhIMr9wVPXMTysV1HyTbkBLQRKlmNQVrQ//Qee6b/pGrIGsw4ndlHqgXkN6CRBmRf
         ELUs4avaKz3eJyxkNWxlt//bSvqCR8dKDigiajLF1+ZdgbAUhPERGzHLhEe4NgQihtpo
         T3b9az6cuqN8Tg7FpH4yM8Yj7RCU0hHgNq7m5iLHDCDk+JnEoLXzlxJKKXjbRbCXgU8G
         ssU+ceBeBiyg7OLxvGnhygJeJ0r9hB8dctteb5uUcvqTM7sGy05jpv1sGXv2UL0bkneh
         mSvg==
X-Gm-Message-State: APjAAAV3Rf4SLnDQ2rtmoji32V61xiKRwQ4IPgqiwzBNQVqcbQWgmdzT
        5eXbqPR90bVLGaD/g/9ydA6Qe4TI
X-Google-Smtp-Source: APXvYqzfx47/Sb3gEazOf+RBw5QCeOdBgjXMl2CCL9H6wLofI/APYeQdyoKK1Wt66PxFChbLql+zDg==
X-Received: by 2002:a63:c84c:: with SMTP id l12mr46905501pgi.287.1554986689371;
        Thu, 11 Apr 2019 05:44:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y23sm55575200pfn.25.2019.04.11.05.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:44:48 -0700 (PDT)
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <155416000985.9540.14182958463813560577.stgit@noble.brown>
 <155416006521.9540.5662092375167065834.stgit@noble.brown>
 <20190410193418.GA32402@roeck-us.net>
 <87r2a9xt79.fsf@notabene.neil.brown.name>
 <87lg0hxe67.fsf@notabene.neil.brown.name>
 <87imvlxcxc.fsf@notabene.neil.brown.name>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5aaaf7c9-0d1c-f058-f841-917fcb61d955@roeck-us.net>
Date:   Thu, 11 Apr 2019 05:44:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87imvlxcxc.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 11:40 PM, NeilBrown wrote:
> On Thu, Apr 11 2019, NeilBrown wrote:
> 
>> On Thu, Apr 11 2019, NeilBrown wrote:
>>
>>> On Wed, Apr 10 2019, Guenter Roeck wrote:
>>>
>>>> Hi,
>>>>
>> .....
>>>>
>>>> This patch causes my qemu q800 boot test to crash reliably.
>>>>
>> ....
>>>> Code: 4a89 6604 4280 60ea 2c2b 000c 2748 000c <2869> 000c 082c 0003 0002 6728 4878 0014 7620 4873 3800 486e ffec 4eb9 002e 5b88
>>>
>>> Thanks for testing and for the report.
>> .....
>>>
>>> .... and after googling a bit I see that 68000 require 2-byte alignment,
>>> but not 4-byte.  Oh..
>>>
>>> That means there aren't two spare bits in an address, so I cannot use
>>> one for the NULLS and one for a lock bit.  Bother.
>>>
>>> I might be able to find a different way forward, but for now I think we
>>> need to drop this series.
>>
>> I have found a way forward that I like.  It only requires one bit per
>> address to be over-loaded.
>>
>> The following patch implements it and works for me.
>> Could you please confirm that it fixes your problem on m68k ??
> 
> Sorry, that was on the wrong base.
> 
> Please try this one, against current net-next.
> 

First of all, excellent analysis!

With this patch applied:

Build reference: next-20190410-1-ge294005789ed

Building mcf5208evb:m5208:m5208evb_defconfig:initrd ... running .... passed
Building q800:m68040:mac_defconfig:initrd ... running .... passed
Building q800:m68040:mac_defconfig:rootfs ... running .... passed


I also reconfirmed the crash with next-20190410.

With that, feel free to add:

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
