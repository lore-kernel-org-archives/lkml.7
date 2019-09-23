Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AF7C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB1A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RvF0xvcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502446AbfIWTv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:51:27 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:40938 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfIWTv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:51:27 -0400
Received: by mail-pl1-f175.google.com with SMTP id d22so6944922pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pvonEcCzxrOzVmnLLiSvnHsK/n4PyoTSVxNoNMSLtQE=;
        b=RvF0xvcBpWSY04xjtnau7M91nps87eOT9SCjg69WURxqqzzAigzyXdYDaAwRjtk0FP
         j9klXFbb/0n1Y5HHQNeaK2IAmYggBcZ/JBrpLJ5K3TR/Xes5gQ1UzfTAXA9McXNAfwjr
         iuT2swg4/dwxVxAxeTtGOPmjL3Pdk9gphmyfzYFHA6vSQemzitmbYjttIlCCf/KjXCUn
         Y2W2eCVhuu2Gjy4Cc1MJ9y9glWCB+2MqIsrm7ckXoFf23B4Yr3ugH2/VJzZRqHz1rHaa
         aGtHMBZ/qI+LDLnbSY7mkiBmu7Ocu+71Etz09XKWg+8/yilYpMiv3HSKARYKOloD/YCZ
         3xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pvonEcCzxrOzVmnLLiSvnHsK/n4PyoTSVxNoNMSLtQE=;
        b=API1QSr94WJlxKbc68FyO84/kZhO1Hd2jfKbYGtQhpMZm7AUDpa1UMPB4SSwk6cFO5
         Pz6zZu7GOY/ztKJKvaVx001W6d3awERjNUcWFUbvRkqyxnlORdBTwDNB++5AwR7Vwzri
         bgjpi3vP+9QNL+5R9xupDBrmQkcAbD7r2CGTdsENsd70NfkxrJdMacC+aVgs53gZkHDJ
         s8c9QMPhF6W1gHyUpYBQmtRemNpOp1svyHdw/34Rj4SqtXlZGQVsQpg7qPrFSw6OiQYc
         d3wyu5tme+vm1qF9wyk9PjgMwGQmhikmkRv2zIrBvquMeCKrgpbIaeaR3qloaO9WKwqo
         9yQw==
X-Gm-Message-State: APjAAAVBVs+yBZRIl/V5aGrqGZvASHUSAhAiFlt2MtV8rMF+/Q4b7m3M
        xIFSm6znL+9wnPeu1R83Wbn2VQ==
X-Google-Smtp-Source: APXvYqyBSU6OJVhkVbCaDlQ8RW9Dmt2OhhDjODmaRa7nHIphHO6r5fIvZNOhq7vN4Aeh5gaO6mDOlw==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr1405130plb.273.1569268284883;
        Mon, 23 Sep 2019 12:51:24 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c64sm21133426pfc.19.2019.09.23.12.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 12:51:24 -0700 (PDT)
Subject: Re: Is congestion broken?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Lin Feng <linf@wangsu.com>, Michal Hocko <mhocko@kernel.org>,
        corbet@lwn.net, mcgrof@kernel.org, akpm@linux-foundation.org,
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
 <45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk>
 <20190923194509.GC1855@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ce7975cd-6353-3f29-b52c-7a81b1d07caa@kernel.dk>
Date:   Mon, 23 Sep 2019 13:51:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923194509.GC1855@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 1:45 PM, Matthew Wilcox wrote:
> On Mon, Sep 23, 2019 at 01:38:23PM -0600, Jens Axboe wrote:
>> On 9/23/19 5:19 AM, Matthew Wilcox wrote:
>>>
>>> Ping Jens?
>>>
>>> On Wed, Sep 18, 2019 at 08:49:49PM -0700, Matthew Wilcox wrote:
>>>> On Thu, Sep 19, 2019 at 10:33:10AM +0800, Lin Feng wrote:
>>>>> On 9/18/19 20:33, Michal Hocko wrote:
>>>>>> I absolutely agree here. From you changelog it is also not clear what is
>>>>>> the underlying problem. Both congestion_wait and wait_iff_congested
>>>>>> should wake up early if the congestion is handled. Is this not the case?
>>>>>
>>>>> For now I don't know why, codes seem should work as you said, maybe I need to
>>>>> trace more of the internals.
>>>>> But weird thing is that once I set the people-disliked-tunable iowait
>>>>> drop down instantly, this is contradictory to the code design.
>>>>
>>>> Yes, this is quite strange.  If setting a smaller timeout makes a
>>>> difference, that indicates we're not waking up soon enough.  I see
>>>> two possibilities; one is that a wakeup is missing somewhere -- ie the
>>>> conditions under which we call clear_wb_congested() are wrong.  Or we
>>>> need to wake up sooner.
>>>>
>>>> Umm.  We have clear_wb_congested() called from exactly one spot --
>>>> clear_bdi_congested().  That is only called from:
>>>>
>>>> drivers/block/pktcdvd.c
>>>> fs/ceph/addr.c
>>>> fs/fuse/control.c
>>>> fs/fuse/dev.c
>>>> fs/nfs/write.c
>>>>
>>>> Jens, is something supposed to be calling clear_bdi_congested() in the
>>>> block layer?  blk_clear_congested() used to exist until October 29th
>>>> last year.  Or is something else supposed to be waking up tasks that
>>>> are sleeping on congestion?
>>
>> Congestion isn't there anymore. It was always broken as a concept imho,
>> since it was inherently racy. We used the old batching mechanism in the
>> legacy stack to signal it, and it only worked for some devices.
> 
> Umm.  OK.  Well, something that used to work is now broken.  So how

It didn't really...

> should we fix it?  Take a look at shrink_node() in mm/vmscan.c.  If we've
> submitted a lot of writes to a device, and overloaded it, we want to
> sleep until it's able to take more writes:
> 
>                  /*
>                   * Stall direct reclaim for IO completions if underlying BDIs
>                   * and node is congested. Allow kswapd to continue until it
>                   * starts encountering unqueued dirty pages or cycling through
>                   * the LRU too quickly.
>                   */
>                  if (!sc->hibernation_mode && !current_is_kswapd() &&
>                     current_may_throttle() && pgdat_memcg_congested(pgdat, root))
>                          wait_iff_congested(BLK_RW_ASYNC, HZ/10);
> 
> With a standard block device, that now sleeps until the timeout (100ms)
> expires, which is far too long for a modern SSD but is probably tuned
> just right for some legacy piece of spinning rust (or indeed a modern
> USB stick).  How would the block layer like to indicate to the mm layer
> "I am too busy, please let the device work for a bit"?

Maybe base the sleep on the bdi write speed? We can't feasibly tell you
if something is congested. It used to sort of work on things like sata
drives, since we'd get congested when we hit the queue limit and that
wasn't THAT far off with reality. Didn't work on SCSI with higher queue
depths, and certainly doesn't work on NVMe where most devices have very
deep queues.

Or we can have something that does "sleep until X requests/MB have been
flushed", something that the vm would actively call. Combined with a
timeout as well, probably.

For the vm case above, it's further complicated by it being global
state. I think you'd be better off just making the delay smaller.  100ms
is an eternity, and 10ms wakeups isn't going to cause any major issues
in terms of CPU usage. If we're calling the above wait_iff_congested(),
it better because we're otherwise SOL.

-- 
Jens Axboe

