Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E312C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA162082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391797AbfIFGZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:25:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45698 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfIFGZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:25:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i67gk-0000Uv-OY; Fri, 06 Sep 2019 08:25:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 565151C0744;
        Fri,  6 Sep 2019 08:25:42 +0200 (CEST)
Date:   Fri, 06 Sep 2019 06:25:42 -0000
From:   "tip-bot2 for Mark-PK Tsai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/hw_breakpoint: Fix arch_hw_breakpoint
 use-before-initialization
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156775114220.13152.7362529034900093824.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     310aa0a25b338b3100c94880c9a69bec8ce8c3ae
Gitweb:        https://git.kernel.org/tip/310aa0a25b338b3100c94880c9a69bec8ce8c3ae
Author:        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
AuthorDate:    Fri, 06 Sep 2019 14:01:16 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Sep 2019 08:24:01 +02:00

perf/hw_breakpoint: Fix arch_hw_breakpoint use-before-initialization

If we disable the compiler's auto-initialization feature, if
-fplugin-arg-structleak_plugin-byref or -ftrivial-auto-var-init=pattern
are disabled, arch_hw_breakpoint may be used before initialization after:

  9a4903dde2c86 ("perf/hw_breakpoint: Split attribute parse and commit")

On our ARM platform, the struct step_ctrl in arch_hw_breakpoint, which
used to be zero-initialized by kzalloc(), may be used in
arch_install_hw_breakpoint() without initialization.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alix Wu <alix.wu@mediatek.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: YJ Chiang <yj.chiang@mediatek.com>
Link: https://lkml.kernel.org/r/20190906060115.9460-1-mark-pk.tsai@mediatek.com
[ Minor edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/hw_breakpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index c5cd852..3cc8416 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -413,7 +413,7 @@ static int hw_breakpoint_parse(struct perf_event *bp,
 
 int register_perf_hw_breakpoint(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint hw;
+	struct arch_hw_breakpoint hw = { };
 	int err;
 
 	err = reserve_bp_slot(bp);
@@ -461,7 +461,7 @@ int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 			        bool check)
 {
-	struct arch_hw_breakpoint hw;
+	struct arch_hw_breakpoint hw = { };
 	int err;
 
 	err = hw_breakpoint_parse(bp, attr, &hw);
