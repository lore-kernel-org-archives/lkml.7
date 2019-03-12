Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64471C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C70214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356308;
	bh=iG3LEmt/Qr+FqshnjO9TU+V6auBasMilB8z8HzboAig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ffftvNk1RH0eEyJjck8XU7zbnZoAtglaDVNzqvrDJavMIwn7g6uQSQQAedvhIUJnd
	 SdGYXpgbT/LBnlo8hMSziatlUU3I0IerNMvOc4aSclIe934UAIPveB8S4/fkoJl75M
	 +ByLzuWhXlolRVYjxltfHoXwi5luCz8+bdoom3zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfCLCFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfCLCC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:02:28 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86B4214AE;
        Tue, 12 Mar 2019 02:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356147;
        bh=iG3LEmt/Qr+FqshnjO9TU+V6auBasMilB8z8HzboAig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwmomOGZsVGr9n7TIbAkUqY+Nsb+v5sLzRfWgI9T0M8Kvo8SfUkTdIpmlFdk4+Rua
         kxZegsSyceDyIeh67G6sxfHFMZa42+i/6Rsf+RjP3LDxE0HrB/bWhLLnrlmm8EVB+6
         EWGs9gsTWTYP0q6tC1EiYdejytgAR06EIFO1Z2Eo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/30] perf time-utils: Add utility function to print time stamps in nanoseconds
Date:   Mon, 11 Mar 2019 23:01:38 -0300
Message-Id: <20190312020204.22092-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a utility function to print nanosecond timestamps.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190305144758.12397-11-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 8 ++++++++
 tools/perf/util/time-utils.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 0f53baec660e..20663a460df3 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -453,6 +453,14 @@ int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 	return scnprintf(buf, sz, "%"PRIu64".%06"PRIu64, sec, usec);
 }
 
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz)
+{
+	u64 sec  = timestamp / NSEC_PER_SEC,
+	    nsec = timestamp % NSEC_PER_SEC;
+
+	return scnprintf(buf, sz, "%" PRIu64 ".%09" PRIu64, sec, nsec);
+}
+
 int fetch_current_timestamp(char *buf, size_t sz)
 {
 	struct timeval tv;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index b923de44e36f..72a42ea1d513 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -30,6 +30,7 @@ int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
 				int *range_size, int *range_num);
 
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);
 
-- 
2.20.1

