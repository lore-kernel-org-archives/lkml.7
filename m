Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C540FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B65206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907061;
	bh=ZlzvcIHy3xlKqg/+oQUIvJD228VjyK6QJBZ/AjXr1CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p4Z14CGEsWdnULo6uG1H0pL/Zdebxq2USCkb7DSYsw/wJ+LcNFcX/lVTlywClJEC4
	 3paWfzEj8VRTbPqp5ysRaiUHgzWHgRhiUyj35/dTQF4njn8W57cuM9MIgRYLbYBRCb
	 ZZkYCCpVF+03UxtA83MkX7uOoIUvq4Bw3TqVNjqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfC3AvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbfC3Au5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:50:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBFC218CD;
        Sat, 30 Mar 2019 00:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907056;
        bh=ZlzvcIHy3xlKqg/+oQUIvJD228VjyK6QJBZ/AjXr1CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hByqiMOBH+LbBQV9mur47mVQIKaWAkDSpsTzvas8C8xR6E6ezn64/D/myXmvoNxNG
         NsEwKrKonutqPf9FxHrnqU2Z5Jc2wi19S8FPyYtOzUwzEJZr5HR4pncKr+R2yhEQ5n
         6aZWboIA5QDUu+fNmSCw6lwEQhV8E0JWA5tvty+o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 07/67] ext4: avoid panic during forced reboot
Date:   Fri, 29 Mar 2019 20:49:47 -0400
Message-Id: <20190330005047.25998-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 1dc1097ff60e4105216da7cd0aa99032b039a994 ]

When admin calls "reboot -f" - i.e., does a hard system reboot by
directly calling reboot(2) - ext4 filesystem mounted with errors=panic
can panic the system. This happens because the underlying device gets
disabled without unmounting the filesystem and thus some syscall running
in parallel to reboot(2) can result in the filesystem getting IO errors.

This is somewhat surprising to the users so try improve the behavior by
switching to errors=remount-ro behavior when the system is running
reboot(2).

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fb12d3c17c1b..b9bca7298f96 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -430,6 +430,12 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 	spin_unlock(&sbi->s_md_lock);
 }
 
+static bool system_going_down(void)
+{
+	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
+		|| system_state == SYSTEM_RESTART;
+}
+
 /* Deal with the reporting of failure conditions on a filesystem such as
  * inconsistencies detected or read IO failures.
  *
@@ -460,7 +466,12 @@ static void ext4_handle_error(struct super_block *sb)
 		if (journal)
 			jbd2_journal_abort(journal, -EIO);
 	}
-	if (test_opt(sb, ERRORS_RO)) {
+	/*
+	 * We force ERRORS_RO behavior when system is rebooting. Otherwise we
+	 * could panic during 'reboot -f' as the underlying device got already
+	 * disabled.
+	 */
+	if (test_opt(sb, ERRORS_RO) || system_going_down()) {
 		ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
 		/*
 		 * Make sure updated value of ->s_mount_flags will be visible
@@ -468,8 +479,7 @@ static void ext4_handle_error(struct super_block *sb)
 		 */
 		smp_wmb();
 		sb->s_flags |= SB_RDONLY;
-	}
-	if (test_opt(sb, ERRORS_PANIC)) {
+	} else if (test_opt(sb, ERRORS_PANIC)) {
 		if (EXT4_SB(sb)->s_journal &&
 		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
 			return;
-- 
2.19.1

