Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FCB23426
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390549AbfHWC2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:28:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33789 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390214AbfHWC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zJ9-00018w-Rc; Fri, 23 Aug 2019 04:28:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5A4FE1C0883;
        Fri, 23 Aug 2019 04:28:07 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:28:07 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf ui: Introduce non-interactive ui__info_window()
 function
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <tip-uat0f89vfwl2w52kv9wzwd8a@git.kernel.org>
References: <tip-uat0f89vfwl2w52kv9wzwd8a@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156652728730.12695.7062987604434542716.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9b01611934c045ac7ca71aebf5ee1906951d6bce
Gitweb:        https://git.kernel.org/tip/9b01611934c045ac7ca71aebf5ee1906951d6bce
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 19 Aug 2019 16:38:24 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:21:49 -03:00

perf ui: Introduce non-interactive ui__info_window() function

Sometimes we want just to print a message on the center of the screen,
like in 'perf top' while we wait for the minimum amount of samples to be
collected before sorting and showing them.

Also expose __ui__info_window() as an optimization for cases where such
message is to be printed while holding the ui lock.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uat0f89vfwl2w52kv9wzwd8a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/tui/util.c | 23 +++++++++++++++--------
 tools/perf/ui/util.h     |  2 ++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index 5d65ea8..1163df8 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -162,8 +162,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 	return key;
 }
 
-int ui__question_window(const char *title, const char *text,
-			const char *exit_msg, int delay_secs)
+void __ui__info_window(const char *title, const char *text, const char *exit_msg)
 {
 	int x, y;
 	int max_len = 0, nr_lines = 0;
@@ -185,8 +184,6 @@ int ui__question_window(const char *title, const char *text,
 		t = sep + 1;
 	}
 
-	pthread_mutex_lock(&ui__lock);
-
 	max_len += 2;
 	nr_lines += 2;
 	if (exit_msg)
@@ -206,19 +203,29 @@ int ui__question_window(const char *title, const char *text,
 	max_len -= 2;
 	SLsmg_write_wrapped_string((unsigned char *)text, y, x,
 				   nr_lines, max_len, 1);
-	SLsmg_gotorc(y + nr_lines - 2, x);
-	SLsmg_write_nstring((char *)" ", max_len);
-	SLsmg_gotorc(y + nr_lines - 1, x);
 	if (exit_msg) {
 		SLsmg_gotorc(y + nr_lines - 2, x);
 		SLsmg_write_nstring((char *)" ", max_len);
 		SLsmg_gotorc(y + nr_lines - 1, x);
 		SLsmg_write_nstring((char *)exit_msg, max_len);
 	}
-	SLsmg_refresh();
+}
 
+void ui__info_window(const char *title, const char *text)
+{
+	pthread_mutex_lock(&ui__lock);
+	__ui__info_window(title, text, NULL);
+	SLsmg_refresh();
 	pthread_mutex_unlock(&ui__lock);
+}
 
+int ui__question_window(const char *title, const char *text,
+			const char *exit_msg, int delay_secs)
+{
+	pthread_mutex_lock(&ui__lock);
+	__ui__info_window(title, text, exit_msg);
+	SLsmg_refresh();
+	pthread_mutex_unlock(&ui__lock);
 	return ui__getch(delay_secs);
 }
 
diff --git a/tools/perf/ui/util.h b/tools/perf/ui/util.h
index 5e44223..4089194 100644
--- a/tools/perf/ui/util.h
+++ b/tools/perf/ui/util.h
@@ -8,6 +8,8 @@ int ui__getch(int delay_secs);
 int ui__popup_menu(int argc, char * const argv[]);
 int ui__help_window(const char *text);
 int ui__dialog_yesno(const char *msg);
+void __ui__info_window(const char *title, const char *text, const char *exit_msg);
+void ui__info_window(const char *title, const char *text);
 int ui__question_window(const char *title, const char *text,
 			const char *exit_msg, int delay_secs);
 
