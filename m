Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69380C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41814206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520598;
	bh=3nlPpKE9KOPLphkL/bgbzzcQNFy/eBNtAUfrYHGEUHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mc0YGiLWr/Nj8dp0x4bl1OdRLTmiMcWi3sW3Peb8nwV8eZup7ESIBxNHXxkSJoHP3
	 9Iis10TPQLcVO6uc2vQNTlNdO3RyK/UTFbJXf4qk9GCtX9tYS1htIWpduJniTFkLrf
	 n3qc5wFVXL0aa2x1Z4U5D+Wu2jTXElLK/+hL79y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbfLPSU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732072AbfLPSUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:20:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F2420717;
        Mon, 16 Dec 2019 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520424;
        bh=3nlPpKE9KOPLphkL/bgbzzcQNFy/eBNtAUfrYHGEUHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riEyj3BflANYdJiYFgEIUuP0Qvf1kCuJGbhvTlQHGvu8wUiZPQuKgUQ4CvkQ8SE9B
         rl3oqPimpHylu6Sd+nEbEV8qiDNUrVHJA/ooopmzEO8n9GewG18SmJbgL5owsUx18I
         Zawl+j4TcfZq/O51kuw2Oc0Sp3VWQVctTxyQtOU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5.4 149/177] quota: Check that quota is not dirty before release
Date:   Mon, 16 Dec 2019 18:50:05 +0100
Message-Id: <20191216174847.743304736@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

commit df4bb5d128e2c44848aeb36b7ceceba3ac85080d upstream.

There is a race window where quota was redirted once we drop dq_list_lock inside dqput(),
but before we grab dquot->dq_lock inside dquot_release()

TASK1                                                       TASK2 (chowner)
->dqput()
  we_slept:
    spin_lock(&dq_list_lock)
    if (dquot_dirty(dquot)) {
          spin_unlock(&dq_list_lock);
          dquot->dq_sb->dq_op->write_dquot(dquot);
          goto we_slept
    if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
          spin_unlock(&dq_list_lock);
          dquot->dq_sb->dq_op->release_dquot(dquot);
                                                            dqget()
							    mark_dquot_dirty()
							    dqput()
          goto we_slept;
        }
So dquot dirty quota will be released by TASK1, but on next we_sleept loop
we detect this and call ->write_dquot() for it.
XFSTEST: https://github.com/dmonakhov/xfstests/commit/440a80d4cbb39e9234df4d7240aee1d551c36107

Link: https://lore.kernel.org/r/20191031103920.3919-2-dmonakhov@openvz.org
CC: stable@vger.kernel.org
Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ocfs2/quota_global.c  |    2 +-
 fs/quota/dquot.c         |    2 +-
 include/linux/quotaops.h |   10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -728,7 +728,7 @@ static int ocfs2_release_dquot(struct dq
 
 	mutex_lock(&dquot->dq_lock);
 	/* Check whether we are not racing with some other dqget() */
-	if (atomic_read(&dquot->dq_count) > 1)
+	if (dquot_is_busy(dquot))
 		goto out;
 	/* Running from downconvert thread? Postpone quota processing to wq */
 	if (current == osb->dc_task) {
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -497,7 +497,7 @@ int dquot_release(struct dquot *dquot)
 
 	mutex_lock(&dquot->dq_lock);
 	/* Check whether we are not racing with some other dqget() */
-	if (atomic_read(&dquot->dq_count) > 1)
+	if (dquot_is_busy(dquot))
 		goto out_dqlock;
 	if (dqopt->ops[dquot->dq_id.type]->release_dqblk) {
 		ret = dqopt->ops[dquot->dq_id.type]->release_dqblk(dquot);
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -54,6 +54,16 @@ static inline struct dquot *dqgrab(struc
 	atomic_inc(&dquot->dq_count);
 	return dquot;
 }
+
+static inline bool dquot_is_busy(struct dquot *dquot)
+{
+	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
+		return true;
+	if (atomic_read(&dquot->dq_count) > 1)
+		return true;
+	return false;
+}
+
 void dqput(struct dquot *dquot);
 int dquot_scan_active(struct super_block *sb,
 		      int (*fn)(struct dquot *dquot, unsigned long priv),


