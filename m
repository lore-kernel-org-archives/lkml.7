Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7BFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9B22087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049686;
	bh=wobtl2ID2xOCZw/F60fzXm4XfJORTmj909wu6rjfCpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LXm0+x6ZY4Alg6Rv0N8aAWt4GxUnUS+5KHt4i7CNxt5l6i3bjnrVU9Ai7QXjBfxfo
	 Eebz4aRAtxPE0scoIWuf/LITLT7/62yQ7I+GLb78tY8gyflKp8cnYv91pB/+5UkMcR
	 DGThQ0nRp9/LE8RXhdIKktkxa6O4jyFzPcrIKbs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCHMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfCHMym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:54:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1942E2085A;
        Fri,  8 Mar 2019 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049681;
        bh=wobtl2ID2xOCZw/F60fzXm4XfJORTmj909wu6rjfCpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzOvzwUfZz3HlOKySjxAsbNX4Dn8+0huaORQQnJDFh1KTvZnqinhl3oJxwhuqY66U
         PObicoZpcBZiWfLt7DVABgXPICj3JZc/YJE6FzJOtT4qBk2uZU69eSL9KzHfDgumQf
         auf5uUXa9+gYO3psf5BORqgTHjUUqagMx28CSSK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 4.20 03/76] binder: create node flag to request senders security context
Date:   Fri,  8 Mar 2019 13:49:15 +0100
Message-Id: <20190308124914.912944766@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todd Kjos <tkjos@android.com>

commit ec74136ded792deed80780a2f8baf3521eeb72f9 upstream.

To allow servers to verify client identity, allow a node
flag to be set that causes the sender's security context
to be delivered with the transaction. The BR_TRANSACTION
command is extended in BR_TRANSACTION_SEC_CTX to
contain a pointer to the security context string.

