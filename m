Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1885ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A1B2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfJVNMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:12:33 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56112 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731754AbfJVNMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:12:32 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iMtxb-0002pr-ON; Tue, 22 Oct 2019 14:12:27 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iMtxa-0002zo-Uj; Tue, 22 Oct 2019 14:12:26 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] timers/sched_clock: include local timekeeping.h for missing declarations
Date:   Tue, 22 Oct 2019 14:12:26 +0100
Message-Id: <20191022131226.11465-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the timekeeping.h header to get the declaration of the
sched_clock_{suspend,resume} functions. Fixes the following
sparse warnings:

kernel/time/sched_clock.c:275:5: warning: symbol 'sched_clock_suspend' was not declared. Should it be static?
kernel/time/sched_clock.c:286:6: warning: symbol 'sched_clock_resume' was not declared. Should it be static?

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/sched_clock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 142b07619918..dbd69052eaa6 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -17,6 +17,8 @@
 #include <linux/seqlock.h>
 #include <linux/bitops.h>
 
+#include "timekeeping.h"
+
 /**
  * struct clock_read_data - data required to read from sched_clock()
  *
-- 
2.23.0

