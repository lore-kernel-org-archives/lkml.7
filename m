Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1841FC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56BB2184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034440;
	bh=gOVFpnyMtMW7GFJCMLnkF/L5/5b/1oUgeN2sDgIbY44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=alCjfugrfWoJ/AwDy8LJigJNwZnGTYQqcu8bTQB2axB428hWs4t3tumB/PZdohynW
	 ovzk3knfinREfzYh4u/gLWBfcqt55+WrqS9/R4eQjAs3dk9o8t6aXHZCTUV1r1aZZg
	 lODCvZL6K/E+B1sE2+tp0anR/GlmkWuW28an5jTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGBC1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfGBC1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623912184E;
        Tue,  2 Jul 2019 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034433;
        bh=gOVFpnyMtMW7GFJCMLnkF/L5/5b/1oUgeN2sDgIbY44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xnMFvTigwm2IxaUO9YeYrboFgs4xpEfx5XaYv3n4m5t4DcvhePRRCoaNCYr7Rotnn
         tqeZ9hTRAuxshv0S+DirfGcplR+QudR2pDcnQoqB6O9/gzXTRAYtGKeWnhoBqS/ocp
         lccjykDJf+XoVILdv5wVrodmSFvFhDi2wALTLHXY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 16/43] tools x86 machine: Add missing util.h to pick up 'page_size'
Date:   Mon,  1 Jul 2019 23:25:49 -0300
Message-Id: <20190702022616.1259-17-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We're getting it by sheer luck, add that util.h to get the 'page_size'
definition.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-347078mgj3d2jfygtxs4ntti@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index 4520ac53caa9..0e508f26f83a 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -3,6 +3,7 @@
 #include <linux/string.h>
 #include <stdlib.h>
 
+#include "../../util/util.h"
 #include "../../util/machine.h"
 #include "../../util/map.h"
 #include "../../util/symbol.h"
-- 
2.20.1

