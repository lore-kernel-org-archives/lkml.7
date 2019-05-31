Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F4FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE69D26F31
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M6TMkH/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfEaVMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:12:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40381 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfEaVMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:12:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so6916250pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vDJef47SRIxwZUsIMJgjK6VVpboiCh9ge6fzV5aK/tc=;
        b=M6TMkH/V/9mT6dRs3J9b/JX5LzJWuFXwJmueAM3sFtd48jYZrEMxKZSv61IH/51s0a
         nBZAEcv60nMTWMfp4GQDDaqmB9pOQpAhc6Gg5T25v0x74DlyNydXHlrxtiS50ajmVpWg
         95Z/dxMhkgG+H4Gz67L0EKh6cK2k8iKq8odbqr31YkMCLCtJ2f2DQQFTQAHEdrETDDaL
         0oa/gJtEwSbqmF86SPddenJQcgV14RIcVDvmz66a6qkISFfQHbRsN9Lt8gS76lz66TSl
         yZrzWqJ7UAwcjk34iWYo1d6KQsFShDEbppxXU88JXpCKwek+zRC93Le8s1LeAPy/Wlaw
         7gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vDJef47SRIxwZUsIMJgjK6VVpboiCh9ge6fzV5aK/tc=;
        b=DSU8TvxMvNDv8d+OtCFi4a7PmMzbinC8RJ1BsuMH5Gqsu5bFuGSbZORAInokQuQb4j
         R5Oz0UoiDzdtPIbw4f0KhbzpPLvS7rsqQLOexVtGR/uPINKxS2ylYCepSTqoHuNfjuJv
         jNVADQ7JV/9cg7VIM1gFnX85uDL4j3EC/LFFrnz7MwUBr/pSnUo/dbhhnV2a39zWgNq3
         kDGoXYVp614HAuYAAbqlX8MmJ2lK+CFp8eXDqdRQ8bu/LXXOI9M0ldPzvCsbVB/Nc4GR
         EpvICP3gNH0B4lSeOMThCbVH4FszzHPtbzmzwV1DE5Y2awR722iO3EaCx3HUGzlYgvsL
         wi1Q==
X-Gm-Message-State: APjAAAXJXYItbTc2H9JaUm2Oeme5+2zCvC3zeOSyTcBp9TmX3tUsi4r4
        QYlTEoNB3c8TK19tVb7AjuC8WwV1GKL0CA==
X-Google-Smtp-Source: APXvYqzFrYv4eNgkP3NdKIFIT6J0jMYWieRpMIm6g5Q7gBVb0g3hjSNbYusIqUdd86VOSVu+kOlqQA==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr11512270pgp.56.1559337137443;
        Fri, 31 May 2019 14:12:17 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i7sm7285747pfo.19.2019.05.31.14.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 14:12:16 -0700 (PDT)
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
To:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, hch@lst.de, oleg@redhat.com,
        gkohli@codeaurora.org, mingo@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
Date:   Fri, 31 May 2019 15:12:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530080358.GG2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 2:03 AM, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 04:25:26PM -0400, Qian Cai wrote:
> 
>> Fixes: 0619317ff8ba ("block: add polled wakeup task helper")
> 
> What is the purpose of that patch ?! The Changelog doesn't mention any
> benefit or performance gain. So why not revert that?

Yeah that is actually pretty weak. There are substantial performance
gains for small IOs using this trick, the changelog should have
included those. I guess that was left on the list...

>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>   include/linux/blkdev.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 592669bcc536..290eb7528f54 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1803,7 +1803,7 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
>>   	 * that case, we don't need to signal a wakeup, it's enough to just
>>   	 * mark us as RUNNING.
>>   	 */
>> -	if (waiter == current)
>> +	if (waiter == current && in_task())
>>   		__set_current_state(TASK_RUNNING);
> 
> NAK, No that's broken too.
> 
> The right fix is something like:
> 
> 	if (waiter == current) {
> 		barrier();
> 		if (current->state & TASK_NORAL)
> 			__set_current_state(TASK_RUNNING);
> 	}
> 
> But even that is yuck to do outside of the scheduler code, as it looses
> tracepoints and stats.
> 
> So can we please just revert that original patch and start over -- if
> needed?

How about we just use your above approach? It looks fine to me (except
the obvious typo). I'd hate to give up this gain, in the realm of
fighting against stupid kernel offload solutions we need every cycle we
can get.

I know it's not super kosher, your patch, but I don't think it's that
bad hidden in a generic helper.

-- 
Jens Axboe

