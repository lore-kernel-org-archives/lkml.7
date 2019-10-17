Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39976ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A77821835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328198;
	bh=41SsR7ctC10siYzLN3hU24uxcmhytYDBlvTZiW/Wcl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AL0Zgeo88nRbOf5YYqfmQHCMej73tYNu7xAhQbtCu4/JBUCphKSN+VQoweuax+hug
	 bPsKaPec5HSNXmoUqyIf22noFzwWAufVSomI5oVb4MzvweDJ5Hmn5MIt+hxzUty/UQ
	 +fOGdIzYYdQ+lDR6HSp3qiwLDNW49ymXIkOgcg/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439840AbfJQQDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfJQQDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C64D021D7C;
        Thu, 17 Oct 2019 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328194;
        bh=41SsR7ctC10siYzLN3hU24uxcmhytYDBlvTZiW/Wcl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbAzK0lLn5NOGOh3pOfC7RsqKdZyd8g+Kyr0wX0dwtBYJ5jL0MurAihhCAz0xfmkh
         p9uxuXDqmpYJycwmbW1SVtsHyIUvqYvIQ9HvhDVCaBpxK0T2kW1fSwR81Mzlt0ZNJx
         xDfuW1jeO3vPhv88+if2eIVJJTGFw7gDpNbBKZJc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/11] perf evlist: Fix fix for freed id arrays
Date:   Thu, 17 Oct 2019 13:02:52 -0300
Message-Id: <20191017160301.20888-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In the earlier fix for the memory overrun of id arrays I managed to typo
the wrong event in the fix.

Of course we need to close the current event in the loop, not the
original failing event.

The same test case as in the original patch still passes.

Fixes: 7834fa948beb ("perf evlist: Fix access of freed id arrays")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191011182140.8353-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d277a98e62df..de79c735e441 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1659,7 +1659,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 			is_open = false;
 		if (c2->leader == leader) {
 			if (is_open)
-				perf_evsel__close(&evsel->core);
+				perf_evsel__close(&c2->core);
 			c2->leader = c2;
 			c2->core.nr_members = 0;
 		}
-- 
2.21.0

