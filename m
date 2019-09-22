Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EE4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BB9214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178022;
	bh=rpLu/oS3jQttqG3AiJBi6ubdqtvP3hbrdcN6X/C/dR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TOfETHzi92LSRybRVqEkgsMRG93fRo0Rq9e/1girSo17zNX+b3GNWs5Sj441joLNr
	 GSKb3fDJ6AiS7QzPT4K2+zSmrS+UFomNMp1+/jD6erMYyOxdK/Hbe7UK7xN41XwBiZ
	 2ZCIgLYIEUgh7B0rLr3AKe+7xXKlwwoiiUfkUTs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390488AbfIVSrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390380AbfIVSqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:46:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF96208C2;
        Sun, 22 Sep 2019 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178014;
        bh=rpLu/oS3jQttqG3AiJBi6ubdqtvP3hbrdcN6X/C/dR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFGiiT+AFA4SfPMwPKYNmvRRC3QzuiVhwITL+MSv2GU+Ro7HQoFngaRHtGIyBunWx
         1vzTCy2IAgxleyxTfAf/ra9aYN/LrJMrzjxGyS6vrvzBJTXRnyKoHS4yKJ1oa1LVvE
         ypNMPMac8ttxhg60PDy9qZi5r8tMKGUO/NGxOpyw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>, Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 101/203] led: triggers: Fix a memory leak bug
Date:   Sun, 22 Sep 2019 14:42:07 -0400
Message-Id: <20190922184350.30563-101-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 60e2dde1e91ae0addb21ac380cc36ebee7534e49 ]

In led_trigger_set(), 'event' is allocated in kasprintf(). However, it is
not deallocated in the following execution if the label 'err_activate' or
'err_add_groups' is entered, leading to memory leaks. To fix this issue,
free 'event' before returning the error.

Fixes: 52c47742f79d ("leds: triggers: send uevent when changing triggers")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/led-triggers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 8d11a5e232271..eff1bda8b5200 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -173,6 +173,7 @@ int led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trig)
 	list_del(&led_cdev->trig_list);
 	write_unlock_irqrestore(&led_cdev->trigger->leddev_list_lock, flags);
 	led_set_brightness(led_cdev, LED_OFF);
+	kfree(event);
 
 	return ret;
 }
-- 
2.20.1

