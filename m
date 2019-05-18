Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F26EC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3CF20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="U5PtnZqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfERJcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:32:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:32:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9WdO51742145
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:32:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9WdO51742145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171960;
        bh=GzdL3l354twIWcYbatsl9bhASnuT97ICkJuzXcibjyE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=U5PtnZqPULD/MT1w4W3FUjosVyFVxGRSicy+8/p3UK0ev7wIk0KSYgZwa5UNP5lFt
         2H9zHOYy7NoXrFs82+h2e+BoMfaUKudkJ1UruxFXPLrlROkt3DLipAVSOqdYwyTHx+
         brH60Qw35hGzG0tG3siOeGgsXpRpigOWMRgVHoK1hdpe5Qs+2NcfQk0hkw94gZ+LyC
         /R7r77KWGJjTIoLmSonrYdep6zb4Je9RnqwlfkgQ9QWjfWMY8N1JZuJLaAcqpP4bHN
         3wmGlVLkjjIYZjLz+hzHQDEJ8cdemhtN5isL8Q7Iic8DkKcRs7DRSWF8ZNziU9kyLc
         VGmoXe+BXdLHg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9Wd9j1742141;
        Sat, 18 May 2019 02:32:39 -0700
Date:   Sat, 18 May 2019 02:32:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-7ba8fa20e26eb3c0c04d747f7fd2223694eac4d5@git.kernel.org>
Cc:     acme@redhat.com, adrian.hunter@intel.com, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Reply-To: adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jolsa@redhat.com
In-Reply-To: <20190510124143.27054-2-adrian.hunter@intel.com>
References: <20190510124143.27054-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Fix instructions sampling rate
Git-Commit-ID: 7ba8fa20e26eb3c0c04d747f7fd2223694eac4d5
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

Commit-ID:  7ba8fa20e26eb3c0c04d747f7fd2223694eac4d5
Gitweb:     https://git.kernel.org/tip/7ba8fa20e26eb3c0c04d747f7fd2223694eac4d5
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 10 May 2019 15:41:41 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 16 May 2019 14:17:23 -0300

perf intel-pt: Fix instructions sampling rate

The timestamp used to determine if an instruction sample is made, is an
estimate based on the number of instructions since the last known
timestamp. A consequence is that it might go backwards, which results in
extra samples. Change it so that a sample is only made when the
timestamp goes forwards.

Note this does not affect a sampling period of 0 or sampling periods
specified as a count of instructions.

Example:

 Before:

 $ perf script --itrace=i10us
 ls 13812 [003] 2167315.222583:       3270 instructions:u:      7fac71e2e494 __GI___tunables_init+0xf4 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:      30902 instructions:u:      7fac71e2da0f _dl_cache_libcmp+0x2f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:         10 instructions:u:      7fac71e2d9ff _dl_cache_libcmp+0x1f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:          8 instructions:u:      7fac71e2d9ea _dl_cache_libcmp+0xa (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:         14 instructions:u:      7fac71e2d9ea _dl_cache_libcmp+0xa (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:          6 instructions:u:      7fac71e2d9ff _dl_cache_libcmp+0x1f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:         14 instructions:u:      7fac71e2d9ff _dl_cache_libcmp+0x1f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:          4 instructions:u:      7fac71e2dab2 _dl_cache_libcmp+0xd2 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222728:      16423 instructions:u:      7fac71e2477a _dl_map_object_deps+0x1ba (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222734:      12731 instructions:u:      7fac71e27938 _dl_name_match_p+0x68 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ...

 After:
 $ perf script --itrace=i10us
 ls 13812 [003] 2167315.222583:       3270 instructions:u:      7fac71e2e494 __GI___tunables_init+0xf4 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:      30902 instructions:u:      7fac71e2da0f _dl_cache_libcmp+0x2f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222728:      16479 instructions:u:      7fac71e2477a _dl_map_object_deps+0x1ba (/lib/x86_64-linux-gnu/ld-2.28.so)
 ...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: f4aa081949e7b ("perf tools: Add Intel PT decoder")
Link: http://lkml.kernel.org/r/20190510124143.27054-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 872fab163585..26dbf11e071a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -888,16 +888,20 @@ static uint64_t intel_pt_next_period(struct intel_pt_decoder *decoder)
 	timestamp = decoder->timestamp + decoder->timestamp_insn_cnt;
 	masked_timestamp = timestamp & decoder->period_mask;
 	if (decoder->continuous_period) {
-		if (masked_timestamp != decoder->last_masked_timestamp)
+		if (masked_timestamp > decoder->last_masked_timestamp)
 			return 1;
 	} else {
 		timestamp += 1;
 		masked_timestamp = timestamp & decoder->period_mask;
-		if (masked_timestamp != decoder->last_masked_timestamp) {
+		if (masked_timestamp > decoder->last_masked_timestamp) {
 			decoder->last_masked_timestamp = masked_timestamp;
 			decoder->continuous_period = true;
 		}
 	}
+
+	if (masked_timestamp < decoder->last_masked_timestamp)
+		return decoder->period_ticks;
+
 	return decoder->period_ticks - (timestamp - masked_timestamp);
 }
 
@@ -926,7 +930,10 @@ static void intel_pt_sample_insn(struct intel_pt_decoder *decoder)
 	case INTEL_PT_PERIOD_TICKS:
 		timestamp = decoder->timestamp + decoder->timestamp_insn_cnt;
 		masked_timestamp = timestamp & decoder->period_mask;
-		decoder->last_masked_timestamp = masked_timestamp;
+		if (masked_timestamp > decoder->last_masked_timestamp)
+			decoder->last_masked_timestamp = masked_timestamp;
+		else
+			decoder->last_masked_timestamp += decoder->period_ticks;
 		break;
 	case INTEL_PT_PERIOD_NONE:
 	case INTEL_PT_PERIOD_MTC:
