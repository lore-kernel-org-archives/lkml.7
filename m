Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0B4C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3442070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258297;
	bh=6S4XpkQfJKp86CXbtxOdeShlrrsU6LoK+5a93PUfcgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQZFvX7BnfrRanya+4PZj7jymhSYQ6mbpPXSbqbkks/sp1xv4H4H0MYcIhv3CMxTT
	 fC8GgaS2L9fIVT5RBYIO7Ob2qVySBbHWcoO+jyKyeKmFL7CB6DNmZ3BFaC6mWJT6og
	 stpjOXAWWD8siL8VuGrtzNnJ2wjKy3dhLP2O5i40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbfCVMJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389297AbfCVMJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:09:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 536C420830;
        Fri, 22 Mar 2019 12:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256560;
        bh=6S4XpkQfJKp86CXbtxOdeShlrrsU6LoK+5a93PUfcgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8Xwf+OL79Lt0UIGJH5Boi4dnR/idQDKEbJYH3L06eyrf0LpL4WsO62tO4Nt9+qwA
         xY0vyFXcGDSXJ0Gr8mCJXRg9IXbb2AHpLzMvCF62fPOumh/fVF2M18q/P+8KQt6kwX
         9pWX1+3lp0jkShokoHdYKK7/rXsM/Z0YtipjMOdM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kent Overstreet <koverstreet@google.com>,
        Daniel Axtens <dja@axtens.net>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 249/280] bcache: never writeback a discard operation
Date:   Fri, 22 Mar 2019 12:16:42 +0100
Message-Id: <20190322111341.179137791@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Axtens <dja@axtens.net>

commit 9951379b0ca88c95876ad9778b9099e19a95d566 upstream.

Some users see panics like the following when performing fstrim on a
bcached volume:

[  529.803060] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[  530.183928] #PF error: [normal kernel read fault]
[  530.412392] PGD 8000001f42163067 P4D 8000001f42163067 PUD 1f42168067 PMD 0
[  530.750887] Oops: 0000 [#1] SMP PTI
[  530.920869] CPU: 10 PID: 4167 Comm: fstrim Kdump: loaded Not tainted 5.0.0-rc1+ #3
[  531.290204] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 12/27/2015
[  531.693137] RIP: 0010:blk_queue_split+0x148/0x620
[  531.922205] Code: 60 38 89 55 a0 45 31 db 45 31 f6 45 31 c9 31 ff 89 4d 98 85 db 0f 84 7f 04 00 00 44 8b 6d 98 4c 89 ee 48 c1 e6 04 49 03 70 78 <8b> 46 08 44 8b 56 0c 48
8b 16 44 29 e0 39 d8 48 89 55 a8 0f 47 c3
[  532.838634] RSP: 0018:ffffb9b708df39b0 EFLAGS: 00010246
[  533.093571] RAX: 00000000ffffffff RBX: 0000000000046000 RCX: 0000000000000000
[  533.441865] RDX: 0000000000000200 RSI: 0000000000000000 RDI: 0000000000000000
[  533.789922] RBP: ffffb9b708df3a48 R08: ffff940d3b3fdd20 R09: 0000000000000000
[  534.137512] R10: ffffb9b708df3958 R11: 0000000000000000 R12: 0000000000000000
[  534.485329] R13: 0000000000000000 R14: 0000000000000000 R15: ffff940d39212020
[  534.833319] FS:  00007efec26e3840(0000) GS:ffff940d1f480000(0000) knlGS:0000000000000000
[  535.224098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  535.504318] CR2: 0000000000000008 CR3: 0000001f4e256004 CR4: 00000000001606e0
[  535.851759] Call Trace:
[  535.970308]  ? mempool_alloc_slab+0x15/0x20
[  536.174152]  ? bch_data_insert+0x42/0xd0 [bcache]
[  536.403399]  blk_mq_make_request+0x97/0x4f0
[  536.607036]  generic_make_request+0x1e2/0x410
[  536.819164]  submit_bio+0x73/0x150
[  536.980168]  ? submit_bio+0x73/0x150
[  537.149731]  ? bio_associate_blkg_from_css+0x3b/0x60
[  537.391595]  ? _cond_resched+0x1a/0x50
[  537.573774]  submit_bio_wait+0x59/0x90
[  537.756105]  blkdev_issue_discard+0x80/0xd0
[  537.959590]  ext4_trim_fs+0x4a9/0x9e0
[  538.137636]  ? ext4_trim_fs+0x4a9/0x9e0
[  538.324087]  ext4_ioctl+0xea4/0x1530
[  538.497712]  ? _copy_to_user+0x2a/0x40
[  538.679632]  do_vfs_ioctl+0xa6/0x600
[  538.853127]  ? __do_sys_newfstat+0x44/0x70
[  539.051951]  ksys_ioctl+0x6d/0x80
[  539.212785]  __x64_sys_ioctl+0x1a/0x20
[  539.394918]  do_syscall_64+0x5a/0x110
[  539.568674]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

We have observed it where both:
1) LVM/devmapper is involved (bcache backing device is LVM volume) and
2) writeback cache is involved (bcache cache_mode is writeback)

On one machine, we can reliably reproduce it with:

 # echo writeback > /sys/block/bcache0/bcache/cache_mode
   (not sure whether above line is required)
 # mount /dev/bcache0 /test
 # for i in {0..10}; do
	file="$(mktemp /test/zero.XXX)"
	dd if=/dev/zero of="$file" bs=1M count=256
	sync
	rm $file
    done
  # fstrim -v /test

Observing this with tracepoints on, we see the following writes:

fstrim-18019 [022] .... 91107.302026: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 4260112 + 196352 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302050: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 4456464 + 262144 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302075: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 4718608 + 81920 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302094: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 5324816 + 180224 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302121: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 5505040 + 262144 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302145: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 5767184 + 81920 hit 0 bypass 1
fstrim-18019 [022] .... 91107.308777: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 6373392 + 180224 hit 1 bypass 0
<crash>

Note the final one has different hit/bypass flags.

This is because in should_writeback(), we were hitting a case where
the partial stripe condition was returning true and so
should_writeback() was returning true early.

If that hadn't been the case, it would have hit the would_skip test, and
as would_skip == s->iop.bypass == true, should_writeback() would have
returned false.

Looking at the git history from 'commit 72c270612bd3 ("bcache: Write out
full stripes")', it looks like the idea was to optimise for raid5/6:

       * If a stripe is already dirty, force writes to that stripe to
	 writeback mode - to help build up full stripes of dirty data

To fix this issue, make sure that should_writeback() on a discard op
never returns true.

More details of debugging:
https://www.spinics.net/lists/linux-bcache/msg06996.html

Previous reports:
 - https://bugzilla.kernel.org/show_bug.cgi?id=201051
 - https://bugzilla.kernel.org/show_bug.cgi?id=196103
 - https://www.spinics.net/lists/linux-bcache/msg06885.html

(Coly Li: minor modification to follow maximum 75 chars per line rule)

Cc: Kent Overstreet <koverstreet@google.com>
Cc: stable@vger.kernel.org
Fixes: 72c270612bd3 ("bcache: Write out full stripes")
Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/writeback.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -63,6 +63,9 @@ static inline bool should_writeback(stru
 	    in_use > CUTOFF_WRITEBACK_SYNC)
 		return false;
 
+	if (bio_op(bio) == REQ_OP_DISCARD)
+		return false;
+
 	if (dc->partial_stripes_expensive &&
 	    bcache_dev_stripe_dirty(dc, bio->bi_iter.bi_sector,
 				    bio_sectors(bio)))


