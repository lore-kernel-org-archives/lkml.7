Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7656AC28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1C52415A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w6GpgIMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfE2UcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:32:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55931 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfE2UcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:32:02 -0400
Received: by mail-it1-f196.google.com with SMTP id g24so6208860iti.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+j1iS5dNAudmx4UH+uWG9vQsSzXOCdgsKti/KKoA57M=;
        b=w6GpgIMW8hIiwXx5o1J3d7Bser43fI2PfRq0K2wMU1lyLzNumJpQ5ARAbG1NExEahG
         +u/bAFy+fgsAQ5mdxsV/A8D3Q8x06C7UcgnqOhvFt8P8wgiAnIW2AtzFcqn1zBnADeeQ
         zDf6UuxZHjjPhSEeVR3KG7+Sbqid7fm/w6HsESA8MxKMNUxgTo3xYVVRph1rJH7BXEFG
         TNh77ryxkOQavb/RKDOAdtBly2PZ7pSAre/+T7urveK81n5LKBvFLOlA4/NIX8ymG9om
         d9RCTtoayKgPCkQMN57R9yNDZA+qNkFwXTt2pzPYsTy7vk2oSepZXP1ql33H/vuJJlSU
         Ki9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+j1iS5dNAudmx4UH+uWG9vQsSzXOCdgsKti/KKoA57M=;
        b=ejj6n6ddsK0H0qbXqdfopbgUohsRBNyic7k2v2xIpWJ46Z5KkrLIbkTERbw4onbR3A
         Cht3AnmW0LzgWTp4bS6gTwJGpMgQvnozD8pURIOnb6+O9IFktOkBTpoSkUGgg78PXKsD
         DlzmYlM2jAsEwfscgbROEPll4nmNRdiuZHPrQsLTolFHJ0wGHhiCURmbP4FW3z9JmHLj
         h9M2pcw3xqziyYFxuS+/Ga12WrQQjuzMxOtvkChjIE48hBJ0tQrW4v70vzkkxOwrV/IP
         ilGnFpx4yqmhCUJxpGnRhsLAHzTPrGG837UWnPDc5irs0LN+7tzl3S41mYKqHxjuKO6h
         EJKw==
X-Gm-Message-State: APjAAAWgTYnNP96/4u7ldZKe3WxW92pyNZOQi2xjt1fEWAqJq1T+yiW+
        c+2JAdxGrYUGGGjiSKYireKWaIO0MpO+kQ==
X-Google-Smtp-Source: APXvYqy3RaoAImWLO3Q8NdcbbkYqij1DCbkDSj7fKDMoc5wdjPmduML0c53h9RnSe8d0KxuFcuKF+w==
X-Received: by 2002:a24:5252:: with SMTP id d79mr157943itb.14.1559161920322;
        Wed, 29 May 2019 13:32:00 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d71sm190824itc.18.2019.05.29.13.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:31:59 -0700 (PDT)
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, hch@lst.de, peterz@infradead.org,
        oleg@redhat.com, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1559161526-618-1-git-send-email-cai@lca.pw>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad24b8de-c1dc-f52a-06af-103ceda891a6@kernel.dk>
Date:   Wed, 29 May 2019 14:31:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559161526-618-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 2:25 PM, Qian Cai wrote:
> The commit 0619317ff8ba ("block: add polled wakeup task helper")
> replaced wake_up_process() with blk_wake_io_task() in
> end_swap_bio_read() which triggers a crash when running heavy swapping
> workloads.
> 
> [T114538] kernel BUG at kernel/sched/core.c:3462!
> [T114538] Process oom01 (pid: 114538, stack limit = 0x000000004f40e0c1)
> [T114538] Call trace:
> [T114538]  do_task_dead+0xf0/0xf8
> [T114538]  do_exit+0xd5c/0x10fc
> [T114538]  do_group_exit+0xf4/0x110
> [T114538]  get_signal+0x280/0xdd8
> [T114538]  do_notify_resume+0x720/0x968
> [T114538]  work_pending+0x8/0x10
> 
> This is because shortly after set_special_state(TASK_DEAD),
> end_swap_bio_read() is called from an interrupt handler that revive the
> task state to TASK_RUNNING causes __schedule() to return and trip the
> BUG() later.
> 
> [  C206] Call trace:
> [  C206]  dump_backtrace+0x0/0x268
> [  C206]  show_stack+0x20/0x2c
> [  C206]  dump_stack+0xb4/0x108
> [  C206]  blk_wake_io_task+0x7c/0x80
> [  C206]  end_swap_bio_read+0x22c/0x31c
> [  C206]  bio_endio+0x3d8/0x414
> [  C206]  dec_pending+0x280/0x378 [dm_mod]
> [  C206]  clone_endio+0x128/0x2ac [dm_mod]
> [  C206]  bio_endio+0x3d8/0x414
> [  C206]  blk_update_request+0x3ac/0x924
> [  C206]  scsi_end_request+0x54/0x350
> [  C206]  scsi_io_completion+0xf0/0x6f4
> [  C206]  scsi_finish_command+0x214/0x228
> [  C206]  scsi_softirq_done+0x170/0x1a4
> [  C206]  blk_done_softirq+0x100/0x194
> [  C206]  __do_softirq+0x350/0x790
> [  C206]  irq_exit+0x200/0x26c
> [  C206]  handle_IPI+0x2e8/0x514
> [  C206]  gic_handle_irq+0x224/0x228
> [  C206]  el1_irq+0xb8/0x140
> [  C206]  _raw_spin_unlock_irqrestore+0x3c/0x74
> [  C206]  do_task_dead+0x88/0xf8
> [  C206]  do_exit+0xd5c/0x10fc
> [  C206]  do_group_exit+0xf4/0x110
> [  C206]  get_signal+0x280/0xdd8
> [  C206]  do_notify_resume+0x720/0x968
> [  C206]  work_pending+0x8/0x10
> 
> Before the offensive commit, wake_up_process() will prevent this from
> happening by taking the pi_lock and bail out immediately if TASK_DEAD is
> set.
> 
> if (!(p->state & TASK_NORMAL))
> 	goto out;
> 
> Fix it by calling wake_up_process() if it is in a non-task context.

I like this one a lot better than the previous fix. Unless folks
object, I'll queue this up for 5.2, thanks.

-- 
Jens Axboe

