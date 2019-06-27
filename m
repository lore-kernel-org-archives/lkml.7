Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD669C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045921882
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596149;
	bh=JaYyVc6kmvJ/E94/JPIGEcZAKmF3YzUOeI2OXslNRIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hR8qyk4qBhEtSgh3du7Ec27JKiSbvklFzAwPltUa7UPnjWneNs7vtWO5exHGmF2Gz
	 tPlH7EJgvYAR7ye2tpPTpFhpQ9SuNlqfur4+Jp3KdHPl5+/8nAFYWN7/kv3jXpTHql
	 /Zr/ydcNEnKuq0xfHhpbhBq/ejcgz2HJ9brklJok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfF0Am2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfF0AmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:42:25 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F9921883;
        Thu, 27 Jun 2019 00:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596144;
        bh=JaYyVc6kmvJ/E94/JPIGEcZAKmF3YzUOeI2OXslNRIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBDuLcEiggMMf5RhtDzKBqLOdduc9InMBLJAaTPeS1jKFL3rmKByZGLfb8jyR6VRV
         uyONJOxfrkMEyx1UeswtT8PvjTcZRoL35IUITW2+T3tHTp1G/TALyGbQMNRUHlxbtT
         Xl0i0yIshXIOLCE3HLCnHjnUiLKS5jr5i8FA6Rfs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 18/21] md: fix for divide error in status_resync
Date:   Wed, 26 Jun 2019 20:41:18 -0400
Message-Id: <20190627004122.21671-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627004122.21671-1-sashal@kernel.org>
References: <20190627004122.21671-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>

[ Upstream commit 9642fa73d073527b0cbc337cc17a47d545d82cd2 ]

Stopping external metadata arrays during resync/recovery causes
retries, loop of interrupting and starting reconstruction, until it
hit at good moment to stop completely. While these retries
curr_mark_cnt can be small- especially on HDD drives, so subtraction
result can be smaller than 0. However it is casted to uint without
checking. As a result of it the status bar in /proc/mdstat while stopping
is strange (it jumps between 0% and 99%).

The real problem occurs here after commit 72deb455b5ec ("block: remove
CONFIG_LBDAF"). Sector_div() macro has been changed, now the
divisor is casted to uint32. For db = -8 the divisior(db/32-1) becomes 0.

Check if db value can be really counted and replace these macro by
div64_u64() inline.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 21698eb671d7..765a16dab2e5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7296,9 +7296,9 @@ static void status_unused(struct seq_file *seq)
 static int status_resync(struct seq_file *seq, struct mddev *mddev)
 {
 	sector_t max_sectors, resync, res;
-	unsigned long dt, db;
-	sector_t rt;
-	int scale;
+	unsigned long dt, db = 0;
+	sector_t rt, curr_mark_cnt, resync_mark_cnt;
+	int scale, recovery_active;
 	unsigned int per_milli;
 
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
@@ -7368,22 +7368,30 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 	 * db: blocks written from mark until now
 	 * rt: remaining time
 	 *
-	 * rt is a sector_t, so could be 32bit or 64bit.
-	 * So we divide before multiply in case it is 32bit and close
-	 * to the limit.
-	 * We scale the divisor (db) by 32 to avoid losing precision
-	 * near the end of resync when the number of remaining sectors
-	 * is close to 'db'.
-	 * We then divide rt by 32 after multiplying by db to compensate.
-	 * The '+1' avoids division by zero if db is very small.
+	 * rt is a sector_t, which is always 64bit now. We are keeping
+	 * the original algorithm, but it is not really necessary.
+	 *
+	 * Original algorithm:
+	 *   So we divide before multiply in case it is 32bit and close
+	 *   to the limit.
+	 *   We scale the divisor (db) by 32 to avoid losing precision
+	 *   near the end of resync when the number of remaining sectors
+	 *   is close to 'db'.
+	 *   We then divide rt by 32 after multiplying by db to compensate.
+	 *   The '+1' avoids division by zero if db is very small.
 	 */
 	dt = ((jiffies - mddev->resync_mark) / HZ);
 	if (!dt) dt++;
-	db = (mddev->curr_mark_cnt - atomic_read(&mddev->recovery_active))
-		- mddev->resync_mark_cnt;
+
+	curr_mark_cnt = mddev->curr_mark_cnt;
+	recovery_active = atomic_read(&mddev->recovery_active);
+	resync_mark_cnt = mddev->resync_mark_cnt;
+
+	if (curr_mark_cnt >= (recovery_active + resync_mark_cnt))
+		db = curr_mark_cnt - (recovery_active + resync_mark_cnt);
 
 	rt = max_sectors - resync;    /* number of remaining sectors */
-	sector_div(rt, db/32+1);
+	rt = div64_u64(rt, db/32+1);
 	rt *= dt;
 	rt >>= 5;
 
-- 
2.20.1

