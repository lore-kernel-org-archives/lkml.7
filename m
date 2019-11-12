Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38E0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D2722469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfKLLSi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33970 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfKLLSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBj-0000kR-Ha; Tue, 12 Nov 2019 12:18:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 32D1D1C04E8;
        Tue, 12 Nov 2019 12:18:17 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:16 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf llvm: Make .o saving a debug message, not an info one
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-o7jd4i7s66kosec5torubqps@git.kernel.org>
References: <tip-o7jd4i7s66kosec5torubqps@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157355749682.29376.1368244256473211022.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a33d2611986ab7c0ac617a8b637fedf013184b98
Gitweb:        https://git.kernel.org/tip/a33d2611986ab7c0ac617a8b637fedf013184b98
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 21 Oct 2019 16:01:26 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf llvm: Make .o saving a debug message, not an info one

Its a bit annoying to have that message, better make it a debug one.

I.e. now this message will only appear when using '-v':

  [root@quaco tracebuffer]# trace -e bristot.c
  LLVM: dumping bristot.o
  ^C[root@quaco tracebuffer]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-o7jd4i7s66kosec5torubqps@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 8b14e4a..eae47c2 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -418,10 +418,9 @@ void llvm__dump_obj(const char *path, void *obj_buf, size_t size)
 		goto out;
 	}
 
-	pr_info("LLVM: dumping %s\n", obj_path);
+	pr_debug("LLVM: dumping %s\n", obj_path);
 	if (fwrite(obj_buf, size, 1, fp) != 1)
-		pr_warning("WARNING: failed to write to file '%s': %s, skip object dumping\n",
-			   obj_path, strerror(errno));
+		pr_debug("WARNING: failed to write to file '%s': %s, skip object dumping\n", obj_path, strerror(errno));
 	fclose(fp);
 out:
 	free(obj_path);
