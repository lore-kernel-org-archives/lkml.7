Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780B6C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4372F20820
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569287201;
	bh=MZsQhhuRGcS97XGINQPk3TBqee6+7XKPTNL9WWEWBhY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1vM6RyQO9R3lUwJRLigpllDFwNf+skQ8FgrYFEUkscOhVrjRbewqeToYgTjrV6Lcu
	 wKPqGGiJcStNvClvVSUABmqWKsXmv+iTyoyMzSrmP0S0a/cKla9ndvd7mhhOVwHm4A
	 M5asS9i+UnIe86E5Id9SC7b/ExJOv8x+CF/cQknU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503800AbfIXBGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:06:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42741 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392131AbfIXBGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:06:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so173064qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6DGshTg/RMbL5O9kzlRUE9xMe5D6/chfzSidGhJCLUY=;
        b=fRNFBI3znk2eSlVtM+9P2CHvI2nbGZHR8wzd9rhIHEXgfbR2xXmQjrKKToBAGW0FwT
         1Y/T2mqCmgLj8kgB4NwnMKdw8z2VRBl1ZZDQHNChNLxOaCewl8/g3eJHWGIBzpG0uzm4
         Kj4f3ag8sccnEGEyK2TLreT+GXZB4TN3Vp4dyr4pd1RrTeOXsMho2Yk2KFHgFqDgUglv
         VZYMdcY2lnxmT9eCThj7f3oSwVdXhAMyQQM84rGKN8d0RUR+hSWy4KO3IGkPvMKiZ0Os
         OX7wMuOy8wPBCCAlLWtz4+uWLUGGSVOAgTFepHAzqqhuTp6a+uv/zYvuPHlhKZtHvhX9
         cE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=6DGshTg/RMbL5O9kzlRUE9xMe5D6/chfzSidGhJCLUY=;
        b=KmINo/pFsXzMoOOaJuY+vWxndhaVoC2QlBu+pbgKJ8K5qA0HKvPQfolSAFc/3uEqwW
         LBjD6BwLw44zxP7Pqwz+LuUziAQRMp7lwfZKMOeXfeNVBJVQJvtDboOOHadjqi7OFpUh
         37k6I2jwjxWoqkm82CElu7uqRaASPIt9mKmZFrXlfeP/M5cCXyReP4q670aUeWA7iF7q
         XhoY7PcFM5WA67V8RSRWYyMM8KBCp5WCkm9MoqBPYFsE8muwp4V1cMttj8Cc1C99lKIG
         SKxfeufN3q2O7EgIX6XKKRz42Yj8PPme2c0gY1oNk9i0yTdSiPE70NKAo+bgifa8esvl
         EvSA==
X-Gm-Message-State: APjAAAUw09cvI1y9ttJeoiRJpLgyQOOeiMTjRMXu3vtfQ3l2CzqztOxB
        rZVQrdIeYKeOFKZuSmC4i5dh43/vnjU=
X-Google-Smtp-Source: APXvYqwyJjQcYBAybizwpkS6SzD/rQ/6BPTGNIaL6BVjH7KAYcufcKuiAXv5I2PlqkaxLRUkptru3Q==
X-Received: by 2002:ac8:4597:: with SMTP id l23mr332247qtn.284.1569287198141;
        Mon, 23 Sep 2019 18:06:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::737b])
        by smtp.gmail.com with ESMTPSA id d23sm49884qkc.127.2019.09.23.18.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 18:06:37 -0700 (PDT)
Date:   Mon, 23 Sep 2019 18:06:31 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] writeback: fix use-after-free in finish_writeback_work()
Message-ID: <20190924010631.GH2233839@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

finish_writeback_work() reads @done->waitq after decrementing
@done->cnt.  However, once @done->cnt reaches zero, @done may be freed
(from stack) at any moment and @done->waitq can contain something
unrelated by the time finish_writeback_work() tries to read it.  This
led to the following crash.

  "BUG: kernel NULL pointer dereference, address: 0000000000000002"
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
  CPU: 40 PID: 555153 Comm: kworker/u98:50 Kdump: loaded Not tainted
  ...
  Workqueue: writeback wb_workfn (flush-btrfs-1)
  RIP: 0010:_raw_spin_lock_irqsave+0x10/0x30
  Code: 48 89 d8 5b c3 e8 50 db 6b ff eb f4 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 9c 5b fa 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 05 48 89 d8 5b c3 89 c6 e8 fe ca 6b ff eb f2 66 90
  RSP: 0018:ffffc90049b27d98 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 0000000000000246 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: 0000000000000003 RDI: 0000000000000002
  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
  R10: ffff889fff407600 R11: ffff88ba9395d740 R12: 000000000000e300
  R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff88bfdfa00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000002 CR3: 0000000002409005 CR4: 00000000001606e0
  Call Trace:
   __wake_up_common_lock+0x63/0xc0
   wb_workfn+0xd2/0x3e0
   process_one_work+0x1f5/0x3f0
   worker_thread+0x2d/0x3d0
   kthread+0x111/0x130
   ret_from_fork+0x1f/0x30

Fix it by reading and caching @done->waitq before decrementing
@done->cnt.

Signed-off-by: Tejun Heo <tj@kernel.org>
Debugged-by: Chris Mason <clm@fb.com>
Fixes: 30638b0125e1 ("writeback: Generalize and expose wb_completion")
Cc: stable@vger.kernel.org # v5.2+
---
 fs/fs-writeback.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 8aaa7eec7b74..e88421d9a48d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -164,8 +164,13 @@ static void finish_writeback_work(struct bdi_writeback *wb,
 
 	if (work->auto_free)
 		kfree(work);
-	if (done && atomic_dec_and_test(&done->cnt))
-		wake_up_all(done->waitq);
+	if (done) {
+		wait_queue_head_t *waitq = done->waitq;
+
+		/* @done can't be accessed after the following dec */
+		if (atomic_dec_and_test(&done->cnt))
+			wake_up_all(waitq);
+	}
 }
 
 static void wb_queue_work(struct bdi_writeback *wb,
