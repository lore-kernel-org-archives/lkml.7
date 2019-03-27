Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95CCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2FF205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712591;
	bh=hD2RJPnaS6Es29brTXoGgh69te7zm5LCCsCvee9+LEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvbut2hKeTwQ+1TQ1X+AjH1fIsyz6syvmpJH0osVJ5jD6kyliW31PEr0lp/EdWuXC
	 kSLS11FuoDV0jspB++zaa0pHMtb6mZgALPpojlrGHfk2sfIdObmeBRvercrT9sh3MG
	 LJLb9rIC3/1qZP3vhWENtVydpRSPS52M787LtQLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390531AbfC0SSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390509AbfC0SSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:18:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5182147C;
        Wed, 27 Mar 2019 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710704;
        bh=hD2RJPnaS6Es29brTXoGgh69te7zm5LCCsCvee9+LEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RINpthu572oMWeOyUpaHZ6EQ7g/72ZQbDrDCbRccumRkV1h1zkN+JfG/8TYUXwJVY
         ieBN++4N93CpeQiOKErizgX92oWWry/Q3IR5GJGPd/n6Tx6BF098tXC9pLQufikB2h
         o9e4X3flj+8tTKr+DBAhwTuxIxb6eslcIlC0NVXQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kazior <michal@plume.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 065/123] leds: lp55xx: fix null deref on firmware load failure
Date:   Wed, 27 Mar 2019 14:15:29 -0400
Message-Id: <20190327181628.15899-65-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kazior <michal@plume.com>

[ Upstream commit 5ddb0869bfc1bca6cfc592c74c64a026f936638c ]

I've stumbled upon a kernel crash and the logs
pointed me towards the lp5562 driver:

> <4>[306013.841294] lp5562 0-0030: Direct firmware load for lp5562 failed with error -2
> <4>[306013.894990] lp5562 0-0030: Falling back to user helper
> ...
> <3>[306073.924886] lp5562 0-0030: firmware request failed
> <1>[306073.939456] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> <4>[306074.251011] PC is at _raw_spin_lock+0x1c/0x58
> <4>[306074.255539] LR is at release_firmware+0x6c/0x138
> ...

After taking a look I noticed firmware_release()
could be called with either NULL or a dangling
pointer.

Fixes: 10c06d178df11 ("leds-lp55xx: support firmware interface")
Signed-off-by: Michal Kazior <michal@plume.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lp55xx-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index 5377f22ff994..e2655953667c 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -201,7 +201,7 @@ static void lp55xx_firmware_loaded(const struct firmware *fw, void *context)
 
 	if (!fw) {
 		dev_err(dev, "firmware request failed\n");
-		goto out;
+		return;
 	}
 
 	/* handling firmware data is chip dependent */
@@ -214,9 +214,9 @@ static void lp55xx_firmware_loaded(const struct firmware *fw, void *context)
 
 	mutex_unlock(&chip->lock);
 
-out:
 	/* firmware should be released for other channel use */
 	release_firmware(chip->fw);
+	chip->fw = NULL;
 }
 
 static int lp55xx_request_firmware(struct lp55xx_chip *chip)
-- 
2.19.1

