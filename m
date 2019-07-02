Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC05C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F1421721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034555;
	bh=FS3KrvQy4+lzn8Fj5tIqLR8J8LzZ1514EQfN2igxvkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HR3N4ugYSL9MZDb20etwBZ4OOR+7pVOMB2FEKFSu4GhO0jn2liOoOKqiS6+A7YXQL
	 hbHnApAECXQf2ZNZussSpWt3tuslVg5hA0/OzBouQpFMebUWYiV7Jvlix0RpfU/h4u
	 bVXTVXl3lfBfxJT1ZpJLrxaSKUJGdJTAgqMZUIWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfGBC1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbfGBC1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 324C42183F;
        Tue,  2 Jul 2019 02:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034436;
        bh=FS3KrvQy4+lzn8Fj5tIqLR8J8LzZ1514EQfN2igxvkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvg3OWCGpi11zh49MNZbT2TWwu4WqCfCMQz1Yx+ZhfG1ZmqSQ2eKYns545mC+WE11
         QET3wjKA6206akfMr0cn+K9ofns42hlDMG29JoswkgwOBftxm+Xzu/kY+H4vKIY3ZV
         YEhoTFYF5T5d2qeZZFOeHaKQiQ7+kbXwaaXRpAkE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/43] perf kallsyms: Adopt hex2u64 from tools/perf/util/util.h
Date:   Mon,  1 Jul 2019 23:25:50 -0300
Message-Id: <20190702022616.1259-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just removing more stuff from tools/perf/, this is mostly used in the
kallsyms parsing and in places in perf where kallsyms is involved, so we
get it for free there.

With this we reduce a bit more util.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5mc1zg0jqdwgkn8c358kaba6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.c | 13 +++++++++++++
 tools/lib/symbol/kallsyms.h |  2 ++
 tools/perf/util/util.c      | 13 -------------
 tools/perf/util/util.h      |  1 -
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index 96d830545bbb..7501611abee4 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -16,6 +16,19 @@ bool kallsyms__is_function(char symbol_type)
 	return symbol_type == 'T' || symbol_type == 'W';
 }
 
+/*
+ * While we find nice hex chars, build a long_val.
+ * Return number of chars processed.
+ */
+int hex2u64(const char *ptr, u64 *long_val)
+{
+	char *p;
+
+	*long_val = strtoull(ptr, &p, 16);
+
+	return p - ptr;
+}
+
 int kallsyms__parse(const char *filename, void *arg,
 		    int (*process_symbol)(void *arg, const char *name,
 					  char type, u64 start))
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index 72ab9870454b..bd988f7b18d4 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -18,6 +18,8 @@ static inline u8 kallsyms2elf_binding(char type)
 	return isupper(type) ? STB_GLOBAL : STB_LOCAL;
 }
 
+int hex2u64(const char *ptr, u64 *long_val);
+
 u8 kallsyms2elf_type(char type);
 
 bool kallsyms__is_function(char symbol_type);
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index d388f80d8703..a61535cf1bca 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -434,19 +434,6 @@ size_t hex_width(u64 v)
 	return n;
 }
 
-/*
- * While we find nice hex chars, build a long_val.
- * Return number of chars processed.
- */
-int hex2u64(const char *ptr, u64 *long_val)
-{
-	char *p;
-
-	*long_val = strtoull(ptr, &p, 16);
-
-	return p - ptr;
-}
-
 int perf_event_paranoid(void)
 {
 	int value;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 09c1b0f91f65..125e215dd3d8 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -43,7 +43,6 @@ ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
 
 size_t hex_width(u64 v);
-int hex2u64(const char *ptr, u64 *val);
 
 extern unsigned int page_size;
 int __pure cacheline_size(void);
-- 
2.20.1

