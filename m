Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D25C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E76216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="evgg/NUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbfG2WAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:00:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37537 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfG2WAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:00:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id i70so18178796pgd.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Z4e7eX8RQPe9vUaooI5ICKzcwt4GloFa186owymu9w=;
        b=evgg/NUaECZfWMgoopuUjqMgL3RIQnKnY+v1LdbrQnAp16/Qsiv9tYEU6iBOpd2igT
         sa8z84mWybDVIyTTmlTr+ziJJNla6OGi5MfVYcsmZzV4BAvm85G9AWfrNZXQsx5PEetg
         tCCjUuXVSeG6hdK4ltLvaG17c49KdMWWjKMYUEKngKgbNh6wUXkUuZ1Mj1mp0cwzoerj
         ae4rW1ihC7pOyWywGxGiS9SXAs41HjV4faGX8uKJ1w6GBG0GPKk7RcCwacWGwKYR9KLG
         2vF5KLTQ/E4thllFpeExE15i8fwI38jDkV8IReYs4T1gWG9L4C/Zm4Pr2Dk08on58wWK
         7IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Z4e7eX8RQPe9vUaooI5ICKzcwt4GloFa186owymu9w=;
        b=jOUCWmrnUGN8Zc6Q/2VtyhIOv5oXWLTquswV0huyYHp71kC6S417ijs3A3bLyJIjl6
         00y3F9nwJfkwIHHF/clDwD4TVVJMUSWJZV2ZBsnW4VFwCND0gwTUHRCA0EKDYY2q6XGx
         ztp4APCGRLuFkzsp+Q/WbMWo+pH6dV4Bz80M4XdiD/j0v1ufOa8DkRwgeq0gtmAGCPbu
         e9HY/Q0Foh+gbpiUcuvCc1lBVxLiAMsExC+Xhn4r9/kgvhhPpYgqIasIGC4q7vla44YF
         YZOXyqWrIlqR8Il/6x5OITfMNtoxUN0VQ+RI1KzzFhiEFkCOOSv7HKO+1HqZ6DanGK9x
         4YWQ==
X-Gm-Message-State: APjAAAUaWvEZOftYuqTh5ETBrki5OWnCrhMTX14AAeYxBMVOQPhMaxZG
        vhWZzRCdCi1JfVj8Y+iG1P0=
X-Google-Smtp-Source: APXvYqyfNcRSjrWVsZSzB3NBDcnt7QuGn/RJ0+xa66W4NnRQyERt4aBYwvHv0KEK3s30PtEkXU6xuQ==
X-Received: by 2002:a17:90a:fa12:: with SMTP id cm18mr113838295pjb.137.1564437611499;
        Mon, 29 Jul 2019 15:00:11 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v138sm71349403pfc.15.2019.07.29.15.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 15:00:10 -0700 (PDT)
Subject: Re: [PATCH v2] libata: zpodd: Fix small read overflow in
 zpodd_get_mech_type()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Tejun Heo <tj@kernel.org>
References: <201907291442.B9953EBED@keescook>
 <3e515b31-0779-4f65-debf-49e462f9cd25@kernel.dk>
 <CAKwvOdkRxJ6Vtm8CX1ZgDgzzAywSyx7Y-nNFn+tVPf35YQc2YQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c270cac-e946-bba8-03e7-633a7c9006e6@kernel.dk>
Date:   Mon, 29 Jul 2019 16:00:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkRxJ6Vtm8CX1ZgDgzzAywSyx7Y-nNFn+tVPf35YQc2YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 3:58 PM, Nick Desaulniers wrote:
> On Mon, Jul 29, 2019 at 2:55 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 7/29/19 3:47 PM, Kees Cook wrote:
>>> Jeffrin reported a KASAN issue:
>>>
>>>     BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
>>>     Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
>>>     ...
>>>     The buggy address belongs to the variable:
>>>       cdb.48319+0x0/0x40
>>>
>>> Much like commit 18c9a99bce2a ("libata: zpodd: small read overflow in
>>> eject_tray()"), this fixes a cdb[] buffer length, this time in
>>> zpodd_get_mech_type():
>>>
>>> We read from the cdb[] buffer in ata_exec_internal_sg(). It has to be
>>> ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.
>>
>> Applied, thanks.
> 
> Dropped my reviewed by tag. :(
> https://lkml.org/lkml/2019/7/22/865

I'll add it.

-- 
Jens Axboe

