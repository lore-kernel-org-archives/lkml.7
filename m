Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215BDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFF7205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDCTpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:45:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37522 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCTpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:45:07 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1hBlom-00086b-Uf; Wed, 03 Apr 2019 19:45:05 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     songliubraving@fb.com, acme@kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH] perf annotate: Fix build on 32 bit for BPF annotation
Date:   Wed,  3 Apr 2019 16:44:52 -0300
Message-Id: <20190403194452.10845-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6987561c9e86 ("perf annotate: Enable annotation of BPF programs") adds
support for BPF programs annotations but the new code does not build on 32-bit.

Fixes: 6987561c9e86 ("perf annotate: Enable annotation of BPF programs")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 tools/perf/util/annotate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c8b01176c9e1..09762985c713 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1714,8 +1714,8 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
 		return -1;
 
-	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
-		 sym->name, sym->start, sym->end - sym->start);
+	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
+		  sym->name, sym->start, sym->end - sym->start);
 
 	memset(tpath, 0, sizeof(tpath));
 	perf_exe(tpath, sizeof(tpath));
@@ -1740,7 +1740,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info_linear = info_node->info_linear;
 	sub_id = dso->bpf_prog.sub_id;
 
-	info.buffer = (void *)(info_linear->info.jited_prog_insns);
+	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
 	info.buffer_length = info_linear->info.jited_prog_len;
 
 	if (info_linear->info.nr_line_info)
@@ -1776,7 +1776,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 		const char *srcline;
 		u64 addr;
 
-		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
+		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
 		count = disassemble(pc, &info);
 
 		if (prog_linfo)
-- 
2.20.1

