Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB170206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641745;
	bh=YE6fA8U4hpcf3Who/RGRmXS2l2nWWlDo7ap4HH8yOzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDs/twEi1lHBE8VLZ0by+fkRnyAERfOr+rf4m1kuxn9c2VQVZmSnIVEfWMqj0J+HL
	 ebaak6P+YXPNJGOPzpdWhJwZw5tpEkkuH4xxCpPY4CiwLNiQaKmyhdUI9Lz/+niS/Z
	 nyCAXvUnl8Gnx4ED2swqp/4VwV5sE/scdXns8dbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfL2RtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731261AbfL2Rsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:48:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D1D207FF;
        Sun, 29 Dec 2019 17:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641734;
        bh=YE6fA8U4hpcf3Who/RGRmXS2l2nWWlDo7ap4HH8yOzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hduXkThxZdhgXMqS53jFbeKQtno58EJRZ3ffS20Nk9ceQVCyjQ+8l8cDGxodaPK8J
         bkhXOmg7vtXcdv0g6HMRRHjgAiQMrirCAA7ZgTZdOKWMzzYFh+onu9oXdPQ5kgTkR/
         iQUgR5uPwfY8KMMfHryxNW+a44g0j7CekAo/t5DU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 148/434] perf vendor events arm64: Fix Hisi hip08 DDRC PMU eventname
Date:   Sun, 29 Dec 2019 18:23:21 +0100
Message-Id: <20191229172711.582498387@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 0d1556fcdffe..99f4fc425564 100644
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



