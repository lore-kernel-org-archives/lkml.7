Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2541C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87F921920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928417;
	bh=OexZN4oQs5HfxhzlABRCLKxGM6AENf8BWG4B3Z4BhKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TwQoRxpg/T3nes6hMZR8p3jjcsAzAPjvOgD6s794SO3VhZIY80cU9S9HR6n5+7N+g
	 JXt8EDRn9Dd7Ghnlv/x0qzyyswZesr+pMdlqqHXbRivanSgt/FRooFaGpHPHetFk4r
	 +ZPQy+yOMgCH+DVV759fLemY4Yj9o4E6zqA9Cv0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbfJALNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731194AbfJALNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:13:35 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01CA222C6;
        Tue,  1 Oct 2019 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928415;
        bh=OexZN4oQs5HfxhzlABRCLKxGM6AENf8BWG4B3Z4BhKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgbGRlJbaxl1Yx49NwUKEFMceDR5Sl6j4sNVk51h20/f9PSvZjhoWuYcJgwb9KOhc
         PLxJV4mlKghFh1q5/oImgtx3Q1NwD980u76bJdrflDz16Av+wZdguv2kDfY+6QbXS4
         xjJKQL9C1f6SRkM3bJcW/948poNlKFJ/t7DMEmKs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/24] perf script brstackinsn: Fix recovery from LBR/binary mismatch
Date:   Tue,  1 Oct 2019 08:12:07 -0300
Message-Id: <20191001111216.7208-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When the LBR data and the instructions in a binary do not match the loop
printing instructions could get confused and print a long stream of
bogus <bad> instructions.

The problem was that if the instruction decoder cannot decode an
instruction it ilen wasn't initialized, so the loop going through the
basic block would continue with the previous value.

Harden the code to avoid such problems:

- Make sure ilen is always freshly initialized and is 0 for bad
  instructions.

- Do not overrun the code buffer while printing instructions

- Print a warning message if the final jump is not on an instruction
  boundary.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20190927233546.11533-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 286fc70d7402..67be8d31afab 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1063,7 +1063,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			continue;
 
 		insn = 0;
-		for (off = 0;; off += ilen) {
+		for (off = 0; off < (unsigned)len; off += ilen) {
 			uint64_t ip = start + off;
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
@@ -1074,6 +1074,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					printed += print_srccode(thread, x.cpumode, ip);
 				break;
 			} else {
+				ilen = 0;
 				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
 						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
 				if (ilen == 0)
@@ -1083,6 +1084,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				insn++;
 			}
 		}
+		if (off != (unsigned)len)
+			printed += fprintf(fp, "\tmismatch of LBR data and executable\n");
 	}
 
 	/*
@@ -1123,6 +1126,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		goto out;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
+		ilen = 0;
 		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
 				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
-- 
2.21.0

