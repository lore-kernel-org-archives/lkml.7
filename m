Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEA8C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3757229EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563912356;
	bh=iWw8WjW7t/Xogrxr28Hix4tdM3kV2pKhLX8g+mvoGrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SmKnwZJPGUSE1Rvv/DJ2MPC0N9T3+LOwdJErJR8PxkQr3CsGmUPHso8kYPJlscale
	 0RthkYWo+HuRXfudjqUPgaDgo3rbaeqlFH3KAm0UcgRA85puzxrhEo+lI4xKlkAmmx
	 WoFI7Qll5IpsoVkttmpZMtomZKzSicGKxve84LbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbfGWUFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfGWUFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:05:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47757229ED;
        Tue, 23 Jul 2019 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563912352;
        bh=iWw8WjW7t/Xogrxr28Hix4tdM3kV2pKhLX8g+mvoGrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4+N43DXkXbEpdTjaowHYUDnH0kXLPtnUkQ1ELnVY785rm8QTUS+NASz54pjI+pwm
         p3C7EOoKLxpxps94XK6OU8N+mLVO7cNiwCAI2iR151mrLRT/enmQ/Ks/G01AQW8xYs
         lhS5TiDoKBgzlFl9Q3JgoqreSRgxRRwSCBj1uPOA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/10] perf script: Improve man page description of metrics
Date:   Tue, 23 Jul 2019 17:05:22 -0300
Message-Id: <20190723200530.14090-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Clarify that a metric is based on events, not referring to itself. Also
some improvements with the sentences.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190711181922.18765-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 042b9e5dcc32..caaab28f8400 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -228,11 +228,11 @@ OPTIONS
 
 	With the metric option perf script can compute metrics for
 	sampling periods, similar to perf stat. This requires
-	specifying a group with multiple metrics with the :S option
+	specifying a group with multiple events defining metrics with the :S option
 	for perf record. perf will sample on the first event, and
-	compute metrics for all the events in the group. Please note
+	print computed metrics for all the events in the group. Please note
 	that the metric computed is averaged over the whole sampling
-	period, not just for the sample point.
+	period (since the last sample), not just for the sample point.
 
 	For sample events it's possible to display misc field with -F +misc option,
 	following letters are displayed for each bit:
-- 
2.21.0

