Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D9C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558222071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKWIQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:16:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36262 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfKWIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZP-0002ac-6K; Sat, 23 Nov 2019 09:15:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 16A101C1AD6;
        Sat, 23 Nov 2019 09:15:02 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:02 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Add a function to test for kernel
 support for AUX area sampling
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-4-adrian.hunter@intel.com>
References: <20191115124225.5247-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690202.21853.14789264761246818665.tip-bot2@tip-bot2>
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

Commit-ID:     9bca1a4ef5034f0a82861ac0375eb0272c5ce04e
Gitweb:        https://git.kernel.org/tip/9bca1a4ef5034f0a82861ac0375eb0272c5ce04e
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:13 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:43:24 -03:00

perf record: Add a function to test for kernel support for AUX area sampling

Architectures are expected to know if AUX area sampling is supported by
the hardware. Add a function perf_can_aux_sample() which will determine
whether the kernel supports it.

Committer notes:

I reported that this message was taking place on a kernel without the
required bits:

  # perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
  Error:
  The sys_perf_event_open() syscall returned with 7 (Argument list too long) for event (branch-misses:u).
  /bin/dmesg | grep -i perf may provide additional information.

Adrian sent a patch addressing it, with this explanation:

 ----
  perf_can_aux_sample_size() always returned true because it did not pass
  the attribute size to sys_perf_event_open, nor correctly check the
  return value and errno.
 ----

After applying it I get, later in the series, when --aux-sample is
added:

  # perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
  AUX area sampling is not supported by kernel

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.h |  1 +
 tools/perf/util/record.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1305140..3655b9e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -176,6 +176,7 @@ void perf_evlist__set_id_pos(struct evlist *evlist);
 bool perf_can_sample_identifier(void);
 bool perf_can_record_switch_events(void);
 bool perf_can_record_cpu_wide(void);
+bool perf_can_aux_sample(void);
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain);
 int record_opts__config(struct record_opts *opts);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 8579505..7def661 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -136,6 +136,37 @@ bool perf_can_record_cpu_wide(void)
 	return true;
 }
 
+/*
+ * Architectures are expected to know if AUX area sampling is supported by the
+ * hardware. Here we check for kernel support.
+ */
+bool perf_can_aux_sample(void)
+{
+	struct perf_event_attr attr = {
+		.size = sizeof(struct perf_event_attr),
+		.exclude_kernel = 1,
+		/*
+		 * Non-zero value causes the kernel to calculate the effective
+		 * attribute size up to that byte.
+		 */
+		.aux_sample_size = 1,
+	};
+	int fd;
+
+	fd = sys_perf_event_open(&attr, -1, 0, -1, 0);
+	/*
+	 * If the kernel attribute is big enough to contain aux_sample_size
+	 * then we assume that it is supported. We are relying on the kernel to
+	 * validate the attribute size before anything else that could be wrong.
+	 */
+	if (fd < 0 && errno == E2BIG)
+		return false;
+	if (fd >= 0)
+		close(fd);
+
+	return true;
+}
+
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain)
 {
