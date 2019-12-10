Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF0CC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8514E24687
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012157;
	bh=2mu7+3HFmFKeJlS5lR+uw4E75ZYbVPQWmMppHv/oUdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w2+r/NRHp0kmcNF7/zTZwEy5rpFJ+y1sNIeGuaQybxg2uN4cfVDhHvHDfFrCuXlen
	 EziZ2nm0EJT6qnaSPabBR0iMSJz4Q8LOKJPj2gZGw7FrJiryKI6frtn3Ki2i4pvbaK
	 GYAyJsinPRnlps+mpH3Ij4dIX4ZWGc4HenQLSVPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfLJVJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbfLJVJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBB81246AA;
        Tue, 10 Dec 2019 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012149;
        bh=2mu7+3HFmFKeJlS5lR+uw4E75ZYbVPQWmMppHv/oUdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KS7VR9ki1z4O5RFrDFNgHHMg21UD0z28KjE0HBsYzsNCZqn0DFHudgkcCvxNJubCe
         iQa1ymPi2guKJcuMgWFVUc7jwT+dDw4jRL/NfbGa7HBDGh+QOUUzHRbgXb5hyfui57
         p65U76gAOTMkY/215hlK9P00xMFLk0xTooYJtT/U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 112/350] perf vendor events arm64: Fix Hisi hip08 DDRC PMU eventname
Date:   Tue, 10 Dec 2019 16:03:37 -0500
Message-Id: <20191210210735.9077-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit 84b0975f4853ba32d2d9b3c19ffa2b947f023fb3 ]

The "EventName" for the DDRC precharge command event is incorrect, so
fix it.

Fixes: 57cc732479ba ("perf jevents: Add support for Hisi hip08 DDRC PMU aliasing")
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1567612484-195727-2-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
index 0d1556fcdffe7..99f4fc4255647 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
@@ -15,7 +15,7 @@
    },
    {
 	    "EventCode": "0x04",
-	    "EventName": "uncore_hisi_ddrc.flux_wr",
+	    "EventName": "uncore_hisi_ddrc.pre_cmd",
 	    "BriefDescription": "DDRC precharge commands",
 	    "PublicDescription": "DDRC precharge commands",
 	    "Unit": "hisi_sccl,ddrc",
-- 
2.20.1

