Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED71C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550632332A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329329;
	bh=b+B8XCXyD4OULEmvT9QUVJIM2/JZdoA6N/AQR5l/yw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y+dESNwcacbNAAUUrBZf21XnlvWcsgcld5okfv5pItf6niI25MzF/oOpplalV7gyv
	 F9CyhjiCz0W/Eo9VyI2AHmmD1fNqUO4VlnpkUjEjRJ2iev+gsxmQWdpxCSYNzu1aC9
	 FtsPg5Y4Zq64JTfmp1t/QpIv0QGDia+RCECvGEN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfHTT2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbfHTT2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:46 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA242339D;
        Tue, 20 Aug 2019 19:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329325;
        bh=b+B8XCXyD4OULEmvT9QUVJIM2/JZdoA6N/AQR5l/yw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itEDXX1+A9ftnJxfrNdN/4+G0d8/yFoDESaFVkrQ9EiJjpfVM96YKUb4laVNDp3BQ
         f1CWQ3+vObxDGc2GY9lrlIHTGe06uk9xuPXLtzNyDpLFkl/VAYvmP3K4eCQeKXaqDP
         ybeE+9tuSVjvg9vp0tWuY+nCFe7/DAMufJEVoRNc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 13/17] perf ui: Introduce non-interactive ui__info_window() function
Date:   Tue, 20 Aug 2019 16:27:29 -0300
Message-Id: <20190820192733.19180-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 5d65ea8b6496..1163df8b6f06 100644
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
index 5e44223b56fa..40891942f465 100644
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
 
-- 
2.21.0

