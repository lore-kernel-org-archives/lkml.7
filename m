Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B031C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1415B20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381437;
	bh=7yg2VtWHuG2gH/RYK/1TRVJxxCTz67lzNn14bCTw81w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IvVaUeXgBBRVrj4VL9DSFSZgPSQe4qM6n/nbJAUsHglm9uaX1hkaCNaIKuLvgbb//
	 wS/ZKoT3pzD6oiANR0OR4QGGRv/OmoRRKZ33nPi56PEDlCnpeGLiUEsgu5ncFKlfNw
	 9U5qSABz431XOBOzVZe337eVQs1PqN50rJrG1T9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLCN5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfLCN5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:13 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E50C206DF;
        Tue,  3 Dec 2019 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381433;
        bh=7yg2VtWHuG2gH/RYK/1TRVJxxCTz67lzNn14bCTw81w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nopv44DWxYNrgikwe5XLFdqUWxo0RSVzU9kzS6Shm84SNDaFuPDMuHgiYWuNtGehi
         dM4iP1bxA4BuunnsgmgTzWDdC4roVZu5WySIS2Cj6xQYRtqg6swBTG+3uR2z9Ubo9/
         2uXOhhFfNSsSLDEvgKI+4jeYOjGkXKy8NgbMZtzY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 19/23] perf beauty: Add CLEAR_SIGHAND support for clone's flags arg
Date:   Tue,  3 Dec 2019 10:56:02 -0300
Message-Id: <20191203135606.24902-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add support for the recently added CLONE_CLEAR_SIGHAND flag.

This takes advantage of the copy of the uapi/linux/sched.h we have in
tools/include, which allows us to build tools/perf in older systems and
have the binary support printing that flag whenever that system gets its
kernel updated to one where this feature is present.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Adrian Reber <areber@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org
Link: https://lkml.kernel.org/n/tip-1vnz497ubtu5oz16ygdcul0e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/clone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index 1a8d3be2030e..062ca849c8fd 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -45,6 +45,7 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size,
 	P_FLAG(NEWPID);
 	P_FLAG(NEWNET);
 	P_FLAG(IO);
+	P_FLAG(CLEAR_SIGHAND);
 #undef P_FLAG
 
 	if (flags)
-- 
2.21.0

