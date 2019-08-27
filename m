Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEB7C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF11920679
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869908;
	bh=JcRGpSAMSkKk1fFKf/1KaMEweffSNEC99Ix3m7DNLCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sJ6sVkp3rBXBZzBFDOhEB7Le93gsf/XwUJnph4EAoNl8/EWRTf1JYp1UrPRTLoy46
	 KmjYZEBVf19o13dbJ1UfgrBGkmFme02OnCXOW3EZK4vf8TCoI5EBXFDCzAIkG9TETL
	 BxZbNaD2Nki9mM0tJ+zoojAU7Bxhab2ogox0Cw5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfH0Bi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfH0BiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:38:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C712341E;
        Tue, 27 Aug 2019 01:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869902;
        bh=JcRGpSAMSkKk1fFKf/1KaMEweffSNEC99Ix3m7DNLCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cryP2NQGisJKOnmPvltBdTxiisQfKz4fyvW65b/obwd4mc6m7f4NHIlae9ss7ke9h
         X+e/GKToKp5gUIQFgO1escOY/W6/5YbkE73tIKDfph1X9mwMyPtc99ScP9/z730qR6
         MaKCIShI6k7y0nNqwkKeVQ72ccqzjit48VbGZcE0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 33/33] perf evsel: Rename perf_missing_features::bpf_event to ::bpf
Date:   Mon, 26 Aug 2019 22:36:34 -0300
Message-Id: <20190827013634.3173-34-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need for that _event suffix, do just like all the other meta events
and do away with that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-bvc83f380dva83wlg52yd10t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 9 ++++-----
 tools/perf/util/evsel.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b3cfe120d097..fa676355559e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1072,8 +1072,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
 	attr->ksymbol = track && !perf_missing_features.ksymbol;
-	attr->bpf_event = track && !opts->no_bpf_event &&
-		!perf_missing_features.bpf_event;
+	attr->bpf_event = track && !opts->no_bpf_event && !perf_missing_features.bpf;
 
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
@@ -1803,7 +1802,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
 	if (perf_missing_features.ksymbol)
 		evsel->core.attr.ksymbol = 0;
-	if (perf_missing_features.bpf_event)
+	if (perf_missing_features.bpf)
 		evsel->core.attr.bpf_event = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
@@ -1920,8 +1919,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		perf_missing_features.aux_output = true;
 		pr_debug2("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
-	} else if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
-		perf_missing_features.bpf_event = true;
+	} else if (!perf_missing_features.bpf && evsel->core.attr.bpf_event) {
+		perf_missing_features.bpf = true;
 		pr_debug2("switching off bpf_event\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 77e07f2486d3..fd60caced4fc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -194,7 +194,7 @@ struct perf_missing_features {
 	bool write_backward;
 	bool group_read;
 	bool ksymbol;
-	bool bpf_event;
+	bool bpf;
 	bool aux_output;
 };
 
-- 
2.21.0

