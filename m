Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3048BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B79208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178808;
	bh=FUo7+AM5G1HtGd+uzgYEtJ+YHg9f4YGf1zd1fEXlen0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LziqF2JtFa23uewZHQ+oATQSSRu6jvfcSAmy5tVm7yNMp5RuEn2j+2k6OWVSmGm3g
	 RYVAy2CLeFIA6I6q+eF4FaBcvUzQf/vxJVIrNHZ4V0d28eIn3A3/Kd9sxSIE8Nbydf
	 Yi792YsIvtRqWCI0MA6+0G7BXP58nZcavJsb+nQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438945AbfIVTAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408294AbfIVTAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:00:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B4C21479;
        Sun, 22 Sep 2019 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178800;
        bh=FUo7+AM5G1HtGd+uzgYEtJ+YHg9f4YGf1zd1fEXlen0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPTSfR59WOMUcLOR8ecVx0voJIlw8cZyqosib+omYzoR+B3ES2UhDO2AauDwASRFA
         l6wGc3K36/qnTQmwebijeYxpOTxkIVjZmkbyAHf2rw3btwle1mWbyEqhclq9Ahoo0w
         aihWkpz1FomT6YNDxyWMglKUMjlgukJFD0mpg5Ls=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 20/60] md: don't call spare_active in md_reap_sync_thread if all member devices can't work
Date:   Sun, 22 Sep 2019 14:58:53 -0400
Message-Id: <20190922185934.4305-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185934.4305-1-sashal@kernel.org>
References: <20190922185934.4305-1-sashal@kernel.org>
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
index 765a16dab2e5f..c1c514792457a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8573,7 +8573,8 @@ void md_reap_sync_thread(struct mddev *mddev)
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

