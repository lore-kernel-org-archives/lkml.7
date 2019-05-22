Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACAEC18E7C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F24A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558503184;
	bh=FBkoYyEKyqIy6cvQAvDRZEV1ACPpoXuHv7FMNI9ssGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sQBkztWFM/KK2bpTX3uur2WnDnboh3kGlQ0oKVRBL/ygnZP4Hxzb9sShRPXUqIrIU
	 RA2ziZX9HyLKTPyBdpmpBEtK1NH6Er1NSHOp3bIsXDF8aB4kBV7Z1A7aerWsfSqt4Y
	 lZfX93H9keWm3NdAKCoEevPKRMhOkGLByn3mAtIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfEVFdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:33:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37449 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfEVFdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:33:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23so698013pff.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKQWaV2a4ZZxrQfFQmbTFsniUKsG6cyKKTMNu6+SBA4=;
        b=tzBJRbwjgkHOJkicIP8FSTcfIubh3wRStyPl3B7c8VJUYenjAaRPu7PVW3QeOTUjyO
         Rn5OAyvBmdAVUqeTRD40kFLHoN5UfpOQXcvzIxLoDKzKOMLJg5cvXd7B3G5SqzSBkfXy
         EYM4CVKo34Vt1nSq7gPP1o29UvqkhNJYnxbXk59K0l5WE8CyuEpa1xh66ttDMn96YK2z
         s4pnCiQ84YpY99cqx5Qr4Bz3m0MydJm9JHaApMENgWPtV1JfDx+I0N3Mb+3++uZ1aQWj
         a8BtfS6G+459RqZidRAm5HXYQFzP6dQsglU/n10wh5F1siuM1W/DBKyn9aZL1xI6epRt
         sJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zKQWaV2a4ZZxrQfFQmbTFsniUKsG6cyKKTMNu6+SBA4=;
        b=J07wSKZ6usCfj0EaM4IheFJFvB/aA6FTDeVsKdTVDpy1IYvLbD/lERYWT2x3t+govg
         YbZ16z5nG4efK/+XFBWJnT0ZEj2hh7xxl9ilgCtoWi0SPMoSSHxPfkXHdlBIK3fR4Ky5
         n0elsg1DJylF3zG2p7Qz6t56Vmzb6IW+HaKuEbBCJ/Ij+HnY1bNuWgfB0VexKuy0EZDD
         wuu8z4MOAiNCAX6cmaWgmHPeU+DXnvTaXSf6VMYSDPpKwmynL4AA9qHEHbXSW9meXbXJ
         d7r1Kah0UyezX0jtYwNHxOmybnbtW7E3mbIT5EkgwbXLDVEHwb3zqv+kqOeBCaJZHEpI
         rEgQ==
X-Gm-Message-State: APjAAAW7uQvMADsos8M+SG/C6ooMv1h/YkXIqG1ulNy0aqlJEBb2Fazf
        /eKdysvDE7Nm8hl/qfucLl0=
X-Google-Smtp-Source: APXvYqy+3hZmBWb3rjY+6bD0nEJ2ex2UWrvss8G8mU61PakGd3T7TBTkQimstiHmrDc5TatQCygPMQ==
X-Received: by 2002:a63:cf:: with SMTP id 198mr86349942pga.228.1558503181487;
        Tue, 21 May 2019 22:33:01 -0700 (PDT)
Received: from namhyung.seo.corp.google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id p7sm25027927pgb.92.2019.05.21.22.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 22:33:00 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCH 2/3] perf tools: Add missing swap ops for namespace events
Date:   Wed, 22 May 2019 14:32:49 +0900
Message-Id: <20190522053250.207156-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190522053250.207156-1-namhyung@kernel.org>
References: <20190522053250.207156-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case it's recorded from other arch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2310a1752983..54cf163347f7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -647,6 +647,26 @@ static void perf_event__throttle_swap(union perf_event *event,
 		swap_sample_id_all(event, &event->throttle + 1);
 }
 
+static void perf_event__namespaces_swap(union perf_event *event,
+					bool sample_id_all)
+{
+	u64 i;
+
+	event->namespaces.pid		= bswap_32(event->namespaces.pid);
+	event->namespaces.tid		= bswap_32(event->namespaces.tid);
+	event->namespaces.nr_namespaces	= bswap_64(event->namespaces.nr_namespaces);
+
+	for (i = 0; i < event->namespaces.nr_namespaces; i++) {
+		struct perf_ns_link_info *ns = &event->namespaces.link_info[i];
+
+		ns->dev = bswap_64(ns->dev);
+		ns->ino = bswap_64(ns->ino);
+	}
+
+	if (sample_id_all)
+		swap_sample_id_all(event, &event->namespaces.link_info[i]);
+}
+
 static u8 revbyte(u8 b)
 {
 	int rev = (b >> 4) | ((b & 0xf) << 4);
@@ -887,6 +907,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_LOST_SAMPLES]	  = perf_event__all64_swap,
 	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
+	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
-- 
2.21.0.1020.gf2820cf01a-goog

