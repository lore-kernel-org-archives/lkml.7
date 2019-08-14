Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58736C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242452084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808373;
	bh=du1uD+QtMWBJW0ocCm9w3dUEW309UDTXQtkK1+GrMsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZwiePMgV9ITrmwALl0CzN4uzMDZ3j1N9oF6/gnKyskPdjjxa90ew9SWWIT26aUrcy
	 l4puRYIhDtSsu94f2TTdak30gjQm/dwMvRZEzIdtXQiB15di7i0286tCQz7Pze2zVw
	 O1jehhetSjis1AWvP/K1AVD+JClv29vi1AF+CrD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfHNSqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfHNSqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:46:11 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291BC2064A;
        Wed, 14 Aug 2019 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808370;
        bh=du1uD+QtMWBJW0ocCm9w3dUEW309UDTXQtkK1+GrMsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwP5ewykspCSaHVC+ryQNOdU5u6TzIis+IG0UVupkNL7kWa3ogj5bTKJuouTIQenZ
         9nnJWXdTyPKUmehS/OWW/3WvXD88RWgTPg5m4Br5dW1dnUL01iHraZxwtVtXZn4k3c
         OfxT5bDGCktLRYAsghN0YQVxoA7tlJS5IfSin0nE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/28] perf intel-pt: Add brief documentation for PEBS via Intel PT
Date:   Wed, 14 Aug 2019 15:40:46 -0300
Message-Id: <20190814184051.3125-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Document how to select PEBS via Intel PT and how to display synthesized
PEBS samples.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-8-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
[ Update the example to use a group with intel_pt// as the group leader, as per Alex comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 50c5b60101bd..e0d9e7dd4f17 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -919,3 +919,18 @@ amended to take the number of elements as a parameter.
 
 Note there is currently no advantage to using Intel PT instead of LBR, but
 that may change in the future if greater use is made of the data.
+
+
+PEBS via Intel PT
+=================
+
+Some hardware has the feature to redirect PEBS records to the Intel PT trace.
+Recording is selected by using the aux-output config term e.g.
+
+	perf record -c 10000 -e '{intel_pt/branch=0/,cycles/aux-output/ppp}' uname
+
+Note that currently, software only supports redirecting at most one PEBS event.
+
+To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
+
+	perf script --itrace=oe
-- 
2.21.0

