Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7757EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EA1216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122053;
	bh=jd1uOWizmBGBo8UAwCv7qJhI9/JxVYYAABnwJ744+Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qgWeoGPeHLuS6Eq44aZ3H9djc0gb2ztvYnnuiLknoLHOyB1CDXJY+AQQpEFbjQ698
	 xrqaeXmdp5Gb+KqhvlYBJMQYL43uxs845fE64xYfHRhdFSvcxZhucY7AgXuEThGld1
	 INJQ63ycR7NHKJ8/qDFtxWWd0qdVyMM6Q5fh5d9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfEQTkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfEQTku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:50 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4552166E;
        Fri, 17 May 2019 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122049;
        bh=jd1uOWizmBGBo8UAwCv7qJhI9/JxVYYAABnwJ744+Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XulHtfMHEwZh4DMLFIlpdXW2o6tA9f5t36cjnm0xfNmQj47B/y1oeuj7URtQ9RtCE
         wb0DTRx7lCELgMyJJ8otN3+NJQDhO+N14mGamba37O1XPlE3HoFYXYvV0iN5/6NRxI
         aHYK1YugYd4YioQo/c9RO0HqkNuxU1pVieo8wmv8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean V Kelley <seanvk.dev@oregontracks.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 61/73] perf vendor events arm64: Remove [[:xdigit:]] wildcard
Date:   Fri, 17 May 2019 16:35:59 -0300
Message-Id: <20190517193611.4974-62-acme@kernel.org>
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

ARM64's implementation of get_cpuidr_str() masks out the revision bits
[3:0] while reading the CPU identifier, there is no need for the
[[:xdigit:]] wildcard.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean V Kelley <seanvk.dev@oregontracks.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org (moderated list:arm pmu profiling and debugging)
Link: http://lkml.kernel.org/r/20190513202522.9050-2-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 59cd8604b0bd..da5ff2204bf6 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,7 +12,7 @@
 #
 #
 #Family-model,Version,Filename,EventType
-0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
+0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
-- 
2.20.1

