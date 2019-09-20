Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5305BC4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276CF207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989656;
	bh=7fWIorHVOy9v2BBGll8uHew7FHCf2wQc2SZa2u3BLJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MOHbvEWjFsnTu3XDv4ucR0B/gg69b0KgnYdeXG2FuBZanWvL4p3BRpzLS2gq04AK9
	 I7PH7zV3W4Nd0cPruT+I+Pe9n9/ykdUu9Exu4ouEmm383iBbVJlHDnjyBGhx0gVJcC
	 D9VlOAxB/VnQTLapNKFfO8Rgd/lsxI/g06fYWpR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbfITO1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389727AbfITO1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:27:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EED217F5;
        Fri, 20 Sep 2019 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989639;
        bh=7fWIorHVOy9v2BBGll8uHew7FHCf2wQc2SZa2u3BLJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkr7o92yK4w+GC93syWdsyfsMLopgiHgP7dzTKiyGyTfyJ32jIzqBIe2md0Fl5h65
         BBKDyqLL/vkgcJZ2GxKjEgJggyP4QYoLXrfehuEe9bURevWbCKg2eC+qi7pTmyM7ym
         mKjZVDa/QbtirizGjpOzpDLKw+OF35GbIgRJwwSM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/31] perf kvm: Add arch neutral function to choose event for perf kvm record
Date:   Fri, 20 Sep 2019 11:25:41 -0300
Message-Id: <20190920142542.12047-31-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

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
 tools/perf/arch/powerpc/util/kvm-stat.c | 37 +++++++++++++++++++++++++
 tools/perf/builtin-kvm.c                | 12 +++++++-
 tools/perf/util/kvm-stat.h              |  1 +
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index f0dbf7b075c8..ec5b771029e4 100644
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
index 2b822be87673..6e3e36658900 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1514,11 +1514,21 @@ static int kvm_cmd_stat(const char *file_name, int argc, const char **argv)
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
index 8fd6ec20662c..6f0fa05b62b6 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -148,4 +148,5 @@ extern const char *kvm_entry_trace;
 extern const char *kvm_exit_trace;
 #endif /* HAVE_KVM_STAT_SUPPORT */
 
+extern int kvm_add_default_arch_event(int *argc, const char **argv);
 #endif /* __PERF_KVM_STAT_H */
-- 
2.21.0

