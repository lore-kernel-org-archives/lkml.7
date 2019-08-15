Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97722C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2F6208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HlZRqz02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfHOJaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:30:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOJaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:30:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9U2Jg2274131
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:30:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9U2Jg2274131
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861403;
        bh=uqLqIdT5VcNKnCq+HZeD0IRyYlCHybYNIEC6ekMtcc4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HlZRqz02nUcvNYov96ysiLY0T6GCuWrGVAhLPjwVnGEtLuTH2CY/5fyFHB6YJ9saC
         TLPZWCgEtnCzUPkEU5809YWZw+brs6h7b6MV2WeAeFS6tGWwGzGeNb1wX63byblPja
         R/qTyBP+N06Lk9I60xPsJUAlrkUpJ6zabp9rKniY7H1VzNtd7SjELzbELosoww96n1
         8R2oj8oY+gNgmT92sjr2R7ADYCatIkMltrHTdCtMFVW6MMPULJL9sQaDkkyzJYf6UV
         8jJ9Wzzvalz9P7gZO9meGTkEI1L4LQJd+NDeawZsgRrw6w5ZNNGr72/WWVKFrYCQ5q
         s0LXnCx96KQHw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9U1QR2274070;
        Thu, 15 Aug 2019 02:30:01 -0700
Date:   Thu, 15 Aug 2019 02:30:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5a4b58e5d64ac7ebca175ffd8d74ca1b5cb0a01f@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, namhyung@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
        acme@redhat.com
Reply-To: kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
          adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, namhyung@kernel.org, hpa@zytor.com,
          jolsa@kernel.org, acme@redhat.com
In-Reply-To: <20190806084606.4021-4-alexander.shishkin@linux.intel.com>
References: <20190806084606.4021-4-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add aux_output attribute flag
Git-Commit-ID: 5a4b58e5d64ac7ebca175ffd8d74ca1b5cb0a01f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5a4b58e5d64ac7ebca175ffd8d74ca1b5cb0a01f
Gitweb:     https://git.kernel.org/tip/5a4b58e5d64ac7ebca175ffd8d74ca1b5cb0a01f
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Aug 2019 11:46:02 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf tools: Add aux_output attribute flag

Add aux_output attribute flag to match the kernel's perf_event.h file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-4-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 3 ++-
 tools/perf/util/evsel.c               | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..bb7b271397a6 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -374,7 +374,8 @@ struct perf_event_attr {
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
-				__reserved_1   : 33;
+				aux_output     :  1, /* generate AUX records instead of events */
+				__reserved_1   : 32;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 64bc32ed6dfa..897a97af2d81 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1587,6 +1587,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(namespaces, p_unsigned);
 	PRINT_ATTRf(ksymbol, p_unsigned);
 	PRINT_ATTRf(bpf_event, p_unsigned);
+	PRINT_ATTRf(aux_output, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
