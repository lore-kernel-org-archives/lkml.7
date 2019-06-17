Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E0C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5E420645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f5UAXSGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfFQJEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:04:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFQJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PpYQ2soWPswvLhDQWVJBpDTx1zwieWRyNiFKfAt130o=; b=f5UAXSGKIFpK1f10hgQTLZu/X1
        lVtEehzoCe9XDsxcJyvr0gOicIysP0NbCnpnhLaSaRz0S+uE0aBhpP/Mt6vJ71gZhiYuMATO7huer
        4DaDoTffFylmZ19S5BgvghHlZ7qqpWsspPUHBHQbYSdvP2+ep1SDg9ngcubD3tnx2kHNeks9wmJLC
        J3cebcDLOHfmimhOhnwCbXXQZR3vGLJoSO8/m20AxcjDSkAHc+l+UpCDvsSDwG/ycWE4RRwzhC7jE
        blAXuaO4FNmAlKXImh9eNGajHMXFrXFRwpbXP9XbnqkIwA8/j7rnLuzprC+Yx+Da9R+oOfskhyZ3T
        NJ0ebO7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcnYA-0001lV-Aq; Mon, 17 Jun 2019 09:03:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC49C201D1C9A; Mon, 17 Jun 2019 11:03:35 +0200 (CEST)
Date:   Mon, 17 Jun 2019 11:03:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, rostedt@goodmis.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: [RFC][PATCH] module: Propagate MODULE_STATE_COMING notifier errors
Message-ID: <20190617090335.GX3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some module notifiers; such as jump_label_module_notifier(),
tracepoint_module_notify(); can fail the MODULE_STATE_COMING callback
(due to -ENOMEM for example). However module.c:prepare_coming_module()
ignores all such errors, even though this function can already fail due
to klp_module_coming().

Therefore, propagate the notifier error and ensure we call the GOING
notifier when we do fail, to ensure cleanup for all notifiers that
didn't fail. Auditing all notifiers to make sure calling GOING without
COMING first is OK found no obvious problems with that, but it did find
a whole bunch of issues with return values, so clean those up too.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/oprofile/buffer_sync.c | 4 ++--
 kernel/module.c                | 9 +++++----
 kernel/trace/bpf_trace.c       | 8 ++++++--
 kernel/trace/trace.c           | 2 +-
 kernel/trace/trace_events.c    | 2 +-
 kernel/trace/trace_printk.c    | 4 ++--
 kernel/tracepoint.c            | 2 +-
 7 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
index ac27f3d3fbb4..4f61b1b45e0d 100644
--- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -116,7 +116,7 @@ module_load_notify(struct notifier_block *self, unsigned long val, void *data)
 {
 #ifdef CONFIG_MODULES
 	if (val != MODULE_STATE_COMING)
-		return 0;
+		return NOTIFY_DONE;
 
 	/* FIXME: should we process all CPU buffers ? */
 	mutex_lock(&buffer_mutex);
@@ -124,7 +124,7 @@ module_load_notify(struct notifier_block *self, unsigned long val, void *data)
 	add_event_entry(MODULE_LOADED_CODE);
 	mutex_unlock(&buffer_mutex);
 #endif
-	return 0;
+	return NOTIFY_OK;
 }
 
 
diff --git a/kernel/module.c b/kernel/module.c
index 80c7c09584cf..0c4831f46380 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3638,9 +3638,10 @@ static int prepare_coming_module(struct module *mod)
 	if (err)
 		return err;
 
-	blocking_notifier_call_chain(&module_notify_list,
-				     MODULE_STATE_COMING, mod);
-	return 0;
+	ret = blocking_notifier_call_chain(&module_notify_list,
+					   MODULE_STATE_COMING, mod);
+	ret = notifier_to_errno(ret);
+	return ret;
 }
 
 static int unknown_module_param_cb(char *param, char *val, const char *modname,
@@ -3780,7 +3781,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	err = prepare_coming_module(mod);
 	if (err)
-		goto bug_cleanup;
+		goto coming_cleanup;
 
 	/* Module is ready to execute: parsing args may do that. */
 	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f92d6ad5e080..18afa75f5208 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1302,10 +1302,11 @@ static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
 {
 	struct bpf_trace_module *btm, *tmp;
 	struct module *mod = module;
+	int ret = 0;
 
 	if (mod->num_bpf_raw_events == 0 ||
 	    (op != MODULE_STATE_COMING && op != MODULE_STATE_GOING))
-		return 0;
+		goto out;
 
 	mutex_lock(&bpf_module_mutex);
 
@@ -1315,6 +1316,8 @@ static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
 		if (btm) {
 			btm->module = module;
 			list_add(&btm->list, &bpf_trace_modules);
+		} else {
+			ret = -ENOMEM;
 		}
 		break;
 	case MODULE_STATE_GOING:
@@ -1330,7 +1333,8 @@ static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
 
 	mutex_unlock(&bpf_module_mutex);
 
-	return 0;
+out:
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block bpf_module_nb = {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c80521fd436..6757e7392f1a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8685,7 +8685,7 @@ static int trace_module_notify(struct notifier_block *self,
 		break;
 	}
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0ce3db67f556..32098dbab72e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2450,7 +2450,7 @@ static int trace_module_notify(struct notifier_block *self,
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index c3fd849d4a8f..d5394e02163f 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -95,7 +95,7 @@ static int module_trace_bprintk_format_notify(struct notifier_block *self,
 		if (val == MODULE_STATE_COMING)
 			hold_module_trace_bprintk_format(start, end);
 	}
-	return 0;
+	return NOTIFY_OK;
 }
 
 /*
@@ -173,7 +173,7 @@ __init static int
 module_trace_bprintk_format_notify(struct notifier_block *self,
 		unsigned long val, void *data)
 {
-	return 0;
+	return NOTIFY_OK;
 }
 static inline const char **
 find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index df3ade14ccbd..9ce0a510e6af 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -521,7 +521,7 @@ static int tracepoint_module_notify(struct notifier_block *self,
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-	return ret;
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block tracepoint_module_nb = {
