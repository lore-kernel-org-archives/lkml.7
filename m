Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E6CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EAB204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905732;
	bh=9+ICddfZi98XsuN/HkDELNh3ybAfa/RqmjvYrgcKWMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q9FDjWC9L/9aCsIBDwHdpbHaixiQyXkUFL5aqfAGYqOZWi0Yv8BImTQXZTcspDGqe
	 Q8PhWy8lBF5qJlOrFBgb8NZDes8RHwxQDFTiYyM6Bb9TKRAlSfe5oTnw9G9qGFhRKh
	 hL3dUu/THCRMR+eP/KgegSvaRL14Ihnigk8Yerj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390091AbfKDWP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389904AbfKDWGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:06:04 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A10B21744;
        Mon,  4 Nov 2019 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905164;
        bh=9+ICddfZi98XsuN/HkDELNh3ybAfa/RqmjvYrgcKWMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sc3G1hzwm/Y7xM5SQRXicCoSrI0H8yv2AnOR4+CYJmno18ociCEZzvkpN3zAuwd8t
         EcaCqd31zt2+bR4rE1JZt2LVQcMbRrVjt8K35eC34ig8Ayyn362XIi0TrJIf3UH8pt
         Z+w2AO6MAgoQeFj/LvQXSujjEoNkHOQpD8KYYcyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 012/163] perf jevents: Fix period for Intel fixed counters
Date:   Mon,  4 Nov 2019 22:43:22 +0100
Message-Id: <20191104212141.364499073@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

[ Upstream commit 6bdfd9f118bd59cf0f85d3bf4b72b586adea17c1 ]

The Intel fixed counters use a special table to override the JSON
information.

During this override the period information from the JSON file got
dropped, which results in inst_retired.any and similar running with
frequency mode instead of a period.

Just specify the expected period in the table.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20190927233546.11533-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/jevents.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index d413761621b09..fa85e33762f72 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -449,12 +449,12 @@ static struct fixed {
 	const char *name;
 	const char *event;
 } fixed[] = {
-	{ "inst_retired.any", "event=0xc0" },
-	{ "inst_retired.any_p", "event=0xc0" },
-	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
-	{ "cpu_clk_unhalted.thread", "event=0x3c" },
-	{ "cpu_clk_unhalted.core", "event=0x3c" },
-	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
+	{ "inst_retired.any", "event=0xc0,period=2000003" },
+	{ "inst_retired.any_p", "event=0xc0,period=2000003" },
+	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03,period=2000003" },
+	{ "cpu_clk_unhalted.thread", "event=0x3c,period=2000003" },
+	{ "cpu_clk_unhalted.core", "event=0x3c,period=2000003" },
+	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1,period=2000003" },
 	{ NULL, NULL},
 };
 
-- 
2.20.1



