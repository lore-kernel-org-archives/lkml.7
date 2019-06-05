Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3696EC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBF0206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oERv5R43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfFEPEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:04:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38909 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFEPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:04:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so9804923plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4r0N0/cqZQsQLzB9riNWHtGeoqNPwixp4EIavL99nJ8=;
        b=oERv5R43tdTVogKDqW2pbdEh9X3kPQEt8rkO9i+PyA1hnJj546cBlYXzqcNAnkeH2o
         xDmAZeAaD3jnQjr0VGd/3yJeW9/U0/CoKmRqtd40ETtm22bSXsBnOuB32EKuu31MPb91
         ZSIW51BWmFZMHfkABF4+vmPS6bIFLD3LSrnjCSMx6330KEtzZiRV2rAVVXuuu5u6ZNF3
         54Qq+ZfFN/F7mWNAP2jok++5M9n9LfGsg48fbCOmIs1bUlM0G9Lx/jcF9KRHn8EseCjE
         5m7W7V2GXw5p0rXmC+VRWhzHmSy5HHyIgphZ1oqomuWKlWHVxlDyDSRiGqUbPO44zi0Z
         IlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4r0N0/cqZQsQLzB9riNWHtGeoqNPwixp4EIavL99nJ8=;
        b=JnQAkuwZox6VSYE+E5+cxz0tGyEnHC0TR4ASbgMhCbOFxkg//ap6pAm7kDEW1Z66dG
         znnkLwLDPO8doAuvU3TAzoyl1DLmCCMfuG2jwP2EHL0l/PSkekNJhFRlXPPFrO9PlPfO
         0KGpcezwa7pj4gsieJmjOAQvRDNymK6rqN204QDwzpH7B96OU7KC6dnTJgr8E6DFm73W
         Uu4C/mAg0Zs6jb/d+UAhxdOF5eAGi1YjRe524G2xKQS6hkQRUk2lCsET1B2eD6rliBU/
         oMcZk48QKpZn9/S0W4DlFO+V17gq1Wwr8M7vseI+KIgJrxIBbdCLpAw+Ec878GYrz5TC
         F/sg==
X-Gm-Message-State: APjAAAWp9ZqnQVETdRNlWih4WxrXm4YeWMOtloQYKhGet0SRj4CKqGBq
        ZwNp5Eb6CVzkww7HODrxoMiiRg1M5pfAxw==
X-Google-Smtp-Source: APXvYqzBM2bZj69n7MfkaSXw8zh+DTZMgfwk0BMgMehP81PBePSCTHmM2EpXvogAFZyH4IQcEXIAvw==
X-Received: by 2002:a17:902:b905:: with SMTP id bf5mr44544164plb.155.1559747050554;
        Wed, 05 Jun 2019 08:04:10 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k1sm4864237pjp.2.2019.06.05.08.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:04:03 -0700 (PDT)
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, hch@lst.de,
        oleg@redhat.com, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
Date:   Wed, 5 Jun 2019 09:04:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603123705.GB3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 6:37 AM, Peter Zijlstra wrote:
> On Fri, May 31, 2019 at 03:12:13PM -0600, Jens Axboe wrote:
>> On 5/30/19 2:03 AM, Peter Zijlstra wrote:
> 
>>> What is the purpose of that patch ?! The Changelog doesn't mention any
>>> benefit or performance gain. So why not revert that?
>>
>> Yeah that is actually pretty weak. There are substantial performance
>> gains for small IOs using this trick, the changelog should have
>> included those. I guess that was left on the list...
> 
> OK. I've looked at the try_to_wake_up() path for these exact
> conditions and we're certainly sub-optimal there, and I think we can put
> much of this special case in there. Please see below.
> 
>> I know it's not super kosher, your patch, but I don't think it's that
>> bad hidden in a generic helper.
> 
> How about the thing that Oleg proposed? That is, not set a waiter when
> we know the loop is polling? That would avoid the need for this
> alltogether, it would also avoid any set_current_state() on the wait
> side of things.
> 
> Anyway, Oleg, do you see anything blatantly buggered with this patch?
> 
> (the stats were already dodgy for rq-stats, this patch makes them dodgy
> for task-stats too)

Tested this patch, looks good to me. Made the trace change to make it
compile, and also moved the cpu = task_cpu() assignment earlier to
avoid uninitialized use of that variable.

How about the following plan - if folks are happy with this sched patch,
we can queue it up for 5.3. Once that is in, I'll kill the block change
that special cases the polled task wakeup. For 5.2, we go with Oleg's
patch for the swap case.

-- 
Jens Axboe

