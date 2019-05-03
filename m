Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BB0C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64062087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iPq7sMO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfECF7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:59:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECF7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:59:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435x7do2618924
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:59:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435x7do2618924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556863147;
        bh=rAGeVewppmnWfX2UxBNvQWcL/n8RNUi8zIWw96y10HY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=iPq7sMO4So9yo7kP/iR3mjHKqUfNWrmTc7WqZ/mSaaeR09A1SeuGHPuJjgohdDj0H
         CU8QtCawMPyRCCX2RAL/2a/fPP1I1lyLQ8FCb6zHN2/Uk9+pb+2CgyIzisDe+AUxNF
         GP4wERIc6pFikyLwepaBRNx3ADberJCslZ8AjShZ4rChMSSJ8T94I+EuZczwNx1ztI
         jJ7DIZlF99TDZMFO2WEHVO21UrM/+4BLLK/sf3VJJJFqG1t2zjnbeqok3AcU3z9Alz
         WMjxUs5vh3P0fATDUCYEtZ/zUZraPd2VvW78/HmUGOkf/hDXyUj/0qgTrwm27Eh/lB
         kDGDVlyfhChyg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435x6Gq2618921;
        Thu, 2 May 2019 22:59:06 -0700
Date:   Thu, 2 May 2019 22:59:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xjpf80o64i2ko74aj2jih0qg@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, acme@redhat.com, arnaldo.melo@gmail.com,
        mingo@kernel.org, Vineet.Gupta1@synopsys.com, dalias@libc.org,
        tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, namhyung@kernel.org, tglx@linutronix.de,
          dalias@libc.org, Vineet.Gupta1@synopsys.com, mingo@kernel.org,
          acme@redhat.com, arnaldo.melo@gmail.com, arnd@arndb.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Remove needless asm/unistd.h include
 fixing build in some places
Git-Commit-ID: 7e221b811f1472d0c58c7d4e0fe84fcacd22580a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7e221b811f1472d0c58c7d4e0fe84fcacd22580a
Gitweb:     https://git.kernel.org/tip/7e221b811f1472d0c58c7d4e0fe84fcacd22580a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 2 May 2019 09:26:23 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:20 -0400

perf tools: Remove needless asm/unistd.h include fixing build in some places

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
