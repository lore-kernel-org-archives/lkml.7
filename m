Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B43C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BCD20880
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIC6dQt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDNRAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 13:00:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33548 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfDNRAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 13:00:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id d55so11722411ede.0;
        Sun, 14 Apr 2019 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssMaGZRioh3Tphw5NqaiTGI5HreidLvqtXve6fx9Qg8=;
        b=OIC6dQt7mp0q4bf/l9FI6aGZzU6mjZa2tx9p5NyoHwwG6XS450wu8P/EoNBs8817n4
         hrY7FBdB/cHpGq8xTfStfEjG9HDOBhOpwv4AvQKB3BMA20FLtqFLi5Sx3VAhkHNUDkCV
         Z38U2RZ8PhV74S6YE9eGcQvz1nfwljkfufF3ZjBLMXfglk7GYLDV1bSidgdzZwKKO9As
         yKXi7/BFOcg8z5X7hTpUtGSMzRQNrjRxz6OCZJFMkoj6b2bzWH95fHXG2eHLBogkntTT
         jqD7bcwElt0KIfbRQqU/HuLXbCt0MJHNlV7v6nlDkuBdtieZk9A1eT3YwHcsVSRwisfi
         Liag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ssMaGZRioh3Tphw5NqaiTGI5HreidLvqtXve6fx9Qg8=;
        b=ZOiWr1V/1x4hki5lMxj1gP6eow1DOmHn6QdwlmYB8L1vn6wRiana+B36kDOfXFIx5G
         XzYBkoaKH89QA7+g3QoenhNb6CMfX73QssVtMl/kRxtLD9YYYbyRJtBE0BI3Ph1QYIw0
         wcRHiued81AhP/P8J1Pr4Oi0tmhHOmmqe0T4rohPTyn0M3dn5QHrM5XYD/dK10lqzIDk
         +1I1a7JPdKhvVRMCHWLxII+//KCFRUBSbEG/RYpb6dufFmqxLKFfH/iP/7JssOHSyP7D
         bthfef/W6ho0X12jAWxCGn4r7zVEPYR5j8hmt8rxqZjif21JE+Z8ZAHqAPo5mUmm/Z5L
         9HcA==
X-Gm-Message-State: APjAAAXbdlZb8m9e178VhQtQcX8QXQiq1Ho6QH2s28LPf+D+QOs3g9Tt
        gMDHKRoiduh7pHu9R9OVkv8=
X-Google-Smtp-Source: APXvYqxBEaEGPOx/7O6LblX5WxRwp+/++on2aH6DqMX0vwazEERFh6TsZfWGi5xUQKREEbE9f96iFw==
X-Received: by 2002:a17:906:7e47:: with SMTP id z7mr6855407ejr.248.1555261215106;
        Sun, 14 Apr 2019 10:00:15 -0700 (PDT)
Received: from localhost.localdomain (ip5b402483.dynamic.kabel-deutschland.de. [91.64.36.131])
        by smtp.gmail.com with ESMTPSA id o9sm8828926ejb.26.2019.04.14.10.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 10:00:14 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io,
        Mauricio Vasquez B <mauricio.vasquez@polito.it>
Subject: [PATCH bpf-next v1] bpf: add map helper functions push,pop,peek in more BPF programs
Date:   Sun, 14 Apr 2019 18:58:46 +0200
Message-Id: <20190414165846.22107-1-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

commit f1a2e44a3aec ("bpf: add queue and stack maps") introduced new BPF
helper functions:
- BPF_FUNC_map_push_elem
- BPF_FUNC_map_pop_elem
- BPF_FUNC_map_peek_elem

but they were made available only for network BPF programs. This patch
makes them available for tracepoint, cgroup and lirc programs.

Signed-off-by: Alban Crequy <alban@kinvolk.io>
Cc: Mauricio Vasquez B <mauricio.vasquez@polito.it>
---
 drivers/media/rc/bpf-lirc.c | 6 ++++++
 kernel/bpf/cgroup.c         | 6 ++++++
 kernel/trace/bpf_trace.c    | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 390a722e6211..ee657003c1a1 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -97,6 +97,12 @@ lirc_mode2_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_map_update_elem_proto;
 	case BPF_FUNC_map_delete_elem:
 		return &bpf_map_delete_elem_proto;
+	case BPF_FUNC_map_push_elem:
+		return &bpf_map_push_elem_proto;
+	case BPF_FUNC_map_pop_elem:
+		return &bpf_map_pop_elem_proto;
+	case BPF_FUNC_map_peek_elem:
+		return &bpf_map_peek_elem_proto;
 	case BPF_FUNC_ktime_get_ns:
 		return &bpf_ktime_get_ns_proto;
 	case BPF_FUNC_tail_call:
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index e58a6c247f56..fcde0f7b2585 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -713,6 +713,12 @@ cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_map_update_elem_proto;
 	case BPF_FUNC_map_delete_elem:
 		return &bpf_map_delete_elem_proto;
+	case BPF_FUNC_map_push_elem:
+		return &bpf_map_push_elem_proto;
+	case BPF_FUNC_map_pop_elem:
+		return &bpf_map_pop_elem_proto;
+	case BPF_FUNC_map_peek_elem:
+		return &bpf_map_peek_elem_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_get_local_storage:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d64c00afceb5..91800be0c8eb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -569,6 +569,12 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_map_update_elem_proto;
 	case BPF_FUNC_map_delete_elem:
 		return &bpf_map_delete_elem_proto;
+	case BPF_FUNC_map_push_elem:
+		return &bpf_map_push_elem_proto;
+	case BPF_FUNC_map_pop_elem:
+		return &bpf_map_pop_elem_proto;
+	case BPF_FUNC_map_peek_elem:
+		return &bpf_map_peek_elem_proto;
 	case BPF_FUNC_probe_read:
 		return &bpf_probe_read_proto;
 	case BPF_FUNC_ktime_get_ns:
-- 
2.20.1

