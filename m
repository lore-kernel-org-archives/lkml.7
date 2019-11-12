Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCBF22469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfKLLTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:19:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34035 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfKLLSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:34 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBp-0000nk-Q0; Tue, 12 Nov 2019 12:18:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C87B81C06B2;
        Tue, 12 Nov 2019 12:18:19 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:19 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf data: Move perf_dir_version into data.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191004083121.12182-3-adrian.hunter@intel.com>
References: <20191004083121.12182-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157355749933.29376.13816147104213658780.tip-bot2@tip-bot2>
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

Commit-ID:     3dedec4f5ccc8048b9a2cfe89838c3b3275b6b2b
Gitweb:        https://git.kernel.org/tip/3dedec4f5ccc8048b9a2cfe89838c3b3275b6b2b
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 04 Oct 2019 11:31:18 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf data: Move perf_dir_version into data.h

perf_dir_version belongs to struct perf_data which is declared in data.h.
To allow its use in inline perf_data functions, move perf_dir_version to
data.h

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.h   | 4 ++++
 tools/perf/util/header.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 259868a..218fe9a 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -9,6 +9,10 @@ enum perf_data_mode {
 	PERF_DATA_MODE_READ,
 };
 
+enum perf_dir_version {
+	PERF_DIR_VERSION	= 1,
+};
+
 struct perf_data_file {
 	char		*path;
 	int		 fd;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index ca53a92..840f95c 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -52,10 +52,6 @@ enum perf_header_version {
 	PERF_HEADER_VERSION_2,
 };
 
-enum perf_dir_version {
-	PERF_DIR_VERSION	= 1,
-};
-
 struct perf_file_section {
 	u64 offset;
 	u64 size;
