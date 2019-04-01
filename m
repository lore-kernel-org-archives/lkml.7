Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A237FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7578220872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbfDABi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 21:38:28 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:42128 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731692AbfDABiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 21:38:25 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7AA7BAFB783FF5A707DC;
        Mon,  1 Apr 2019 09:38:22 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x311cGG2061244;
        Mon, 1 Apr 2019 09:38:16 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019040109382016-7035260 ;
          Mon, 1 Apr 2019 09:38:20 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/7] cpufreq: kirkwood: fix possible object reference leak
Date:   Mon, 1 Apr 2019 09:37:50 +0800
Message-Id: <1554082674-2049-4-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
References: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-01 09:38:20,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-01 09:38:17,
        Serialize complete at 2019-04-01 09:38:17
X-MAIL: mse01.zte.com.cn x311cGG2061244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/cpufreq/kirkwood-cpufreq.c:127:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 118, but without a corresponding object release within this function.
./drivers/cpufreq/kirkwood-cpufreq.c:133:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 118, but without a corresponding object release within this function.

and also do some cleanup:
- of_node_put(np);
- np = NULL;
...
of_node_put(np);

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/cpufreq/kirkwood-cpufreq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index c2dd43f..8d63a6dc 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -124,13 +124,14 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");
 	if (IS_ERR(priv.cpu_clk)) {
 		dev_err(priv.dev, "Unable to get cpuclk\n");
-		return PTR_ERR(priv.cpu_clk);
+		err = PTR_ERR(priv.cpu_clk);
+		goto out_node;
 	}
 
 	err = clk_prepare_enable(priv.cpu_clk);
 	if (err) {
 		dev_err(priv.dev, "Unable to prepare cpuclk\n");
-		return err;
+		goto out_node;
 	}
 
 	kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
@@ -161,20 +162,22 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 		goto out_ddr;
 	}
 
-	of_node_put(np);
-	np = NULL;
-
 	err = cpufreq_register_driver(&kirkwood_cpufreq_driver);
-	if (!err)
-		return 0;
+	if (err) {
+		dev_err(priv.dev, "Failed to register cpufreq driver\n");
+		goto out_powersave;
+	}
 
-	dev_err(priv.dev, "Failed to register cpufreq driver\n");
+	of_node_put(np);
+	return 0;
 
+out_powersave:
 	clk_disable_unprepare(priv.powersave_clk);
 out_ddr:
 	clk_disable_unprepare(priv.ddr_clk);
 out_cpu:
 	clk_disable_unprepare(priv.cpu_clk);
+out_node:
 	of_node_put(np);
 
 	return err;
-- 
2.9.5

