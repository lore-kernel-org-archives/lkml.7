Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D4AC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10DF24685
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLFIDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:03:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60497 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfLFIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:03:46 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1id8aN-00053E-80; Fri, 06 Dec 2019 09:03:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E01361C2784;
        Fri,  6 Dec 2019 09:03:34 +0100 (CET)
Date:   Fri, 06 Dec 2019 08:03:34 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf inject: Fix processing of ID index for
 injected instruction tracing
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191204120800.8138-1-adrian.hunter@intel.com>
References: <20191204120800.8138-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157561941481.21853.14727169121373627514.tip-bot2@tip-bot2>
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

Commit-ID:     29f6eeca0e14b301d9c03a3164b852c318d6348a
Gitweb:        https://git.kernel.org/tip/29f6eeca0e14b301d9c03a3164b852c318d6348a
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 04 Dec 2019 14:08:00 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 04 Dec 2019 12:39:53 -03:00

perf inject: Fix processing of ID index for injected instruction tracing

The ID index event is used when decoding, but can result in the
following error:

 $ perf record --aux-sample -e '{intel_pt//,branch-misses}:u' ls
 $ perf inject -i perf.data -o perf.data.inj --itrace=be
 $ perf script -i perf.data.inj
 0x1020 [0x410]: failed to process type: 69 [No such file or directory]

Fix by having 'perf inject' drop the ID index event.

Fixes: c0a6de06c446 ("perf record: Add support for AUX area sampling")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191204120800.8138-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 9664a72..7e124a7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -403,17 +403,6 @@ static int perf_event__repipe_tracing_data(struct perf_session *session,
 	return err;
 }
 
-static int perf_event__repipe_id_index(struct perf_session *session,
-				       union perf_event *event)
-{
-	int err;
-
-	perf_event__repipe_synth(session->tool, event);
-	err = perf_event__process_id_index(session, event);
-
-	return err;
-}
-
 static int dso__read_build_id(struct dso *dso)
 {
 	if (dso->has_build_id)
@@ -651,7 +640,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.comm	    = perf_event__repipe_comm;
 		inject->tool.namespaces	    = perf_event__repipe_namespaces;
 		inject->tool.exit	    = perf_event__repipe_exit;
-		inject->tool.id_index	    = perf_event__repipe_id_index;
+		inject->tool.id_index	    = perf_event__process_id_index;
 		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
 		inject->tool.auxtrace	    = perf_event__process_auxtrace;
 		inject->tool.aux	    = perf_event__drop_aux;
