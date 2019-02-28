Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DBB205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfB1Hhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:37:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbfB1Hhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:37:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7b6ti2947070
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:37:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7b6mU2947067;
        Wed, 27 Feb 2019 23:37:06 -0800
Date:   Wed, 27 Feb 2019 23:37:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tommi Rantala <tipbot@zytor.com>
Message-ID: <tip-83244772a4cf9490a54182be2f65f45d6b1a1ee8@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, tommi.t.rantala@nokia.com, kim.phillips@arm.com,
        brueckner@linux.ibm.com, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, mpetlan@redhat.com, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
          mpetlan@redhat.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, brueckner@linux.ibm.com,
          kim.phillips@arm.com, jolsa@redhat.com,
          tommi.t.rantala@nokia.com, namhyung@kernel.org, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20190215134253.11454-1-tt.rantala@gmail.com>
References: <20190215134253.11454-1-tt.rantala@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests shell: Skip trace+probe_vfs_getname.sh
 if built without trace support
Git-Commit-ID: 83244772a4cf9490a54182be2f65f45d6b1a1ee8
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

Commit-ID:  83244772a4cf9490a54182be2f65f45d6b1a1ee8
Gitweb:     https://git.kernel.org/tip/83244772a4cf9490a54182be2f65f45d6b1a1ee8
Author:     Tommi Rantala <tommi.t.rantala@nokia.com>
AuthorDate: Fri, 15 Feb 2019 15:42:46 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 15 Feb 2019 13:42:26 -0300

perf tests shell: Skip trace+probe_vfs_getname.sh if built without trace support

If perf was built without trace support, the trace+probe_vfs_getname.sh
'perf test' entry fails:

  # perf trace -h
  perf: 'trace' is not a perf-command. See 'perf --help'

  # perf test 64
  64: Check open filename arg using perf trace + vfs_getname: FAILED!

Check trace support, so that we'll skip the test in that case:

  # perf test 64
  64: Check open filename arg using perf trace + vfs_getname: Skip

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190215134253.11454-1-tt.rantala@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe.sh               | 5 +++++
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/lib/probe.sh b/tools/perf/tests/shell/lib/probe.sh
index 6293cc660947..e37787be672b 100644
--- a/tools/perf/tests/shell/lib/probe.sh
+++ b/tools/perf/tests/shell/lib/probe.sh
@@ -4,3 +4,8 @@ skip_if_no_perf_probe() {
 	perf probe 2>&1 | grep -q 'is not a perf-command' && return 2
 	return 0
 }
+
+skip_if_no_perf_trace() {
+	perf trace -h 2>&1 | grep -q -e 'is not a perf-command' -e 'trace command not available' && return 2
+	return 0
+}
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 50109f27ca07..147efeb6b195 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -12,6 +12,7 @@
 . $(dirname $0)/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
+skip_if_no_perf_trace || exit 2
 
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
