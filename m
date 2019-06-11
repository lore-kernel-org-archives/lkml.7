Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67D5C06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39A921871
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279567;
	bh=c2PSAm9/6AEmzZrUKDXDvImOpyg/KiK8HasmE/vfCog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XEM4KMG7MalDPzOSfkjtxPHjMxr38HAqhYAK/JM9Lcj9CupRjvYpV/QVB8HHunyFh
	 PJlG4y4WlsksnMdpPEnySVqASHk4C0Dc17titBc5+j3M4ggLQBoK7GXUqoeKovv6mb
	 10rQASvWgsj5anZHpe3jqVrkjNvdR+DowIWqmP3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405068AbfFKS71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392179AbfFKS7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C172183E;
        Tue, 11 Jun 2019 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279565;
        bh=c2PSAm9/6AEmzZrUKDXDvImOpyg/KiK8HasmE/vfCog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoGZZn09Nkf1z5AF5MVQQM9DMDVkrAQdEQ2i6cypDJ0Gyjm1gJOyt/4ANxRs5ICYF
         F+/dFAfXnFWh+Jn2gxsMyFjR9tcKTwHGrQBJlGtyQ1Kzwu/3T1STuPEqHczRcCYBjZ
         YegA5Z3sWljmUxKfpRK6Bk1p1dfkh0qFoE9qMhZ0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 01/85] perf data: Add description of header HEADER_BPF_PROG_INFO and HEADER_BPF_BTF
Date:   Tue, 11 Jun 2019 15:57:47 -0300
Message-Id: <20190611185911.11645-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This patch addes description of HEADER_BPF_PROG_INFO and HEADER_BPF_BTF to
perf.data-file-format.txt.

Requested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
Link: http://lkml.kernel.org/r/20190521064406.2498925-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/Documentation/perf.data-file-format.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 6967e9b02be5..022bb8b1c84a 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -272,6 +272,22 @@ struct {
 
 Two uint64_t for the time of first sample and the time of last sample.
 
+        HEADER_BPF_PROG_INFO = 25,
+
+struct bpf_prog_info_linear, which contains detailed information about
+a BPF program, including type, id, tag, jited/xlated instructions, etc.
+
+        HEADER_BPF_BTF = 26,
+
+Contains BPF Type Format (BTF). For more information about BTF, please
+refer to Documentation/bpf/btf.rst.
+
+struct {
+	u32	id;
+	u32	data_size;
+	char	data[];
+};
+
         HEADER_COMPRESSED = 27,
 
 struct {
-- 
2.20.1

