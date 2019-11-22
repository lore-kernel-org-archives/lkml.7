Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F69C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E4520707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tDUTxm8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKVTJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:09:18 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:32972 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfKVTJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:09:18 -0500
Received: by mail-il1-f193.google.com with SMTP id y16so389301iln.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 11:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DOCK+6WxJDwJCu7vsybHbWscysPdbKKXNyZNo+L4M5E=;
        b=tDUTxm8k09/6nKUoonMkeRC3xoHYns2IJ0puK0Ivfig4go4qPq9RS575RpGmwvlsgp
         S5o8dQvshaTp0DYs4GC8/8xswR/vdXTNZ9DZHt7lUXkcvYA43W6FYPSWMEYOUtosu4Fc
         bFxPDaJKEk+iX8tLu5k+me+En3AZ19/nkTyeOz0uLM/YT5HI5tej3eATwLo7vdsvhY29
         TOcr8XRvLhJAhO/PmWb0AHA/i+4qklOMxWReYsDgnsrusqkXAJcayeKqi/8i/spmNY5G
         +xlH4pCf79qBXJdVMFJwyXfJaujbMDsi57G0qb42EmYSoDaSPVuFGELlyLgOxJD9sRT0
         HJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DOCK+6WxJDwJCu7vsybHbWscysPdbKKXNyZNo+L4M5E=;
        b=jyvpKx8LXNgwTE95VbBFVKOhWURawSFxNeUJcX0b1mM7dD6sxrLgiCxuJBy0DoiqZS
         2y47Y506zQho5hwyxTBwJEVk2tUGA9NsuMwSCXAGiYf3SKeqjmHkLZjC/6+3JIk+TuC+
         7SHHBSmf5V/JrQG83cdYaEvlPSZt3c0E7mr9paJkl9BKmYEILxKfx+TyEi9/WxkY0Qbq
         s2dFUqJ2kQ6LxdnhjItJJTZlgkGnsXs7zMjx688gIpQZ1a7J43b4SZbg2ScKyO/brRuD
         9Xp7X7qW9M7p99Gyg3MfXzrIStOyoGTKcuTsKrzqb5GE17Zzw+N5GdoA7AmZuQ8xZnyx
         u+tg==
X-Gm-Message-State: APjAAAW6HgKQpy27jZPtnbNOUIxJyvg3OLLKU3m/eeDhQoKQKqdZ2KfR
        gEdEMNFq5IeEssl43Vu9nFW/APl8ZU1CNQ==
X-Google-Smtp-Source: APXvYqzeVAaG7s6dU+b45QldZWAxzgDdqcWVeffhI9sbJGd8FrXhO2litKgzEV1J/LChGDJTbS6oSg==
X-Received: by 2002:a92:1b49:: with SMTP id b70mr17872727ilb.180.1574449756698;
        Fri, 22 Nov 2019 11:09:16 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h15sm3172651ilh.85.2019.11.22.11.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 11:09:15 -0800 (PST)
Subject: Re: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
To:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180824211535.GA22251@beast> <201911221052.0FDE1A1@keescook>
 <20191122190707.GA2136@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <94976fb5-12d3-557d-7f31-347d6116b18c@kernel.dk>
Date:   Fri, 22 Nov 2019 12:09:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191122190707.GA2136@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/19 12:07 PM, Christoph Hellwig wrote:
> On Fri, Nov 22, 2019 at 10:53:22AM -0800, Kees Cook wrote:
>> Friendly ping! I keep tripping over this. Can this please get applied so
>> we can silence syzbot and avoid needless WARNs? :)
> 
> What call stack reaches this?  Upper layers should never submit a write
> bio on a read-only queue, and we need to fix that in the upper layer.

It's an fsync, the trace is here:

https://syzkaller.appspot.com/x/log.txt?x=159503d2e00000

-- 
Jens Axboe

