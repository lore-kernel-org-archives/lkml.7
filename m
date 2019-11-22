Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E8EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B38F20721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420491;
	bh=SLDHED6xIDXCXATD9sFjZPXRCps2xfzuuQ0qam3yhVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iqNOpQvE8U/yOMX5bSIyYiGfc0nfyUn3jckyB4HjIagk1YCgRVtHaWbYgNB+ayJLf
	 gpi3BDFYOFAhMFsvwfsMPM0m4elg48rZxNh2yzYrmkGmFzEdZ4R22Hq7S5wix3i83M
	 XQUrNh3GDnTkuoXX5F6Gp4fQzRX0PGoVlex61czU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfKVLBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbfKVLB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:01:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F2920706;
        Fri, 22 Nov 2019 11:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420487;
        bh=SLDHED6xIDXCXATD9sFjZPXRCps2xfzuuQ0qam3yhVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1gJrn85hgpXLZQF1YJaLLVcTRU4adGL1A5VSiITsJDMlNUZ/pafQfGFIYZszIWih
         4ybB5TkhTZ9wrl2o+4vaGLT4lAOpFiyTOPhxxRcMJcOZfJ80+k4BpejujLbGmtKVdQ
         oTHwd9gvXEWfubL6Fgt/jrjQ9j1Is5g3IWbihxwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        NeilBrown <neilb@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/220] md: allow metadata updates while suspending an array - fix
Date:   Fri, 22 Nov 2019 11:27:24 +0100
Message-Id: <20191122100918.048620714@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



