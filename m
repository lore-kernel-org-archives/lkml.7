Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BB6C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 04:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2C3217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 04:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2gy/qwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfIUENp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 00:13:45 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56355 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfIUENp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 00:13:45 -0400
Received: by mail-pf1-f202.google.com with SMTP id m25so6075819pfa.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kHBqDHMjSO8qTU9fcbWkd49WIUWFo+41tMM5TfeDLnM=;
        b=f2gy/qwjI3Q4nnPYDutHrdK5ttNNQYZ9Z/rrMpAoix6jxyCoiWrwt4NOhQkBTF6dmp
         emLJSq6XFMbhSwju6NtyEixPB2Wx5xfqNp84oV6vJq8jrCHplwsDG/M2vSDWVQJPzR/S
         MdGDLtTcG2CnmQ4CoYYQ1W076ZMK1FLpDPepVZ/9r9ux1L1sUqxgAXc3BQK/PRGXnNP3
         tKUPugk9grx8dkXe6vKCS23zmNvapA3Q3EFa7vnTEf+e2qTS4JRL2D+d/wupUJ4PmThL
         0gtr5F3iV4r3IJZhOMdz5PbATEna8+sPiduibm8CrvmTLOYO3MpNVjMcLnbli9GLcOl6
         SEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kHBqDHMjSO8qTU9fcbWkd49WIUWFo+41tMM5TfeDLnM=;
        b=PKHiDlR5t3p1XClsYedksTL3a3Xzio49dnvJ+ZmbSllIg+GEl130cwIa0w/8n50HEj
         i3l0+YgIHMoCX8jiTx+BmO1gmv+/GpJops+jahQu9HSs/Dh+56FIqR2c7ruBHh0NbOQr
         5LsJUtm89BEhSxEXj7PUPcge3N49BXPJj8vaPmqL+R7dmGyd5jsz7QHeQ76K+TS3NM4r
         kxG/xIawlsXK05dBP6BAKlI5gKb6g2ZQZ0f0dEjXyZxd1o5FPHPZcb4QTTWPrhZD6P/M
         F+grJ06V9/DrH6o0iV1p0qnva4y6tMBUzgNqAdgZFuv6X/Qq3XuWu3E0zP1Ia/43IdxT
         cIgg==
X-Gm-Message-State: APjAAAVpBjsuBmsT9DPMLXQA/CnzaA5IYfoipGy7EcgPePpg/XSDcOUd
        qdyt8Ea9cUuMSfpmkeZhBQG82I28uLo3
X-Google-Smtp-Source: APXvYqzjM7I8IBxCa27oLt5CbjPBYC7K0TQHMGaY8Dr6+AKYAj/zTzqL7245VfUYpwiMRDwWKG9WCsToN0Lx
X-Received: by 2002:a63:1f23:: with SMTP id f35mr17289025pgf.298.1569039224007;
 Fri, 20 Sep 2019 21:13:44 -0700 (PDT)
Date:   Fri, 20 Sep 2019 21:13:27 -0700
Message-Id: <20190921041327.155054-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH] perf docs: Allow man page date to be specified
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this change if a perf_date parameter is provided to asciidoc
then it will override the default date written to the man page metadata.
Without this change, or if the perf_date isn't specified, then the
current date is written to the metadata. Having this parameter allows
the metadata to be constant if builds happen on different dates. The
name of the parameter is intended to be consistent with the existing
perf_version parameter.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/asciidoc.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/asciidoc.conf b/tools/perf/Documentation/asciidoc.conf
index 356b23a40339..2b62ba1e72b7 100644
--- a/tools/perf/Documentation/asciidoc.conf
+++ b/tools/perf/Documentation/asciidoc.conf
@@ -71,6 +71,9 @@ ifdef::backend-docbook[]
 [header]
 template::[header-declarations]
 <refentry>
+ifdef::perf_date[]
+<refentryinfo><date>{perf_date}</date></refentryinfo>
+endif::perf_date[]
 <refmeta>
 <refentrytitle>{mantitle}</refentrytitle>
 <manvolnum>{manvolnum}</manvolnum>
-- 
2.23.0.351.gc4317032e6-goog

