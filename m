Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52860C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3772087C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980776;
	bh=mJ6txY1Ch3/D4+EiSUn8ju3dKrBWyf2ks/Bs+BThj7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JDPi+sQ64JJFltvUQgmRoFzkW3XI1DwurPPzsPzCu3PbahZrQCtdqTsu1U7otSr19
	 Xcj4vhmAxnVfVmepytoP3r8kQFXtNov2wKw0sPqPRYYHkAWaRY88ULBDbTNDZiXFwE
	 QcWhNYGjYmCn4th+9XbK6c2JlcDpOjpyuZkNNf7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCGRqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfCGRqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:08 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBEBE2085A;
        Thu,  7 Mar 2019 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980767;
        bh=mJ6txY1Ch3/D4+EiSUn8ju3dKrBWyf2ks/Bs+BThj7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZiMG2f65HQSgrKgtPNZn0jD8YiGjvknlD6pPRq5YLkzqSs2TxGlzXoHaZ4U1Z4GJ
         EkZ92L0L5W6ol8F976wcT0tWbKcCqQi7BALSW5bcTjzKFUTcNOND7Ll/nkRFdTyK9G
         ZK39GVs186ujYmKyfanyIbP7jhzM352bUx53WdIM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Travis Downs <travis.downs@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 19/35] perf annotate: Calculate the max instruction name, align column to that
Date:   Thu,  7 Mar 2019 14:44:17 -0300
Message-Id: <20190307174433.28819-20-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were hardcoding '6' as the max instruction name, and we have lots
that are longer than that, see the diff from two 'P' printed TUI
annotations for a libc function that uses instructions with long names,
such as 'vpmovmskb' with its 9 chars:

  --- __strcmp_avx2.annotation.before	2019-03-06 16:31:39.368020425 -0300
  +++ __strcmp_avx2.annotation	2019-03-06 16:32:12.079450508 -0300
  @@ -2,284 +2,284 @@
   Event: cycles:ppp

   Percent        endbr64
  -  0.10         mov    %edi,%eax
  +  0.10         mov        %edi,%eax
  -               xor    %edx,%edx
  +               xor        %edx,%edx
  -  3.54         vpxor  %ymm7,%ymm7,%ymm7
  +  3.54         vpxor      %ymm7,%ymm7,%ymm7
  -               or     %esi,%eax
  +               or         %esi,%eax
  -               and    $0xfff,%eax
  +               and        $0xfff,%eax
  -               cmp    $0xf80,%eax
  +               cmp        $0xf80,%eax
  -             ↓ jg     370
  +             ↓ jg         370
  - 27.07         vmovdqu (%rdi),%ymm1
  + 27.07         vmovdqu    (%rdi),%ymm1
  -  7.97         vpcmpeqb (%rsi),%ymm1,%ymm0
  +  7.97         vpcmpeqb   (%rsi),%ymm1,%ymm0
  -  2.15         vpminub %ymm1,%ymm0,%ymm0
  +  2.15         vpminub    %ymm1,%ymm0,%ymm0
  -  4.09         vpcmpeqb %ymm7,%ymm0,%ymm0
  +  4.09         vpcmpeqb   %ymm7,%ymm0,%ymm0
  -  0.43         vpmovmskb %ymm0,%ecx
  +  0.43         vpmovmskb  %ymm0,%ecx
  -  1.53         test   %ecx,%ecx
  +  1.53         test       %ecx,%ecx
  -             ↓ je     b0
  +             ↓ je         b0
  -  5.26         tzcnt  %ecx,%edx
  +  5.26         tzcnt      %ecx,%edx
  - 18.40         movzbl (%rdi,%rdx,1),%eax
  + 18.40         movzbl     (%rdi,%rdx,1),%eax
  -  7.09         movzbl (%rsi,%rdx,1),%edx
  +  7.09         movzbl     (%rsi,%rdx,1),%edx
  -  3.34         sub    %edx,%eax
  +  3.34         sub        %edx,%eax
     2.37         vzeroupper
                ← retq
                  nop
  -         50:   tzcnt  %ecx,%edx
  +         50:   tzcnt      %ecx,%edx
  -               movzbl 0x20(%rdi,%rdx,1),%eax
  +               movzbl     0x20(%rdi,%rdx,1),%eax
  -               movzbl 0x20(%rsi,%rdx,1),%edx
  +               movzbl     0x20(%rsi,%rdx,1),%edx
  -               sub    %edx,%eax
  +               sub        %edx,%eax
                  vzeroupper
                ← retq
  -               data16 nopw %cs:0x0(%rax,%rax,1)
  +               data16     nopw %cs:0x0(%rax,%rax,1)

