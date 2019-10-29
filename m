Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B204DCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886642087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgr0d/3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbfJ2ODA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:03:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40259 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfJ2ODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:03:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id r4so3986783pfl.7;
        Tue, 29 Oct 2019 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KN9MskQmflVnB4L2PhN33bbW9nU67D9GmEhihR64Dow=;
        b=Xgr0d/3KsmBYi0Vds45njbcN6sFqyATIR6A0Rp79dYlw9LqMyF8XJo5gS4UO2pGj8B
         cAVPkjM29SI/pGVsUrhsfm4h4LHuwhHwHFhFj4wARDJe3ePM2kD61b/c79s9Wpp3osBY
         epByIFRhKkZjIEq7YYTI1DsgVffhouIXEj6ZjIDWbZRoj3dBNK6vbVtTCWMF9lv2kFRI
         r5wIHKOHD8ewiV0n8zQYHvOPu1w+5A0YDKyZgRcizuFQWacBf8WWjR4UDqNIxeQkfgFG
         Rqg9qZlSVH4mSucMdHPlpubVb1ZSUHQKSBD/lT224rtUgrkksZK35JhCYXznykvSgXT4
         ERfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KN9MskQmflVnB4L2PhN33bbW9nU67D9GmEhihR64Dow=;
        b=pqfNrGNxoSKT22kFGUajQt9qEheqyBFzzc26egHS/iMfXljCrzpPCfCv/MYLzh+WQl
         grkosTtEal0EdmSa582AYwwz78ULhc9VyheJtWYTTs7QwGtWUKSdH4RD7ZB1XQfjlI3b
         H34HdAslTiPSXZXV5b2FZF9DgOVj6rgHPJuDBgmPv15c+tMAF57Dmkc4n9MRVy6+JXcm
         +CNwq5YxGPlYmdiCm0/S+rcICHXyL8kYYrD6uopRwJUvuP6S9Jla38QPsujat7PSq1B+
         0yGE4WMAgKdzI5WOmF5NZR0zd5jRY3eKaSkQ3Rtl+g4fsrjAOY9Swv5QvZdohNijt5tE
         tcyg==
X-Gm-Message-State: APjAAAX8H9C8EVDXkdLf3rBTdvL3qlRsl8fZkoxDvdh/XzDlnnOQwr3J
        QIFc43qEAqT32sgYSYCdkCPYr0aa
X-Google-Smtp-Source: APXvYqyOln2o9Ja2+yx0sK6SUz5OpkWA83Kv7lxXaoEByvKo5+Ca5UEnvQF4KFSOORIdHDvPSGRZtA==
X-Received: by 2002:a63:1b07:: with SMTP id b7mr27500421pgb.166.1572357779088;
        Tue, 29 Oct 2019 07:02:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z16sm6293023pge.55.2019.10.29.07.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 07:02:56 -0700 (PDT)
Subject: Re: [PATCH] lm75: add lm75b detection
To:     Jean Delvare <jdelvare@suse.de>, Rain Wang <Rain_Wang@Jabil.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20191026081049.GA16839@rainw-fedora28-jabil.corp.JABIL.ORG>
 <7a2ddf42-8bbe-59e0-dae8-85b184ea0da0@roeck-us.net>
 <20191028104618.5f21af38@endymion>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <82a0b331-daa0-af9a-a7d0-0f1b3246ea49@roeck-us.net>
Date:   Tue, 29 Oct 2019 07:02:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028104618.5f21af38@endymion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/19 2:46 AM, Jean Delvare wrote:
> On Sun, 27 Oct 2019 16:03:39 -0700, Guenter Roeck wrote:
>> On 10/26/19 1:10 AM, Rain Wang wrote:
>>> The National Semiconductor LM75B is very similar as the
>>> LM75A, but it has no ID byte register 7, and unused registers
>>> return 0xff rather than the last read value like LM75A.
> 
> Please send hwmon-related patches to the linux-hwmon list.
> 
>>> Signed-off-by: Rain Wang <rain_wang@jabil.com>
>>
>> I am quite hesitant to touch the detect function for this chip.
>> Each addition increases the risk for false positives. What is the
>> use case ?
> 
> I'm positively certain I don't want this. Ideally there should be no
> detection at all for device without ID registers. The only reason there
> are some occurrences of that is because there were no way to explicitly
> instantiate I2C devices back then, and we have left the detection in
> place to avoid perceived regressions. But today there are plenty of
> ways to explicitly instantiate your I2C devices so there are no excuses
> for more crappy detect functions. Ideally we would even get rid of
> existing ones at some point in the future.
> 
> This patch is bad anyway as it only changes the device name without
> implementing proper support for the LM75B.
> 
FWIW, I don't think there is anything to implement; I don't see any
differences in functionality.

I am much more concerned about weakening the already weak detection even further:
As written, each chip with register 0x07 != 0xa1 will be identified as LM75B.
Even if that was strengthened to actually check if the register value is 0xff,
we have no idea what other vendors might implement in those registers. it would
most certainly mis-identify LM75C as LM75B. Not that it really matters if
the chip _is_ a LM75C, but who knows if other chips fit that identification
pattern.

Overall, my suggestion is to add a small startup script to affected systems
to instantiate the chip directly, and avoid weakening the detect function.

Guenter
