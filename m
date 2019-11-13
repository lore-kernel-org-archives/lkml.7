Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC5C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A84A222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611869;
	bh=SLDHED6xIDXCXATD9sFjZPXRCps2xfzuuQ0qam3yhVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BT6F24Ss3hSe+cwzLLd20dmmaE3Wlc42ILCMKFO0Xb4/xl1fdMG1dcrJY41lH7GIq
	 7JG+oLunjKfTcnYfxij2JiGTPIg3Q1BXNcqPyuRFDj6778C829q+9tvsUv+sW1WYWF
	 IkvMSIfaXNxC9oqWWUq7U3Qgs87UXNhqQDrJxTNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfKMBwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:52:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfKMBv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C592245A;
        Wed, 13 Nov 2019 01:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609919;
        bh=SLDHED6xIDXCXATD9sFjZPXRCps2xfzuuQ0qam3yhVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlvXKzqN32yGjlLNZYgAgTBdKaQzUlcxlT8sYbdA0Pr2RKy37JIDJLyZbdi3X5iX8
         bSKE6igJuh/wgRFfIe7ipI5NrSSJS/yME1aaTH63NAFIYwSwTtqe6QiY3IuQbTt8pw
         ZAo2Un6RP6O9CRwhdHGcsStZauVBRZRzN1gpCFqY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     NeilBrown <neilb@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Shaohua Li <shli@fb.com>, Sasha Levin <sashal@kernel.org>,
        linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 067/209] md: allow metadata updates while suspending an array - fix
Date:   Tue, 12 Nov 2019 20:48:03 -0500
Message-Id: <20191113015025.9685-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>

[ Upstream commit 059421e041eb461fb2b3e81c9adaec18ef03ca3c ]

Commit 35bfc52187f6 ("md: allow metadata update while suspending.")
added support for allowing md_check_recovery() to still perform
metadata updates while the array is entering the 'suspended' state.
This is needed to allow the processes of entering the state to
complete.

Unfortunately, the patch doesn't really work.  The test for
"mddev->suspended" at the start of md_check_recovery() means that the
function doesn't try to do anything at all while entering suspend.

This patch moves the code of updating the metadata while suspending to
*before* the test on mddev->suspended.

Reported-by: Jeff Mahoney <jeffm@suse.com>
Fixes: 35bfc52187f6 ("md: allow metadata update while suspending.")
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a8fbaa384e9ae..2fe4f93d1d7d4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8778,6 +8778,18 @@ static void md_start_sync(struct work_struct *ws)
  */
 void md_check_recovery(struct mddev *mddev)
 {
+	if (test_bit(MD_ALLOW_SB_UPDATE, &mddev->flags) && mddev->sb_flags) {
+		/* Write superblock - thread that called mddev_suspend()
+		 * holds reconfig_mutex for us.
+		 */
+		set_bit(MD_UPDATING_SB, &mddev->flags);
+		smp_mb__after_atomic();
+		if (test_bit(MD_ALLOW_SB_UPDATE, &mddev->flags))
+			md_update_sb(mddev, 0);
+		clear_bit_unlock(MD_UPDATING_SB, &mddev->flags);
+		wake_up(&mddev->sb_wait);
+	}
+
 	if (mddev->suspended)
 		return;
 
@@ -8938,16 +8950,6 @@ void md_check_recovery(struct mddev *mddev)
 	unlock:
 		wake_up(&mddev->sb_wait);
 		mddev_unlock(mddev);
-	} else if (test_bit(MD_ALLOW_SB_UPDATE, &mddev->flags) && mddev->sb_flags) {
-		/* Write superblock - thread that called mddev_suspend()
-		 * holds reconfig_mutex for us.
-		 */
-		set_bit(MD_UPDATING_SB, &mddev->flags);
-		smp_mb__after_atomic();
-		if (test_bit(MD_ALLOW_SB_UPDATE, &mddev->flags))
-			md_update_sb(mddev, 0);
-		clear_bit_unlock(MD_UPDATING_SB, &mddev->flags);
-		wake_up(&mddev->sb_wait);
 	}
 }
 EXPORT_SYMBOL(md_check_recovery);
-- 
2.20.1

