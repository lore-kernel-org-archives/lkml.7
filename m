Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC83CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99004217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X6E930ot";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XHBG5puf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfJOGRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:17:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfJOGRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:17:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AD60C60907; Tue, 15 Oct 2019 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571120260;
        bh=nh6Hu+eyt5jL/ceEK128KwBXAqUtFIn8LM1k3NDK07I=;
        h=From:To:Cc:Subject:Date:From;
        b=X6E930otBl5oOT+dOBHYQqK2sUH2CqQ8E9j1TLRruoZdf7ZbhZjsXQlYGZIs45184
         JgeLYlxI3MOKrAPMURUKKtcQ1hxEo08gw9gZ811j97Tyspbm8nb0teEcZwVqMvifI3
         2PUSr/YmGNIF+R241eJz0hUD66DrsBEOZ2r6+R0Y=
Received: from prsood-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7E5360A43;
        Tue, 15 Oct 2019 06:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571120259;
        bh=nh6Hu+eyt5jL/ceEK128KwBXAqUtFIn8LM1k3NDK07I=;
        h=From:To:Cc:Subject:Date:From;
        b=XHBG5pufxoVnNckW5hndEwneiCcNJNTEmeXrRRxIdOsSngBWpKTOyu7V0mmAlBEdR
         UtlEEJXPzuw2S8MdQ2rTZzPH9N1+A5duLVkV0yeTt+i8BYi1hhaPGS1tTRPJ7oYSIa
         I467hNAHu6lj3y/aq7hurHWuuLypxbLBGFvwH45I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7E5360A43
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
From:   Prateek Sood <prsood@codeaurora.org>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, kaushalk@codeaurora.org,
        Prateek Sood <prsood@codeaurora.org>
Subject: [PATCH] trace: fix race in perf_trace_buf initialization
Date:   Tue, 15 Oct 2019 11:47:25 +0530
Message-Id: <1571120245-4186-1-git-send-email-prsood@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[  943.034988] Unable to handle kernel paging request at virtual address 0000003106f2003c
[  943.043653] Mem abort info:
[  943.046679]   ESR = 0x96000045
[  943.050428]   Exception class = DABT (current EL), IL = 32 bits
[  943.056643]   SET = 0, FnV = 0
[  943.060168]   EA = 0, S1PTW = 0
[  943.063449] Data abort info:
[  943.066474]   ISV = 0, ISS = 0x00000045
[  943.070856]   CM = 0, WnR = 1
[  943.074016] user pgtable: 4k pages, 39-bit VAs, pgdp = ffffffc034b9b000
[  943.081446] [0000003106f2003c] pgd=0000000000000000, pud=0000000000000000
[  943.088862] Internal error: Oops: 96000045 [#1] PREEMPT SMP
[  943.141700] Process syz-executor (pid: 18393, stack limit = 0xffffffc093190000)
[  943.164146] pstate: 80400005 (Nzcv daif +PAN -UAO)
[  943.169119] pc : __memset+0x20/0x1ac
[  943.172831] lr : memset+0x3c/0x50
[  943.176269] sp : ffffffc09319fc50

[  943.557593]  __memset+0x20/0x1ac
[  943.560953]  perf_trace_buf_alloc+0x140/0x1a0
[  943.565472]  perf_trace_sys_enter+0x158/0x310
[  943.569985]  syscall_trace_enter+0x348/0x7c0
[  943.574413]  el0_svc_common+0x11c/0x368
[  943.578394]  el0_svc_handler+0x12c/0x198
[  943.582459]  el0_svc+0x8/0xc

In Ramdumps:
total_ref_count = 3
perf_trace_buf = (
    0x0 -> NULL,
    0x0 -> NULL,
    0x0 -> NULL,
    0x0 -> NULL)

event_call in perf_trace_sys_enter()
event_call = 0xFFFFFF900CB511D8 -> (
    list = (next = 0xFFFFFF900CB4E2E0, prev = 0xFFFFFF900CB512B0),
    class = 0xFFFFFF900CDC8308,
    name = 0xFFFFFF900CDDA1D8,
    tp = 0xFFFFFF900CDDA1D8,
    event = (
      node = (next = 0x0, pprev = 0xFFFFFF900CB80210),
      list = (next = 0xFFFFFF900CB512E0, prev = 0xFFFFFF900CB4E310),
      type = 21,
      funcs = 0xFFFFFF900CB51130),
    print_fmt = 0xFFFFFF900CB51150,
    filter = 0x0,
    mod = 0x0,
    data = 0x0,
    flags = 18,
    perf_refcount = 1,
    perf_events = 0xFFFFFF8DB8E54158,
    prog_array = 0x0,
    perf_perm = 0x0)

perf_events added on CPU0
(struct hlist_head *)(0xFFFFFF8DB8E54158+__per_cpu_offset[0]) -> (
    first = 0xFFFFFFC0980FD0E0 -> (
      next = 0x0,
      pprev = 0xFFFFFFBEBFD74158))

Could you please confirm:
1) the race mentioned below exists or not.
2) if following patch fixes it.


>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8

A race condition exists while initialiazing perf_trace_buf from
perf_trace_init() and perf_kprobe_init().

      CPU0                                        CPU1
perf_trace_init()
  mutex_lock(&event_mutex)
    perf_trace_event_init()
      perf_trace_event_reg()
        total_ref_count == 0
	buf = alloc_percpu()
        perf_trace_buf[i] = buf
        tp_event->class->reg() //fails       perf_kprobe_init()
	goto fail                              perf_trace_event_init()
                                                 perf_trace_event_reg()
        fail:
	  total_ref_count == 0

                                                   total_ref_count == 0
                                                   buf = alloc_percpu()
                                                   perf_trace_buf[i] = buf
                                                   tp_event->class->reg()
                                                   total_ref_count++

          free_percpu(perf_trace_buf[i])
          perf_trace_buf[i] = NULL

Any subsequent call to perf_trace_event_reg() will observe total_ref_count > 0,
causing the perf_trace_buf to be NULL always. This can result in perf_trace_buf
getting accessed from perf_trace_buf_alloc() without being initialized. Acquiring
event_mutex in perf_kprobe_init() before calling perf_trace_event_init() should
fix this race.

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
---
 kernel/trace/trace_event_perf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 4629a61..48ee92c 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -272,9 +272,11 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
 		goto out;
 	}
 
+	mutex_lock(&event_mutex);
 	ret = perf_trace_event_init(tp_event, p_event);
 	if (ret)
 		destroy_local_trace_kprobe(tp_event);
+	mutex_unlock(&event_mutex);
 out:
 	kfree(func);
 	return ret;
@@ -282,8 +284,10 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
 
 void perf_kprobe_destroy(struct perf_event *p_event)
 {
+	mutex_lock(&event_mutex);
 	perf_trace_event_close(p_event);
 	perf_trace_event_unreg(p_event);
+	mutex_unlock(&event_mutex);
 
 	destroy_local_trace_kprobe(p_event->tp_event);
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

