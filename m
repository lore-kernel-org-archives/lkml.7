Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62638C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F2220645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbfETLiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733121AbfETLh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:59 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/22] perf intel-pt: Document IPC usage
Date:   Mon, 20 May 2019 14:37:18 +0300
Message-Id: <20190520113728.14389-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add brief documentation about instructions-per-cycle (IPC) information
derived from Intel PT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/intel-pt.txt | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 60d99e5e7921..50c5b60101bd 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -103,6 +103,36 @@ The flags are "bcrosyiABEx" which stand for branch, call, return, conditional,
 system, asynchronous, interrupt, transaction abort, trace begin, trace end, and
 in transaction, respectively.
 
+Another interesting field that is not printed by default is 'ipc' which can be
+displayed as follows:
+
+	perf script --itrace=be -F+ipc
+
+There are two ways that instructions-per-cycle (IPC) can be calculated depending
+on the recording.
+
+If the 'cyc' config term (see config terms section below) was used, then IPC is
+calculated using the cycle count from CYC packets, otherwise MTC packets are
+used - refer to the 'mtc' config term.  When MTC is used, however, the values
+are less accurate because the timing is less accurate.
+
+Because Intel PT does not update the cycle count on every branch or instruction,
+the values will often be zero.  When there are values, they will be the number
+of instructions and number of cycles since the last update, and thus represent
+the average IPC since the last IPC for that event type.  Note IPC for "branches"
+events is calculated separately from IPC for "instructions" events.
+
+Also note that the IPC instruction count may or may not include the current
+instruction.  If the cycle count is associated with an asynchronous branch
+(e.g. page fault or interrupt), then the instruction count does not include the
+current instruction, otherwise it does.  That is consistent with whether or not
+that instruction has retired when the cycle count is updated.
+
+Another note, in the case of "branches" events, non-taken branches are not
+presently sampled, so IPC values for them do not appear e.g. a CYC packet with a
+TNT packet that starts with a non-taken branch.  To see every possible IPC
+value, "instructions" events can be used e.g. --itrace=i0ns
+
 While it is possible to create scripts to analyze the data, an alternative
 approach is available to export the data to a sqlite or postgresql database.
 Refer to script export-to-sqlite.py or export-to-postgresql.py for more details,
-- 
2.17.1

