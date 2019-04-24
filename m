Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B216C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBADC20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128680;
	bh=kZzlM+teg2cU093if+vR6a5sFUxlD7aQx2guqyJVss8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XtbsVlXIwlOrAdlDSsIRKuJXfgxKoQ9fDoc/4PDlMq6OGLcRMUBhvbgkIDibhWAN5
	 pfDIp8Ix5aqCZjSWCvnNI7+2FI236/X6GMblX5wAHfEAB0Qlv0m84WEwb5NdZNnvHx
	 wo/LrDA9xIxlmV4DxsD8VIg42V4k8U3qKoaS1MxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391363AbfDXR57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390023AbfDXRZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:25:24 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 745BA205ED;
        Wed, 24 Apr 2019 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126723;
        bh=kZzlM+teg2cU093if+vR6a5sFUxlD7aQx2guqyJVss8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gIWNTnClY8DS9gSfNCGRdW/j3XS5QmuOAOQPPiVsjbIP5hUg+lkGrRQh0uwpyE0Ox
         N3SbADnqm9t7CnncpU+x7qZJRYtCOOhZrxufBIVWH/IC5l7obQOgrCiaMvPwhnfo+j
         tAZT7z/0mpkGjJ9VqLmHM4hdcSu6APz0aSNyI4Zo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Pu Wen <puwen@hygon.cn>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 37/44] perf/x86/amd: Add event map for AMD Family 17h
Date:   Wed, 24 Apr 2019 19:10:15 +0200
Message-Id: <20190424170900.511642990@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

commit 3fe3331bb285700ab2253dbb07f8e478fcea2f1b upstream.

Family 17h differs from prior families by:

 - Does not support an L2 cache miss event
 - It has re-enumerated PMC counters for:
   - L2 cache references
   - front & back end stalled cycles

So we add a new amd_f17h_perfmon_event_map[] so that the generic
perf event names will resolve to the correct h/w events on
family 17h and above processors.

Reference sections 2.1.13.3.3 (stalls) and 2.1.13.3.6 (L2):

  https://www.amd.com/system/files/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: <stable@vger.kernel.org> # v4.9+
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Fixes: e40ed1542dd7 ("perf/x86: Add perf support for AMD family-17h processors")
[ Improved the formatting a bit. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/amd/core.c |   35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -113,22 +113,39 @@ static __initconst const u64 amd_hw_cach
 };
 
 /*
- * AMD Performance Monitor K7 and later.
+ * AMD Performance Monitor K7 and later, up to and including Family 16h:
  */
 static const u64 amd_perfmon_event_map[PERF_COUNT_HW_MAX] =
 {
-  [PERF_COUNT_HW_CPU_CYCLES]			= 0x0076,
-  [PERF_COUNT_HW_INSTRUCTIONS]			= 0x00c0,
-  [PERF_COUNT_HW_CACHE_REFERENCES]		= 0x077d,
-  [PERF_COUNT_HW_CACHE_MISSES]			= 0x077e,
-  [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]		= 0x00c2,
-  [PERF_COUNT_HW_BRANCH_MISSES]			= 0x00c3,
-  [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00d0, /* "Decoder empty" event */
-  [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x00d1, /* "Dispatch stalls" event */
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x077d,
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x077e,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00d0, /* "Decoder empty" event */
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x00d1, /* "Dispatch stalls" event */
+};
+
+/*
+ * AMD Performance Monitor Family 17h and later:
+ */
+static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
+{
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0xff60,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x0287,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x0187,
 };
 
 static u64 amd_pmu_event_map(int hw_event)
 {
+	if (boot_cpu_data.x86 >= 0x17)
+		return amd_f17h_perfmon_event_map[hw_event];
+
 	return amd_perfmon_event_map[hw_event];
 }
 


