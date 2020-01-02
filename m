Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450C9C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5D82253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003212;
	bh=q/za1TwvjQaCfArDL6dZoW6XLm60Lz49aUmjfvLWx14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eyjbRU/orE1QqIEh3gTEN1MmJZF3SMTbmHb9U2j5q8VRG3C4n8x1CChk+6LZyyTA8
	 Nr9HH1RPFKjcbyzpHYk6RBQGQl3bmHxoI94wvg5CxAiFtyh4IYuA+e8tJfh4mTDDU8
	 zg75g3xa51qNZ8nBml0CugT/1wMBA0CmtyW3JWcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgABWN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:13:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgABWNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:13:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3B122314;
        Thu,  2 Jan 2020 22:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003198;
        bh=q/za1TwvjQaCfArDL6dZoW6XLm60Lz49aUmjfvLWx14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wj+UJLgEh1VmZ+fYDkcwIu3lF+ZUIHULQgqOmw4WJCjP5LZEeDtMj/C0aTNPDGtsP
         BLtJdsYncjqBNhOJE8M0f/wISfU9Y0sOlLQ9BbyYUCTe1F+hldZ+K6euahxEPlVBBQ
         PUx6NR5NVS7pPPXI6gchKYunxY9kW30wU7ZziH5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 035/191] leds: trigger: netdev: fix handling on interface rename
Date:   Thu,  2 Jan 2020 23:05:17 +0100
Message-Id: <20200102215833.738367972@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit 5f820ed52371b4f5d8c43c93f03408d0dbc01e5b ]

The NETDEV_CHANGENAME code is not "unneeded" like it is stated in commit
4cb6560514fa ("leds: trigger: netdev: fix refcnt leak on interface
rename").

The event was accidentally misinterpreted equivalent to
NETDEV_UNREGISTER, but should be equivalent to NETDEV_REGISTER.

This was the case in the original code from the openwrt project.

Otherwise, you are unable to set netdev led triggers for (non-existent)
netdevices, which has to be renamed. This is the case, for example, for
ppp interfaces in openwrt.

Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
Fixes: 4cb6560514fa ("leds: trigger: netdev: fix refcnt leak on interface rename")
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/trigger/ledtrig-netdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 136f86a1627d..d5e774d83021 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -302,10 +302,12 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		container_of(nb, struct led_netdev_data, notifier);
 
 	if (evt != NETDEV_UP && evt != NETDEV_DOWN && evt != NETDEV_CHANGE
-	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER)
+	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER
+	    && evt != NETDEV_CHANGENAME)
 		return NOTIFY_DONE;
 
 	if (!(dev == trigger_data->net_dev ||
+	      (evt == NETDEV_CHANGENAME && !strcmp(dev->name, trigger_data->device_name)) ||
 	      (evt == NETDEV_REGISTER && !strcmp(dev->name, trigger_data->device_name))))
 		return NOTIFY_DONE;
 
@@ -315,6 +317,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 
 	clear_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
 	switch (evt) {
+	case NETDEV_CHANGENAME:
 	case NETDEV_REGISTER:
 		if (trigger_data->net_dev)
 			dev_put(trigger_data->net_dev);
-- 
2.20.1



