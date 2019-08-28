Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D00C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BBE2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566977534;
	bh=0uJ8OV/wzP+lMaDiWMGUAoXoB0nTWbNW8NbSSOd74n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H5GBRQspaHrCmKUY4rrIB/CUmdARVCKyEA1ClQq3n8vOFj6lG1SQbcZDqsVhnG2LK
	 3KjOoz4OqgmGaRDWQxxXoXQuXN9hqGEhAyyKbEzSOvWDayDuk2qM3naInxFX691GNb
	 DycrVFLZcBWJFaWp/dARETsGR7eiY5gpjlwMhOjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfH1HcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:32:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39451 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfH1HcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:32:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id y200so1136573pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKnre4R7fhph+USsgtPJx3psLS7PXokZ8cevH4X8ccM=;
        b=KkZM+ntg14jRR6hmOejPB+hVoOReqc4Ttq6IpEJPEYYFrpldBSRj4Yr5EqPTD6oEic
         wg4RzEafGpliZwZgZuKOCntOH/ZwqD35BxypBFAZ6fXXnwpxjocqCkAanBsjY8EMxDHg
         1Ed52IE7XbqNRKdbpHAB7fX+VVsC9AXcTb5FEk4xvWhq6BeL+QOGkygpD9cL2FSLlLex
         KycQnktH78Le0oDsTxaOFEx42G1tBoWo+HWeatu9zTM3JHCEsl1sYPZXl+PglQNlgvRN
         QjOFhApjEqhgqiTO95oDSuQw4VaZjLE8y3ks9xdOgmEv50KOkCfGDvtZR/qxvxsbmc8T
         QCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pKnre4R7fhph+USsgtPJx3psLS7PXokZ8cevH4X8ccM=;
        b=QhYsn4iJ7p508/8lDkfQ6ckN0GDkFavD/ssNEattDHFuO18Sc/I94/MxmbJm0OfJHn
         O24kKMoQNTqBNdmIfimujpphNwWiG/urQ0wzj7K4VZXcFHteKuxDaFDExlewcwh+hkLK
         FwkMngUVs0W6L58YCB0TD4MNkrxd3D28xif8ddHdGk9QTidpD9oi4Da1u5IT+d9j8uCX
         gFiZa6xZQQ2BKC2DHzF6mfBbcJh9XlK+HFAUR/s/DLhYqRNM6HkpmuQSEALcefKnLpnB
         ie4jHBMlBEiJgCklxLgmeGQ8eOAo+0FdIu88uaMeM1KkIN3GMJwH438cgjQ7Vi9OoGpH
         hLqw==
X-Gm-Message-State: APjAAAWHQYG9BcrVwBGrCPgDff+No/NsTYAtdOWvm5b3gisfI/TFQlSu
        GslnemsGKSGEkSXTepkgsh8=
X-Google-Smtp-Source: APXvYqznG8BpG9iF1o74URvNzxOVAqsy58YPyy4gfXrKGHiyQJ746hxBtNMWTEPWiaPkpAUmJPCSVQ==
X-Received: by 2002:a17:90a:9a90:: with SMTP id e16mr2878882pjp.71.1566977524902;
        Wed, 28 Aug 2019 00:32:04 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:32:04 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 7/9] perf record: Add --all-cgroups option
Date:   Wed, 28 Aug 2019 16:31:28 +0900
Message-Id: <20190828073130.83800-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828073130.83800-1-namhyung@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --all-cgroups option is to enable cgroup profiling support.  It
tells kernel to record CGROUP events in the ring buffer so that perf
report can identify task/cgroup association later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 5 ++++-
 tools/perf/builtin-record.c              | 5 +++++
 tools/perf/util/evsel.c                  | 5 +++++
 tools/perf/util/record.h                 | 1 +
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c6f9f31b6039..fa2e83f72461 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -382,7 +382,10 @@ displayed with the weight and local_weight sort keys.  This currently works for
 abort events and some memory events in precise mode on modern Intel CPUs.
 
 --namespaces::
-Record events of type PERF_RECORD_NAMESPACES.
+Record events of type PERF_RECORD_NAMESPACES.  This enables 'cgroup_id' sort key.
+
+--all-cgroups::
+Record events of type PERF_RECORD_CGROUP.  This enables 'cgroup' sort key.
 
 --transaction::
 Record transaction flags for transaction related events.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a6e3c4413b39..918af5e9f05d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1354,6 +1354,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (rec->opts.record_namespaces)
 		tool->namespace_events = true;
 
+	if (rec->opts.record_cgroup)
+		tool->cgroup_events = true;
+
 	if (rec->opts.auxtrace_snapshot_mode || rec->switch_output.enabled) {
 		signal(SIGUSR2, snapshot_sig_handler);
 		if (rec->opts.auxtrace_snapshot_mode)
@@ -2215,6 +2218,8 @@ static struct option __record_options[] = {
 			"per thread proc mmap processing timeout in ms"),
 	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &record.opts.record_cgroup,
+		    "Record cgroup events"),
 	OPT_BOOLEAN(0, "switch-events", &record.opts.record_switch_events,
 		    "Record context switch events"),
 	OPT_BOOLEAN_FLAG(0, "all-kernel", &record.opts.all_kernel,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 86a38679cad1..390ecb554446 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1077,6 +1077,11 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
 
+	if (opts->record_cgroup) {
+		attr->cgroup = track;
+		perf_evsel__set_sample_bit(evsel, CGROUP);
+	}
+
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 00275afc524d..740d110fc770 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -33,6 +33,7 @@ struct record_opts {
 	bool	      auxtrace_snapshot_mode;
 	bool	      auxtrace_snapshot_on_exit;
 	bool	      record_namespaces;
+	bool	      record_cgroup;
 	bool	      record_switch_events;
 	bool	      all_kernel;
 	bool	      all_user;
-- 
2.23.0.187.g17f5b7556c-goog

