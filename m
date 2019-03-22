Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADC4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612DA2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256590;
	bh=Wt1SEsdwlozRxtZITkZD9EsY0nXsiu6Adkq1+OZLxHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IDf+SnQG2KJM+sZeakM6CSYQmFu3LSfjgJEZRzAo6TRMjKoUZEbz8YoLtS35pxLe5
	 XDJbs1AtEckIkT4ZC6On6Ghp7ddwbnGq9i8IEyOXaYCbn8XY68CF7Lnhj2kS2ntsah
	 gCBHFJ7hqoDhb5Ho4cLLzpQtNotY9kUJYI66CSA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbfCVMJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389351AbfCVMJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:09:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38A42082C;
        Fri, 22 Mar 2019 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256582;
        bh=Wt1SEsdwlozRxtZITkZD9EsY0nXsiu6Adkq1+OZLxHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPX9LGn2enSPPnnmw0I9OcqoLmy73UYTIP/c9UkixVSxyiM/Noq9AeTv95ElA1t1c
         FbdHmXhqeUGL46+BT/JQ8GyOKFNAY0aGs0GnCO0CrrSc0iaJsQuCwo+Lm2qrfgrNOb
         QlJNYPEcU61YC2oSeza2N2LPXV3ovWnQ1hHRNEiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 255/280] perf auxtrace: Define auxtrace record alignment
Date:   Fri, 22 Mar 2019 12:16:48 +0100
Message-Id: <20190322111342.879868387@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit c3fcadf0bb765faf45d6d562246e1d08885466df upstream.

Define auxtrace record alignment so that it can be referenced elsewhere.

Note this is preparation for patch "perf intel-pt: Fix overlap calculation
for padding"

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190206103947.15750-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/auxtrace.c |    4 ++--
 tools/perf/util/auxtrace.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1273,9 +1273,9 @@ static int __auxtrace_mmap__read(struct
 	}
 
 	/* padding must be written by fn() e.g. record__process_auxtrace() */
-	padding = size & 7;
+	padding = size & (PERF_AUXTRACE_RECORD_ALIGNMENT - 1);
 	if (padding)
-		padding = 8 - padding;
+		padding = PERF_AUXTRACE_RECORD_ALIGNMENT - padding;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.auxtrace.header.type = PERF_RECORD_AUXTRACE;
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -38,6 +38,9 @@ struct record_opts;
 struct auxtrace_info_event;
 struct events_stats;
 
+/* Auxtrace records must have the same alignment as perf event records */
+#define PERF_AUXTRACE_RECORD_ALIGNMENT 8
+
 enum auxtrace_type {
 	PERF_AUXTRACE_UNKNOWN,
 	PERF_AUXTRACE_INTEL_PT,


