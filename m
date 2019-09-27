Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0E3C388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B17120863
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfI0Xfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 19:35:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:10139 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfI0Xfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 19:35:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 16:35:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="196870949"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2019 16:35:50 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 099B6301B2A; Fri, 27 Sep 2019 16:35:50 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/3] perf annotate: Improve handling of corrupted ~/.debug
Date:   Fri, 27 Sep 2019 16:35:46 -0700
Message-Id: <20190927233546.11533-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927233546.11533-1-andi@firstfloor.org>
References: <20190927233546.11533-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Sometimes ~/.debug can get corrupted and contain files that still
have symbol tables, but which objdump cannot handle. Add a fallback
to read the "original" file in such a case. This might be wrong
too if it's different, but in many cases when profiling
on the same host it will work.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/annotate.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1748f528b6e9..cff5f36786fa 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1638,19 +1638,22 @@ int symbol__strerror_disassemble(struct symbol *sym __maybe_unused, struct map *
 	return 0;
 }
 
-static int dso__disassemble_filename(struct dso *dso, char *filename, size_t filename_size)
+static int dso__disassemble_filename(struct dso *dso, char *filename, size_t filename_size,
+				     bool *build_id)
 {
 	char linkname[PATH_MAX];
 	char *build_id_filename;
 	char *build_id_path = NULL;
 	char *pos;
 
+	*build_id = false;
 	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(dso))
 		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
 
 	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
 	if (build_id_filename) {
+		*build_id = true;
 		__symbol__join_symfs(filename, filename_size, build_id_filename);
 		free(build_id_filename);
 	} else {
@@ -1854,11 +1857,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	int lineno = 0;
 	int nline;
 	pid_t pid;
-	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
+	bool build_id;
+	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename),
+					    &build_id);
 
 	if (err)
 		return err;
 
+again:
 	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
 		 symfs_filename, sym->name, map->unmap_ip(map, sym->start),
 		 map->unmap_ip(map, sym->end));
@@ -1955,8 +1961,21 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		nline++;
 	}
 
-	if (nline == 0)
-		pr_err("No output from %s\n", command);
+	if (nline == 0) {
+		pr_err("No objdump output for %s. Corrupted file?\n", symfs_filename);
+		if (build_id) {
+			/*
+			 * It could be that the buildid file is corrupted.
+			 * Try again with the "true" file. This might be wrong
+			 * too, but it's better than nothing.
+			 * We could move the build id file here?
+			 */
+			__symbol__join_symfs(symfs_filename, sizeof(symfs_filename),
+					     dso->long_name);
+			build_id = false;
+			goto again;
+		}
+	}
 
 	/*
 	 * kallsyms does not have symbol sizes so there may a nop at the end.
-- 
2.21.0

