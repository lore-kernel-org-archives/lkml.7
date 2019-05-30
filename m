Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75770C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA532453F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185974;
	bh=xD8BCILq0qaxWL0pZybmxB4YVqjMc1p4hd14D/e0VZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aae2yqm8sfz7fODXTJn2z4CCTcD9UpWhdX3s0+ZoljWzSpKm6xkSGKZ/W/YLVZvnU
	 /UpnHQitvMEmNCm8UqrmGgUsNKaLg7fv/vapeIgLgqoIa3nezGpit4iSeV7+hE9ecK
	 qDFtIwtotoqKwox/bAey4uEn5j2dFZ6jfBRIoERY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfE3DMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbfE3DLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:20 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20ED6244FA;
        Thu, 30 May 2019 03:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185880;
        bh=xD8BCILq0qaxWL0pZybmxB4YVqjMc1p4hd14D/e0VZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzQjMJWCNZn8J8ShGCujh2tP2P79RrjOsrDe+HCt+EsAlSnHqDGR7LXPCyuFVDvem
         xUg0lXBKAt7EDglS0mnBVq4mvkQTZ+hTGuuL+MV02FHpeRUUY2mrLArGiNEZAwUEaV
         v2n2QEYdUaslN0rtYQvUJWT6QkoqYElIi7UlJJqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 229/405] cpufreq: imx6q: fix possible object reference leak
Date:   Wed, 29 May 2019 20:03:47 -0700
Message-Id: <20190530030552.617460274@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ddb64c5db3cc8fb9c1242214d5798b2c2865681c ]

The call to of_node_get returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/cpufreq/imx6q-cpufreq.c:391:4-10: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 348, but without a corresponding object release within this function.
./drivers/cpufreq/imx6q-cpufreq.c:395:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 348, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index a4ff09f91c8f8..3e17560b1efe3 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -388,11 +388,11 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		ret = imx6ul_opp_check_speed_grading(cpu_dev);
 		if (ret) {
 			if (ret == -EPROBE_DEFER)
-				return ret;
+				goto put_node;
 
 			dev_err(cpu_dev, "failed to read ocotp: %d\n",
 				ret);
-			return ret;
+			goto put_node;
 		}
 	} else {
 		imx6q_opp_check_speed_grading(cpu_dev);
-- 
2.20.1