Reported-by: Travis Downs <travis.downs@gmail.com>
LPU-Reference: CAOBGo4z1KfmWeOm6Et0cnX5Z6DWsG2PQbAvRn1MhVPJmXHrc5g@mail.gmail.com
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-89wsdd9h9g6bvq52sgp6d0u4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/annotate/instructions.c |  2 +-
 tools/perf/arch/s390/annotate/instructions.c  |  2 +-
 tools/perf/util/annotate.c                    | 74 ++++++++++++-------
 tools/perf/util/annotate.h                    |  7 +-
 4 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 76c6345a57d5..8f70a1b282df 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -58,7 +58,7 @@ static int arm64_mov__parse(struct arch *arch __maybe_unused,
 }
 
 static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
-			  struct ins_operands *ops);
+			  struct ins_operands *ops, int max_ins_name);
 
 static struct ins_ops arm64_mov_ops = {
 	.parse	   = arm64_mov__parse,
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index de0dd66dbb48..89bb8f2c54ce 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -46,7 +46,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 }
 
 static int call__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops);
+			   struct ins_operands *ops, int max_ins_name);
 
 static struct ins_ops s390_call_ops = {
 	.parse	   = s390_call__parse,
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 11a8a447a3af..5f6dbbf5d749 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -198,18 +198,18 @@ static void ins__delete(struct ins_operands *ops)
 }
 
 static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
-			      struct ins_operands *ops)
+			      struct ins_operands *ops, int max_ins_name)
 {
-	return scnprintf(bf, size, "%-6s %s", ins->name, ops->raw);
+	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
 int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		  struct ins_operands *ops)
+		   struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
-		return ins->ops->scnprintf(ins, bf, size, ops);
+		return ins->ops->scnprintf(ins, bf, size, ops, max_ins_name);
 
-	return ins__raw_scnprintf(ins, bf, size, ops);
+	return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
 }
 
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2)
@@ -273,18 +273,18 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 }
 
 static int call__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
 	if (ops->target.sym)
-		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->target.sym->name);
 
 	if (ops->target.addr == 0)
-		return ins__raw_scnprintf(ins, bf, size, ops);
+		return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
 
 	if (ops->target.name)
-		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.name);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->target.name);
 
-	return scnprintf(bf, size, "%-6s *%" PRIx64, ins->name, ops->target.addr);
+	return scnprintf(bf, size, "%-*s *%" PRIx64, max_ins_name, ins->name, ops->target.addr);
 }
 
 static struct ins_ops call_ops = {
@@ -388,15 +388,15 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 }
 
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
 	const char *c;
 
 	if (!ops->target.addr || ops->target.offset < 0)
-		return ins__raw_scnprintf(ins, bf, size, ops);
+		return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
 
 	if (ops->target.outside && ops->target.sym != NULL)
-		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->target.sym->name);
 
 	c = strchr(ops->raw, ',');
 	c = validate_comma(c, ops);
@@ -415,7 +415,7 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			c++;
 	}
 
-	return scnprintf(bf, size, "%-6s %.*s%" PRIx64,
+	return scnprintf(bf, size, "%-*s %.*s%" PRIx64, max_ins_name,
 			 ins->name, c ? c - ops->raw : 0, ops->raw,
 			 ops->target.offset);
 }
@@ -483,16 +483,16 @@ static int lock__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 }
 
 static int lock__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
 	int printed;
 
 	if (ops->locked.ins.ops == NULL)
-		return ins__raw_scnprintf(ins, bf, size, ops);
+		return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
 
