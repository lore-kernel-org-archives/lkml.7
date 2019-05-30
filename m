Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54172C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A0D25703
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FPlr499h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfE3IWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:22:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34469 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfE3IWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:22:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8LxND2906116
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:21:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8LxND2906116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204519;
        bh=YEiEEjF650mPaCQKd5gPkn4BZeSHbLmRJSVZva7u/nw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FPlr499hYukRDlRndIsYOOD5Lq7mpJUBHitiyHo2uR4TaGitBAdDztJ6jt00JeA3B
         kH7eN6Qf4i3+dkHEi0Fm4WXqyQCYjqVuK57kYMA7OTcOty5mgX6MwJkcMjFuuoXSKw
         Q0aRb2z2jkRRxXX0uDJjUUovMjgOJ75KCecD/gNG6H6EKOFk3YnorLwYS9vCubQnYo
         uVt5dabK58CXUYDnJO7etw1vhadnI4shfTUYfc9vniZxiq9sZQhE6wmYeVXiwdpzwR
         2dSgDY/4EcLPZX9O1G8mRmacsKdQBdGpU00gBUfw8+1jGjX5RqgOYh159NOV3C8Atm
         u9syFDtnUHb0w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8Lw8w2906108;
        Thu, 30 May 2019 01:21:58 -0700
Date:   Thu, 30 May 2019 01:21:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-14f1cfd4f7b4794e2f9d2ae214bcf049654b0b5c@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, tglx@linutronix.de, jolsa@redhat.com,
          acme@redhat.com
In-Reply-To: <20190412113830.4126-9-adrian.hunter@intel.com>
References: <20190412113830.4126-9-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Rationalize intel_pt_sync_switch()'s
 use of next_tid
Git-Commit-ID: 14f1cfd4f7b4794e2f9d2ae214bcf049654b0b5c
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

Commit-ID:  14f1cfd4f7b4794e2f9d2ae214bcf049654b0b5c
Gitweb:     https://git.kernel.org/tip/14f1cfd4f7b4794e2f9d2ae214bcf049654b0b5c
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 12 Apr 2019 14:38:30 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:45 -0300

perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid

Returning 1 from intel_pt_sync_switch() causes the current tid to be
set. That negates the need to keep next_tid anymore. Rationalize the
code to that effect.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6aaba1146fc8..7a70693c1b91 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1859,7 +1859,6 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 
 	switch (ptq->switch_state) {
 	case INTEL_PT_SS_NOT_TRACING:
-		ptq->next_tid = -1;
 		break;
 	case INTEL_PT_SS_UNKNOWN:
 	case INTEL_PT_SS_TRACING:
@@ -1879,13 +1878,14 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 		ptq->switch_state = INTEL_PT_SS_TRACING;
 		break;
 	case INTEL_PT_SS_EXPECTING_SWITCH_IP:
-		ptq->next_tid = tid;
 		intel_pt_log("ERROR: cpu %d expecting switch ip\n", cpu);
 		break;
 	default:
 		break;
 	}
 
+	ptq->next_tid = -1;
+
 	return 1;
 }
 
