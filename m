Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7170218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254709;
	bh=Vm2m0EqLUU3PLerBkGMLQOhkLqAQuoVL7CC/zyGj8Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q2Ft2B0zNGQeoeBQt0IrBN8RHruGlY+P0DRQ/jdv4xtnB6WmQCAoF4stejDP5NFkg
	 NvJIDFPjDyIolo+4AobD0uWtHwcEMAQY96QL9xqF7YkqMrMJzEuK0PoxktzN4D19qS
	 CWvEc5zBNuVndXT8JrEQxcAII3mLgwB1tt55wDeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfCVLi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730223AbfCVLi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:38:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1C22082C;
        Fri, 22 Mar 2019 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254705;
        bh=Vm2m0EqLUU3PLerBkGMLQOhkLqAQuoVL7CC/zyGj8Yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKaiQN8p0FSx/QUZWePf7qzOsQX+kXZMGMEfjY3GjU4MV5EaTuhWmaLM0xGhql8VB
         soNiUbB2I5sWbc4wz9RufveASgvkqosGw2YyNo1QhnsiaPDQZmPujqn4ezpxbXkHjY
         yzTqdHv6W2RDYPrhvV44/6YsqODAB7CgXGTpdksQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.4 217/230] perf auxtrace: Define auxtrace record alignment
Date:   Fri, 22 Mar 2019 12:15:55 +0100
Message-Id: <20190322111252.112022945@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1226,9 +1226,9 @@ static int __auxtrace_mmap__read(struct
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
@@ -37,6 +37,9 @@ struct record_opts;
 struct auxtrace_info_event;
 struct events_stats;
 
+/* Auxtrace records must have the same alignment as perf event records */
+#define PERF_AUXTRACE_RECORD_ALIGNMENT 8
+
 enum auxtrace_type {
 	PERF_AUXTRACE_UNKNOWN,
 	PERF_AUXTRACE_INTEL_PT,


