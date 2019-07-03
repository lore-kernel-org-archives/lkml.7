Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5DDC06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5042189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dUVSYtdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGCRwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:52:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45490 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCRwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:52:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so1620628plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i2FMup8JP34BQXzcr9NEGjQytjFqnsavOY77a6JHYaA=;
        b=dUVSYtdqvWELrPwprF7PYmxJuQYJfr5zHCfcdHK7MgUCxdXIXE18mQZPha2oRFSboJ
         2JEuUzcRHXZwBNiPsfZ9HGt3oTgDxGniKiXECcXsuVdz07s1ejOJszha3vET9ucNUbWq
         AvQzJ7mBbieplSHs4iJzW0FoDL4dqAQ4a1okp57VswvSJQcK3FyxSJIATJdEz8wukAZ8
         slAtOY9mEGCOOPV7czTI9hT9OOdDUqcorfqMJDCCPHyGuqvslWC2JvingwTnF4oy79V2
         ACKpMHg3MXJzpARMp0eZILX8/q34GzbiDovr20Azud577yPDY4XlSltW0Py2NEsssb+L
         tiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i2FMup8JP34BQXzcr9NEGjQytjFqnsavOY77a6JHYaA=;
        b=NvtG5TL6x5ZfHEUwgM/P34SF4G41eiHzivDmvAZIknelzQWstMoCeeSBI9uwPFt+Ss
         6QF21CM+wkDZru70BWAAvm+FUQb0Hj8D8ijlX+BPuKgkHvmCJQ/OnOzAHRARxuDyr1Ye
         M8g8rsr84lYUZHRb/u7FaO3aeCcDvxmS91gxg7btlvosz6Bf/NjMNndjaWSotpS7kmwf
         gznKxdNWhtz+f4381WpiuRi0U19yhuZ6Wi6J/T3nOPtoNzxratdY4Xjb2os/yxPJb49m
         MlohHagwjLw+Ch57bvC3rW/w+dwBT2KvdhrIwqPZbsWDlGjIBqR1LiQHvUifHJfUx6mR
         t6Aw==
X-Gm-Message-State: APjAAAUUyT83+svh2MDGd19mz/5c7JgZWry/Wy5Cb2vr64kmhQnqpw+s
        KeC66KFWcldTmS9baCpC7VqUP1Lx+fiwGg==
X-Google-Smtp-Source: APXvYqy8BByQqGDcL3JfHMPSKyTFXUsjXfOB5EQTLI+UaM5WG4+T7r6FSEVp5tAO6P3kSH3FLSjJiA==
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr44400466plo.211.1562176348809;
        Wed, 03 Jul 2019 10:52:28 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id l31sm6823400pgm.63.2019.07.03.10.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 10:52:27 -0700 (PDT)
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
To:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        hch@lst.de, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
 <alpine.LSU.2.11.1906301542410.1105@eggly.anvils>
 <97d2f5cc-fe98-f28e-86ce-6fbdeb8b67bd@kernel.dk>
 <20190702150615.1dfbbc2345c1c8f4d2a235c0@linux-foundation.org>
 <20190703173546.GB21672@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c2596766-4b9c-9e84-b13e-efec3fe4d3f7@kernel.dk>
Date:   Wed, 3 Jul 2019 11:52:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703173546.GB21672@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/19 11:35 AM, Oleg Nesterov wrote:
> On 07/02, Andrew Morton wrote:
> 
>> On Mon, 1 Jul 2019 08:22:32 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> Andrew, can you queue Oleg's patch for 5.2? You can also add my:
>>>
>>> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>>
>> Sure.  Although things are a bit of a mess.  Oleg, can we please have a
>> clean resend with signoffs and acks, etc?
> 
> OK, will do tomorrow. This cleanup can be improved, we can avoid get/put_task_struct
> altogether, but need to recheck.

I'd just send it again as-is. We're removing the blk wakeup special case
anyway for 5.3.

-- 
Jens Axboe

