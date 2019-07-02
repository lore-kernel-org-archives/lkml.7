Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985FCC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA3D2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmeaKVWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfGBKfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:35:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39449 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:35:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id m202so12622923oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zTwTfXNgxTmrGRUjBKcfiXIJvV7RcQHKF6DIe75zo+I=;
        b=qmeaKVWdYJMzo5niBo8eJXFwzM8pytrY9m8n2B5/m28fbL9VJT6KWdOOE86JBx8ntL
         +vff4tW/HcSWI7kaAKHhD3u+0ivKHodubYbUbLUSilYabfc3gbGl+4nWUvaSCp+zj0ay
         QqIfGyD6iwhac5mxyv5FSMGGKbIK/XJMfsOKX7YTs0KXvUGx3Xqz2PBqs9avL+DCOH1T
         u2Rw3lY5ZSgrrfRnnMQ3rc/w8GuoaGJeh8U3W4jhpwrnZBbWCuFQ9EE2Jjd6sudTm7VX
         aH3e9GH6StNynB4j47dNPlpAEuRgXbbHp7/vr3dv9cCdgf8TtuiNQ3k71NfaNui1NR6/
         8FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zTwTfXNgxTmrGRUjBKcfiXIJvV7RcQHKF6DIe75zo+I=;
        b=iRKow5t+3ToaxGjePoa0Davl2rlJmGPDnm4q7veSmBVbm9OxqpeL2sE/Fi7be7o7h+
         QJeX2hVFV4TIb2S6lxZBEu24fuZIDsq+JJkClrvRfoVUHJ5MVf2qth7O5BO0gk5c7R+6
         a3170zOLeexo5aXodVpgJHT0h4FxU7QfQlOkbhQbC6yhskSDr8fw9uvylKCQ9RqulcKs
         x4i7tBVmJPgXhk2r+5LJpfMLS+hsX9m8agIL3zaKoy6HY3J18c0ze7l03CmpX1gx86oY
         MefbB/jpBKbU7NwNISQCEbcIS7FF9/+j0W3jDBt2XXR+2l1ooEPcfiDKBKKeRaerNJEB
         glSA==
X-Gm-Message-State: APjAAAWrpyTKOpDK7hGpfTM8pLpS+pGvBMXWjhG+ZtOATGvAKmIbShWm
        A7UVxdHru+9Y2TYihU3ben/fjA==
X-Google-Smtp-Source: APXvYqzadH2JYmTLt475KdiZ+RY+YlPJ1tAhSwr9KnjUX2mXMzimmxW9XG9aSGOZZ3INH1wy364PFg==
X-Received: by 2002:aca:5241:: with SMTP id g62mr2474775oib.41.1562063749790;
        Tue, 02 Jul 2019 03:35:49 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:35:49 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 08/11] perf session: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:34:17 +0800
Message-Id: <20190702103420.27540-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/util/session.c:1252
  dump_read() error: we previously assumed 'evsel' could be null
  (see line 1249)

tools/perf/util/session.c
1240 static void dump_read(struct perf_evsel *evsel, union perf_event *event)
1241 {
1242         struct read_event *read_event = &event->read;
1243         u64 read_format;
1244
1245         if (!dump_trace)
1246                 return;
1247
1248         printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
1249                evsel ? perf_evsel__name(evsel) : "FAIL",
1250                event->read.value);
1251
1252         read_format = evsel->attr.read_format;
                           ^^^^^^^

'evsel' could be NULL pointer, for this case this patch directly bails
out without dumping read_event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/session.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 54cf163347f7..2e61dd6a3574 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1249,6 +1249,9 @@ static void dump_read(struct perf_evsel *evsel, union perf_event *event)
 	       evsel ? perf_evsel__name(evsel) : "FAIL",
 	       event->read.value);
 
+	if (!evsel)
+		return;
+
 	read_format = evsel->attr.read_format;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-- 
2.17.1

