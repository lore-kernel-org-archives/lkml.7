Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 14:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D88206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 14:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfIVOFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 10:05:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55887 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfIVOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 10:05:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iC2UR-0002wi-EL; Sun, 22 Sep 2019 16:05:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B60021C0131;
        Sun, 22 Sep 2019 16:05:26 +0200 (CEST)
Date:   Sun, 22 Sep 2019 14:05:26 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tests: Fix static build test
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190905090924.GA1949@krava>
References: <20190905090924.GA1949@krava>
MIME-Version: 1.0
Message-ID: <156916112669.4511.15106187732638392365.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b117b9b48b24cbb090dd3844b563b464d60a6278
Gitweb:        https://git.kernel.org/tip/b117b9b48b24cbb090dd3844b563b464d60a6278
Author:        Jiri Olsa <jolsa@redhat.com>
AuthorDate:    Thu, 05 Sep 2019 11:09:24 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 14:37:28 -03:00

perf tests: Fix static build test

Disable the potentional shared library features, which breaks static
build if they are enabled and detected: jvmti and vdso libraries.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190905090924.GA1949@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 6b3afed..c850d16 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -100,7 +100,7 @@ make_install_info   := install-info
 make_install_pdf    := install-pdf
 make_install_prefix       := install prefix=/tmp/krava
 make_install_prefix_slash := install prefix=/tmp/krava/
-make_static         := LDFLAGS=-static
+make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
 
 # all the NO_* variable combined
 make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1
