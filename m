Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D332ECA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4A62087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfJ3KfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:35:23 -0400
Received: from smtp1.axis.com ([195.60.68.17]:1741 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfJ3KfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:35:23 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 06:35:22 EDT
IronPort-SDR: ve5p2pZNlvpDL2krbZnIKB2D9SwTBZKOjF0PY2JWzUWzbkxJYfhyJuAEAhD8N7aY7IwgMrL1Zu
 MbyHMzRC6yElgKfYimu97StkUmT8BAAKziXK1M/R4Zb+ubqt67DIJOCFoNXil2wj7odpBQD3pY
 kPOugSZr7DeRoTvMIM22FuSeKfBf8L/HSQWVYNK5EUjWDQqjdSOka08z4IufXIr873n2TPRgHC
 HJzxrs0l+l5F4Wmy6Z+9x/l15Vee7sRD11o0OMJo9sGKsCZ2f1M+ypV1Ww7zuwOZWVOkBkRdI7
 bDE=
X-IronPort-AV: E=Sophos;i="5.68,247,1569276000"; 
   d="scan'208";a="1996420"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     axboe@kernel.dk
Cc:     linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] buffer: Work around I/O errors due to ARM CPU bug
Date:   Wed, 30 Oct 2019 11:28:10 +0100
Message-Id: <20191030102810.20744-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my dual-core ARM Cortex-A9, reading from squashfs (over
dm-verity/ubi/mtd) in a loop for hundreds of hours inevitably results in
a read failure in squashfs_read_data().  The errors occur because the
buffer_uptodate() check fails after wait_on_buffer().  Further debugging
shows that the bh was in fact uptodate and that there is no actual I/O
error in the lower layers.

The problem appears to be caused by the read-after-read hazards in the
ARM Cortex-A9 MPCore (erratum #761319, see [1]).  The new value of the
BH_Lock flag is seen but the new value of BH_Uptodate is not even though
both the bits are read from the same memory location.  Work around it by
adding a DMB between the two reads of bh->flags.

 27c:	9d08      	ldr	r5, [sp, #32]
 27e:	2400      	movs	r4, #0
 280:	e006      	b.n	290 <squashfs_read_data+0x290>
 282:	6803      	ldr	r3, [r0, #0]
 284:	07da      	lsls	r2, r3, #31
 286:	f140 810d 	bpl.w	4a4 <squashfs_read_data+0x4a4>
 28a:	3401      	adds	r4, #1
 28c:	42bc      	cmp	r4, r7
 28e:	da08      	bge.n	2a2 <squashfs_read_data+0x2a2>
 290:	f855 0f04 	ldr.w	r0, [r5, #4]!
 294:	6803      	ldr	r3, [r0, #0]
 296:	0759      	lsls	r1, r3, #29
 298:	d5f3      	bpl.n	282 <squashfs_read_data+0x282>
 29a:	f7ff fffe 	bl	0 <__wait_on_buffer>

With this barrier, no failures have been seen in 2500+ hours of the same
test.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.uan0004a/UAN0004A_a9_read_read.pdf

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 include/linux/buffer_head.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7b73ef7f902d..4ef909a91f8c 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -352,6 +352,14 @@ static inline void wait_on_buffer(struct buffer_head *bh)
 	might_sleep();
 	if (buffer_locked(bh))
 		__wait_on_buffer(bh);
+
+#ifdef CONFIG_ARM
+	/*
+	 * Work around ARM Cortex-A9 MPcore Read-after-Read Hazards (erratum
+	 * 761319).
+	 */
+	smp_rmb();
+#endif
 }
 
 static inline int trylock_buffer(struct buffer_head *bh)
-- 
2.20.0

