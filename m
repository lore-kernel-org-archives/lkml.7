Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C957C41514
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A9723711
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340638;
	bh=9px1FZ1rIhRpneIFx13p7Djord1P36UB7dag+r6K7+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZsuI9nq7gu4O+Gu2CqAxoncuu5xYqMJUtAyDoQak2SPCAZILmpJFInuSAALSPl3yS
	 Nn7zAP15mmwWAKil3Ac3yLTK+/VEvntUdNCSFdPkzO73DIWKtZNwVEDuLPUFvC5lHU
	 k0J1j0LEn5y6rHqlZ2sNwpZ/amsLtlpxYa4WD1zU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfIAMXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfIAMXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:23:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB19823431;
        Sun,  1 Sep 2019 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340628;
        bh=9px1FZ1rIhRpneIFx13p7Djord1P36UB7dag+r6K7+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVUGF30uh4NBC3wKp4fh7n1R4kJWh42WLK0G8dOZvcUNQBXEP2RubB9GIHOq09H/l
         kv7+VzpVP+9P4ydekM8ppd6fCzYPOEzYgs4ZLsabXa1reBd9HIM/q/nsF5/zIIrLM2
         EBTWX9bD/oehPv8Pi6B36zkNXGG0z1puRFx1n/7o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/47] perf stat: Replace MAX_NR_CPUS with cpu__max_cpu()
Date:   Sun,  1 Sep 2019 09:22:43 -0300
Message-Id: <20190901122326.5793-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Meyer <meyerk@hpe.com>

The function cpu__max_cpu() returns the possible number of CPUs as
defined in the sysfs and can be used as an alternative for MAX_NR_CPUS
in zero_per_pkg() and check_per_pkg().

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-4-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 66f8808e57d3..f6eb6af5f151 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -210,7 +210,7 @@ void perf_evlist__reset_stats(struct evlist *evlist)
 static void zero_per_pkg(struct evsel *counter)
 {
 	if (counter->per_pkg_mask)
-		memset(counter->per_pkg_mask, 0, MAX_NR_CPUS);
+		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
 }
 
 static int check_per_pkg(struct evsel *counter,
@@ -229,7 +229,7 @@ static int check_per_pkg(struct evsel *counter,
 		return 0;
 
 	if (!mask) {
-		mask = zalloc(MAX_NR_CPUS);
+		mask = zalloc(cpu__max_cpu());
 		if (!mask)
 			return -ENOMEM;
 
-- 
2.21.0

