Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F0C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2300206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510898;
	bh=q6ZwduEz3SIA3cGQ9kT7ctMqIpIL+dpMb15m/DyQLtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z6RpoWuLhuNdhZeWZTrtXd7pYwzUGYkW4GLfM7PTaa0dJIh64qrihAmVN4zdLoUYB
	 GuLpPgFufvNvZGVwYOTds9mllCW4O46HsOJrLrpnuoobn7RlNySv15WD4HQIqDJSWQ
	 vVqmfbuqfLJp3FlMMyYUDBfDAb9F4PGkEpeO7n1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbfGSEe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729620AbfGSEBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:01:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A5D218A6;
        Fri, 19 Jul 2019 04:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508901;
        bh=q6ZwduEz3SIA3cGQ9kT7ctMqIpIL+dpMb15m/DyQLtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xRZvywWrvV8Ak412507F0CDIeAErd04wnZUZDEAwhywVKiHrgpDyKK6z0qSMglYr1
         gOuSB86Fs8TPT0ysBTXsXPF1ETTUPQDzvdcUNXKvKJ1WoSNhg1dMGNcbosq9WtRv19
         HrNPeIQ2S9X7F733cRjxwdKZCYPujk6jel3HQNoo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 149/171] s390/dasd: Make layout analysis ESE compatible
Date:   Thu, 18 Jul 2019 23:56:20 -0400
Message-Id: <20190719035643.14300-149-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

[ Upstream commit ce6915f5343f5f2a2a937b683d8ffbf12dab3ad4 ]

The disk layout and volume information of a DASD reside in the first two
tracks of cylinder 0. When a DASD is set online, currently the first
three tracks are read and analysed to confirm an expected layout.

For CDL (Compatible Disk Layout) only count area data of the first track
is evaluated and checked against expected key and data lengths. For LDL
(Linux Disk Layout) the first and third track is evaluated. However,
an LDL formatted volume is expected to be in the same format across all
tracks. Checking the third track therefore doesn't have any more value
than checking any other track at random.

Now, an Extent Space Efficient (ESE) DASD is initialised by only
formatting the first two tracks, as those tracks always contain all
information necessarry.

Checking the third track on an ESE volume will therefore most likely
fail with a record not found error, as the third track will be empty.
This in turn leads to the device being recognised with a volume size of
0. Attempts to write volume information on the first two tracks then
fail with "no space left on device" errors.

Initialising the first three tracks for an ESE volume is not a viable
solution, because the third track is already a regular track and could
contain user data. With that there is potential for data corruption.

Instead, always only analyse the first two tracks, as it is sufficiant
for both CDL and LDL, and allow ESE volumes to be recognised as well.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index c09039eea707..c7aec1b44b7c 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -157,7 +157,7 @@ static const int sizes_trk0[] = { 28, 148, 84 };
 #define LABEL_SIZE 140
 
 /* head and record addresses of count_area read in analysis ccw */
-static const int count_area_head[] = { 0, 0, 0, 0, 2 };
+static const int count_area_head[] = { 0, 0, 0, 0, 1 };
 static const int count_area_rec[] = { 1, 2, 3, 4, 1 };
 
 static inline unsigned int
@@ -1823,8 +1823,8 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
-	/* Define extent for the first 3 tracks. */
-	define_extent(ccw++, cqr->data, 0, 2,
+	/* Define extent for the first 2 tracks. */
+	define_extent(ccw++, cqr->data, 0, 1,
 		      DASD_ECKD_CCW_READ_COUNT, device, 0);
 	LO_data = cqr->data + sizeof(struct DE_eckd_data);
 	/* Locate record for the first 4 records on track 0. */
@@ -1843,9 +1843,9 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 		count_data++;
 	}
 
-	/* Locate record for the first record on track 2. */
+	/* Locate record for the first record on track 1. */
 	ccw[-1].flags |= CCW_FLAG_CC;
-	locate_record(ccw++, LO_data++, 2, 0, 1,
+	locate_record(ccw++, LO_data++, 1, 0, 1,
 		      DASD_ECKD_CCW_READ_COUNT, device, 0);
 	/* Read count ccw. */
 	ccw[-1].flags |= CCW_FLAG_CC;
@@ -1967,7 +1967,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 		}
 	}
 	if (i == 3)
-		count_area = &private->count_area[4];
+		count_area = &private->count_area[3];
 
 	if (private->uses_cdl == 0) {
 		for (i = 0; i < 5; i++) {
-- 
2.20.1

