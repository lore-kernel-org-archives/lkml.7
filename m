Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9714EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6540B218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9utDyvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfCWEn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:43:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42035 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCWEn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:43:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so2828679pgh.9;
        Fri, 22 Mar 2019 21:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n6YMKIWqfFpj5Cq5WsET4CT+5yAJGLmN1iNB4F4+8GI=;
        b=K9utDyvmYd18GSC/ddvyHj+SALkX6CbjmO1L/iL+3TDA2fJKPTd32Sv/x74JqHY97y
         oCSEmS35Aq+zoKwsvCzF8I5EST+0H6blVAe+G/UN3fktXa70OOyT6pt6mtj0rZ7qCiRS
         o1Xi9Aurza8PAjBQUoFQD5xSX6jjQOFJw0TBTRO1ch8i2S0tSqQkuPXmtF0xe5xShEQV
         ZC3zD//pN6cSW/ypOg6e/UR4fKb9isPb1w9p2kpO/qsoauPnN4/geUa0YCZkrZpd5iRY
         5gMwQ033q2NJghJq777XZvb3BOQAh+2c/18qks7hHxgP8jpUuqCg2fdwnvQ9+cXHES46
         Fy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n6YMKIWqfFpj5Cq5WsET4CT+5yAJGLmN1iNB4F4+8GI=;
        b=kMCn5vCwiX9awNP51k0iXSiUw4ZkQrHWwR7M9UwbLJ4GFmzhtAVB+4aQFpU6TAJ/SM
         5tEh/kBZzndLOx7MVym6MMaLkGEy77fp3YnUi1XBfuma6XmMzYlOdZ0OhEvVWJXm3c0H
         LJkS5kDSgHTUDpVgiWS91SnvJXPfPRgTwst3nqFV4qKWrJJoHNrCZJV/nSXOv58RQoAN
         GpI0VYTmPXeLXOnDxwkkyYIQvCI4uWd546DKyCeDb5AO0bcBmOK/98cbX+GNC0rhTaX3
         K60/mabaZFhiA2lFs2oxMX/pcE7x1MBwAxddyC7UCLtlFXrs/lqizyVw3M/TOt0njmRn
         JQkQ==
X-Gm-Message-State: APjAAAVjeC/VSm67EJbqQHsLdnRQQAIvQsp+m7T8hJv8Tnc0t/C5Lfee
        8xqWRgQz8T69MxX7EPSItYQ6OiTt
X-Google-Smtp-Source: APXvYqwkzGxYVxJ1iPfxT6YXlb8wjMDvyxwUhqU97fO3gLQIGituyyo7Z7h/AXNpxf1OyluzAKvU8g==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1mr13388903plp.34.1553316207927;
        Fri, 22 Mar 2019 21:43:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h13sm12194342pfn.114.2019.03.22.21.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 21:43:27 -0700 (PDT)
Subject: Re: [PATCH 3.16 00/16] 3.16.64-rc1 review
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
References: <lsq.1553232017.771830163@decadent.org.uk>
 <917fab4a-f8b1-760c-2e7d-22156f580276@roeck-us.net>
Message-ID: <1152dd86-bb63-dd64-9a96-36588de82889@roeck-us.net>
Date:   Fri, 22 Mar 2019 21:43:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <917fab4a-f8b1-760c-2e7d-22156f580276@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 6:44 AM, Guenter Roeck wrote:
> On 3/21/19 10:20 PM, Ben Hutchings wrote:
>> This is the start of the stable review cycle for the 3.16.64 release.
>> There are 16 patches in this series, which will be posted as responses
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Mon Mar 25 18:00:00 UTC 2019.
>> Anything received after that time might be too late.
>>
> 
> Build results:
>      total: 137 pass: 136 fail: 1
> Failed builds:
>      i386:tools/perf
> Qemu test results:
>      total: 222 pass: 221 fail: 1
> Failed tests:
>      arm:midway:multi_v7_defconfig:mem2G:ecx-2000:initrd
> 
> The failed qemu test simply hangs. The test passes with v3.16.63.
> I started a bisect.
> 

False positive.

Sorry for the noise.

Guenter
