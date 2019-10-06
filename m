Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C0C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F280620700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383486;
	bh=mqSyEFPTAyzBwMRSRdz3y61W0tMmYA/5+LdqDpAIF+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M38lptS5ahFf4ovyNZ0ZdTl4IbXSYy83oa47i5Wi/0hHZFvE8TbBKo643XTYSdS0A
	 gXzyw9oHvfSbLMA9sxYbZWFnJRxos2DxxYPTQ3d/wgPtbWARTbnHI1BFWNYT42w0da
	 qTyXS/wu5JLxdelQTC1s6g91GED/4wvtsb15DbN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfJFRiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729972AbfJFRiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:38:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A2B20700;
        Sun,  6 Oct 2019 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383481;
        bh=mqSyEFPTAyzBwMRSRdz3y61W0tMmYA/5+LdqDpAIF+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHL12JFBjNCFsJ32sXGAjCGbPzQU05La1TV9r5CG9NMr64UMqPSd+U5IzHR0GhnIb
         Wi62B6+8RHuoysdRhALQrnKFRxZbpRZurZaQWx00VPKVfs2u+uuUchVyFA2lPjwDhR
         Od3FAX2lPyAi9gbnKr+7SATwUTwmus4dV3wiC8wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 119/137] pktcdvd: remove warning on attempting to register non-passthrough dev
Date:   Sun,  6 Oct 2019 19:21:43 +0200
Message-Id: <20191006171219.165851348@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit eb09b3cc464d2c3bbde9a6648603c8d599ea8582 ]

Anatoly reports that he gets the below warning when booting -git on
a sparc64 box on debian unstable:

...
[   13.352975] aes_sparc64: Using sparc64 aes opcodes optimized AES
implementation
[   13.428002] ------------[ cut here ]------------
[   13.428081] WARNING: CPU: 21 PID: 586 at
drivers/block/pktcdvd.c:2597 pkt_setup_dev+0x2e4/0x5a0 [pktcdvd]
[   13.428147] Attempt to register a non-SCSI queue
[   13.428184] Modules linked in: pktcdvd libdes cdrom aes_sparc64
n2_rng md5_sparc64 sha512_sparc64 rng_core sha256_sparc64 flash
sha1_sparc64 ip_tables x_tables ipv6 crc_ccitt nf_defrag_ipv6 autofs4
ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear
md_mod crc32c_sparc64
[   13.428452] CPU: 21 PID: 586 Comm: pktsetup Not tainted
5.3.0-10169-g574cc4539762 #1234
[   13.428507] Call Trace:
[   13.428542]  [00000000004635c0] __warn+0xc0/0x100
[   13.428582]  [0000000000463634] warn_slowpath_fmt+0x34/0x60
[   13.428626]  [000000001045b244] pkt_setup_dev+0x2e4/0x5a0 [pktcdvd]
[   13.428674]  [000000001045ccf4] pkt_ctl_ioctl+0x94/0x220 [pktcdvd]
[   13.428724]  [00000000006b95c8] do_vfs_ioctl+0x628/0x6e0
[   13.428764]  [00000000006b96c8] ksys_ioctl+0x48/0x80
[   13.428803]  [00000000006b9714] sys_ioctl+0x14/0x40
[   13.428847]  [0000000000406294] linux_sparc_syscall+0x34/0x44
[   13.428890] irq event stamp: 4181
[   13.428924] hardirqs last  enabled at (4189): [<00000000004e0a74>]
console_unlock+0x634/0x6c0
[   13.428984] hardirqs last disabled at (4196): [<00000000004e0540>]
console_unlock+0x100/0x6c0
[   13.429048] softirqs last  enabled at (3978): [<0000000000b2e2d8>]
__do_softirq+0x498/0x520
[   13.429110] softirqs last disabled at (3967): [<000000000042cfb4>]
do_softirq_own_stack+0x34/0x60
[   13.429172] ---[ end trace 2220ca468f32967d ]---
[   13.430018] pktcdvd: setup of pktcdvd device failed
[   13.455589] des_sparc64: Using sparc64 des opcodes optimized DES
implementation
[   13.515334] camellia_sparc64: Using sparc64 camellia opcodes
optimized CAMELLIA implementation
[   13.522856] pktcdvd: setup of pktcdvd device failed
[   13.529327] pktcdvd: setup of pktcdvd device failed
[   13.532932] pktcdvd: setup of pktcdvd device failed
[   13.536165] pktcdvd: setup of pktcdvd device failed
[   13.539372] pktcdvd: setup of pktcdvd device failed
[   13.542834] pktcdvd: setup of pktcdvd device failed
[   13.546536] pktcdvd: setup of pktcdvd device failed
[   15.431071] XFS (dm-0): Mounting V5 Filesystem
...

Apparently debian auto-attaches any cdrom like device to pktcdvd, which
can lead to the above warning. There's really no reason to warn for this
situation, kill it.

Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/pktcdvd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 024060165afa7..76457003f1406 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2594,7 +2594,6 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	if (ret)
 		return ret;
 	if (!blk_queue_scsi_passthrough(bdev_get_queue(bdev))) {
-		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
 		blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
 		return -EINVAL;
 	}
-- 
2.20.1



