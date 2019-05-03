Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF24C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7912075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SfobSS6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfECFxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:53:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECFxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:53:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435rbWt2618031
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:53:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435rbWt2618031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556862818;
        bh=Z018EsgS5L+Qa0YLaWNCVYQ6IYJaDKtfJSGSpJmmsFw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SfobSS6OAogH1FB/KApIXJFDAn8FKAAFUoI7/hQJHJn9vXnC1Ampphl6UvIwTSdx/
         o6gwJq9ykTJ8yKtODBlKK9iuwstwPvE3nYfM6I1DR9ycPhFD+PnjIzbTW45BBghXEf
         NpKnLQ41vB8LK5pjRPNt6/f7X/FQ6lec3imX1x93IE9QXcNlrGFW1Vh2vBWlLoUBgZ
         Ew4fa5uoADxCEGvzZImdXWHAfNeRPqkX/UjbQZY4jeiZJd43jUVIz7u5ZAaQlcIf3G
         aw81vTdre0EzYOiQbsk/fiMRyjkEoVnWSZMEzYde0Yj0hh+bbKr3oFrJnCaQ5sE7Fl
         /bz0tRgQSeKMw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435rbK62618028;
        Thu, 2 May 2019 22:53:37 -0700
Date:   Thu, 2 May 2019 22:53:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thadeu Lima de Souza Cascardo <tipbot@zytor.com>
Message-ID: <tip-01e985e900d3e602e9b1a55372a8e5274012a417@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, songliubraving@fb.com,
        cascardo@canonical.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, cascardo@canonical.com, mingo@kernel.org,
          songliubraving@fb.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, acme@redhat.com
In-Reply-To: <20190403194452.10845-1-cascardo@canonical.com>
References: <20190403194452.10845-1-cascardo@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Fix build on 32 bit for BPF
 annotation
Git-Commit-ID: 01e985e900d3e602e9b1a55372a8e5274012a417
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  01e985e900d3e602e9b1a55372a8e5274012a417
Gitweb:     https://git.kernel.org/tip/01e985e900d3e602e9b1a55372a8e5274012a417
Author:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
AuthorDate: Wed, 3 Apr 2019 16:44:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:19 -0400

perf annotate: Fix build on 32 bit for BPF annotation

Commit 6987561c9e86 ("perf annotate: Enable annotation of BPF programs") adds
support for BPF programs annotations but the new code does not build on 32-bit.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Acked-by: Song Liu <songliubraving@fb.com>
Fixes: 6987561c9e86 ("perf annotate: Enable annotation of BPF programs")
Link: http://lkml.kernel.org/r/20190403194452.10845-1-cascardo@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
