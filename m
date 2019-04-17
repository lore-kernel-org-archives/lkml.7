Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C70EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2053E2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfDQCmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:42:31 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:54986 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfDQCm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:42:29 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B6835BA9BFF2DA252E23;
        Wed, 17 Apr 2019 10:42:27 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3H2gKi3060602;
        Wed, 17 Apr 2019 10:42:20 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041710424087-8909752 ;
          Wed, 17 Apr 2019 10:42:40 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] power: supply: fix leaked of_node refs in ab8500_bm_of_probe
Date:   Wed, 17 Apr 2019 10:43:02 +0800
Message-Id: <1555468983-34952-2-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
References: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-17 10:42:40,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-17 10:42:13,
        Serialize complete at 2019-04-17 10:42:13
X-MAIL: mse01.zte.com.cn x3H2gKi3060602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

492 int ab8500_bm_of_probe(struct device *dev,
493                        struct device_node *np,
494                        struct abx500_bm_data *bm)
495 {
496         const struct batres_vs_temp *tmp_batres_tbl;
497         struct device_node *battery_node;
    ...
501         /* get phandle to 'battery-info' node */
502         battery_node = of_parse_phandle(np, "battery", 0);
    ...
509         if (!btech) {
510                 dev_warn(dev, "missing property battery-name/type\n");
511                 return -EINVAL;    ---> leaked here
512         }
    ...
540         of_node_put(battery_node);   ---> released here
541
542         return 0;
543 }

Detected by coccinelle with the following warnings:
./drivers/power/supply/ab8500_bmdata.c:511:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 502, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/power/supply/ab8500_bmdata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 7b2b699..f6a6697 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -508,6 +508,7 @@ int ab8500_bm_of_probe(struct device *dev,
 	btech = of_get_property(battery_node, "stericsson,battery-type", NULL);
 	if (!btech) {
 		dev_warn(dev, "missing property battery-name/type\n");
+		of_node_put(battery_node);
 		return -EINVAL;
 	}
 
-- 
2.9.5

