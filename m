Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D73C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3922120645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562055375;
	bh=rzSk6Xvf6SOVkEDQGSHSnozbq8Xr/xVPZq8fm2Xn8/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XVjuTpO3af1zT25GbfCIJVkba6NvicGV9Y4aV7oRsjCvLX6lbANEFPC+MIbTc3dZp
	 Imn8C1QrZI0tb5ihJfbx5da+krFMREcYOgi+NEoG45GM8hgvuuWL5FLgPpcB3D6BsL
	 uMOLXsgmOyi8xqQaqBg2yOAEBbfVzudGplAL46k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfGBIE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfGBIES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:04:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D3F2183F;
        Tue,  2 Jul 2019 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054657;
        bh=rzSk6Xvf6SOVkEDQGSHSnozbq8Xr/xVPZq8fm2Xn8/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJqltrNcF0Ts9t6ngQMXicciceaRE4uKJbIH1u4oTngLJnvo0oEOpLugBWIxcSJLN
         mpTHHhBLIauA5meKuoD8MnqwQPpnNjjH9s0SkYJt72FH+6Xidwq7myZquLrBHjV9et
         yKQ+dOPfdkdtO0ci7HLxHAmUVYYhsVW7whqagYes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Mullins <mmullins@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.1 46/55] bpf: fix nested bpf tracepoints with per-cpu data
Date:   Tue,  2 Jul 2019 10:01:54 +0200
Message-Id: <20190702080126.479691032@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.103022729@linuxfoundation.org>
References: <20190702080124.103022729@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mullins <mmullins@fb.com>

commit 9594dc3c7e71b9f52bee1d7852eb3d4e3aea9e99 upstream.

BPF_PROG_TYPE_RAW_TRACEPOINTs can be executed nested on the same CPU, as
they do not increment bpf_prog_active while executing.

This enables three levels of nesting, to support
  - a kprobe or raw tp or perf event,
  - another one of the above that irq context happens to call, and
  - another one in nmi context
(at most one of which may be a kprobe or perf event).

Fixes: 20b9d7ac4852 ("bpf: avoid excessive stack usage for perf_sample_data")
Signed-off-by: Matt Mullins <mmullins@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/bpf_trace.c |  100 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 16 deletions(-)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -402,8 +402,6 @@ static const struct bpf_func_proto bpf_p
 	.arg4_type	= ARG_CONST_SIZE,
 };
 
-static DEFINE_PER_CPU(struct perf_sample_data, bpf_trace_sd);
-
 static __always_inline u64
 __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 			u64 flags, struct perf_sample_data *sd)
@@ -434,24 +432,50 @@ __bpf_perf_event_output(struct pt_regs *
 	return perf_event_output(event, sd, regs);
 }
 
