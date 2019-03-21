Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FE7218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfCUMmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:42:49 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfCUMms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:42:48 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MdNoW-1gXcDB18xU-00ZOR0; Thu, 21 Mar 2019 13:42:41 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: export tracepoint symbols to modules
Date:   Thu, 21 Mar 2019 13:42:25 +0100
Message-Id: <20190321124240.901884-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pd3t12x6dNGCoSiDpwb2zoqrttMlgcEFDesLvGE0x5eBuDxvKo5
 pa3tdrqN9r0LRzNe6P+oy5fdAbLOuw+zhnwsd2lOwYuqw9KfmnUvnZXbZpbky/158XZXTk+
 ZxZ5NWIIwm0gKN0iSlGz4WvkOZ7L8fDo/ztpDivccI++V81X96t/wFfw9dEuRZDxWsAn1N+
 3E7dm4/2x1Jx/SikkpnlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9b7YripScv0=:TEO795keyctp8mgUBkIt74
 h9wtxbJeyJV8X2SaurOfPFt+zYaQQUa4kihoyEmgXdOE/82y+mjSAueXjU7oChzpZZDUz3iRs
 ryj9a8EFhWDn44MKP1RgFJkX935jSHm0lx66ldQ4QFgTVc4EiZwekcdGcgbSMsd8xQXmjIBLg
 LvrBZm1DOuSLy5uSoqnsuyIaRIdQvhQl2ntnmyUnBoZ5cWDUKEAHTges1+gD/kTU2Dd898VoV
 ZKYhVbsqMga7m6ySrDwpkKeULssVC0y6oYtLritAvqdPn3XnVMQL+SLkYpp6o+7xhSdbHJyov
 GmGLVWuukkKOJOEFafIA7wmMbKDRFATon4IyYxGjX4JG6A8Zx1UsGk6X+CMPHH8MctPjbQ0zJ
 Ryc9tMYlaXXXTk4CpS0Vo9Pi/rGHD90NLqjVr/k3nj1eP3hO5hDhFh3xp7qgfW4dnc3mT3F2C
 QWcQPYHWIF/xyoEqGsQzRpu0x6hLA2RWWGQys8DG1bK52JipIcXsnETjgHaVNks2bkwGSiapA
 3aoi19L/9anG3r4efCAdm9a5Wt4wxykndoTTZNwrs/3g072G8aUmHXksvqLYw0V0di5TTYPwS
 /4VlkokLbfaGvtNqbFLUwoud0rNnI5rwGLs2SL1TLR4OkLnRq90r9/R0rJE9V9SF4DdlP5+Ma
 afON4XZbBnLblDagSXg+pdKiNx98dnkMQzRagFvVMtjVM4f8qDypuq83K3yP2QhljZKzhBSD4
 /dOnnwqz0PrY7qYG1jv8Knv25zl6CD4ifluz/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added tracepoints in the spi-mxs driver cause a link
error when the driver is a loadable module:

ERROR: "__tracepoint_spi_transfer_stop" [drivers/spi/spi-mxs.ko] undefined!
ERROR: "__tracepoint_spi_transfer_start" [drivers/spi/spi-mxs.ko] undefined!

I'm not quite sure where to put the export statements, but
directly after the inclusion of the header seems as good as
any other place.

Fixes: f3fdea3af405 ("spi: mxs: add tracing to custom .transfer_one_message callback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 93986f879b09..e5d38152888a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -36,6 +36,8 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
+EXPORT_TRACEPOINT_SYMBOL(spi_transfer_start);
+EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 
 #include "internals.h"
 
-- 
2.20.0

