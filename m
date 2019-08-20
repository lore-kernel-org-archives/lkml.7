Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE19C22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329342;
	bh=BNM201EwE+W3GCuwJIDAW80iWdyUHoTYonWoW9RFml0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0hWSO2YBH8rd9DGC4qe8zr2QwcK5jptEdY/s+bBuuT612puIbSBVmuLnutmUYigv4
	 7xNXZF32BCc/JA5ffyy2Fbg2xAVc1ZOLB0TFjXbutPSzCOovS2LM+AZ8Ga9eGn0XG6
	 T0J5GfI26SIYYs8ndiFxhR2mX5dGbPfcVaak4I98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbfHTT3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730979AbfHTT26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:58 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3302339D;
        Tue, 20 Aug 2019 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329337;
        bh=BNM201EwE+W3GCuwJIDAW80iWdyUHoTYonWoW9RFml0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbF+xeAZJh9tuwpQe6r6NGuSsoRLM6NgKcOERr85obBdZ8AaFbHuEqG6/VvP9Z8aO
         zai8tY0dMCC0KfW2prhPuQxGKQa0+HJU10sPlRmD9QrzU8a3MFLkgCaYyAE+Hd+uVz
         TnldASKst5RkILM68JIbUkCm1p9ereOeLHf0xk+s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/17] libperf: Fix arch include paths
Date:   Tue, 20 Aug 2019 16:27:33 -0300
Message-Id: <20190820192733.19180-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Guenter Roeck reported problem with compilation when the ARCH is
specified:

  $ make ARCH=x86_64
  In file included from tools/include/asm/atomic.h:6:0,
                   from include/linux/atomic.h:5,
                   from tools/include/linux/refcount.h:41,
                   from cpumap.c:4: tools/include/asm/../../arch/x86/include/asm/atomic.h:11:10:
  fatal error: asm/cmpxchg.h: No such file or directory

The problem is that we don't use SRCARCH (the sanitized ARCH version)
and we don't get the proper include path.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 314350491810 ("libperf: Make libperf.a part of the perf build")
Link: http://lkml.kernel.org/r/20190820124624.GG24105@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 8a9ae50818e4..a67efb8d9d39 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -59,7 +59,7 @@ else
   CFLAGS := -g -Wall
 endif
 
-INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/ -I$(srctree)/tools/arch/$(ARCH)/include/uapi -I$(srctree)/tools/include/uapi
+INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/ -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
-- 
2.21.0

