Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9087C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862662084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554220988;
	bh=4N+VPm5f1/zQnNNJbcqUM3GEbcauyNmfi+aHALhvDLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c0zOuQDfx3+8n5CkEXjqQ0DpNgjmYguKR3cTLNcijPfH/02Jy/tSXnB1LRd7ELplq
	 CdGYrSeLJ4tvBZ7ZNm5oCwz6ajbWpiOPn+BzDNLHD1yUN+qiSMKWT1kp+ynPuKckQ6
	 I18AFzRt4LQhkuz2VqCzsCrGdzvdZTeXmOc8qHe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfDBQDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbfDBQCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:02:55 -0400
Received: from lenoir.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E180E2084C;
        Tue,  2 Apr 2019 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554220975;
        bh=4N+VPm5f1/zQnNNJbcqUM3GEbcauyNmfi+aHALhvDLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lxi+VPkIeZS33NpQ/6gNa/R+Rvabm87WICBuhggWDFbYv+PzZ9YYclaBTfh29bX1K
         DzngTRTS4D5XNfBLhBTRfCNitYGtj5cJVkRTTVgPVff2km7cx42MPYwgAZZF3Z86jq
         ipUOZEe96GrIIk26j78CRbNPdxGyE5CZ8NbS/Ty0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/4] locking/lockdep: Map remaining magic numbers to lock usage mask names
Date:   Tue,  2 Apr 2019 18:02:42 +0200
Message-Id: <20190402160244.32434-3-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402160244.32434-1-frederic@kernel.org>
References: <20190402160244.32434-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify the code with mapping some more constant numbers that haven't
been named after their corresponding LOCK_USAGE_* symbol.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9c5819ef4a28..2288aa2fa4c6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -516,11 +516,11 @@ static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
 {
 	char c = '.';
 
-	if (class->usage_mask & lock_flag(bit + 2))
+	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
 		c = '+';
 	if (class->usage_mask & lock_flag(bit)) {
 		c = '-';
-		if (class->usage_mask & lock_flag(bit + 2))
+		if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
 			c = '?';
 	}
 
@@ -1971,7 +1971,10 @@ static const char *state_rnames[] = {
 
 static inline const char *state_name(enum lock_usage_bit bit)
 {
-	return (bit & LOCK_USAGE_READ_MASK) ? state_rnames[bit >> 2] : state_names[bit >> 2];
+	if (bit & LOCK_USAGE_READ_MASK)
+		return state_rnames[bit >> LOCK_USAGE_DIR_MASK];
+	else
+		return state_names[bit >> LOCK_USAGE_DIR_MASK];
 }
 
 static int exclusive_bit(int new_bit)
@@ -3017,7 +3020,7 @@ static int (*state_verbose_f[])(struct lock_class *class) = {
 static inline int state_verbose(enum lock_usage_bit bit,
 				struct lock_class *class)
 {
-	return state_verbose_f[bit >> 2](class);
+	return state_verbose_f[bit >> LOCK_USAGE_DIR_MASK](class);
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-- 
2.21.0