Signed-off-by: Todd Kjos <tkjos@google.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c            |  106 ++++++++++++++++++++++++++++--------
 include/uapi/linux/android/binder.h |   19 ++++++
 2 files changed, 102 insertions(+), 23 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -356,6 +356,8 @@ struct binder_error {
  *                        (invariant after initialized)
  * @min_priority:         minimum scheduling priority
  *                        (invariant after initialized)
+ * @txn_security_ctx:     require sender's security context
+ *                        (invariant after initialized)
  * @async_todo:           list of async work items
  *                        (protected by @proc->inner_lock)
  *
@@ -392,6 +394,7 @@ struct binder_node {
 		 * invariant after initialization
 		 */
 		u8 accept_fds:1;
+		u8 txn_security_ctx:1;
 		u8 min_priority;
 	};
 	bool has_async_transaction;
@@ -642,6 +645,7 @@ struct binder_transaction {
 	long	saved_priority;
 	kuid_t	sender_euid;
 	struct list_head fd_fixups;
+	binder_uintptr_t security_ctx;
 	/**
 	 * @lock:  protects @from, @to_proc, and @to_thread
 	 *
@@ -1165,6 +1169,7 @@ static struct binder_node *binder_init_n
 	node->work.type = BINDER_WORK_NODE;
 	node->min_priority = flags & FLAT_BINDER_FLAG_PRIORITY_MASK;
 	node->accept_fds = !!(flags & FLAT_BINDER_FLAG_ACCEPTS_FDS);
+	node->txn_security_ctx = !!(flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX);
 	spin_lock_init(&node->lock);
 	INIT_LIST_HEAD(&node->work.entry);
 	INIT_LIST_HEAD(&node->async_todo);
@@ -2777,6 +2782,8 @@ static void binder_transaction(struct bi
 	binder_size_t last_fixup_min_off = 0;
 	struct binder_context *context = proc->context;
 	int t_debug_id = atomic_inc_return(&binder_last_id);
+	char *secctx = NULL;
+	u32 secctx_sz = 0;
 
 	e = binder_transaction_log_add(&binder_transaction_log);
 	e->debug_id = t_debug_id;
@@ -3017,6 +3024,20 @@ static void binder_transaction(struct bi
 	t->flags = tr->flags;
 	t->priority = task_nice(current);
 
+	if (target_node && target_node->txn_security_ctx) {
+		u32 secid;
+
+		security_task_getsecid(proc->tsk, &secid);
+		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
+		if (ret) {
+			return_error = BR_FAILED_REPLY;
+			return_error_param = ret;
+			return_error_line = __LINE__;
+			goto err_get_secctx_failed;
+		}
+		extra_buffers_size += ALIGN(secctx_sz, sizeof(u64));
+	}
+
 	trace_binder_transaction(reply, t, target_node);
 
 	t->buffer = binder_alloc_new_buf(&target_proc->alloc, tr->data_size,
@@ -3033,6 +3054,19 @@ static void binder_transaction(struct bi
 		t->buffer = NULL;
 		goto err_binder_alloc_buf_failed;
 	}
+	if (secctx) {
+		size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
+				    ALIGN(tr->offsets_size, sizeof(void *)) +
+				    ALIGN(extra_buffers_size, sizeof(void *)) -
+				    ALIGN(secctx_sz, sizeof(u64));
+		char *kptr = t->buffer->data + buf_offset;
+
+		t->security_ctx = (uintptr_t)kptr +
+		    binder_alloc_get_user_buffer_offset(&target_proc->alloc);
+		memcpy(kptr, secctx, secctx_sz);
+		security_release_secctx(secctx, secctx_sz);
+		secctx = NULL;
+	}
 	t->buffer->debug_id = t->debug_id;
 	t->buffer->transaction = t;
 	t->buffer->target_node = target_node;
@@ -3302,6 +3336,9 @@ err_copy_data_failed:
 	t->buffer->transaction = NULL;
 	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
 err_binder_alloc_buf_failed:
+	if (secctx)
+		security_release_secctx(secctx, secctx_sz);
+err_get_secctx_failed:
 	kfree(tcomplete);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
 err_alloc_tcomplete_failed:
@@ -4033,11 +4070,13 @@ retry:
 
 	while (1) {
 		uint32_t cmd;
-		struct binder_transaction_data tr;
+		struct binder_transaction_data_secctx tr;
+		struct binder_transaction_data *trd = &tr.transaction_data;
 		struct binder_work *w = NULL;
 		struct list_head *list = NULL;
 		struct binder_transaction *t = NULL;
 		struct binder_thread *t_from;
+		size_t trsize = sizeof(*trd);
 
 		binder_inner_proc_lock(proc);
 		if (!binder_worklist_empty_ilocked(&thread->todo))
@@ -4232,8 +4271,8 @@ retry:
 		if (t->buffer->target_node) {
 			struct binder_node *target_node = t->buffer->target_node;
 
-			tr.target.ptr = target_node->ptr;
-			tr.cookie =  target_node->cookie;
+			trd->target.ptr = target_node->ptr;
+			trd->cookie =  target_node->cookie;
 			t->saved_priority = task_nice(current);
 			if (t->priority < target_node->min_priority &&
 			    !(t->flags & TF_ONE_WAY))
@@ -4243,22 +4282,23 @@ retry:
 				binder_set_nice(target_node->min_priority);
 			cmd = BR_TRANSACTION;
 		} else {
-			tr.target.ptr = 0;
-			tr.cookie = 0;
+			trd->target.ptr = 0;
+			trd->cookie = 0;
 			cmd = BR_REPLY;
 		}
-		tr.code = t->code;
-		tr.flags = t->flags;
-		tr.sender_euid = from_kuid(current_user_ns(), t->sender_euid);
+		trd->code = t->code;
+		trd->flags = t->flags;
+		trd->sender_euid = from_kuid(current_user_ns(), t->sender_euid);
 
 		t_from = binder_get_txn_from(t);
 		if (t_from) {
 			struct task_struct *sender = t_from->proc->tsk;
 
-			tr.sender_pid = task_tgid_nr_ns(sender,
-							task_active_pid_ns(current));
+			trd->sender_pid =
+				task_tgid_nr_ns(sender,
+						task_active_pid_ns(current));
 		} else {
-			tr.sender_pid = 0;
+			trd->sender_pid = 0;
 		}
 
 		ret = binder_apply_fd_fixups(t);
@@ -4289,15 +4329,20 @@ retry:
 			}
 			continue;
 		}
-		tr.data_size = t->buffer->data_size;
-		tr.offsets_size = t->buffer->offsets_size;
-		tr.data.ptr.buffer = (binder_uintptr_t)
+		trd->data_size = t->buffer->data_size;
+		trd->offsets_size = t->buffer->offsets_size;
+		trd->data.ptr.buffer = (binder_uintptr_t)
 			((uintptr_t)t->buffer->data +
 			binder_alloc_get_user_buffer_offset(&proc->alloc));
-		tr.data.ptr.offsets = tr.data.ptr.buffer +
+		trd->data.ptr.offsets = trd->data.ptr.buffer +
 					ALIGN(t->buffer->data_size,
 					    sizeof(void *));
 
+		tr.secctx = t->security_ctx;
+		if (t->security_ctx) {
+			cmd = BR_TRANSACTION_SEC_CTX;
+			trsize = sizeof(tr);
+		}
 		if (put_user(cmd, (uint32_t __user *)ptr)) {
 			if (t_from)
 				binder_thread_dec_tmpref(t_from);
@@ -4308,7 +4353,7 @@ retry:
 			return -EFAULT;
 		}
 		ptr += sizeof(uint32_t);
-		if (copy_to_user(ptr, &tr, sizeof(tr))) {
+		if (copy_to_user(ptr, &tr, trsize)) {
 			if (t_from)
 				binder_thread_dec_tmpref(t_from);
 
@@ -4317,7 +4362,7 @@ retry:
 
 			return -EFAULT;
 		}
-		ptr += sizeof(tr);
+		ptr += trsize;
 
 		trace_binder_transaction_received(t);
 		binder_stat_br(proc, thread, cmd);
@@ -4325,16 +4370,18 @@ retry:
 			     "%d:%d %s %d %d:%d, cmd %d size %zd-%zd ptr %016llx-%016llx\n",
 			     proc->pid, thread->pid,
 			     (cmd == BR_TRANSACTION) ? "BR_TRANSACTION" :
-			     "BR_REPLY",
+				(cmd == BR_TRANSACTION_SEC_CTX) ?
+				     "BR_TRANSACTION_SEC_CTX" : "BR_REPLY",
 			     t->debug_id, t_from ? t_from->proc->pid : 0,
 			     t_from ? t_from->pid : 0, cmd,
 			     t->buffer->data_size, t->buffer->offsets_size,
-			     (u64)tr.data.ptr.buffer, (u64)tr.data.ptr.offsets);
+			     (u64)trd->data.ptr.buffer,
+			     (u64)trd->data.ptr.offsets);
 
 		if (t_from)
 			binder_thread_dec_tmpref(t_from);
 		t->buffer->allow_user_free = 1;
-		if (cmd == BR_TRANSACTION && !(t->flags & TF_ONE_WAY)) {
+		if (cmd != BR_REPLY && !(t->flags & TF_ONE_WAY)) {
 			binder_inner_proc_lock(thread->proc);
 			t->to_parent = thread->transaction_stack;
 			t->to_thread = thread;
@@ -4676,7 +4723,8 @@ out:
 	return ret;
 }
 
-static int binder_ioctl_set_ctx_mgr(struct file *filp)
+static int binder_ioctl_set_ctx_mgr(struct file *filp,
+				    struct flat_binder_object *fbo)
 {
 	int ret = 0;
 	struct binder_proc *proc = filp->private_data;
@@ -4705,7 +4753,7 @@ static int binder_ioctl_set_ctx_mgr(stru
 	} else {
 		context->binder_context_mgr_uid = curr_euid;
 	}
-	new_node = binder_new_node(proc, NULL);
+	new_node = binder_new_node(proc, fbo);
 	if (!new_node) {
 		ret = -ENOMEM;
 		goto out;
@@ -4828,8 +4876,20 @@ static long binder_ioctl(struct file *fi
 		binder_inner_proc_unlock(proc);
 		break;
 	}
+	case BINDER_SET_CONTEXT_MGR_EXT: {
+		struct flat_binder_object fbo;
+
+		if (copy_from_user(&fbo, ubuf, sizeof(fbo))) {
+			ret = -EINVAL;
+			goto err;
+		}
+		ret = binder_ioctl_set_ctx_mgr(filp, &fbo);
+		if (ret)
+			goto err;
+		break;
+	}
 	case BINDER_SET_CONTEXT_MGR:
-		ret = binder_ioctl_set_ctx_mgr(filp);
+		ret = binder_ioctl_set_ctx_mgr(filp, NULL);
 		if (ret)
 			goto err;
 		break;
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -41,6 +41,14 @@ enum {
 enum {
 	FLAT_BINDER_FLAG_PRIORITY_MASK = 0xff,
 	FLAT_BINDER_FLAG_ACCEPTS_FDS = 0x100,
+
+	/**
+	 * @FLAT_BINDER_FLAG_TXN_SECURITY_CTX: request security contexts
+	 *
+	 * Only when set, causes senders to include their security
+	 * context
+	 */
+	FLAT_BINDER_FLAG_TXN_SECURITY_CTX = 0x1000,
 };
 
 #ifdef BINDER_IPC_32BIT
@@ -218,6 +226,7 @@ struct binder_node_info_for_ref {
 #define BINDER_VERSION			_IOWR('b', 9, struct binder_version)
 #define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debug_info)
 #define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_info_for_ref)
+#define BINDER_SET_CONTEXT_MGR_EXT	_IOW('b', 13, struct flat_binder_object)
 
 /*
  * NOTE: Two special error codes you should check for when calling
@@ -276,6 +285,11 @@ struct binder_transaction_data {
 	} data;
 };
 
+struct binder_transaction_data_secctx {
+	struct binder_transaction_data transaction_data;
+	binder_uintptr_t secctx;
+};
+
 struct binder_transaction_data_sg {
 	struct binder_transaction_data transaction_data;
 	binder_size_t buffers_size;
@@ -311,6 +325,11 @@ enum binder_driver_return_protocol {
 	BR_OK = _IO('r', 1),
 	/* No parameters! */
 
+	BR_TRANSACTION_SEC_CTX = _IOR('r', 2,
+				      struct binder_transaction_data_secctx),
+	/*
+	 * binder_transaction_data_secctx: the received command.
+	 */
 	BR_TRANSACTION = _IOR('r', 2, struct binder_transaction_data),
 	BR_REPLY = _IOR('r', 3, struct binder_transaction_data),
 	/*


