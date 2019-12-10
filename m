Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C784DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9074E2465C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576011900;
	bh=6Ap/4dLrJtbhgDZjWBk601+fL/rDqhvc0pmlWurQAGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RBiGEnuNs+R6heJcp3swMLqOda7Iz7kWMLz79Lb6Jc1LXbJukiVBG4+u4qHJDCWXN
	 FJkPAly14BJB8acYQa3LKsR7a0qzg03d+EkKkrrsEXd8PmPySVSU72HVoet9BNW2UM
	 Q0GVF8TQYwJdMA8kwdxL2n7ed+2OHWYlXqpH2t+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfLJVE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfLJVEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:04:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E48D24681;
        Tue, 10 Dec 2019 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576011890;
        bh=6Ap/4dLrJtbhgDZjWBk601+fL/rDqhvc0pmlWurQAGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOyS89ElagNQGSu42plTzFStjAoaqFVNSjnWNgzXnsPrT1ZHR+zvLcAuU6A3Ppywu
         iIgXX+HEtO42QoKbf2UuAlZPKUvetg5pUKOr1jRPdUmtX7S6kMxcmD32OT5Zi7VP/0
         J6GoeS5emywo8MLFNXJAd6KwVoYZEAdSAhA9rPuc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 040/350] media: ov6650: Fix control handler not freed on init error
Date:   Tue, 10 Dec 2019 15:58:52 -0500
Message-Id: <20191210210402.8367-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210402.8367-1-sashal@kernel.org>
References: <20191210210402.8367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

[ Upstream commit c404af950d14b71bfbf574a752b6c29d726baaba ]

Since commit afd9690c72c3 ("[media] ov6650: convert to the control
framework"), if an error occurs during initialization of a control
handler, resources possibly allocated to the handler are not freed
before device initialiaton is aborted.  Fix it.

Fixes: afd9690c72c3 ("[media] ov6650: convert to the control framework")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov6650.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 5b9af5e5b7f13..68776b0710f98 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -989,8 +989,10 @@ static int ov6650_probe(struct i2c_client *client,
 			V4L2_CID_GAMMA, 0, 0xff, 1, 0x12);
 
 	priv->subdev.ctrl_handler = &priv->hdl;
-	if (priv->hdl.error)
-		return priv->hdl.error;
+	if (priv->hdl.error) {
+		ret = priv->hdl.error;
+		goto ectlhdlfree;
+	}
 
 	v4l2_ctrl_auto_cluster(2, &priv->autogain, 0, true);
 	v4l2_ctrl_auto_cluster(3, &priv->autowb, 0, true);
@@ -1008,8 +1010,10 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->subdev.internal_ops = &ov6650_internal_ops;
 
 	ret = v4l2_async_register_subdev(&priv->subdev);
-	if (ret)
-		v4l2_ctrl_handler_free(&priv->hdl);
+	if (!ret)
+		return 0;
+ectlhdlfree:
+	v4l2_ctrl_handler_free(&priv->hdl);
 
 	return ret;
 }
-- 
2.20.1

