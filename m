Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44030C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F26320650
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353730;
	bh=1WDmaeQnzHdPuKnUb+DOjRMz6dZ0mYdB0EDJCkGbeH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W3x65RPJtFhqZunaBPMooJWcGZln8sLSfxzoolOR5QVW7TARLClm76ukr4u9ikl3u
	 WjnPxcWrlDBjBG4Sfq+Yf+pKAOfb22/+ZWZROP/LGIts56iOM1tOPerhutr6se0OEe
	 D00zEdMh2SaqelkOOaxDdxTlU0Rpj72QWLu/pL/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfKJCmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbfKJCmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:42:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4AD321924;
        Sun, 10 Nov 2019 02:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353720;
        bh=1WDmaeQnzHdPuKnUb+DOjRMz6dZ0mYdB0EDJCkGbeH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LA2MbHg7iUZJ/GS5AgBWqYX8HE2UNImI/XBkSAZmKB2Xoxi1lCIJxm6y6OU6QNdbq
         4DYq8tHaYkHrKVMW3xSySFaL/tqOPfVw94iKVAMI7S4nHPsGXE+/vPbCk+55vY9sWO
         nzwft1Glb0QfuNu6K+eN3Rk64Mw3FBFsCDgSHzSo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 053/191] usb: chipidea: Fix otg event handler
Date:   Sat,  9 Nov 2019 21:37:55 -0500
Message-Id: <20191110024013.29782-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 59739131e0ca06db7560f9073fff2fb83f6bc2a5 ]

At OTG work running time, it's possible that several events need to be
addressed (e.g. ID and VBUS events). The current implementation handles
only one event at a time which leads to ignoring the other one. Fix it.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/otg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index db4ceffcf2a61..f25d4827fd49c 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -203,14 +203,17 @@ static void ci_otg_work(struct work_struct *work)
 	}
 
 	pm_runtime_get_sync(ci->dev);
+
 	if (ci->id_event) {
 		ci->id_event = false;
 		ci_handle_id_switch(ci);
-	} else if (ci->b_sess_valid_event) {
+	}
+
+	if (ci->b_sess_valid_event) {
 		ci->b_sess_valid_event = false;
 		ci_handle_vbus_change(ci);
-	} else
-		dev_err(ci->dev, "unexpected event occurs at %s\n", __func__);
+	}
+
 	pm_runtime_put_sync(ci->dev);
 
 	enable_irq(ci->irq);
-- 
2.20.1

