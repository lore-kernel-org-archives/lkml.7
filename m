Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17D1C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6752067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611986;
	bh=aR+7IWwqhRZDLaMIVikkwQEGC9EKDQlI50+mJ7hE0ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DFvoPYvff4lpN47U3BSBgclQM8vGDkH8f2v3snpzj6OaZhrjM1y1FI3X/pI3IUEx1
	 1RBQyRonoRTWLiiBSmCROPrfRtIT+rAkRuClzdPNME00IDKx0OddwI8zZWVLSrpFPE
	 yv8o4VW7SuMLwyMfIVx3HX7cVkHlWq8wbh3u/Hk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfKMC0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfKMBvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C048322459;
        Wed, 13 Nov 2019 01:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609875;
        bh=aR+7IWwqhRZDLaMIVikkwQEGC9EKDQlI50+mJ7hE0ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMxKPJstolRhWnDb2BhXxagKYrFQblG9CsKxqlOaqwOZt+5hyda3r1NQcxgrcyfkw
         L0xO62tdcnXe20T5qlwOkN9dKA/Bp7uu8c0rzWkeCM+3t5+chBsRWP5jx3MtP18Mjf
         qCrPbnUkmCjwjtrN1a8UZOCa/YaZBAhPsmUYA0pw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 038/209] watchdog: core: fix null pointer dereference when releasing cdev
Date:   Tue, 12 Nov 2019 20:47:34 -0500
Message-Id: <20191113015025.9685-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