-	printed = scnprintf(bf, size, "%-6s ", ins->name);
+	printed = scnprintf(bf, size, "%-*s ", max_ins_name, ins->name);
 	return printed + ins__scnprintf(&ops->locked.ins, bf + printed,
-					size - printed, ops->locked.ops);
+					size - printed, ops->locked.ops, max_ins_name);
 }
 
 static void lock__delete(struct ins_operands *ops)
@@ -564,9 +564,9 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 }
 
 static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
-	return scnprintf(bf, size, "%-6s %s,%s", ins->name,
+	return scnprintf(bf, size, "%-*s %s,%s", max_ins_name, ins->name,
 			 ops->source.name ?: ops->source.raw,
 			 ops->target.name ?: ops->target.raw);
 }
@@ -604,9 +604,9 @@ static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops
 }
 
 static int dec__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
-	return scnprintf(bf, size, "%-6s %s", ins->name,
+	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
 			 ops->target.name ?: ops->target.raw);
 }
 
@@ -616,9 +616,9 @@ static struct ins_ops dec_ops = {
 };
 
 static int nop__scnprintf(struct ins *ins __maybe_unused, char *bf, size_t size,
-			  struct ins_operands *ops __maybe_unused)
+			  struct ins_operands *ops __maybe_unused, int max_ins_name)
 {
-	return scnprintf(bf, size, "%-6s", "nop");
+	return scnprintf(bf, size, "%-*s", max_ins_name, "nop");
 }
 
 static struct ins_ops nop_ops = {
@@ -1232,12 +1232,12 @@ void disasm_line__free(struct disasm_line *dl)
 	annotation_line__delete(&dl->al);
 }
 
-int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw)
+int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw, int max_ins_name)
 {
 	if (raw || !dl->ins.ops)
-		return scnprintf(bf, size, "%-6s %s", dl->ins.name, dl->ops.raw);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, dl->ins.name, dl->ops.raw);
 
-	return ins__scnprintf(&dl->ins, bf, size, &dl->ops);
+	return ins__scnprintf(&dl->ins, bf, size, &dl->ops, max_ins_name);
 }
 
 static void annotation_line__add(struct annotation_line *al, struct list_head *head)
@@ -2414,12 +2414,30 @@ static inline int width_jumps(int n)
 	return 1;
 }
 
+static int annotation__max_ins_name(struct annotation *notes)
+{
+	int max_name = 0, len;
+	struct annotation_line *al;
+
+        list_for_each_entry(al, &notes->src->source, node) {
+		if (al->offset == -1)
+			continue;
+
+		len = strlen(disasm_line(al)->ins.name);
+		if (max_name < len)
+			max_name = len;
+	}
+
+	return max_name;
+}
+
 void annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
 {
 	notes->widths.addr = notes->widths.target =
 		notes->widths.min_addr = hex_width(symbol__size(sym));
 	notes->widths.max_addr = hex_width(sym->end);
 	notes->widths.jumps = width_jumps(notes->max_jump_sources);
+	notes->widths.max_ins_name = annotation__max_ins_name(notes);
 }
 
 void annotation__update_column_widths(struct annotation *notes)
@@ -2583,7 +2601,7 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 		obj__printf(obj, "  ");
 	}
 
-	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset);
+	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset, notes->widths.max_ins_name);
 }
 
 static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 95053cab41fe..df34fe483164 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -59,14 +59,14 @@ struct ins_ops {
 	void (*free)(struct ins_operands *ops);
 	int (*parse)(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms);
 	int (*scnprintf)(struct ins *ins, char *bf, size_t size,
-			 struct ins_operands *ops);
+			 struct ins_operands *ops, int max_ins_name);
 };
 
 bool ins__is_jump(const struct ins *ins);
 bool ins__is_call(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
-int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops);
+int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops, int max_ins_name);
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 
 #define ANNOTATION__IPC_WIDTH 6
@@ -219,7 +219,7 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   struct perf_evsel *evsel,
 					   bool show_freq);
 
-int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
+int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw, int max_ins_name);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
 
@@ -289,6 +289,7 @@ struct annotation {
 		u8		target;
 		u8		min_addr;
 		u8		max_addr;
+		u8		max_ins_name;
 	} widths;
 	bool			have_cycles;
 	struct annotated_source *src;
-- 
2.20.1

