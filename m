Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A61C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316CA214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178898;
	bh=E/lSzvPqTxdIB5ncEwxU1w/9V+oMwQfMO5+3WkZbCeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pT/aUVOTAa89Ej4DtpFomALX/GyysWAMuCc/BwctjAyR6iTZhl1Zl6q4mJgE14ven
	 a7XEB+kgXaCaBJE1iv6Ao3LkfoT/txWHpR1vcYci/XSW4FPphtzGeh4a0W8++hRMUi
	 hJwB1a2nPTKg2/BCJqGbBPzfZ0e86RFRYPVfU+7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439031AbfIVTBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbfIVTB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:01:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB232070C;
        Sun, 22 Sep 2019 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178887;
        bh=E/lSzvPqTxdIB5ncEwxU1w/9V+oMwQfMO5+3WkZbCeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFjaWpFCzv43oN/nD+ar1isAcg39cwjiIm4yhG7PGW34+dKiJ13kD6SM+gvQMKVlb
         nLSiorEEL8sYiZK3lyr6wsmhC3ZCDdHiqDHF0hMSZCQA8DahwacJ8PD9eE3A3uERm/
         9dY80T0xUX3DsopxYqpQdBYESB3TD4y7CAKbUOy8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 17/44] md: don't call spare_active in md_reap_sync_thread if all member devices can't work
Date:   Sun, 22 Sep 2019 15:00:35 -0400
Message-Id: <20190922190103.4906-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922190103.4906-1-sashal@kernel.org>
References: <20190922190103.4906-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Jiang <jgq516@gmail.com>

[ Upstream commit 0d8ed0e9bf9643f27f4816dca61081784dedb38d ]

When add one disk to array, the md_reap_sync_thread is responsible
to activate the spare and set In_sync flag for the new member in
spare_active().

But if raid1 has one member disk A, and disk B is added to the array.
Then we offline A before all the datas are synchronized from A to B,
obviously B doesn't have the latest data as A, but B is still marked
with In_sync flag.

So let's not call spare_active under the condition, otherwise B is
still showed with 'U' state which is not correct.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 067af77bb729a..d1b09657c1939 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8445,7 +8445,8 @@ void md_reap_sync_thread(struct mddev *mddev)
 	/* resync has finished, collect result */
 	md_unregister_thread(&mddev->sync_thread);
 	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
-	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery)) {
+	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
+	    mddev->degraded != mddev->raid_disks) {
 		/* success...*/
 		/* activate any spares */
 		if (mddev->pers->spare_active(mddev)) {
-- 
2.20.1

