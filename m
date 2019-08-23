Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E02FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C0623406
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390630AbfHWC2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:28:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33787 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389429AbfHWC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zJ9-00018e-BF; Fri, 23 Aug 2019 04:28:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D22811C07E4;
        Fri, 23 Aug 2019 04:28:06 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:28:06 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf ui browser: Allow specifying message to show
 when no samples are
 available to display
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <tip-89ciceg8cy4442he3t0jzo3f@git.kernel.org>
References: <tip-89ciceg8cy4442he3t0jzo3f@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156652728679.12691.16260831939328577053.tip-bot2@tip-bot2>
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

Commit-ID:     2284cf8074ff12b6304665618f81ced3aa0b41de
Gitweb:        https://git.kernel.org/tip/2284cf8074ff12b6304665618f81ced3aa0b41de
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 19 Aug 2019 16:43:58 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:22:18 -03:00

perf ui browser: Allow specifying message to show when no samples are available to display

The 'perf top' tool will use that to avoid having a initial blank screen
while collecting the minimum number of samples to sort and display.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-89ciceg8cy4442he3t0jzo3f@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c | 2 ++
 tools/perf/ui/browser.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index d227d74..c797a85 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -347,6 +347,8 @@ static int __ui_browser__refresh(struct ui_browser *browser)
 	SLsmg_fill_region(browser->y + row + browser->extra_title_lines, browser->x,
 			  browser->rows - row, width, ' ');
 
+	if (browser->nr_entries == 0 && browser->no_samples_msg)
+		__ui__info_window(NULL, browser->no_samples_msg, NULL);
 	return 0;
 }
 
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index dc14441..3678eb8 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -23,6 +23,7 @@ struct ui_browser {
 	void	      *priv;
 	const char    *title;
 	char	      *helpline;
+	const char    *no_samples_msg;
 	void 	      (*refresh_dimensions)(struct ui_browser *browser);
 	unsigned int  (*refresh)(struct ui_browser *browser);
 	void	      (*write)(struct ui_browser *browser, void *entry, int row);
