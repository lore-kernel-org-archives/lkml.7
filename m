Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E6CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D108A2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633026AbfJRJGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:06:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727741AbfJRJGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:06:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7138B24653149FBE9F7C;
        Fri, 18 Oct 2019 17:06:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 18 Oct 2019
 17:05:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <andriin@fb.com>
CC:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH bpf-next] bpf: Fix build error without CONFIG_NET
Date:   Fri, 18 Oct 2019 17:03:44 +0800
Message-ID: <20191018090344.26936-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_NET is n, building fails:

kernel/trace/bpf_trace.o: In function `raw_tp_prog_func_proto':
bpf_trace.c:(.text+0x1a34): undefined reference to `bpf_skb_output_proto'

Wrap it into a #ifdef to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: a7658e1a4164 ("bpf: Check types of arguments passed into helpers")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/trace/bpf_trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 52f7e9d..c324089 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1055,8 +1055,10 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	switch (func_id) {
 	case BPF_FUNC_perf_event_output:
 		return &bpf_perf_event_output_proto_raw_tp;
+#ifdef CONFIG_NET
 	case BPF_FUNC_skb_output:
 		return &bpf_skb_output_proto;
+#endif
 	case BPF_FUNC_get_stackid:
 		return &bpf_get_stackid_proto_raw_tp;
 	case BPF_FUNC_get_stack:
-- 
2.7.4


