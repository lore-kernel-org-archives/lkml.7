Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F7920872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfDABi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 21:38:27 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:32862 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfDABiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 21:38:24 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 630916E9A88795D6508E;
        Mon,  1 Apr 2019 09:38:23 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x311cI35061268;
        Mon, 1 Apr 2019 09:38:18 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019040109382171-7035266 ;
          Mon, 1 Apr 2019 09:38:21 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/7] cpufreq: maple: fix possible object reference leak
Date:   Mon, 1 Apr 2019 09:37:51 +0800
Message-Id: <1554082674-2049-5-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
References: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-01 09:38:21,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-01 09:38:18,
        Serialize complete at 2019-04-01 09:38:18
X-MAIL: mse01.zte.com.cn x311cI35061268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_cpu_device_node_get returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/cpufreq/maple-cpufreq.c:213:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 177, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Viresh Kumar <viresh.kumar@linaro.org>
linux-pm@vger.kernel.org
linux-kernel@vger.kernel.org
---
 drivers/cpufreq/maple-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index d9df893..a05f134 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -210,7 +210,7 @@ static int __init maple_cpufreq_init(void)
 	 */
 	valp = of_get_property(cpunode, "clock-frequency", NULL);
 	if (!valp)
-		return -ENODEV;
+		goto bail_noprops;
 	max_freq = (*valp)/1000;
 	maple_cpu_freqs[0].frequency = max_freq;
 	maple_cpu_freqs[1].frequency = max_freq/2;
-- 
2.9.5