+/*
+ * Support executing tracepoints in normal, irq, and nmi context that each call
+ * bpf_perf_event_output
+ */
+struct bpf_trace_sample_data {
+	struct perf_sample_data sds[3];
+};
+
+static DEFINE_PER_CPU(struct bpf_trace_sample_data, bpf_trace_sds);
+static DEFINE_PER_CPU(int, bpf_trace_nest_level);
 BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags, void *, data, u64, size)
 {
-	struct perf_sample_data *sd = this_cpu_ptr(&bpf_trace_sd);
+	struct bpf_trace_sample_data *sds = this_cpu_ptr(&bpf_trace_sds);
+	int nest_level = this_cpu_inc_return(bpf_trace_nest_level);
 	struct perf_raw_record raw = {
 		.frag = {
 			.size = size,
 			.data = data,
 		},
 	};
+	struct perf_sample_data *sd;
+	int err;
 
-	if (unlikely(flags & ~(BPF_F_INDEX_MASK)))
-		return -EINVAL;
+	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	sd = &sds->sds[nest_level - 1];
+
+	if (unlikely(flags & ~(BPF_F_INDEX_MASK))) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	perf_sample_data_init(sd, 0, 0);
 	sd->raw = &raw;
 
-	return __bpf_perf_event_output(regs, map, flags, sd);
+	err = __bpf_perf_event_output(regs, map, flags, sd);
+
+out:
+	this_cpu_dec(bpf_trace_nest_level);
+	return err;
 }
 
 static const struct bpf_func_proto bpf_perf_event_output_proto = {
@@ -808,16 +832,48 @@ pe_prog_func_proto(enum bpf_func_id func
 /*
  * bpf_raw_tp_regs are separate from bpf_pt_regs used from skb/xdp
  * to avoid potential recursive reuse issue when/if tracepoints are added
- * inside bpf_*_event_output, bpf_get_stackid and/or bpf_get_stack
+ * inside bpf_*_event_output, bpf_get_stackid and/or bpf_get_stack.
+ *
+ * Since raw tracepoints run despite bpf_prog_active, support concurrent usage
+ * in normal, irq, and nmi context.
  */
-static DEFINE_PER_CPU(struct pt_regs, bpf_raw_tp_regs);
+struct bpf_raw_tp_regs {
+	struct pt_regs regs[3];
+};
+static DEFINE_PER_CPU(struct bpf_raw_tp_regs, bpf_raw_tp_regs);
+static DEFINE_PER_CPU(int, bpf_raw_tp_nest_level);
+static struct pt_regs *get_bpf_raw_tp_regs(void)
+{
+	struct bpf_raw_tp_regs *tp_regs = this_cpu_ptr(&bpf_raw_tp_regs);
+	int nest_level = this_cpu_inc_return(bpf_raw_tp_nest_level);
+
+	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(tp_regs->regs))) {
+		this_cpu_dec(bpf_raw_tp_nest_level);
+		return ERR_PTR(-EBUSY);
+	}
+
+	return &tp_regs->regs[nest_level - 1];
+}
+
+static void put_bpf_raw_tp_regs(void)
+{
+	this_cpu_dec(bpf_raw_tp_nest_level);
+}
+
 BPF_CALL_5(bpf_perf_event_output_raw_tp, struct bpf_raw_tracepoint_args *, args,
 	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
 {
-	struct pt_regs *regs = this_cpu_ptr(&bpf_raw_tp_regs);
+	struct pt_regs *regs = get_bpf_raw_tp_regs();
+	int ret;
+
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	perf_fetch_caller_regs(regs);
-	return ____bpf_perf_event_output(regs, map, flags, data, size);
+	ret = ____bpf_perf_event_output(regs, map, flags, data, size);
+
+	put_bpf_raw_tp_regs();
+	return ret;
 }
 
 static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
@@ -834,12 +890,18 @@ static const struct bpf_func_proto bpf_p
 BPF_CALL_3(bpf_get_stackid_raw_tp, struct bpf_raw_tracepoint_args *, args,
 	   struct bpf_map *, map, u64, flags)
 {
-	struct pt_regs *regs = this_cpu_ptr(&bpf_raw_tp_regs);
+	struct pt_regs *regs = get_bpf_raw_tp_regs();
+	int ret;
+
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	perf_fetch_caller_regs(regs);
 	/* similar to bpf_perf_event_output_tp, but pt_regs fetched differently */
-	return bpf_get_stackid((unsigned long) regs, (unsigned long) map,
-			       flags, 0, 0);
+	ret = bpf_get_stackid((unsigned long) regs, (unsigned long) map,
+			      flags, 0, 0);
+	put_bpf_raw_tp_regs();
+	return ret;
 }
 
 static const struct bpf_func_proto bpf_get_stackid_proto_raw_tp = {
@@ -854,11 +916,17 @@ static const struct bpf_func_proto bpf_g
 BPF_CALL_4(bpf_get_stack_raw_tp, struct bpf_raw_tracepoint_args *, args,
 	   void *, buf, u32, size, u64, flags)
 {
-	struct pt_regs *regs = this_cpu_ptr(&bpf_raw_tp_regs);
+	struct pt_regs *regs = get_bpf_raw_tp_regs();
+	int ret;
+
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	perf_fetch_caller_regs(regs);
-	return bpf_get_stack((unsigned long) regs, (unsigned long) buf,
-			     (unsigned long) size, flags, 0);
+	ret = bpf_get_stack((unsigned long) regs, (unsigned long) buf,
+			    (unsigned long) size, flags, 0);
+	put_bpf_raw_tp_regs();
+	return ret;
 }
 
 static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {


