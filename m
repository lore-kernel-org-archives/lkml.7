Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0E2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31981204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963275;
	bh=mcmamO7Oh+IA5VVXze+//Ym8Kz+7TgLgMJ+OLyC967U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Eu0miLK3O7+P6fZQ0cgy8L63Bzw/oYNr66CgVLh8CbKG1e0bofzvtRTAvk6dtD8y
	 PrbMhh7NAK2mbqGfarJoalz5iXDTRj2lQlqiZ4f+ZI2DqTyd/YuWV/ZtZ+L5VIudKN
	 Ou0mevxEQIRNVCWvUUwN1wIFAz8up4ZDv99IV+kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfDVUBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfDVTrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3166C21906;
        Mon, 22 Apr 2019 19:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962420;
        bh=mcmamO7Oh+IA5VVXze+//Ym8Kz+7TgLgMJ+OLyC967U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFrcl+VThllPklk4LLg9lWdl5L65Ugu5aBeXtZWAQvd53htJTEdx9yinoI6gpwULS
         s+72UL4cnreRyuf89VAZGjDW+pjZww6BvtIyqfrjOKV/2BMzAF4fj1O/JoTx+L1AKr
         D2N91lm6YnzhUCYtwC6gviS7hK5ZRI/wiWvJYx1I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 53/68] leds: trigger: netdev: fix refcnt leak on interface rename
Date:   Mon, 22 Apr 2019 15:45:01 -0400
Message-Id: <20190422194516.11634-53-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 4cb6560514fa19d556954b88128f3846fee66a03 ]

Renaming a netdev-trigger-tracked interface was resulting in an
unbalanced dev_hold().

Example:
> iw phy phy0 interface add foo type __ap
> echo netdev > trigger
> echo foo > device_name
> ip link set foo name bar
> iw dev bar del
[  237.355366] unregister_netdevice: waiting for bar to become free. Usage count = 1
[  247.435362] unregister_netdevice: waiting for bar to become free. Usage count = 1
[  257.545366] unregister_netdevice: waiting for bar to become free. Usage count = 1

Above problem was caused by trigger checking a dev->name which obviously
changes after renaming an interface. It meant missing all further events
including the NETDEV_UNREGISTER which is required for calling dev_put().

This change fixes that by:
1) Comparing device struct *address* for notification-filtering purposes
2) Dropping unneeded NETDEV_CHANGENAME code (no behavior change)

Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/leds/trigger/ledtrig-netdev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 3dd3ed46d473..167a94c02d05 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -301,11 +301,11 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		container_of(nb, struct led_netdev_data, notifier);
 
 	if (evt != NETDEV_UP && evt != NETDEV_DOWN && evt != NETDEV_CHANGE
-	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER
-	    && evt != NETDEV_CHANGENAME)
+	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER)
 		return NOTIFY_DONE;
 
-	if (strcmp(dev->name, trigger_data->device_name))
+	if (!(dev == trigger_data->net_dev ||
+	      (evt == NETDEV_REGISTER && !strcmp(dev->name, trigger_data->device_name))))
 		return NOTIFY_DONE;
 
 	cancel_delayed_work_sync(&trigger_data->work);
@@ -320,12 +320,9 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		dev_hold(dev);
 		trigger_data->net_dev = dev;
 		break;
-	case NETDEV_CHANGENAME:
 	case NETDEV_UNREGISTER:
-		if (trigger_data->net_dev) {
-			dev_put(trigger_data->net_dev);
-			trigger_data->net_dev = NULL;
-		}
+		dev_put(trigger_data->net_dev);
+		trigger_data->net_dev = NULL;
 		break;
 	case NETDEV_UP:
 	case NETDEV_CHANGE:
-- 
2.19.1

