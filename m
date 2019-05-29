Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC50C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5618A20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HE9E00Ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfE2W5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:57:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40364 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfE2W5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:57:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so2598258pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ccsFrMe6KP8aiz8EyYKirxWsnxkvhC/brM0NiqqoSf0=;
        b=HE9E00EvJ7o8sB9u2IBisHlbg8URix/DMrkDq4JGbmITr2VrN3s9bocIka9bOjVbSx
         XKjZuu1jeBy8klRSNbkhUj+zTwSokHfMq6/fPdW1tvDTdY2Ln5FWZPl4jyJQhJoorS0U
         lBjyThtI+5+YK2Z8a1kGNCEIw0pUngfWmMtSyvmi7q28Dq4UoCwQudZDb3NmzCJAiZJo
         muuq+5j8JFJggBKvWWGN7lJHG48lfw8D5np8mpFEbC1mv4bWF6DdacLSkSQGpkkmadBw
         VUekQcV0HcvWDJbUqFIG4sU0Rkdxsb3Hy8yMvT9vosUtmEZTkCiN/qXLpMCiCOAWzhB3
         08fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ccsFrMe6KP8aiz8EyYKirxWsnxkvhC/brM0NiqqoSf0=;
        b=F7XRcbxKE3B7e8pQRiKIoIXYRo5ymHfiguzyH2rICZRRep0rFOGm0iWFOd2IvimWKx
         kA7hqVc0MAB2zJIQpRgjAfHIZtUngSsP7vNtuG4zwP70836zYsrwJVQuGPAt+GvxomNm
         EtWDWv5Mt+D/pmDLUEWjAp6qyNVQp21VQeTTXLy5YcTKJ3SQBt3bIF2yfG+gC5Ea+L48
         v7m2zslCAvfTYDRxw2O671qY3xlDnPeGB5QgCLQ0MB/1lDfQXscDfwINy6wDi1eztxCH
         KfFKPDsw/NGtRBi+6eZnpNbUmALuwZcDFamkbyuepAEkcOxmkKBqwQ6TzIcwrju6Y/3P
         ih4g==
X-Gm-Message-State: APjAAAW/Gn1M6Y7dtxqQFgDkSZzihVKwDYMR9Dg8r293vzHFgztL6rd0
        AtIzvyttHYjUY7jG8saQcH98h4X8wNkERg==
X-Google-Smtp-Source: APXvYqw6Z+KcPoaQ5yIAnQ055ieAIXfUyBwwmKI99T3gUkL7mzAPKw5N2QmTZmBFV/yvhC9n3STIcw==
X-Received: by 2002:a62:fb10:: with SMTP id x16mr162681pfm.112.1559170635534;
        Wed, 29 May 2019 15:57:15 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id r44sm532812pjb.13.2019.05.29.15.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 15:57:14 -0700 (PDT)
Subject: Re: [PATCH] mm/page_io: fix a crash in do_task_dead()
To:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>
Cc:     hch@lst.de, peterz@infradead.org, oleg@redhat.com,
        gkohli@codeaurora.org, mingo@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1559156813-30681-1-git-send-email-cai@lca.pw>
 <20190529154424.c0fe2758cf5af42ff258714a@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <73a24780-6760-926b-40be-7a31562704d8@kernel.dk>
Date:   Wed, 29 May 2019 16:57:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529154424.c0fe2758cf5af42ff258714a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 4:44 PM, Andrew Morton wrote:
> On Wed, 29 May 2019 15:06:53 -0400 Qian Cai <cai@lca.pw> wrote:
> 
>> The commit 0619317ff8ba ("block: add polled wakeup task helper")
>> replaced wake_up_process() with blk_wake_io_task() in
>> end_swap_bio_read() which triggers a crash when running heavy swapping
>> workloads.
>>
>> [T114538] kernel BUG at kernel/sched/core.c:3462!
>> [T114538] Process oom01 (pid: 114538, stack limit = 0x000000004f40e0c1)
>> [T114538] Call trace:
>> [T114538]  do_task_dead+0xf0/0xf8
>> [T114538]  do_exit+0xd5c/0x10fc
>> [T114538]  do_group_exit+0xf4/0x110
>> [T114538]  get_signal+0x280/0xdd8
>> [T114538]  do_notify_resume+0x720/0x968
>> [T114538]  work_pending+0x8/0x10
>>
>> This is because shortly after set_special_state(TASK_DEAD),
>> end_swap_bio_read() is called from an interrupt handler that revive the
>> task state to TASK_RUNNING causes __schedule() to return and trip the
>> BUG() later.
>>
>> [  C206] Call trace:
>> [  C206]  dump_backtrace+0x0/0x268
>> [  C206]  show_stack+0x20/0x2c
>> [  C206]  dump_stack+0xb4/0x108
>> [  C206]  blk_wake_io_task+0x7c/0x80
>> [  C206]  end_swap_bio_read+0x22c/0x31c
>> [  C206]  bio_endio+0x3d8/0x414
>> [  C206]  dec_pending+0x280/0x378 [dm_mod]
>> [  C206]  clone_endio+0x128/0x2ac [dm_mod]
>> [  C206]  bio_endio+0x3d8/0x414
>> [  C206]  blk_update_request+0x3ac/0x924
>> [  C206]  scsi_end_request+0x54/0x350
>> [  C206]  scsi_io_completion+0xf0/0x6f4
>> [  C206]  scsi_finish_command+0x214/0x228
>> [  C206]  scsi_softirq_done+0x170/0x1a4
>> [  C206]  blk_done_softirq+0x100/0x194
>> [  C206]  __do_softirq+0x350/0x790
>> [  C206]  irq_exit+0x200/0x26c
>> [  C206]  handle_IPI+0x2e8/0x514
>> [  C206]  gic_handle_irq+0x224/0x228
>> [  C206]  el1_irq+0xb8/0x140
>> [  C206]  _raw_spin_unlock_irqrestore+0x3c/0x74
>> [  C206]  do_task_dead+0x88/0xf8
>> [  C206]  do_exit+0xd5c/0x10fc
>> [  C206]  do_group_exit+0xf4/0x110
>> [  C206]  get_signal+0x280/0xdd8
>> [  C206]  do_notify_resume+0x720/0x968
>> [  C206]  work_pending+0x8/0x10
>>
>> Before the offensive commit, wake_up_process() will prevent this from
>> happening by taking the pi_lock and bail out immediately if TASK_DEAD is
>> set.
>>
>> if (!(p->state & TASK_NORMAL))
>> 	goto out;
> 
> Nice description, thanks.
> 
> And...  ouch.  blk_wake_io_task() is a scary thing - changing a task to
> TASK_RUNNING state from interrupt context.  I wonder whether the
> assumptions which that is making hold true in all situations even after
> this change.
> 
> Is polled block IO important enough for doing this stuff?

Andrew, you missed the improved patch, you were CC'ed on that one too
and I queued it up a few hours ago:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=6f3ead091fe2a8fb57a5996fe8b94237a896c6e9

Please drop this one.

>> Fixes: 0619317ff8ba ("block: add polled wakeup task helper")
> 
> That will be needing a cc:stable, no?

Also added that when I did.

-- 
Jens Axboe

