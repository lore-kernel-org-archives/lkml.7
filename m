Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD24C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158C021835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v1HIiNoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfJGLYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58462 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfJGLYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/dXEM5OM4zrNkl3+H0fx7UYSDgq0oZpTD7FikSQnxaI=; b=v1HIiNoWA/ooj2MTshslA7lR2T
        qzcA9/BEQX+TaoIgjVD/1ispR2dsZMJD70ugVzVnvBsk/VVvLpQRxLS+Z/kP4bMXAr/n3wFJLzs4p
        xwPmkEigNXaWOQgaCDx8gVc4Pi6m7LyTffQ4/b/VjlEDp54eTZOKxKdtpW/muxTLRGCigDVZt5Z14
        s7Qec/gHvlQQ5uk5Ys6SIGx52CJPbuIUeXXlWF2xUL07OEcs6Pi4peSsXl8M1TPBiNbXlIkESFLZf
        qfeRBtbzoCBiwPMZazq22ICGJ/FHObIKgG+7p9BFOCYFMF/qhqZm5gEXrItf14kbC4vAlSX8GqgAD
        ULQkPLmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0002BU-AK; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0080F306C06;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8A05620244FAE; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007082700.08643163.5@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:25:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Robert Richter <rric@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v2 2/4] module: Fix up module_notifier return values.
References: <20191007082541.64146933.7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While auditing all module notifiers I noticed a whole bunch of fail
wrt the return value. Notifiers have a 'special' return semantics.

As is; NOTIFY_DONE vs NOTIFY_OK is a bit vague; but
notifier_from_errno(0) results in NOTIFY_OK and NOTIFY_DONE has a
comment that says "Don't care".

>From this I've used NOTIFY_DONE when the function completely ignores
the callback and notifier_to_error() isn't used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Robert Richter <rric@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: oprofile-list@lists.sf.net
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Song Liu <songliubraving@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
---
 drivers/oprofile/buffer_sync.c |    4 ++--
 kernel/trace/bpf_trace.c       |    8 ++++++--
 kernel/trace/trace.c           |    2 +-
 kernel/trace/trace_events.c    |    2 +-
 kernel/trace/trace_printk.c    |    4 ++--
 kernel/tracepoint.c            |    2 +-
 6 files changed, 13 insertions(+), 9 deletions(-)

--- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -116,7 +116,7 @@ module_load_notify(struct notifier_block
 {
 #ifdef CONFIG_MODULES
 	if (val != MODULE_STATE_COMING)
-		return 0;
+		return NOTIFY_DONE;
 
 	/* FIXME: should we process all CPU buffers ? */
 	mutex_lock(&buffer_mutex);
@@ -124,7 +124,7 @@ module_load_notify(struct notifier_block
 	add_event_entry(MODULE_LOADED_CODE);
 	mutex_unlock(&buffer_mutex);
 #endif
-	return 0;
+	return NOTIFY_OK;
 }
 
 
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1451,10 +1451,11 @@ static int bpf_event_notify(struct notif
 {
 	struct bpf_trace_module *btm, *tmp;
 	struct module *mod = module;
+	int ret = 0;
 
 	if (mod->num_bpf_raw_events == 0 ||
 	    (op != MODULE_STATE_COMING && op != MODULE_STATE_GOING))
-		return 0;
+		goto out;
 
 	mutex_lock(&bpf_module_mutex);
 
@@ -1464,6 +1465,8 @@ static int bpf_event_notify(struct notif
 		if (btm) {
 			btm->module = module;
 			list_add(&btm->list, &bpf_trace_modules);
+		} else {
+			ret = -ENOMEM;
 		}
 		break;
 	case MODULE_STATE_GOING:
@@ -1479,7 +1482,8 @@ static int bpf_event_notify(struct notif
 
 	mutex_unlock(&bpf_module_mutex);
 
-	return 0;
+out:
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block bpf_module_nb = {
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8696,7 +8696,7 @@ static int trace_module_notify(struct no
 		break;
 	}
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2442,7 +2442,7 @@ static int trace_module_notify(struct no
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -95,7 +95,7 @@ static int module_trace_bprintk_format_n
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
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -521,7 +521,7 @@ static int tracepoint_module_notify(stru
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-	return ret;
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block tracepoint_module_nb = {


