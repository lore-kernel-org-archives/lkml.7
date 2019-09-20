Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A839EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E872173E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405140AbfITQV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:21:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52865 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404965AbfITQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLeT-00040e-PO; Fri, 20 Sep 2019 18:20:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA51B1C0DF4;
        Fri, 20 Sep 2019 18:20:56 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:20:56 -0000
From:   "tip-bot2 for Anju T Sudhakar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf kvm: Add arch neutral function to choose
 event for perf kvm record
Cc:     Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190718181749.30612-2-anju@linux.vnet.ibm.com>
References: <20190718181749.30612-2-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <156899645688.24167.9735365574301898952.tip-bot2@tip-bot2>
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

Commit-ID:     124eb5f82bf9395419b20205c4dcc1b8fcda7f29
Gitweb:        https://git.kernel.org/tip/124eb5f82bf9395419b20205c4dcc1b8fcda7f29
Author:        Anju T Sudhakar <anju@linux.vnet.ibm.com>
AuthorDate:    Thu, 18 Jul 2019 23:47:48 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 10:28:26 -03:00

perf kvm: Add arch neutral function to choose event for perf kvm record

'perf kvm record' uses 'cycles'(if the user did not specify any event)
as the default event to profile the guest.

This will not provide any proper samples from the guest incase of
powerpc architecture, since in powerpc the PMUs are controlled by the
guest rather than the host.

Patch adds a function to pick an arch specific event for 'perf kvm
record', instead of selecting 'cycles' as a default event for all
architectures.

For powerpc this function checks for any user specified event, and if
there isn't any it returns invalid instead of proceeding with 'cycles'
event.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20190718181749.30612-2-anju@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 37 ++++++++++++++++++++++++-
 tools/perf/builtin-kvm.c                | 12 +++++++-
 tools/perf/util/kvm-stat.h              |  1 +-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index f0dbf7b..ec5b771 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -8,6 +8,7 @@
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
+#include <subcmd/parse-options.h>
 
 #define NR_TPS 4
 
@@ -172,3 +173,39 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
 
 	return ret;
 }
+
+/*
+ * Incase of powerpc architecture, pmu registers are programmable
+ * by guest kernel. So monitoring guest via host may not provide
+ * valid samples. It is better to fail the "perf kvm record"
+ * with default "cycles" event to monitor guest in powerpc.
+ *
+ * Function to parse the arguments and return appropriate values.
+ */
+int kvm_add_default_arch_event(int *argc, const char **argv)
+{
+	const char **tmp;
+	bool event = false;
+	int i, j = *argc;
+
+	const struct option event_options[] = {
+		OPT_BOOLEAN('e', "event", &event, NULL),
+		OPT_END()
+	};
+
+	tmp = calloc(j + 1, sizeof(char *));
+	if (!tmp)
+		return -EINVAL;
+
+	for (i = 0; i < j; i++)
+		tmp[i] = argv[i];
+
+	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
+	if (!event) {
+		free(tmp);
+		return -EINVAL;
+	}
+
+	free(tmp);
+	return 0;
+}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 2b822be..6e3e366 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1514,11 +1514,21 @@ perf_stat:
 }
 #endif /* HAVE_KVM_STAT_SUPPORT */
 
+int __weak kvm_add_default_arch_event(int *argc __maybe_unused,
+					const char **argv __maybe_unused)
+{
+	return 0;
+}
+
 static int __cmd_record(const char *file_name, int argc, const char **argv)
 {
-	int rec_argc, i = 0, j;
+	int rec_argc, i = 0, j, ret;
 	const char **rec_argv;
 
+	ret = kvm_add_default_arch_event(&argc, argv);
+	if (ret)
+		return -EINVAL;
+
 	rec_argc = argc + 2;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	rec_argv[i++] = strdup("record");
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 8fd6ec2..6f0fa05 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -148,4 +148,5 @@ extern const char *kvm_entry_trace;
 extern const char *kvm_exit_trace;
 #endif /* HAVE_KVM_STAT_SUPPORT */
 
+extern int kvm_add_default_arch_event(int *argc, const char **argv);
 #endif /* __PERF_KVM_STAT_H */
