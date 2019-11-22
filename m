Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC383C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8905A2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421139;
	bh=aR+7IWwqhRZDLaMIVikkwQEGC9EKDQlI50+mJ7hE0ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eK1KG58y/iTG/tQO2cQBCyqFh8VkEFkosPgb9upnF/ULDp07mbbo+TDyaX+8U+DWA
	 xhNs5CO8S1s2UyGiYpr7yta2Uz5rst31lyTVynrsqGTEiGzZP+5aJzP8OhjtTpxvXL
	 SpyTG+dsTTwac+Rvb4QIm0FB//YoD0Dgpy47beX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfKVK6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbfKVK5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:57:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECB4B20718;
        Fri, 22 Nov 2019 10:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420271;
        bh=aR+7IWwqhRZDLaMIVikkwQEGC9EKDQlI50+mJ7hE0ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7nWQ7raXohxYnWuHz6o28vbGo1MQitT4Q5u7dY/y9LHY5ZPAu4z3335SuYdpASl8
         DCDIsZ0Bxjumyb3bKf1Mo2isXT+ShIlBzXZnhLu0/GucCk+QKBaTIdpe3penu6xsTe
         OObPTpNzAILGT+e9yT7OxyEBCbeUc1BHXzwAvICo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/220] watchdog: core: fix null pointer dereference when releasing cdev
Date:   Fri, 22 Nov 2019 11:26:55 +0100
Message-Id: <20191122100915.802441612@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 953b9dd7725bad55a922a35e75bff7bebf7b9978 ]

watchdog_stop() calls watchdog_update_worker() which needs a valid
wdd->wd_data pointer. So, when unregistering the cdev, clear the
pointers after we call watchdog_stop(), not before.

Fixes: bb292ac1c602 ("watchdog: Introduce watchdog_stop_on_unregister helper")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/watchdog_dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ffbdc4642ea55..f6c24b22b37c0 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1019,16 +1019,16 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 		old_wd_data = NULL;
 	}
 
-	mutex_lock(&wd_data->lock);
-	wd_data->wdd = NULL;
-	wdd->wd_data = NULL;
-	mutex_unlock(&wd_data->lock);
-
 	if (watchdog_active(wdd) &&
 	    test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
 		watchdog_stop(wdd);
 	}
 
+	mutex_lock(&wd_data->lock);
+	wd_data->wdd = NULL;
+	wdd->wd_data = NULL;
+	mutex_unlock(&wd_data->lock);
+
 	hrtimer_cancel(&wd_data->timer);
 	kthread_cancel_work_sync(&wd_data->work);
 
-- 
2.20.1



