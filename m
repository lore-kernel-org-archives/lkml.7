Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1F6C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B96120880
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mIXOWeDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgAGWdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:33:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38977 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgAGWdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:33:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so566998pfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 14:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRiS/kenaXg7SZmNLSxylaMfUm+yt4xVkhJf7MIsuM0=;
        b=mIXOWeDRssPm9xYaJbB0pMhXHGtyJ0N/bPkzg5r8WArlJeS1/EDmPmYz70Hz76BaU+
         nzLNyeMrGMVg4kUWmBqN+gEt87UhbdWjq20ICoROOgns0bWlKk62r51ll77NMcp9BSVT
         vO9x43Ti+Q6Mn3iy/0s/bIJfgh8gJVfQofsP2CpJ/Qsw0A2CI7FEVEcaRl93ppzmMhMZ
         FUauXclxBLmtmiu02d/5NQb+QzRennpCQ0wwPJ8PVADJwwWPNWBkiIy7y8B9YIVqVg7Y
         RhpFLREaAQrIfhm2x50bBHLig+mHGAT0as5l2rSyH7hMOcDUh85/CRTMKfgb5OdjvgWP
         HpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRiS/kenaXg7SZmNLSxylaMfUm+yt4xVkhJf7MIsuM0=;
        b=YqLs4M5njblanuCsSdNTHYzX8Rb3ftYwlXfxmp9uIpnIt1FoHB7K6IT3uKa+uzw2Tn
         7u26dKMvJ3eTvrh/JCSHzKWPT4Z3nhQZvAgbo4WH4i0D6RxQ73dvy9SyCCr6kHtANQY7
         KrUI+1lc7TOdt8a761BTxBR4J3zeOcT+vWdGCI7u8A3P5IQc7si37pt9EWO/nN9G/99W
         RFdlcbrb0ysHyG+1PaivJcW4U/AtieFdKNmm74vCWNIswlZgqRkHMPbhATcQc2008cqR
         Pfy+ovLovLIZitlL+a3JipxN7wewN/NLVJKx07WdjtQ7hRh2w5C3N7brCg6kjZ9E4KQq
         dLVg==
X-Gm-Message-State: APjAAAWdVAxBwS2rQc58vRfInXfH4HLjzbiO9d9a7DHCf21i5UHeIgEh
        KdqCQb3gs3m0ZJnU52+4g6p2mw==
X-Google-Smtp-Source: APXvYqzTmk/w38eM+QUnrT21lreh59E8q2tHSB3ZFcAdt0J7PzWOBdTeIkX/fbtcyO4DUtGwdAPMSg==
X-Received: by 2002:a63:fd10:: with SMTP id d16mr1810632pgh.177.1578436380843;
        Tue, 07 Jan 2020 14:33:00 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g22sm746358pgk.85.2020.01.07.14.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 14:33:00 -0800 (PST)
Subject: Re: [PATCH] block: fix splitting segments
To:     Ming Lei <ming.lei@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200107124708.GA20285@roeck-us.net> <20200107152339.GA23622@ming.t460p>
 <20200107181145.GA22076@roeck-us.net> <20200107223035.GA7505@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25ce5140-ee29-c32c-7f5e-b8c6da5c7e90@kernel.dk>
Date:   Tue, 7 Jan 2020 15:32:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107223035.GA7505@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 3:30 PM, Ming Lei wrote:
> On Tue, Jan 07, 2020 at 10:11:45AM -0800, Guenter Roeck wrote:
>> On Tue, Jan 07, 2020 at 11:23:39PM +0800, Ming Lei wrote:
>>> On Tue, Jan 07, 2020 at 04:47:08AM -0800, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> On Sun, Dec 29, 2019 at 10:32:30AM +0800, Ming Lei wrote:
>>>>> There are two issues in get_max_segment_size():
>>>>>
>>>>> 1) the default segment boudary mask is bypassed, and some devices still
>>>>> require segment to not cross the default 4G boundary
>>>>>
>>>>> 2) the segment start address isn't taken into account when checking
>>>>> segment boundary limit
>>>>>
>>>>> Fixes the two issues.
>>>>>
>>>>> Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>
>>>> This patch, pushed into mainline as "block: fix splitting segments on
>>>> boundary masks", results in the following crash when booting 'versatilepb'
>>>> in qemu from disk. Bisect log is attached. Detailed log is at
>>>> https://kerneltests.org/builders/qemu-arm-master/builds/1410/steps/qemubuildcommand/logs/stdio
>>>>
>>>> Guenter
>>>>
>>>> ---
>>>> Crash:
>>>>
>>>> kernel BUG at block/bio.c:1885!
>>>> Internal error: Oops - BUG: 0 [#1] ARM
>>>
>>> Please apply the following debug patch, and post the log.
>>>
>>
>> Here you are:
>>
>> max_sectors 2560 max_segs 96 max_seg_size 65536 mask ffffffff
>> c738da80: 8c80/0 2416 28672, 0
>>          total sectors 56
>>
>> (I replaced %p with %px).
>>
> 
> Please try the following patch and see if it makes a difference.
> If not, replace trace_printk with printk in previous debug patch,
> and apply the debug patch only & post the log.

If it is a 32-bit issue, then we should use a 64-bit type to make
this nicer than ULL. But it seems reasonable that it could be!

-- 
Jens Axboe

