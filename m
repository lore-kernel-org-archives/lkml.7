Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B78C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD94E206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lBi2qmPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388990AbfIPPTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:19:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36114 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfIPPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:19:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so39340716wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AaDpJ2vFVH83bqcz70+BN9/ikwFwkcl+68V0vnu32lQ=;
        b=lBi2qmPR3YES68If3/adPkQIQ1BvZGlcZ9ftg7/zrakEm2T6M+YWTCnQ4+0MqCFJWA
         1Zq9OqRYPyeV7NS7JhErH//fGFRtETc1wK4x3/ihhEqHA5kcAtpN649X3XOZm1Eo+k+M
         Y3ganHO7a104Jc8akm+55uO9fKd3foAowbeHAaJk7WPVmr5sLzhpfAsTf6Ikqi/5CGoG
         h3PMosW4sXU3XLmZZUbXIMglt0OQouB/Q8pExcofCZu4Cn7tvo8CzA11nJKHfCLTbTA8
         rW0D98rCrcSah6WybDuXOhQf2u0bh+XacntV+lHMwEaUciLtrrtkHjjlGSSYXDxwFbAz
         fQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AaDpJ2vFVH83bqcz70+BN9/ikwFwkcl+68V0vnu32lQ=;
        b=KYeDeBe586G+EAsJA+wlfRLs/lTGyll5UZFQ5lXd4BajWABT0ESZWdjC4ID3DaKvwG
         EkRWgEOLE+5Z6Fr0ov/ZOeI1hpBRSWuH7Ie4yO1Yq22mVZFSfOq5GYGCoYryU+MlArLH
         xUpMzzX69880sUv7IcFjT7zsY+Y4it5ww3WtvCCc1m6w7OBQcf8PutYglXqRfMg6bRMx
         zEJcW9e7WU7C/l9uWoyBJVCh3TxAVZ4SzEc22DnxQujNF0sIGqmryZ8o7//VwLO9RSx0
         uqCRhtL+u9YULqOUetlJwbnYniaquVeGxKAz+F6C+azNNHm+4rgYRvL7dsRZzP+I+b7q
         Cz3A==
X-Gm-Message-State: APjAAAVM3hsjJFwm+bSz2h19OCIOqmIqpKqhLJv6Mf6ik9DDaQsCJF4E
        vEXeQAmdj891B5u3Mhll0hrGOg==
X-Google-Smtp-Source: APXvYqwXYe4XoLQ4PTqw4QLTNqut8cuXqzbSkP8URRc18n5I92+rKVcKz7/zv4OrJheUEWRrgiDrsg==
X-Received: by 2002:a5d:4146:: with SMTP id c6mr233450wrq.205.1568647184551;
        Mon, 16 Sep 2019 08:19:44 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f18sm14362721wrv.38.2019.09.16.08.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:19:43 -0700 (PDT)
Subject: Re: [PATCH 8/9] select/restart_block: Convert poll's timeout to u64
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20190909102340.8592-1-dima@arista.com>
 <20190909102340.8592-9-dima@arista.com>
 <fd8bfb2bed23492cb5e6c43b10be6125@AcuMS.aculab.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <eacd2de1-5dfb-79f5-5706-9dd01fb23425@arista.com>
Date:   Mon, 16 Sep 2019 16:19:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fd8bfb2bed23492cb5e6c43b10be6125@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/19 2:07 PM, David Laight wrote:
> From: Dmitry Safonov
>> Sent: 09 September 2019 11:24
>>
>> All preparations have been done - now poll() can set u64 timeout in
>> restart_block. It allows to do the next step - unifying all timeouts in
>> restart_block and provide ptrace() API to read it.
>>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  fs/select.c                   | 27 +++++++--------------------
>>  include/linux/restart_block.h |  4 +---
>>  2 files changed, 8 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/select.c b/fs/select.c
>> index 4af88feaa2fe..ff2b9c4865cd 100644
>> --- a/fs/select.c
>> +++ b/fs/select.c
> ...
>> @@ -1037,16 +1030,10 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
>>  		struct restart_block *restart_block;
>>
>>  		restart_block = &current->restart_block;
>> -		restart_block->fn = do_restart_poll;
>> -		restart_block->poll.ufds = ufds;
>> -		restart_block->poll.nfds = nfds;
>> -
>> -		if (timeout_msecs >= 0) {
>> -			restart_block->poll.tv_sec = end_time.tv_sec;
>> -			restart_block->poll.tv_nsec = end_time.tv_nsec;
>> -			restart_block->poll.has_timeout = 1;
>> -		} else
>> -			restart_block->poll.has_timeout = 0;
>> +		restart_block->fn		= do_restart_poll;
>> +		restart_block->poll.ufds	= ufds;
>> +		restart_block->poll.nfds	= nfds;
>> +		restart_block->poll.timeout	= timeout;
> 
> What is all that whitespace for?

Aligned them with tabs just to make it look better.
I've no hard feelings about this - I can do it with spaces or drop the
align at all.

Thanks,
          Dmitry
