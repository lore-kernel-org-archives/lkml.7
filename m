Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56204ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C0820815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ghk4OsGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbfJAOJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:09:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45307 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbfJAOJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:09:24 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so48174296iot.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RatxRyirkC/4rfNMMyrhD+loNoE95qLYi7XTzhLkh0=;
        b=Ghk4OsGG6Oz7tZ5M6eRx1P6XEdLbmrF2aEY6vccsaJberBmlyClMkjTnCDUvfgSoy8
         oNi1eKeNRo3+bYcSn0gvIlsZKya2riDbF2MmiNMpb7tr9rGA5cB4bFPRVNLp4ol9yMiW
         QOU8U5m+QQemvlzF+O/n94HQ8AEX+KydRPxZLaXLyFrOhBDD0qb8JoT7+7HaiAsuSv5X
         3yeuYt/vsr2NBT/WYeEUw/mYX2/5yk5mfMBYthUynDq3HY2i1hMmJq87rszhxXsnTUL4
         vfcatmG2SXm3yADHfu0rFgwrswiTFriyhC9Ak6WlppWNDCzwuRW1URjT03nKqaIGOZ8v
         YlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RatxRyirkC/4rfNMMyrhD+loNoE95qLYi7XTzhLkh0=;
        b=h9mihGuWcOUeEziixrHXOWX0EcMqfbJ9NECWK5MoLsqzZ1CkQAybNqzZ54djWaKCXN
         bW840re4xoAOVjBBfLPDLN5s+LZ+FOiPT+feICHi/lVcedGn2j65Vs+r13G9Eoj2ckej
         WQw2DwXI1nvrlZPGDOo3XUwqQv8U1xbPNnTZLUqGvHSYRnk9H7befVkimcPnVP3FSUWd
         7L/SLwYWNiG/KFtDL1t2/NHZ8Ty4H21sWo2JAaSCgVC66czJeXb3YXxXIxPPubE9mIEE
         KzBPly2iNlpCd/ulMatHsGbz+KAR3KAnQvpGEHvo6dAqZR/aOhG3LnB91abcyH2SPJAf
         culQ==
X-Gm-Message-State: APjAAAVXhS0u4BZJzNtYcjy/rDrLnCpe49BP1xrdMuaG/z4kYfueJe97
        5O0a7M6KifW5QFzJf5g2kp/gUZiKAaYM8Q==
X-Google-Smtp-Source: APXvYqwIU8KTZ8E+y38iJxYiNYbx3DqPrbV92LcVOROG8LhAavzL5GtuetwG67KAKXV7C4rnKXRPBw==
X-Received: by 2002:a92:6507:: with SMTP id z7mr23935789ilb.191.1569938961846;
        Tue, 01 Oct 2019 07:09:21 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b7sm7177343iod.42.2019.10.01.07.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 07:09:20 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190930202055.1748710-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
Date:   Tue, 1 Oct 2019 08:09:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930202055.1748710-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 2:20 PM, Arnd Bergmann wrote:
> All system calls use struct __kernel_timespec instead of the old struct
> timespec, but this one was just added with the old-style ABI. Change it
> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
> the need for compat handlers on 32-bit architectures.
> 
> Any user space caller will have to use __kernel_timespec now, but this
> is unambiguous and works for any C library regardless of the time_t
> definition. A nicer way to specify the timeout would have been a less
> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
> change that as this would impact both 32-bit and 64-bit users.

Thanks for catching that, Arnd. Applied.

-- 
Jens Axboe

