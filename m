Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB5C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776A62183E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279949;
	bh=BSKqJkm2KUIjk7/NLhS5jqbmeOxjuShwPme09F+I9gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BmzsLQ13Me2I0n3+Q6Kh9bChaZGhSWAwOvdvYoYumH4U36Rpgx2+L11W3Jtb8Oc5e
	 QNpGDfSt3NRBY9+ng5z20LWwpiqqykbEPOHsJ45OhRPYpUcYnvYsvVlP/nKNU7CHOR
	 t33v0HSj/EbdB2PwThLbIA8o+bYhrqSbJdrYKaUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406656AbfFKTFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392542AbfFKTDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260B3217D6;
        Tue, 11 Jun 2019 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279811;
        bh=BSKqJkm2KUIjk7/NLhS5jqbmeOxjuShwPme09F+I9gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRw+i10wovA/LZkq7pkAG1vZZDLjKtv+FgHPDdOmvWqYxrg1gwp6KcKimtPTHdZ2W
         zeUEYEt3NIstIzkOX4UdKanT0abxtOaDtC9gPdRECSHgldk9c6EmB+Z+oxPPLH8TSv
         QnI8h8buFtjelnK9di7hylq1foaLICyHmk2PbxKI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 57/85] perf header: Rename "sibling cores" to "sibling sockets"
Date:   Tue, 11 Jun 2019 15:58:43 -0300
Message-Id: <20190611185911.11645-58-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The "sibling cores" actually shows the sibling CPUs of a socket.  The
name "sibling cores" is very misleading.

Rename "sibling cores" to "sibling sockets"

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1559688644-106558-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 tools/perf/util/header.c                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 0165e92e717e..de78183f6881 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -168,7 +168,7 @@ struct {
 };
 
 Example:
-	sibling cores   : 0-8
+	sibling sockets : 0-8
 	sibling dies	: 0-3
 	sibling dies	: 4-7
 	sibling threads : 0-1
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 64976254431c..06ddb6618ef3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1460,7 +1460,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 	str = ph->env.sibling_cores;
 
 	for (i = 0; i < nr; i++) {
-		fprintf(fp, "# sibling cores   : %s\n", str);
+		fprintf(fp, "# sibling sockets : %s\n", str);
 		str += strlen(str) + 1;
 	}
 
-- 
2.20.1

