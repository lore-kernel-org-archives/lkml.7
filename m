Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B7FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B253F21905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127451;
	bh=YE1EgZeukspEzv6MCxasg31Wtb1pIL9dwAGoNgFUUdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lRFcdnK/mjWpK6SnsAolYpw5ylvaOvHwDstFH2pQ+YcumpWF2GelpavKdxR4itHpJ
	 MvciTmjd8Zsnj5zZ3MYqNhWRVat3HIglUWElZKPinRKbicfKxjkRD7nR9E9LfblWtD
	 QY2APbcpGjJxQrbmFyoNQs84vgsjO2KweptK1kBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfDXRhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387911AbfDXRh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:28 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8C720675;
        Wed, 24 Apr 2019 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127447;
        bh=YE1EgZeukspEzv6MCxasg31Wtb1pIL9dwAGoNgFUUdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXRhmhUPrDVc55T/apURKhVfF+Pj00Ux+qapK3ddrR7Jb9jF2u9Tzn4IU0yiFUNgT
         koisDDsEpKviC+uTZElUZpvmgvfJK5Y0G5mryzgn8ixAMIY0OU37bhfKcxxsRck7bF
         FT1X/IPYd00/6M7dcGJvRpVzLq4tlHwVGzshpAPo=
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
Subject: [PATCH 5.0 095/115] perf/x86/amd: Add event map for AMD Family 17h
Date:   Wed, 24 Apr 2019 19:10:31 +0200
Message-Id: <20190424170930.368617985@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
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
@@ -117,22 +117,39 @@ static __initconst const u64 amd_hw_cach
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
 


