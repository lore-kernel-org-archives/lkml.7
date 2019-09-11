Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33773C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006972085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fL/D7OGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfIKWXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:23:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38728 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfIKWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:23:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id d10so12259361pgo.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qromHROGHzTlsC/WWBIc0wK3SHAiGEj7/sh02xgyJfA=;
        b=fL/D7OGT3hg6ZbSy9k31tEMlyexTFo/vJMgGxHnlXpjbVwsNlbl/eZ16IfqxNLUnkF
         12rfCZgrU8Wv3rNJHflP8jGa0QAG66zT4tHdZOoTGtKJxdIfykuJbl1KqD2YEuM/0f36
         3wDR3qDI1aEP02sOaTe7gRk4AVtYZFmVPXQcBIcx4aHtaxSqtfqv0S91ZxdDaMvluEPM
         6kU5yF7rP1HOz/6MT2blFvov/2+UxBhE6rd09Aj9ZbV4FJ8kZjZu8OsuXfYSb2euGy+m
         2fiuKjg37rEiLS9B073m+KY9HsirvV1DDTuDg7kk41oKNbYrEbUf6KKXeZBiM3OrJHTq
         vcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qromHROGHzTlsC/WWBIc0wK3SHAiGEj7/sh02xgyJfA=;
        b=P0NIR2WpTGXLgIZFAsVJsSYQDCwHzORcXj26BE+a5TD3UHl7K+7dXYepCEU5tt0VYq
         bcY6WQWwZMlbP5A1wg7Q7mh3AZiHJ96qmxnKhADnphZFaQwzdS5+Vj6tsn8XGSTVB0X3
         pj09pNt3A+YrQGFnwQ3Am/obn5Ilh2QOVajL6wFAzbVnerqsP5sk5Mk/lngYCHlTDlGa
         R5Rhqr/UUtkiCZlH4ljndk83CyACDl9gjFMpsMSbCnsB0jHVkWyur6473Ams6HT3Dwla
         DZynjyxTzBEJsHTbYo6jyEGlcGAu6ZYTWL6Ez5tH2EbskTSpcpo8CjbU+IyBEbkiykTc
         OnBA==
X-Gm-Message-State: APjAAAXN3QomvmJtlOYvx+MlkYrZbDbZmxR405xhffNbLQhe6jSba1QU
        xhHdCskWtjpg9wrEqgto6nXfhQ==
X-Google-Smtp-Source: APXvYqzc743lzXnjTPp/VEzJzWirmx//opNHkRTia7oyO9PI6Yt0NZRtEGWasS6hpxhuqhXujLW33Q==
X-Received: by 2002:a63:f5d:: with SMTP id 29mr10003179pgp.434.1568240592167;
        Wed, 11 Sep 2019 15:23:12 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.160])
        by smtp.gmail.com with ESMTPSA id h4sm25163273pfg.159.2019.09.11.15.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 15:23:11 -0700 (PDT)
Subject: Re: [PATCH v2] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
References: <CAEJqkgjJEHmTT3N42BXkeb+2mDbteE1YwW25cgUpMk7A_sOWzg@mail.gmail.com>
 <6a47a06d-f8f1-1865-1919-5ede359d0b10@kernel.dk>
 <CAEJqkgguW183DsU+JUPcV193HtDXzVsyUa4JEgVKrhumYTzpAg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <856d3393-53c7-5c32-7c87-a682f6abc090@kernel.dk>
Date:   Wed, 11 Sep 2019 16:23:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgguW183DsU+JUPcV193HtDXzVsyUa4JEgVKrhumYTzpAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 4:18 PM, Gabriel C wrote:
> Am Mi., 11. Sept. 2019 um 23:33 Uhr schrieb Jens Axboe <axboe@kernel.dk>:
>>
>> On 9/11/19 3:21 PM, Gabriel C wrote:
>>>    Booting with default_ps_max_latency_us >6000 makes the device fail.
>>>    Also SUBNQN is NULL and gives a warning on each boot/resume.
>>>     $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
>>>       subnqn    : (null)
>>>
>>>    I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
>>>    To be sure is not a Laptop issue only, I tested the device on
>>>    my server board too with the same results.
>>>    ( with 2x,4x link on the board and 4x on a PCI-E card ).
>>>
>>>    Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
>>>    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>
>> For some reason your commit message is indented. Additionally, your
>> patch is whitespace damaged. So this won't apply anywhere.
> 
> Gmail hates me it seems. Sry but I don't have an proper setup on that
> box right now.
> My Laptop died and I try to fix the usual issue for new Laptops on
> this one right now.
> I uploaded the git patch, if you accept it like this. If not I will
> re-send as soon I fix
> this laptop and have git* and other things proper set up.

Use git send-email, it's trivial to use with gmail. That's what I use
and that works fine. If you use gmail (web) for kernel development,
you're going to have a really bad time.

-- 
Jens Axboe

