Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D48C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7122084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfDLGBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:01:41 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:30332 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfDLGBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:01:37 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 9879E1CF80F00DE50E5E;
        Fri, 12 Apr 2019 14:01:35 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3C61QxU088863;
        Fri, 12 Apr 2019 14:01:26 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041214020559-8432938 ;
          Fri, 12 Apr 2019 14:02:05 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Patrice Chotard <patrice.chotard@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 3/5] pinctrl: st: fix leaked of_node references
Date:   Fri, 12 Apr 2019 14:02:21 +0800
Message-Id: <1555048943-39589-4-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn>
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-12 14:02:05,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-12 14:01:12,
        Serialize complete at 2019-04-12 14:01:12
X-MAIL: mse01.zte.com.cn x3C61QxU088863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pinctrl/pinctrl-st.c:1188:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1175, but without a corresponding object release within this function.
./drivers/pinctrl/pinctrl-st.c:1188:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1175, but without a corresponding object release within this function.
./drivers/pinctrl/pinctrl-st.c:1199:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1175, but without a corresponding object release within this function.
./drivers/pinctrl/pinctrl-st.c:1199:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1175, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
---
 drivers/pinctrl/pinctrl-st.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index e66af93..195b442 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1170,7 +1170,7 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 	struct property *pp;
 	struct st_pinconf *conf;
 	struct device_node *pins;
-	int i = 0, npins = 0, nr_props;
+	int i = 0, npins = 0, nr_props, ret = 0;
 
 	pins = of_get_child_by_name(np, "st,pins");
 	if (!pins)
@@ -1185,7 +1185,8 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 			npins++;
 		} else {
 			pr_warn("Invalid st,pins in %pOFn node\n", np);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out_put_node;
 		}
 	}
 
@@ -1195,8 +1196,10 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 	grp->pin_conf = devm_kcalloc(info->dev,
 					npins, sizeof(*conf), GFP_KERNEL);
 
-	if (!grp->pins || !grp->pin_conf)
-		return -ENOMEM;
+	if (!grp->pins || !grp->pin_conf) {
+		ret = -ENOMEM;
+		goto out_put_node;
+	}
 
 	/* <bank offset mux direction rt_type rt_delay rt_clk> */
 	for_each_property_of_node(pins, pp) {
@@ -1229,9 +1232,11 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 		}
 		i++;
 	}
+
+out_put_node:
 	of_node_put(pins);
 
-	return 0;
+	return ret;
 }
 
 static int st_pctl_parse_functions(struct device_node *np,
-- 
2.9.5

