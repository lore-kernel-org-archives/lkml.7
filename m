Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD17C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AF620CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380701;
	bh=wJlV9uxbuGvpLMn0SR+wrb+pr59x6GztUh8UsrE8Zks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E8zHza8uKI4cwY3h6PKdYqUO+qmz+M7YGqGmxn8ZtL+ugYjNJRzeiarGtEJkqfF2g
	 scuAy/VVIs/372HltoWGr65A5Xykj1E3jt2D0yTnsfxLyDhlQ2p25hycbZ1af0Wl7K
	 DfjFSPPvI3LM+FhEUTjrrRsV8gq2tTRYShLGkRfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389652AbfIMNST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390178AbfIMNSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:18:15 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCDC206A5;
        Fri, 13 Sep 2019 13:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380694;
        bh=wJlV9uxbuGvpLMn0SR+wrb+pr59x6GztUh8UsrE8Zks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IHUmp8cwsr7gESG8TfrJriXnMsTQxf6rYw2Dl5IaoWnOleqYT8NHftM5QLZxgtf5r
         sFFWDMCFeSyw10TGv4ZFVHVNXoB7hNZjoOP6bhN+S9Ph4/KXPYLOmE6Al+qapsU8Fk
         Y9rX0VGv4w3BXp/yF3259PVgtv1QSlpCorPQKnW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 147/190] staging: wilc1000: fix error path cleanup in wilc_wlan_initialize()
Date:   Fri, 13 Sep 2019 14:06:42 +0100
Message-Id: <20190913130611.717936449@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6419f818ababebc1116fb2d0e220bd4fe835d0e3 ]

For the error path in wilc_wlan_initialize(), the resources are not
cleanup in the correct order. Reverted the previous changes and use the
correct order to free during error condition.

Fixes: b46d68825c2d ("staging: wilc1000: remove COMPLEMENT_BOOT")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wilc1000/linux_wlan.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
index 649caae2b6033..25798119426b3 100644
--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -649,17 +649,17 @@ static int wilc_wlan_initialize(struct net_device *dev, struct wilc_vif *vif)
 			goto fail_locks;
 		}
 
-		if (wl->gpio_irq && init_irq(dev)) {
-			ret = -EIO;
-			goto fail_locks;
-		}
-
 		ret = wlan_initialize_threads(dev);
 		if (ret < 0) {
 			ret = -EIO;
 			goto fail_wilc_wlan;
 		}
 
+		if (wl->gpio_irq && init_irq(dev)) {
+			ret = -EIO;
+			goto fail_threads;
+		}
+
 		if (!wl->dev_irq_num &&
 		    wl->hif_func->enable_interrupt &&
 		    wl->hif_func->enable_interrupt(wl)) {
@@ -715,7 +715,7 @@ fail_irq_enable:
 fail_irq_init:
 		if (wl->dev_irq_num)
 			deinit_irq(dev);
-
+fail_threads:
 		wlan_deinitialize_threads(dev);
 fail_wilc_wlan:
 		wilc_wlan_cleanup(dev);
-- 
2.20.1



