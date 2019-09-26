Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF9C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3788721D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458223;
	bh=jiv2t760Y1/f5UY+q5In++3xxOIA015laCLoO1cpq2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RxAgJ8U3cBsIDJi+3wzC0pmLdFVAb8xWQBgngaUpH4KxHpOOOekjkBk+JfX47bsJi
	 zc+fwYvneSEZtb99zT196WLmygtOYNJo9yfFS29u6o8vi21J3W4DQyHVC79nIhm484
	 pHdk8RkL1jBDtm9azPznbL7P6v7aNbcDbwChRPKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391070AbfIZAhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390965AbfIZAg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:57 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A88217F4;
        Thu, 26 Sep 2019 00:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458217;
        bh=jiv2t760Y1/f5UY+q5In++3xxOIA015laCLoO1cpq2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQFkUGJHOKxALBw4c5b5NIIoGhjyYp2EuXUQsX+uboNT93YDeptVa37/7BjL1VxSM
         0vquPbMfhT1R46mM/UJI1rclc6z4IZb0sTetkwENSYeJmBkJBcJfTe3P+tSN2U/Kx2
         18e6JoygaIGNWEU9JuLHtb2yiAqiOTSS5zDylLVk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 66/66] perf parser: Remove needless include directives
Date:   Wed, 25 Sep 2019 21:32:44 -0300
Message-Id: <20190926003244.13962-67-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

They go on accumulating there like the debug.h one, that was introduced
here:

  f23610245c1a ("perf list: Add debug support for outputing alias string")

But then, when that need is removed via:

  2073ad3326b7 ("perf tools: Factor out PMU matching in parser")

The thing stays there, so continue the house cleaning spree...

list.h not needed, no macros from there are used, and 'struct
list_head' is in linux/types.h, ditto for util.h, no need for that as
well.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zkxr3mf6inun8m5mbnil4u0d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 65809ad67808..48126ae4cd13 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -11,12 +11,9 @@
 #include <fnmatch.h>
 #include <stdio.h>
 #include <linux/compiler.h>
-#include <linux/list.h>
 #include <linux/types.h>
-#include "util.h"
 #include "pmu.h"
 #include "evsel.h"
-#include "debug.h"
 #include "parse-events.h"
 #include "parse-events-bison.h"
 
-- 
2.21.0

