Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793AAC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34428208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="eb5GWFAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VoxY5jWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfHIVra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:47:30 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52635 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbfHIVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:47:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 846F720C1;
        Fri,  9 Aug 2019 17:47:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Aug 2019 17:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=iSQMMbGOyK35Z
        pi3epLBW+Ua8ZuM4GNSQRMB+9j5e0E=; b=eb5GWFAnuibwE0HmsRAmqCYJXvFVY
        1hgQMqOTqGaiTewg+LnPJe9zv+g45Qor+NZOvO202illoM3Eo9eiwpIrSxd91iRX
        ZNiINxw/vg5umzTcDrnkRjcqaqPzhxu/qffaVSe9KtULe6n3MLmWRk8okpfFXFPZ
        vKqEmcLHA/hZOMyr/PBpIAyo6n6G22Is5kZ/xF+dAKX4kTbgG67BTTEfZq/LFJxl
        v4NLwD6NAeijgRx8au+44UCioIbBl9l3dT/fdEDzo/GnywvAlDQQRe0YD19OerwG
        KqB3Z5UO/Y5EHKMSE418dvq5M4v8J2c0NyGusrUquMaTWWiGRVcf2+c2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=iSQMMbGOyK35Zpi3epLBW+Ua8ZuM4GNSQRMB+9j5e0E=; b=VoxY5jWY
        Jm97B9wyX1qhIT9TzKWwycNGwwP9AqxUwn6B+hP9uO/INGuGDpnR2QCvTMzQIkBj
        G1P8JpVCTXhVBJm+XJZQN0u8qZ2DRafbbm6Etx3CgR+XiZh62qFaQANU1GsXb74F
        zBAq3RMtj81u5Hq13sfeeRVmzw7uHCbBLNXvldb0HoblQisnYS8zyDv/rb73av5a
        xbwBE9hnmemiNl0sjjmdtEmvYopZM3gCjETcoQyVZPwthUYQJDdWUCiPaKbW1C6M
        sXO6WI3SEybpyjibSQ+ykmU85iSDMiPQ0u6AhyeA+m3hO2ejm9BSG4a/syd8iLb7
        6dVPjgHkoRbRdg==
X-ME-Sender: <xms:8OlNXZw8rzQRxxMZqmHZ6hGChXmTnyPllEFMxBsPUpbWQZ0GoWb1RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddukedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:8OlNXXh8WWk4M5qb9nrD9m0si7GpxjadECbQ6CaAXaoT3giwkQUNFA>
    <xmx:8OlNXcoS3Ab-TzrMewZe-iygzQELyV8drdXbfdKfBuba75AvVe8ojw>
    <xmx:8OlNXehOshnbMKxLf1P_--CoR-OV5VTv7HMJICTymO0yXoissMr30g>
    <xmx:8OlNXaDc6cVqj6rC3KgVW6N91OsQXgTdA787o2mvddJXCDQazTP6Sg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id D4F50380083;
        Fri,  9 Aug 2019 17:47:26 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        peterz@infraded.org, mingo@redhat.com, acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 1/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE ioctl
Date:   Fri,  9 Aug 2019 14:46:39 -0700
Message-Id: <20190809214642.12078-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809214642.12078-1-dxu@dxuuu.xyz>
References: <20190809214642.12078-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's useful to know [uk]probe's nmissed and nhit stats. For example with
tracing tools, it's important to know when events may have been lost.
debugfs currently exposes a control file to get this information, but
it is not compatible with probes registered with the perf API.

While bpf programs may be able to manually count nhit, there is no way
to gather nmissed. In other words, it is currently not possible to
retrieve information about FD-based probes.

This patch adds a new ioctl that lets users query nmissed (as well as
nhit for completeness). We currently only add support for [uk]probes
but leave the possibility open for other probes like tracepoint.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/trace_events.h    | 12 ++++++++++++
 include/uapi/linux/perf_event.h | 19 +++++++++++++++++++
 kernel/events/core.c            | 20 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c     | 23 +++++++++++++++++++++++
 kernel/trace/trace_uprobe.c     | 23 +++++++++++++++++++++++
 5 files changed, 97 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5150436783e8..61558f19696a 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -586,6 +586,12 @@ extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **symbol,
 			       u64 *probe_offset, u64 *probe_addr,
 			       bool perf_type_tracepoint);
