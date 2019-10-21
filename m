Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B31CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56362067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfJUG1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:27:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33218 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfJUG0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:26:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMR9P-000274-M0; Mon, 21 Oct 2019 08:26:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 161F91C0494;
        Mon, 21 Oct 2019 08:26:43 +0200 (CEST)
Date:   Mon, 21 Oct 2019 06:26:42 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tools: Fix mode setting in copyfile_mode_ns()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007070221.11158-1-adrian.hunter@intel.com>
References: <20191007070221.11158-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157163920270.29376.13870140679809212692.tip-bot2@tip-bot2>
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

Commit-ID:     5a0baf5123236362fda4e9772cc63b7faa16a0df
Gitweb:        https://git.kernel.org/tip/5a0baf5123236362fda4e9772cc63b7faa16a0df
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 07 Oct 2019 10:02:21 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 12:05:18 -03:00

perf tools: Fix mode setting in copyfile_mode_ns()

slow_copyfile() opens the file by name, so "write" permissions must not
be removed in copyfile_mode_ns() before calling slow_copyfile().

Example:

 Before:

  $ sudo chmod +r /proc/kcore
  $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
  $ tools/perf/perf buildid-cache -k /proc/kcore
  Couldn't add /proc/kcore

 After:

  $ sudo chmod +r /proc/kcore
  $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
  $ tools/perf/perf buildid-cache -v -k /proc/kcore
  kcore added to build-id cache directory /home/ahunter/.debug/[kernel.kcore]/37e340b1b5a7cf4f57ba8de2bc777359588a957f/2019100709562289

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lore.kernel.org/lkml/20191007070221.11158-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/copyfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/copyfile.c b/tools/perf/util/copyfile.c
index 3fa0db1..47e03de 100644
--- a/tools/perf/util/copyfile.c
+++ b/tools/perf/util/copyfile.c
@@ -101,14 +101,16 @@ static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
 	if (tofd < 0)
 		goto out;
 
-	if (fchmod(tofd, mode))
-		goto out_close_to;
-
 	if (st.st_size == 0) { /* /proc? do it slowly... */
 		err = slow_copyfile(from, tmp, nsi);
+		if (!err && fchmod(tofd, mode))
+			err = -1;
 		goto out_close_to;
 	}
 
+	if (fchmod(tofd, mode))
+		goto out_close_to;
+
 	nsinfo__mountns_enter(nsi, &nsc);
 	fromfd = open(from, O_RDONLY);
 	nsinfo__mountns_exit(&nsc);
