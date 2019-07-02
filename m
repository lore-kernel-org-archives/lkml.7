Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64416C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E2A21852
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034481;
	bh=NQMuIr+ArSmEmysWl7qbWwoJE4t6nbJ4otzdPVvVupI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/JJl+QkH9lLlpXBEMDj6TAs0rgWhkq0MIdSiBNHuXyMV6b1amDw7YvO7At79w0j9
	 AJyztWDWg1IvckQIJePdSZGji+dN/31BXA6DSuJzY2IjtaFXGNVNlVYpgUO86BQU3A
	 +gsnh4PW9ck0en5JYwPYJ6wn3OlKDEPm6uP9qsxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfGBC2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfGBC17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1C4206A2;
        Tue,  2 Jul 2019 02:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034478;
        bh=NQMuIr+ArSmEmysWl7qbWwoJE4t6nbJ4otzdPVvVupI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5/uhm8B+MGME6DMx/66QjICti59l2p4pEnnqIRinBvJaXxy03wzWgWHPM1GAPnN+
         cBUGyxNy9EB6j2rUYeUwhJRxIoIkDRERjNYqnjsyO8IVJJcuyN93k5CpoESR0gBr3U
         5QwB3po9wxJIKCwnDgwoiARNIyC+x6M8xbppC2oM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 29/43] perf metricgroup: Use strsep()
Date:   Mon,  1 Jul 2019 23:26:02 -0300
Message-Id: <20190702022616.1259-30-acme@kernel.org>
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

No change in behaviour intended, trivial optimization done by avoiding
looking for spaces in 'g' right after setting it to "No_group".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-f2siadtp3hb5o0l1w7bvd8bk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a0cf3cd95ced..90cd84e2a503 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -308,10 +308,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 				struct mep *me;
 				char *s;
 
+				g = skip_spaces(g);
 				if (*g == 0)
 					g = "No_group";
-				while (isspace(*g))
-					g++;
 				if (filter && !strstr(g, filter))
 					continue;
 				if (raw)
-- 
2.20.1

