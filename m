Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A6C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0342064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfGJHdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:33:52 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:36690 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfGJHdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:33:51 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 9744B65CB9B0520C0A0A;
        Wed, 10 Jul 2019 15:33:46 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6A7Vu2q076458;
        Wed, 10 Jul 2019 15:31:56 +0800 (GMT-8)
        (envelope-from yang.bin18@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071015321609-2237267 ;
          Wed, 10 Jul 2019 15:32:16 +0800 
From:   Yang Bin <yang.bin18@zte.com.cn>
To:     lduncan@suse.com
Cc:     cleech@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        " Yang Bin " <yang.bin18@zte.com.cn>
Subject: [PATCH] Check sk before sendpage
Date:   Wed, 10 Jul 2019 15:30:09 +0800
Message-Id: <1562743809-31133-1-git-send-email-yang.bin18@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-10 15:32:16,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-10 15:31:59,
        Serialize complete at 2019-07-10 15:31:59
X-MAIL: mse-fl2.zte.com.cn x6A7Vu2q076458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: " Yang Bin "<yang.bin18@zte.com.cn>

Before xmit,iscsi may disconnect just now.
So must check connection sock NULL or not,or kernel will crash for
accessing NULL pointer.

Signed-off-by: Yang Bin <yang.bin18@zte.com.cn>
---
 drivers/scsi/iscsi_tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 7bedbe8..a59c49f 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -264,6 +264,9 @@ static int iscsi_sw_tcp_xmit_segment(struct iscsi_tcp_conn *tcp_conn,
 	unsigned int copied = 0;
 	int r = 0;
 
+	if (!sk)
+		return -ENOTCONN;
+
 	while (!iscsi_tcp_segment_done(tcp_conn, segment, 0, r)) {
 		struct scatterlist *sg;
 		unsigned int offset, copy;
-- 
1.8.3.1

