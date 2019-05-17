Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3CC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F8221744
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122058;
	bh=vNCEyfGL2swp6F3Ex3pVppTepG/WJmcHLtARAOk72PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E7UEsDWUaZhPV+bPEnf0XiAUrhI/OIADW1kk/C25Lt3q+SLDfG7I02Gj1yXHXE9cQ
	 Js9oE9zwLgrAD4B9gicnTOQBJRNJ9/GlKHAuVh1Sukn33+InkDKNMeCfTdQndxd+QL
	 Piq95EkqTLWSloP7bJ5EZMdsdtOMtQmBf6X7hNZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfEQTk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfEQTkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:55 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FCDD2087B;
        Fri, 17 May 2019 19:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122055;
        bh=vNCEyfGL2swp6F3Ex3pVppTepG/WJmcHLtARAOk72PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUFJmv/YeaLh7rDMSUcf23BEmqpDT8LXj+0dW8dgUAveI/UfIDu/D/IxqGkXwztTn
         z9TlCmKpM3G2Svopeax1b19HNgVCjY4YHrsNA0CQV0s5/lRYVHj1lWHOnfg0FBkYyb
         7zUSNi5osyjhSIpQnMlS7Dxn1AlfITTQFyy9Gtj0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean V Kelley <seanvk.dev@oregontracks.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 62/73] perf vendor events arm64: Map Brahma-B53 CPUID to cortex-a53 events
Date:   Fri, 17 May 2019 16:36:00 -0300
Message-Id: <20190517193611.4974-63-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

Broadcom's Brahma-B53 CPUs support the same type of events that the
Cortex-A53 supports, recognize its CPUID and map it to the cortex-a53
events.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean V Kelley <seanvk.dev@oregontracks.org>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org (moderated list
Link: http://lkml.kernel.org/r/20190513202522.9050-3-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index da5ff2204bf6..013155f1eb58 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,6 +13,7 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000410fd030,v1,arm/cortex-a53,core
+0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
-- 
2.20.1

