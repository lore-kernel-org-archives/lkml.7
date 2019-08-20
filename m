Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83F9C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92498230F2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329326;
	bh=EkJxKz4u+q8ZKgqhSLL9/DOv/Q6wJNl+yFxl6ZK0WbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XMgJ1rX0Fn6LvV1wNAIEf+WWS3yZ1AAvHhC5L8VxQPtZB/k/aJr1Of4aI5U0lcWsl
	 7ENAquWYGTYWGIKRNCpcJHTN9dH1XmNH6os1hd8NMRi4U3GSE2moaeuAEzz2HbMecA
	 JT1Z+6DIqqlSIAfk/zrg+UpYYp/S0BXP204ZNF/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfHTT2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbfHTT2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:43 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA48B22DD3;
        Tue, 20 Aug 2019 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329322;
        bh=EkJxKz4u+q8ZKgqhSLL9/DOv/Q6wJNl+yFxl6ZK0WbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyA4b/28AJ48JOOn6P2R7szQOMSKh1oL8Y17F2vSt/ZG9VNW4/+wCpQVa0cyMq2QD
         oN77ANukrpoVflzoDVwRmUWpP2fBG0x1/kZlNyMy+jcb6ObVpPJMwQlFwwxL+RpHi0
         tr5i3toJn3BZm/TuM6xFGviSpF/By+fqBlAjb/20=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/17] perf ui: Make 'exit_msg' optional in ui__question_window()
Date:   Tue, 20 Aug 2019 16:27:28 -0300
Message-Id: <20190820192733.19180-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We will not need it when refactoring this function to be
non-interactive, so make it optional.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pnx1dn17bsz7lqt9ty95nnjx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/tui/util.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index fe5e571816fc..5d65ea8b6496 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -188,7 +188,9 @@ int ui__question_window(const char *title, const char *text,
 	pthread_mutex_lock(&ui__lock);
 
 	max_len += 2;
-	nr_lines += 4;
+	nr_lines += 2;
+	if (exit_msg)
+		nr_lines += 2;
 	y = SLtt_Screen_Rows / 2 - nr_lines / 2,
 	x = SLtt_Screen_Cols / 2 - max_len / 2;
 
@@ -199,14 +201,20 @@ int ui__question_window(const char *title, const char *text,
 		SLsmg_write_string((char *)title);
 	}
 	SLsmg_gotorc(++y, x);
-	nr_lines -= 2;
+	if (exit_msg)
+		nr_lines -= 2;
 	max_len -= 2;
 	SLsmg_write_wrapped_string((unsigned char *)text, y, x,
 				   nr_lines, max_len, 1);
 	SLsmg_gotorc(y + nr_lines - 2, x);
 	SLsmg_write_nstring((char *)" ", max_len);
 	SLsmg_gotorc(y + nr_lines - 1, x);
-	SLsmg_write_nstring((char *)exit_msg, max_len);
+	if (exit_msg) {
+		SLsmg_gotorc(y + nr_lines - 2, x);
+		SLsmg_write_nstring((char *)" ", max_len);
+		SLsmg_gotorc(y + nr_lines - 1, x);
+		SLsmg_write_nstring((char *)exit_msg, max_len);
+	}
 	SLsmg_refresh();
 
 	pthread_mutex_unlock(&ui__lock);
-- 
2.21.0

