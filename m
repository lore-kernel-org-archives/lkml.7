Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9945C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988692089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556843185;
	bh=bU8YVmihreBibL9qsDyREcdAcLDskJg4afZ3Ca/kTi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NM95vVnOdqd7nwKOLN5bys8jum2Re56cRxb8NmrjdmKlS34mqq+3UgUg0T3qUIDON
	 hIva6bXX6yEA0XYTXX7YQ1IQeTpmyX8GNELYghoOs9MdqW3qAl0eMiqjyyUmET4FDt
	 XcCQtIw6Vo6AxhqpOLIRg8hFLJzZjo+TWe8XJNfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfECA0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfECA0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:26:16 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C3C217D9;
        Fri,  3 May 2019 00:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843175;
        bh=bU8YVmihreBibL9qsDyREcdAcLDskJg4afZ3Ca/kTi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9NLL5UkYzritbtMRV7qT8vsMMRxK9L2VQY7NGui4o5m1eJsbuassFC0JC5c7733T
         pnWfKtyn++koO6EDjzh4ueDz0+mkZX3JoqEEZyjrOhFAZJXp4PUJDqRj6QpNMFuyI3
         NSKFcsigcJsFxETUa3XrVjxhLEsyEKXGWWtRfN5c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 11/11] perf tools: Remove needless asm/unistd.h include fixing build in some places
Date:   Thu,  2 May 2019 20:25:33 -0400
Message-Id: <20190503002533.29359-12-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were including sys/syscall.h and asm/unistd.h, since sys/syscall.h
includes asm/unistd.h, sometimes this leads to the redefinition of
defines, breaking the build.

Noticed on ARC with uCLibc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Link: https://lkml.kernel.org/n/tip-xjpf80o64i2ko74aj2jih0qg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cloexec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index ca0fff6272be..06f48312c5ed 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,7 +7,6 @@
 #include "asm/bug.h"
 #include "debug.h"
 #include <unistd.h>
-#include <asm/unistd.h>
 #include <sys/syscall.h>
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
-- 
2.20.1

