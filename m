Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479B02082F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434674;
	bh=pMiHMjkst8uF+c0O4864EVOqN3A1CosTB5SKcJgXGA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QvY9qmqxco2pJNoeOS/OQ4L2SvGsPkMoqOAU3lAUbYNzNqp+QYjZOo547DwDHkWEc
	 +guKbYZxlvovZxUlQcfKYAaesGQZvzEDQOREBVjTnfRhZi8so2FXeaG5UJACiG0gj4
	 cUuEZqMyioXpKmSX5tVehhhebP61c0wfN3sa5NWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKVO5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfKVO5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:49 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3762075E;
        Fri, 22 Nov 2019 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434668;
        bh=pMiHMjkst8uF+c0O4864EVOqN3A1CosTB5SKcJgXGA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je1bNoNKKYGFrGCh7Nmcn+vWpIdB89gFiejJMWgjfIgdA8k/Dx1S8cXQhm/3nudgh
         UXZtT2g9MvaAgR+H0Q8qmOMv7m83Sg6We5GyFu+oKteRortRdXNZWZlxE4F6MV3F2y
         XF9KKsbt+VBA1wcMOBYXaW+W/i9ATCd10sTyTjpw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/26] perf record: Add a function to test for kernel support for AUX area sampling
Date:   Fri, 22 Nov 2019 11:56:55 -0300
Message-Id: <20191122145711.3171-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
index 13051409fd22..3655b9ebb147 100644
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
index 8579505c29a4..7def66168503 100644
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
-- 
2.21.0

