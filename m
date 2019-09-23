Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B52C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DA0206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="s19vFEsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502265AbfIWTi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:38:28 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:46097 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfIWTi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:38:28 -0400
Received: by mail-pl1-f174.google.com with SMTP id q24so6908005plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=riBJUAnFgj9nDVI+i5Nb/om+rNkxXzEsRdcl+2egnO4=;
        b=s19vFEshxAW384piB/ezxkPFrjjo13YeQzWF9b9dbk7vhPuK6amZjiAprUOKGKulzy
         yXIjNkpzVOWZ9v7f+nSqJOGWNG/A8UlqcyzOiz2GG6BekJNXTU3gDTVIPxDHVX4PZQ6M
         Fg/AnN/Ig6SV3jwOioONtvHTgDNK9lzVDyB5IUVR+anl4me9busAYBKVPueDFmzF8XH9
         r4uDtyUitwNi/mzP0GNiwWmKnO+luk3lIzz8VeRTc6NgUyZ/IHA+og0kAHD9KiyvyhXx
         aLNA2J5lzu8v3WYkt+1a3yCw74DidaaAyZ337wSYXbOrFipS3JbDFPaZmpYmGRp+I1Mx
         8OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=riBJUAnFgj9nDVI+i5Nb/om+rNkxXzEsRdcl+2egnO4=;
        b=G2lR8n+VFM+qyN9Sxv7Dccst+qovnzzttPzjtE3Ml79EYM6x44kb7608w8U7dmhxqt
         /eEbCwC7ccVMsuBeWpG6b3hnYbZ4zXuN8coGdztcoCMZPgZQ7kZ882h/EAsh/qHfhWtp
         Wn3HbTgpALgZuhOxB9aTD4XVnyAW6j0EvGc+IXIwW9ZJuIBT0b54Kju4Jq2G2vsN93IU
         ZuVaxpZkTsxaxNOpYnb9Y3d+wPMBi25Itq5ZDWNhmU+oUEu536x6xuC7JXFV1t0M4zON
         FPkqRR8/JcN3BlEb+G8ok6dt/9sk5g9nI7/x4gtEPOHSEH04m4SD5RRKcuJKzLoCv1cs
         VTPQ==
X-Gm-Message-State: APjAAAUnsZe1YiypnqDfxEjt04RlkfDzWwZw/G+23lXHe1Z2+6aCVOkc
        cbScF1ktcXxTnxA6mFLTw1Fm4g==
X-Google-Smtp-Source: APXvYqxZF87yHJ5Xz3fYmOys+zaQo1oYbLk64QvbewX8GlJWL2gsgDdynRDgYaTLsrdYO/mfhhuXJw==
X-Received: by 2002:a17:902:7846:: with SMTP id e6mr1464546pln.136.1569267507352;
        Mon, 23 Sep 2019 12:38:27 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r186sm17219515pfr.40.2019.09.23.12.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 12:38:26 -0700 (PDT)
Subject: Re: Is congestion broken?
To:     Matthew Wilcox <willy@infradead.org>, Lin Feng <linf@wangsu.com>
Cc:     Michal Hocko <mhocko@kernel.org>, corbet@lwn.net,
        mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        keescook@chromium.org, mchehab+samsung@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20190917115824.16990-1-linf@wangsu.com>
 <20190917120646.GT29434@bombadil.infradead.org>
 <20190918123342.GF12770@dhcp22.suse.cz>
 <6ae57d3e-a3f4-a3db-5654-4ec6001941a9@wangsu.com>
 <20190919034949.GF9880@bombadil.infradead.org>
 <20190923111900.GH15392@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk>
Date:   Mon, 23 Sep 2019 13:38:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923111900.GH15392@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 5:19 AM, Matthew Wilcox wrote:
> 
> Ping Jens?
> 
> On Wed, Sep 18, 2019 at 08:49:49PM -0700, Matthew Wilcox wrote:
>> On Thu, Sep 19, 2019 at 10:33:10AM +0800, Lin Feng wrote:
>>> On 9/18/19 20:33, Michal Hocko wrote:
>>>> I absolutely agree here. From you changelog it is also not clear what is
>>>> the underlying problem. Both congestion_wait and wait_iff_congested
>>>> should wake up early if the congestion is handled. Is this not the case?
>>>
>>> For now I don't know why, codes seem should work as you said, maybe I need to
>>> trace more of the internals.
>>> But weird thing is that once I set the people-disliked-tunable iowait
>>> drop down instantly, this is contradictory to the code design.
>>
>> Yes, this is quite strange.  If setting a smaller timeout makes a
>> difference, that indicates we're not waking up soon enough.  I see
>> two possibilities; one is that a wakeup is missing somewhere -- ie the
>> conditions under which we call clear_wb_congested() are wrong.  Or we
>> need to wake up sooner.
>>
>> Umm.  We have clear_wb_congested() called from exactly one spot --
>> clear_bdi_congested().  That is only called from:
>>
>> drivers/block/pktcdvd.c
>> fs/ceph/addr.c
>> fs/fuse/control.c
>> fs/fuse/dev.c
>> fs/nfs/write.c
>>
>> Jens, is something supposed to be calling clear_bdi_congested() in the
>> block layer?  blk_clear_congested() used to exist until October 29th
>> last year.  Or is something else supposed to be waking up tasks that
>> are sleeping on congestion?

Congestion isn't there anymore. It was always broken as a concept imho,
since it was inherently racy. We used the old batching mechanism in the
legacy stack to signal it, and it only worked for some devices.

-- 
Jens Axboe

