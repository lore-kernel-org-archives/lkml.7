Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA1CC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3C9205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLFNX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:23:57 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:60312 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfLFNX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:23:56 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id adPu2100G5USYZQ01dPuM7; Fri, 06 Dec 2019 14:23:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1idDaM-0006C6-7a; Fri, 06 Dec 2019 14:23:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1idDaM-0007Z7-5s; Fri, 06 Dec 2019 14:23:54 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] block: Make request_queue.rpm_status an enum
Date:   Fri,  6 Dec 2019 14:23:50 +0100
Message-Id: <20191206132350.29040-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_queue.rpm_status is assigned values of the rpm_status enum only,
so reflect that in its type.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Perhaps this was done to avoid the need to #include <linux/pm.h>?
Let's see what kbuild has to report about this...
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 397bb9bc230b6349..6419cd9523c370f8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -466,7 +466,7 @@ struct request_queue {
 
 #ifdef CONFIG_PM
 	struct device		*dev;
-	int			rpm_status;
+	enum rpm_status		rpm_status;
 	unsigned int		nr_pending;
 #endif
 
-- 
2.17.1

