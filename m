Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADBEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E71F2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507786;
	bh=4+U28/ZoIpsrqQWSHdlu9+OL4ZkQwq9VvMqokWb70SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JFxAkv6uqSaUpOSPVRnp4NNcBqWyImbObbPsKfKiuhzIivhoLJBhYu1p7xJTMuJbJ
	 qmjhrKmzZRmwaT5jVZL6elns6aiZjh8KFWlFlZvboma+AkSsRA0zqScBpC6igIqJ5a
	 VVvm0EEu6/G6x6zkt3wOddQJaXvoJVxbo349uF5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404707AbfHVVBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404669AbfHVVBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:33 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E00023401;
        Thu, 22 Aug 2019 21:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507693;
        bh=4+U28/ZoIpsrqQWSHdlu9+OL4ZkQwq9VvMqokWb70SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRA8dxUayC/Y0ZrJoIyRaGTZnf8PnMAQSbyvmOXaWh+4UjJBURW86hX6Xc/xI9GHi
         VuzIVAxatrUv1wexwvlkZcwooDT7hnATpsoy6JSDPnI9pwCzz0jjeFCFf5hesTEhjK
         ONEsFmz/E85DjGHqszDYhwXExJpTEjY2imp6wKWc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 05/25] perf arm64: Add missing debug.h header
Date:   Thu, 22 Aug 2019 18:00:40 -0300
Message-Id: <20190822210100.3461-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This file uses pr_debug() but isn't including debug.h, getting it by
luck, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-t7pisnsdfh88kclpw52jcwl7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/header.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 602caf550e7f..e41defaaa2e6 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,6 +1,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <api/fs/fs.h>
+#include "debug.h"
 #include "header.h"
 
 #define MIDR "/regs/identification/midr_el1"
-- 
2.21.0

