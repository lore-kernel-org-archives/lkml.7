Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3879AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FCB20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfE0M1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:27:55 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:54596 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfE0M1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:27:54 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id HQTs2000W3XaVaC06QTtMm; Mon, 27 May 2019 14:27:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEjI-0001UW-TC; Mon, 27 May 2019 14:27:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEjI-0001gT-RC; Mon, 27 May 2019 14:27:52 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / clk: Remove error message on out-of-memory condition
Date:   Mon, 27 May 2019 14:27:51 +0200
Message-Id: <20190527122751.6430-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print an error message if kstrdup() fails, as the
memory allocation core already takes care of that.

Note that commit 59d84ca8c46a93ad ("PM / OPP / clk: Remove unnecessary
OOM message") already removed similar error messages, but this one was
forgotten.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/clock_ops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59d19dd649289287..1cf86fcaeff8faac 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -92,8 +92,6 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
 	if (con_id) {
 		ce->con_id = kstrdup(con_id, GFP_KERNEL);
 		if (!ce->con_id) {
-			dev_err(dev,
-				"Not enough memory for clock connection ID.\n");
 			kfree(ce);
 			return -ENOMEM;
 		}
-- 
2.17.1

