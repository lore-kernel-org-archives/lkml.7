Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C282C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6AD20578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455400;
	bh=5LkOgcPDaLCwL5UVlzn70Wlc+nI4zLnqaopdl77+VnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sYwb778uf5I24QBZAkMHsWd/BWTamxnpyOONbFsnDsUnkEhjNaAx4KLFw6OLOiasb
	 YeWEhhAL1F2NbSYvm8HJBxOjkUhWCFtuGCE67XOkNmssF+AXHouMB60XfGK25K5w2D
	 sYTsIbXRt5RcGMsJawLr+X1hHvVtsGJlLLgIigkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfG3C4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731562AbfG3C4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:56:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F376520578;
        Tue, 30 Jul 2019 02:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455392;
        bh=5LkOgcPDaLCwL5UVlzn70Wlc+nI4zLnqaopdl77+VnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKE4GAT3C+A9w7BxVMa8WivCua9Dt5M86DrU7OktwOQpQ7ZoUwdSH0XrT1sFpmtL2
         o0URxevA8roTHFNPBiw1mKUHvyYs6OwwFSoJux1VYMirFt82dtwXIBbQUju60Ea9Y0
         nhNJ6UcadCrh1kyhVP+8mWfIM/pDF59KBmTlZChY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 004/107] perf trace: Add pointer to BPF object containing __augmented_syscalls__
Date:   Mon, 29 Jul 2019 23:54:27 -0300
Message-Id: <20190730025610.22603-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can use it when looking for other components of that object
file, such as other programs to add to the BPF_MAP_TYPE_PROG_ARRAY and
use with bpf_tail_call().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1ibmz7ouv6llqxajy7m8igtd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4f0bbffee05f..6aa080845a84 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -96,6 +96,7 @@ struct trace {
 	struct perf_evlist	*evlist;
 	struct machine		*host;
 	struct thread		*current;
+	struct bpf_object	*bpf_obj;
 	struct cgroup		*cgroup;
 	u64			base_time;
 	FILE			*output;
@@ -3895,6 +3896,20 @@ int cmd_trace(int argc, const char **argv)
 
 	if (evsel) {
 		trace.syscalls.events.augmented = evsel;
+
+		evsel = perf_evlist__find_tracepoint_by_name(trace.evlist, "raw_syscalls:sys_enter");
+		if (evsel == NULL) {
+			pr_err("ERROR: raw_syscalls:sys_enter not found in the augmented BPF object\n");
+			goto out;
+		}
+
+		if (evsel->bpf_obj == NULL) {
+			pr_err("ERROR: raw_syscalls:sys_enter not associated to a BPF object\n");
+			goto out;
+		}
+
+		trace.bpf_obj = evsel->bpf_obj;
+
 		trace__set_bpf_map_filtered_pids(&trace);
 		trace__set_bpf_map_syscalls(&trace);
 	}
-- 
2.21.0

