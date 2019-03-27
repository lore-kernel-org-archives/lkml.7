Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6558BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5E42064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714073;
	bh=IK+Q3u2yyokmjWTGqHRwKm2/iafLGkkIFQoYl/IFvOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AvYNz/th9XfXFzR+HthSYYUZ+4mpJxOi9S1tv4uMVEGypVI7Lgcz+wI1aDyBJjOiR
	 n6AzKLYcfnggWarqb1NH+qIlo6lFhnVeZ2b81HOos3Bzygo8XFE+gQlcpB7TpjbMMo
	 BL+QTIgsRovzlwaaC6Os5zw6VWZooUcl8lLHjG3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbfC0TOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387926AbfC0SJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C07A2147C;
        Wed, 27 Mar 2019 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710181;
        bh=IK+Q3u2yyokmjWTGqHRwKm2/iafLGkkIFQoYl/IFvOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAecO8yWwJC9nW9st8/Rmlo3MeIWoJSAwm7UgdNCXfqbNNM2zYIJ7BKKdUPkbiJxz
         3MN6Ygga/Mb+Zlx+++aTAW20H3tf20f5inFNfn0Zn2r1xCDVt3OUuUtP1FN8gcnulU
         qzPLyhfzBIfo05Go+evoBiS6v4mVtU54RUWFsLcM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 238/262] audit: hand taken context to audit_kill_trees for syscall logging
Date:   Wed, 27 Mar 2019 14:01:33 -0400
Message-Id: <20190327180158.10245-238-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Guy Briggs <rgb@redhat.com>

[ Upstream commit 9e36a5d49c3a6fc4a2e0ba2dc11b27c4a8ae6303 ]

Since the context is derived from the task parameter handed to
__audit_free(), hand the context to audit_kill_trees() so it can be used
to associate with a syscall record.  This requires adding the context
parameter to kill_rules() rather than using the current audit_context.

The callers of trim_marked() and evict_chunk() still have their context.

The EOE record was being issued prior to the pruning of the killed_tree
list.

Move the kill_trees call before the audit_log_exit call in
__audit_free() and __audit_syscall_exit() so that any pruned trees
CONFIG_CHANGE records are included with the associated syscall event by
the user library due to the EOE record flagging the end of the event.

See: https://github.com/linux-audit/audit-kernel/issues/50
See: https://github.com/linux-audit/audit-kernel/issues/59

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
[PM: fixed merge fuzz in kernel/audit_tree.c]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/audit.h      |  4 ++--
 kernel/audit_tree.c | 19 +++++++++++--------
 kernel/auditsc.c    | 12 ++++++------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 91421679a168..6ffb70575082 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -314,7 +314,7 @@ extern void audit_trim_trees(void);
 extern int audit_tag_tree(char *old, char *new);
 extern const char *audit_tree_path(struct audit_tree *tree);
 extern void audit_put_tree(struct audit_tree *tree);
-extern void audit_kill_trees(struct list_head *list);
+extern void audit_kill_trees(struct audit_context *context);
 #else
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL
@@ -323,7 +323,7 @@ extern void audit_kill_trees(struct list_head *list);
 #define audit_put_tree(tree) (void)0
 #define audit_tag_tree(old, new) -EINVAL
 #define audit_tree_path(rule) ""	/* never called */
-#define audit_kill_trees(list) BUG()
+#define audit_kill_trees(context) BUG()
 #endif
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index d4af4d97f847..abfb112f26aa 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -524,13 +524,14 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 	return 0;
 }
 
-static void audit_tree_log_remove_rule(struct audit_krule *rule)
+static void audit_tree_log_remove_rule(struct audit_context *context,
+				       struct audit_krule *rule)
 {
 	struct audit_buffer *ab;
 
 	if (!audit_enabled)
 		return;
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "op=remove_rule dir=");
@@ -540,7 +541,7 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
 	audit_log_end(ab);
 }
 
-static void kill_rules(struct audit_tree *tree)
+static void kill_rules(struct audit_context *context, struct audit_tree *tree)
 {
 	struct audit_krule *rule, *next;
 	struct audit_entry *entry;
@@ -551,7 +552,7 @@ static void kill_rules(struct audit_tree *tree)
 		list_del_init(&rule->rlist);
 		if (rule->tree) {
 			/* not a half-baked one */
-			audit_tree_log_remove_rule(rule);
+			audit_tree_log_remove_rule(context, rule);
 			if (entry->rule.exe)
 				audit_remove_mark(entry->rule.exe);
 			rule->tree = NULL;
@@ -633,7 +634,7 @@ static void trim_marked(struct audit_tree *tree)
 		tree->goner = 1;
 		spin_unlock(&hash_lock);
 		mutex_lock(&audit_filter_mutex);
-		kill_rules(tree);
+		kill_rules(audit_context(), tree);
 		list_del_init(&tree->list);
 		mutex_unlock(&audit_filter_mutex);
 		prune_one(tree);
@@ -973,8 +974,10 @@ static void audit_schedule_prune(void)
  * ... and that one is done if evict_chunk() decides to delay until the end
  * of syscall.  Runs synchronously.
  */
-void audit_kill_trees(struct list_head *list)
+void audit_kill_trees(struct audit_context *context)
 {
+	struct list_head *list = &context->killed_trees;
+
 	audit_ctl_lock();
 	mutex_lock(&audit_filter_mutex);
 
@@ -982,7 +985,7 @@ void audit_kill_trees(struct list_head *list)
 		struct audit_tree *victim;
 
 		victim = list_entry(list->next, struct audit_tree, list);
-		kill_rules(victim);
+		kill_rules(context, victim);
 		list_del_init(&victim->list);
 
 		mutex_unlock(&audit_filter_mutex);
@@ -1017,7 +1020,7 @@ static void evict_chunk(struct audit_chunk *chunk)
 		list_del_init(&owner->same_root);
 		spin_unlock(&hash_lock);
 		if (!postponed) {
-			kill_rules(owner);
+			kill_rules(audit_context(), owner);
 			list_move(&owner->list, &prune_list);
 			need_prune = 1;
 		} else {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6593a5207fb0..b585ceb2f7a2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1444,6 +1444,9 @@ void __audit_free(struct task_struct *tsk)
 	if (!context)
 		return;
 
+	if (!list_empty(&context->killed_trees))
+		audit_kill_trees(context);
+
 	/* We are called either by do_exit() or the fork() error handling code;
 	 * in the former case tsk == current and in the latter tsk is a
 	 * random task_struct that doesn't doesn't have any meaningful data we
@@ -1460,9 +1463,6 @@ void __audit_free(struct task_struct *tsk)
 			audit_log_exit();
 	}
 
-	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(&context->killed_trees);
-
 	audit_set_context(tsk, NULL);
 	audit_free_context(context);
 }
@@ -1537,6 +1537,9 @@ void __audit_syscall_exit(int success, long return_code)
 	if (!context)
 		return;
 
+	if (!list_empty(&context->killed_trees))
+		audit_kill_trees(context);
+
 	if (!context->dummy && context->in_syscall) {
 		if (success)
 			context->return_valid = AUDITSC_SUCCESS;
@@ -1571,9 +1574,6 @@ void __audit_syscall_exit(int success, long return_code)
 	context->in_syscall = 0;
 	context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
 
-	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(&context->killed_trees);
-
 	audit_free_names(context);
 	unroll_tree_refs(context, NULL, 0);
 	audit_free_aux(context);
-- 
2.19.1

