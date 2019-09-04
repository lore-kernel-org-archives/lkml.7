Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3250CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CDC21670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLktABIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfIDVkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:40:46 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:33359 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDVkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:40:46 -0400
Received: by mail-pg1-f171.google.com with SMTP id n190so161879pgn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=0MXlNdDRrqJRDTO11X2I0qzQabr7EuyoaDjlEW34sB0=;
        b=lLktABICp/dvvtoR977IgPSzkDXv4FGqn/UXm18OEzW4/3HhYg/BmIbVEJkyQYN2Ug
         u/jrBaW67FFBDe5RJ6c6c/jJWQHUe53l0qwGkkp72YDS8XB02+xGC6j13I9X4yZ0Gqhq
         /5EDhlLzBcgJ/j4QgPKhYwEdHDogbBDjowAsXbYMGMSGCnoryjDu8Lx+6I1S86yFaiZS
         V9EEbi7L0eFN2ZaVFA9dNOEJSCJEPKPJJMhAcqBKzQ1/vnLMlWl9vZW9RAwCfNtiphBy
         zMa/fg6MSD2SP921/BC2v9vUe3NKDMrrMXBIi5v3U7BGXcb/6N68Imvz46imZVO23unc
         20nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=0MXlNdDRrqJRDTO11X2I0qzQabr7EuyoaDjlEW34sB0=;
        b=kREKzd59gOxTr8cXrzwFxkBdO0gXlqqh9qBeMG1la33l+H4Fw8jzqPw6We/DkbVIPp
         nfnGp/yjgETVVPhGHtNB+3fdQV6NY6NnDrKXVvOD5e+BeZWH8MpUygxDS0HXFSa2O34K
         zEWb39gLujCc2dym/ZpzJWgXl24Y30TEdNs9caZcdLoUWmB5ChSTt1lNltfVhBjg3YWY
         Ykt+mbbiqXcCvy4DLKSL0z+GEM60cwUXbJff4EchkpXHLbyxjo5BKagYMY+bbkwEfgBA
         0OOAoQZwWLwpOqeZwfpyDOQpyitGm7VbNVIfy1i1ZbFVLeF/lH7gYh69R2HnKvozDNhi
         XrgQ==
X-Gm-Message-State: APjAAAVW7tHHe8kcVsFEcO4ztd/IJhG8GhwVb7LZTb5S1uMNA8dKVBah
        oNQ4Q9NhS8h7E7pJiHVcUQrDSw==
X-Google-Smtp-Source: APXvYqzgqxcDS/3kwLs9oS5rKLMFhs47ZSC86NAbK0PWE7yQUEFAd7iJ6VmtRJsrjqXK00DlDo3DBA==
X-Received: by 2002:a62:cf82:: with SMTP id b124mr28032810pfg.159.1567633245566;
        Wed, 04 Sep 2019 14:40:45 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b5sm17228pfp.38.2019.09.04.14.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:40:44 -0700 (PDT)
Date:   Wed, 4 Sep 2019 14:40:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
cc:     Peter Gonda <pgonda@google.com>, Jianxiong Gao <jxgao@google.com>,
        linux-kernel@vger.kernel.org
Subject: [bug] __blk_mq_run_hw_queue suspicious rcu usage
Message-ID: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, Jens, and Ming,

While booting a 5.2 SEV-enabled guest we have encountered the following 
WARNING that is followed up by a BUG because we are in atomic context 
while trying to call set_memory_decrypted:

 WARNING: suspicious RCU usage
 5.2.0 #1 Not tainted
 -----------------------------
 include/linux/rcupdate.h:266 Illegal context switch in RCU read-side critical section!
 
 other info that might help us debug this:
 
 
 rcu_scheduler_active = 2, debug_locks = 1
 3 locks held by kworker/0:1H/97:
  #0: 0000000016e1b654 ((wq_completion)kblockd){+.+.}, at: process_one_work+0x1b5/0x5e0
  #1: 00000000002674ff ((work_completion)(&(&hctx->run_work)->work)){+.+.}, at: process_one_work+0x1b5/0x5e0
  #2: 00000000addb6aba (rcu_read_lock){....}, at: hctx_lock+0x17/0xe0
 
 stack backtrace:
 CPU: 0 PID: 97 Comm: kworker/0:1H Not tainted 5.2.0 #1
 Workqueue: kblockd blk_mq_run_work_fn
 Call Trace:
  dump_stack+0x67/0x90
  ___might_sleep+0xfb/0x180
  _vm_unmap_aliases+0x3e/0x1f0
  __set_memory_enc_dec+0x7b/0x120
  dma_direct_alloc_pages+0xcc/0x100
  dma_pool_alloc+0xcf/0x1e0
  nvme_queue_rq+0x5fb/0x9f0
  blk_mq_dispatch_rq_list+0x350/0x5a0
  blk_mq_do_dispatch_sched+0x76/0x110
  blk_mq_sched_dispatch_requests+0x119/0x170
  __blk_mq_run_hw_queue+0x6c/0xf0
  process_one_work+0x23b/0x5e0
  worker_thread+0x3d/0x390
  kthread+0x121/0x140
  ret_from_fork+0x27/0x50

hctx_lock() in __blk_mq_run_hw_queue() takes rcu_read_lock or 
srcu_read_lock depending on BLK_MQ_F_BLOCKING.

dma_direct_alloc_pages() can then call set_memory_decrypted() which must 
be allowed to block.

Any ideas on how to address this?
