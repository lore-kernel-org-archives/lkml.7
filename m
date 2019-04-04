Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F010C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1206C20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369590;
	bh=PUxZ6XTFiERQDXhCNU4XSAB8j4Rrqq0bUb63Er4ArQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNglxj1rDGYT0t6qwSErwIxIvOwRLPOQMp0F6kGWl+2ze5zNIzY5lrDzlSszGhvPW
	 Zg6Ex8BWpWil0npoC5wSPe5of9uzZ84lKZ0RyydfMKqxPjd/1J5errrwVgnocaUgfG
	 I4rUS5FF51ljISpm2jT6/TwQWX55p+QLHUz2KcTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbfDDJTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388283AbfDDJR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C950920652;
        Thu,  4 Apr 2019 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369475;
        bh=PUxZ6XTFiERQDXhCNU4XSAB8j4Rrqq0bUb63Er4ArQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0qiuxTa+IlIgGmyZ+6kratkHGlXEmFx2KtzWjgBODuFrtkPn/Fv6qtrtP37H4Sp+i
         3Kb1XBdp/39tysLVLa242u524vcXkU0EwyFpsNX5iUXNPYbR6S4XxLS271LYy7l2rZ
         7dOWayozDetRuoArQ2iNBkC1mU/BB4wTWfFIe17E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 222/246] audit: hand taken context to audit_kill_trees for syscall logging
Date:   Thu,  4 Apr 2019 10:48:42 +0200
Message-Id: <20190404084626.979243425@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



