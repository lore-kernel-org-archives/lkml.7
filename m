Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF4EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975222175B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfGAOAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:00:12 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:50852 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfGAOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:00:12 -0400
Received: from ramsan ([84.194.98.4])
        by albert.telenet-ops.be with bizsmtp
        id XS0A2001305gfCL06S0Aef; Mon, 01 Jul 2019 16:00:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hhwqo-0007yC-OK; Mon, 01 Jul 2019 16:00:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hhwqo-0006Ai-Mz; Mon, 01 Jul 2019 16:00:10 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] lib/vsprintf: Reinstate printing of legacy clock IDs
Date:   Mon,  1 Jul 2019 16:00:09 +0200
Message-Id: <20190701140009.23683-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the legacy clock framework, clock pointers are no longer
printed as IDs, as the !CONFIG_COMMON_CLK case was accidentally
considered an error case.

Fix this by reverting to the old behavior, which allows to distinguish
clocks by ID, as the legacy clock framework does not store names with
clocks.

Fixes: 0b74d4d763fd4ee9 ("vsprintf: Consolidate handling of unknown pointer specifiers")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The line reverted was modified later by commit c8c3b584343cb752
("vsprintf: Limit the length of inlined error messages").
Both commits entered upstream in v5.2-rc1, though.
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 63937044c57d5585..bc96b1cdb36727ff 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1799,7 +1799,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 #ifdef CONFIG_COMMON_CLK
 		return string(buf, end, __clk_get_name(clk), spec);
 #else
-		return error_string(buf, end, "(%pC?)", spec);
+		return ptr_to_id(buf, end, clk, spec);
 #endif
 	}
 }
-- 
2.17.1

