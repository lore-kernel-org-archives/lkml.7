Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97969C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7418A2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDLGBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:01:50 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:50730 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfDLGBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:01:38 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 4E785C5B7025EE087238;
        Fri, 12 Apr 2019 14:01:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3C61RbO088889;
        Fri, 12 Apr 2019 14:01:27 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041214020665-8432948 ;
          Fri, 12 Apr 2019 14:02:06 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 5/5] pinctrl: zte: fix leaked of_node references
Date:   Fri, 12 Apr 2019 14:02:23 +0800
Message-Id: <1555048943-39589-6-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn>
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-12 14:02:06,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-12 14:01:13,
        Serialize complete at 2019-04-12 14:01:13
X-MAIL: mse01.zte.com.cn x3C61RbO088889
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pinctrl/zte/pinctrl-zx.c:415:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
./drivers/pinctrl/zte/pinctrl-zx.c:422:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
./drivers/pinctrl/zte/pinctrl-zx.c:436:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
./drivers/pinctrl/zte/pinctrl-zx.c:444:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
./drivers/pinctrl/zte/pinctrl-zx.c:448:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pinctrl/zte/pinctrl-zx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/zte/pinctrl-zx.c b/drivers/pinctrl/zte/pinctrl-zx.c
index caa44dd..3cb6930 100644
--- a/drivers/pinctrl/zte/pinctrl-zx.c
+++ b/drivers/pinctrl/zte/pinctrl-zx.c
@@ -411,6 +411,7 @@ int zx_pinctrl_init(struct platform_device *pdev,
 	}
 
 	zpctl->aux_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!zpctl->aux_base)
 		return -ENOMEM;
 
-- 
2.9.5

