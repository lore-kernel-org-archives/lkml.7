Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE70C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C75218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279616;
	bh=umwKmiHLrxUFwaeJpIQl/HmL+VMS5ae+0pRD4m1/Izc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jqHMQRIoU/QwyhXXwK4Hkt9ZxS0wkzW72pLSS41qiJp993iJHq290j1f8it8hj7TY
	 Tb4k3mkRqk/Eyz2SygME8sERUCnXh0E+iICyP++ag01OqYTtRZhi8yMh6Av7NeWgxQ
	 qg8Njn+59cBX3erElsV59D/UohBVP8V13PWvah+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407182AbfFKTAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405209AbfFKTAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A39721841;
        Tue, 11 Jun 2019 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279613;
        bh=umwKmiHLrxUFwaeJpIQl/HmL+VMS5ae+0pRD4m1/Izc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5IcbglUEV2r6pCAbzVi8xueLVT6jHTBdeLASNeghiwaprlJO+fTu4+A4VzrXVzsl
         1VydFJ7k4fGe5TENuDeg7sBaa4hWLZ2B1tLh2H2/SCxnWj96K88XnswwVGH6q1UfLP
         f76aCWMD4BJbv54uX1VzguOv/vyoU4Xu8y8OfFos=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/85] perf intel-pt: Document IPC usage
Date:   Tue, 11 Jun 2019 15:58:01 -0300
Message-Id: <20190611185911.11645-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add brief documentation about instructions-per-cycle (IPC) information
derived from Intel PT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

