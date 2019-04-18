Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9681C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893B420675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611035;
	bh=Ry/fhiyEgWF0AA1ikIdMjZpB+mjIFoMWeKf5AtmVcDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SE0EsYiIVCwysUBIQK4k26rpYj9XW0bJ23hnrLCHQer6xlhj43rcGL/SVB5sv5FuG
	 R/H0iCNJUjtBiDWai53b9tr4gS+ZYgOQaXI6uUE5h0os9G6vKYZzrB8jiOmjBTIAlK
	 69OhS16XCF5NzyLwmOnLEacKojCJa27km+ehM3Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404132AbfDRSKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391486AbfDRSK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF6D20652;
        Thu, 18 Apr 2019 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611026;
        bh=Ry/fhiyEgWF0AA1ikIdMjZpB+mjIFoMWeKf5AtmVcDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UO0Dt4IzqD0tSvwXy44qr6gWJMjGaeoM80p6E2GFFV398/tRoDnUiFu2MoI09ZLbE
         XQ6rUQoq8MnUL5ufcW+aS+q1PKnYFdTfZEk3i/BD+KGLNK1EFgmq+eJeokBK6+R/67
         +WIb0+bOsR0OZSnZI0af7FaEm0lpFThfoHm6L92E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 07/93] ext4: avoid panic during forced reboot
Date:   Thu, 18 Apr 2019 19:56:45 +0200
Message-Id: <20190418160437.771182786@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



