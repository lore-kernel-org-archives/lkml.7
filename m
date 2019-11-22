Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECEAC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB24820715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418711;
	bh=HImH6DBQCdYDbrYV5nm8VU8wabB9MtuWvxvVxo2aZSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5p++dKFf9cm36bKv2Fwb1S4uXYblHU4tL+9TV6LNfA14ATbHE/8x21ErJ/BRCj1v
	 Xz0x3y42bf48wWE4Y06Klo0TGYRvJnsPMLTNzC6AOYBZRWRrQzvDZ8mfZnMHt+xdLP
	 omWbwJnZnYgaO503zwnlzGF00FBCUtFLIH04XHmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKVKbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:31:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbfKVKbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:31:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E59720714;
        Fri, 22 Nov 2019 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418708;
        bh=HImH6DBQCdYDbrYV5nm8VU8wabB9MtuWvxvVxo2aZSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuDmyK83uaWrVnoLjDYphLg6ZMUz63FNqC3rASYHFzTFZHT1MdIlxi8YL7Mj+/jlx
         khBw6gTuwbC8oaIWGcnNso5hc3q1s/Cj2+fUz0qqbl+RVKWKvz78UT8BvGnGp0KWUl
         XSfrrU2Tz7o8RrWB6IRO8R1AbYW8yyaMxaV7QjL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 024/159] rtl8187: Fix warning generated when strncpy() destination length matches the sixe argument
Date:   Fri, 22 Nov 2019 11:26:55 +0100
Message-Id: <20191122100722.924886289@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

[ Upstream commit 199ba9faca909e77ac533449ecd1248123ce89e7 ]

In gcc8, when the 3rd argument (size) of a call to strncpy() matches the
length of the first argument, the compiler warns of the possibility of an
unterminated string. Using strlcpy() forces a null at the end.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c
index c2d5b495c179a..c089540116fa7 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c
@@ -146,7 +146,7 @@ static int rtl8187_register_led(struct ieee80211_hw *dev,
 	led->dev = dev;
 	led->ledpin = ledpin;
 	led->is_radio = is_radio;
-	strncpy(led->name, name, sizeof(led->name));
+	strlcpy(led->name, name, sizeof(led->name));
 
 	led->led_dev.name = led->name;
 	led->led_dev.default_trigger = default_trigger;
-- 
2.20.1



