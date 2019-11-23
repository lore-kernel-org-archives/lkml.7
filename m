Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4DDC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD7020720
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfKWIPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKWIPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZT-0002d9-Az; Sat, 23 Nov 2019 09:15:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2EF7D1C1ADB;
        Sat, 23 Nov 2019 09:15:03 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:03 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf dsos: Remove unused dsos__find() method
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-teqz0eqcw43mnt7i3me44esw@git.kernel.org>
References: <tip-teqz0eqcw43mnt7i3me44esw@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157449690310.21853.9705711021788218829.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1f74b100c9d9406fa12b22675c6b2111e5f60e9c
Gitweb:        https://git.kernel.org/tip/1f74b100c9d9406fa12b22675c6b2111e5f60e9c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 19 Nov 2019 17:51:34 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 19 Nov 2019 17:51:34 -03:00

perf dsos: Remove unused dsos__find() method

Not used anywhere, nuke it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-teqz0eqcw43mnt7i3me44esw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dsos.c |  9 ---------
 tools/perf/util/dsos.h |  1 -
 2 files changed, 10 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index ecf8d73..1d38d6a 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -159,15 +159,6 @@ struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 	return __dsos__findnew_by_longname(&dsos->root, name);
 }
 
-struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
-{
-	struct dso *dso;
-	down_read(&dsos->lock);
-	dso = __dsos__find(dsos, name, cmp_short);
-	up_read(&dsos->lock);
-	return dso;
-}
-
 static void dso__set_basename(struct dso *dso)
 {
 	char *base, *lname;
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 32f1fbe..fd7ba51 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -24,7 +24,6 @@ void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
-struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 struct dso *__dsos__findnew(struct dsos *dsos, const char *name);
 struct dso *dsos__findnew(struct dsos *dsos, const char *name);
 
