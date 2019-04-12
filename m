Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F10C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3AD2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDLGBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:01:36 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:30212 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfDLGBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:01:34 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id EB3D5B81A3EB8C133913;
        Fri, 12 Apr 2019 14:01:31 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3C61Prp088823;
        Fri, 12 Apr 2019 14:01:25 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041214020465-8432934 ;
          Fri, 12 Apr 2019 14:02:04 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 1/5] pinctrl: pistachio: fix leaked of_node references
Date:   Fri, 12 Apr 2019 14:02:19 +0800
Message-Id: <1555048943-39589-2-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn>
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-12 14:02:04,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-12 14:01:11,
        Serialize complete at 2019-04-12 14:01:11
X-MAIL: mse01.zte.com.cn x3C61Prp088823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pinctrl/pinctrl-pistachio.c:1422:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1360, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pinctrl/pinctrl-pistachio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index aa5f949..5b0678f 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1367,6 +1367,7 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 		if (!of_find_property(child, "gpio-controller", NULL)) {
 			dev_err(pctl->dev,
 				"No gpio-controller property for bank %u\n", i);
+			of_node_put(child);
 			ret = -ENODEV;
 			goto err;
 		}
@@ -1374,6 +1375,7 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 		irq = irq_of_parse_and_map(child, 0);
 		if (irq < 0) {
 			dev_err(pctl->dev, "No IRQ for bank %u: %d\n", i, irq);
+			of_node_put(child);
 			ret = irq;
 			goto err;
 		}
-- 
2.9.5