+extern int perf_kprobe_event_query(struct perf_event *event, void __user *info);
+#else
+int perf_kprobe_event_query(struct perf_event *event, void __user *info)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
 extern int  perf_uprobe_init(struct perf_event *event,
@@ -594,6 +600,12 @@ extern void perf_uprobe_destroy(struct perf_event *event);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
 			       u64 *probe_offset, bool perf_type_tracepoint);
+extern int perf_uprobe_event_query(struct perf_event *event, void __user *info);
+#else
+int perf_uprobe_event_query(struct perf_event *event, void __user *info)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
 				     char *filter_str);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..65faa9b2a3b4 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -447,6 +447,24 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
+/*
+ * Structure used by below PERF_EVENT_IOC_QUERY_PROBE command
+ * to query information about the probe attached to the perf
+ * event. Currently only supports [uk]probes.
+ */
+struct perf_event_query_probe {
+	/*
+	 * Set by the kernel to indicate number of times this probe
+	 * was temporarily disabled
+	 */
+	__u64	nmissed;
+	/*
+	 * Set by the kernel to indicate number of times this probe
+	 * was hit
+	 */
+	__u64	nhit;
+};
+
 /*
  * Ioctls that can be done on a perf event fd:
  */
@@ -462,6 +480,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_QUERY_PROBE		_IOR('$', 12, struct perf_event_query_probe *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 026a14541a38..3e0fe6eaaad0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5060,6 +5060,8 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
+static int perf_probe_event_query(struct perf_event *event,
+				    void __user *info);
 
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
@@ -5143,6 +5145,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+#if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
+	case PERF_EVENT_IOC_QUERY_PROBE:
+		return perf_probe_event_query(event, (void __user *)arg);
+#endif
 	default:
 		return -ENOTTY;
 	}
@@ -8833,6 +8839,20 @@ static inline void perf_tp_register(void)
 #endif
 }
 
+static int perf_probe_event_query(struct perf_event *event,
+				    void __user *info)
+{
+#ifdef CONFIG_KPROBE_EVENTS
+	if (event->attr.type == perf_kprobe.type)
+		return perf_kprobe_event_query(event, (void __user *)info);
+#endif
+#ifdef CONFIG_UPROBE_EVENTS
+	if (event->attr.type == perf_uprobe.type)
+		return perf_uprobe_event_query(event, (void __user *)info);
+#endif
+	return -EINVAL;
+}
+
 static void perf_event_free_filter(struct perf_event *event)
 {
 	ftrace_profile_free_filter(event);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9d483ad9bb6c..a734c2d506be 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -196,6 +196,29 @@ bool trace_kprobe_error_injectable(struct trace_event_call *call)
 	return within_error_injection_list(trace_kprobe_address(tk));
 }
 
+int perf_kprobe_event_query(struct perf_event *event, void __user *info)
+{
+	struct perf_event_query_probe __user *uquery = info;
+	struct perf_event_query_probe query = {};
+	struct trace_event_call *call = event->tp_event;
+	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
+	u64 nmissed, nhit;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (copy_from_user(&query, uquery, sizeof(query)))
+		return -EFAULT;
+
+	nhit = trace_kprobe_nhit(tk);
+	nmissed = tk->rp.kp.nmissed;
+
+	if (put_user(nmissed, &uquery->nmissed) ||
+	    put_user(nhit, &uquery->nhit))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int register_kprobe_event(struct trace_kprobe *tk);
 static int unregister_kprobe_event(struct trace_kprobe *tk);
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 1ceedb9146b1..5f50386ada59 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1333,6 +1333,29 @@ static inline void init_trace_event_call(struct trace_uprobe *tu)
 	call->data = tu;
 }
 
+int perf_uprobe_event_query(struct perf_event *event, void __user *info)
+{
+	struct perf_event_query_probe __user *uquery = info;
+	struct perf_event_query_probe query = {};
+	struct trace_event_call *call = event->tp_event;
+	struct trace_uprobe *tu = (struct trace_uprobe *)call->data;
+	u64 nmissed, nhit;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (copy_from_user(&query, uquery, sizeof(query)))
+		return -EFAULT;
+
+	nhit = tu->nhit;
+	nmissed = 0;
+
+	if (put_user(nmissed, &uquery->nmissed) ||
+	    put_user(nhit, &uquery->nhit))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int register_uprobe_event(struct trace_uprobe *tu)
 {
 	init_trace_event_call(tu);
-- 
2.20.1

