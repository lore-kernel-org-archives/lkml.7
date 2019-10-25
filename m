Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8420DCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB8921D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qPW1lQp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395305AbfJYOFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:05:36 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:40657 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632763AbfJYN4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:56:04 -0400
Received: by mail-io1-f53.google.com with SMTP id p6so2494442iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DN/boTIWxa8MaNmxPDzQ/RzCmNnBTB12r1M0NQaPgf4=;
        b=qPW1lQp3D1B6cgueUqjGz5fEvkXdXC95H5/2b3GdD4rOqNskoNNTqIYmK3fpW90clN
         78dU+wproOmKEhQM1QINUK2U083V/y2XUJz1p7pX5PLnl6O2la3tGjUqLMa6+KAYf15q
         fszcDsr6ktdUB0QvIsSlMGCupeW0RZqbSP9X5tr3DSi/+fWhkSUnEJtwZ12xmwJAZl/X
         h8YmanVa+hHnZ5Xmziwc94S4QcKqODMMaD51Hv6UbpVKfnKWl0KAEohHyeowzQwzrChQ
         2DSVzANzDaQqD1a+jBl5pm28Npai9PVHdgWj5hzKy0RirFUxr62lnzwui3bk1sNF3zSy
         AU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DN/boTIWxa8MaNmxPDzQ/RzCmNnBTB12r1M0NQaPgf4=;
        b=UtYPuEkbPbm3FUhqrH9Ac93VyQg1P8KmD8kLW50wgLcMrnNg+QtlcuRtf0gi5ZoEe8
         QJHagEWuf58aeoqrwRGHh732J3bL9w7NGKEB0nR927BrSuWZqDqydae9syD9G1YdgUOX
         0BSjqXLw9XhCWP9e8tMgXNkpzpfIkxemsDcIcUonYR2kmpNhhHrtayVwwdwqRtWESFdm
         UXcNWJxX8CqwIlOP9DV3MnR7Tn+yXEEn8A4ySrVI8ot01Q9cwjveaCKU5RfmKDfAf/EL
         oDqSR3iHXalsIwrl2WZPr1SJNsSIgeMYtrK/hvM0Exfvjsuaa8IEOxE7Cp9rZHQ9GSPI
         3Ecw==
X-Gm-Message-State: APjAAAW3V7oFgA9M5qDtE04r9QJUAXJIgwUuq5VhmmqYE2i+svBV/0vZ
        GYoWZ6fFKH79xN9hhJl+9n42FjtQrxgymQ==
X-Google-Smtp-Source: APXvYqy6JeyOVDx2zUMS3zZ9Ddjo7Oa/bQ9LFZhInqkZ2QErefqQfJ9tx988Jl+EOGBObqtsgpgupA==
X-Received: by 2002:a6b:400e:: with SMTP id k14mr3818319ioa.254.1572011762416;
        Fri, 25 Oct 2019 06:56:02 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l23sm262266ion.76.2019.10.25.06.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 06:56:01 -0700 (PDT)
Subject: Re: [PATCH][next] io-wq: fix unintentional integer overflow on left
 shift
From:   Jens Axboe <axboe@kernel.dk>
To:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191025124315.21742-1-colin.king@canonical.com>
 <fc23061e-31ec-8a66-2b62-771121d182de@kernel.dk>
Message-ID: <02517010-9244-771f-d0ce-558bbebe6a63@kernel.dk>
Date:   Fri, 25 Oct 2019 07:56:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fc23061e-31ec-8a66-2b62-771121d182de@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 6:54 AM, Jens Axboe wrote:
> On 10/25/19 6:43 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Shifting the integer value 1U is evaluated with type unsigned int
>> using 32-bit arithmetic and then used in an expression that expects
>> a 64-bit value, so there is potentially an integer overflow. Fix this
>> by using the BIT_ULL macro to perform the shift and avoid the overflow.
> 
> Good catch, that should indeed have been 1ULL. I'll fold in your
> fix, thanks!

BTW, this missed the same issue on the clear side of it, in
io_worker_handle_work(). I've fixed that one up the same way.

-- 
Jens Axboe

