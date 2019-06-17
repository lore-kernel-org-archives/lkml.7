Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2E2208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Aww1fixw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfFQTVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:21:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39809 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:21:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJLYYl3560818
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:21:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJLYYl3560818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799295;
        bh=6r7GGYpStpoYFiWY25W3SsWlF6hczYYv0rEe5z3gELw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Aww1fixw8+qiqfLjy3jeAe7a1yJQxrunJnFsxH7OF3Xe918k03oIqdVkEVhkboVuL
         4DuqGImC4zmn+L0WwVGGq3TmXXYFW2bldwPvFwvojGgZ5TJs52jCyp1t2uy9gX5b+3
         SfvZ31kxqYzEMbnbYw3TM1Jkv9HqZ1/nfg0iJlphKBHTiNM6W8sCyXnguvUgShNaCz
         M7VCGYEEb80r3J3lOYTl747CUq05Ut7Q7bxqiEOiObVp2W6RqZ08DW4i8iBSVidyTW
         Hn1oH0gNjKMMWPb+g/Hemf73A0ozcwxt5neWMv0i69q8Tg94ewctuM1acY6c2Z8sdX
         i0cREmYNN5PvA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJLY1X3560815;
        Mon, 17 Jun 2019 12:21:34 -0700
Date:   Mon, 17 Jun 2019 12:21:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-e5993c42e8bb8dd90eb81a05fb58d5aa243325dd@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, acme@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        hpa@zytor.com
Reply-To: peterz@infradead.org, jolsa@redhat.com, hpa@zytor.com,
          leo.yan@linaro.org, mathieu.poirier@linaro.org,
          suzuki.poulose@arm.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          namhyung@kernel.org
In-Reply-To: <20190524173508.29044-4-mathieu.poirier@linaro.org>
References: <20190524173508.29044-4-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Configure SWITCH_EVENTS in CPU-wide
 mode
Git-Commit-ID: e5993c42e8bb8dd90eb81a05fb58d5aa243325dd
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

Commit-ID:  e5993c42e8bb8dd90eb81a05fb58d5aa243325dd
Gitweb:     https://git.kernel.org/tip/e5993c42e8bb8dd90eb81a05fb58d5aa243325dd
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:34:54 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:01 -0300

perf cs-etm: Configure SWITCH_EVENTS in CPU-wide mode

Ask the perf core to generate an event when processes are swapped in/out
of context.  That way proper action can be taken by the decoding code
when faced with such event.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-4-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index be1e4f20affa..cc7f1cd23b14 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -257,6 +257,9 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	ptr->evlist = evlist;
 	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
 
+	if (perf_can_record_switch_events())
+		opts->record_switch_events = true;
+
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->attr.type == cs_etm_pmu->type) {
 			if (cs_etm_evsel) {
