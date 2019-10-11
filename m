Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10F8ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A832190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824416;
	bh=vg43QH1RPy++/kfKsY8qGwuiCs5Yp/ELD6nbRJSMeeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MgqtzovsDZdq36tJCMEIJTxBQS3hSXy8zlsV/j8tDI1Lfi4BTwNjFPw0JctlDOs+Q
	 qBq1q43z6Vtrbcm9J/T3ReLmrfAsHG9f7p22hbGjCX34rczQGJUZBQVXBhjE5HRFmJ
	 md0BaeoX/sx3JEKtkKFx+/0r403P7W5L04dLVmNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfJKUGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbfJKUGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:06:54 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 879642245B;
        Fri, 11 Oct 2019 20:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824413;
        bh=vg43QH1RPy++/kfKsY8qGwuiCs5Yp/ELD6nbRJSMeeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDNQHazTfiDGPeHLsjRDsrxlAHYe9njBwXw/fawYhQEPwDm58D1j0lQWVUFLOfwxK
         oI4nb5ytEF2xsIrsVWj5VeUTERFn6UYDd6HOAQEQGkqzet/UFI4Py/5oGC5MnsEpp2
         g3WBmTB2FmAEIzL0ZN30ZwEfT4iBS819XCNJWm6Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 06/69] perf trace: Generalize the syscall_fmt find routines
Date:   Fri, 11 Oct 2019 17:04:56 -0300
Message-Id: <20191011200559.7156-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To allow them to be used with other stuff, such as tracepoints.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-od3gzg77ppqgnnrxqv40fvgx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cb853434d761..313dfc1cefc5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -966,24 +966,35 @@ static int syscall_fmt__cmp(const void *name, const void *fmtp)
 	return strcmp(name, fmt->name);
 }
 
+static struct syscall_fmt *__syscall_fmt__find(struct syscall_fmt *fmts, const int nmemb, const char *name)
+{
+	return bsearch(name, fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
+}
+
 static struct syscall_fmt *syscall_fmt__find(const char *name)
 {
 	const int nmemb = ARRAY_SIZE(syscall_fmts);
-	return bsearch(name, syscall_fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
+	return __syscall_fmt__find(syscall_fmts, nmemb, name);
 }
 
-static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
+static struct syscall_fmt *__syscall_fmt__find_by_alias(struct syscall_fmt *fmts, const int nmemb, const char *alias)
 {
-	int i, nmemb = ARRAY_SIZE(syscall_fmts);
+	int i;
 
 	for (i = 0; i < nmemb; ++i) {
-		if (syscall_fmts[i].alias && strcmp(syscall_fmts[i].alias, alias) == 0)
-			return &syscall_fmts[i];
+		if (fmts[i].alias && strcmp(fmts[i].alias, alias) == 0)
+			return &fmts[i];
 	}
 
 	return NULL;
 }
 
+static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
+{
+	const int nmemb = ARRAY_SIZE(syscall_fmts);
+	return __syscall_fmt__find_by_alias(syscall_fmts, nmemb, alias);
+}
+
 /*
  * is_exit: is this "exit" or "exit_group"?
  * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
-- 
2.21.0

