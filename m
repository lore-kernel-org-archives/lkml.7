Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC800CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4F214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904083;
	bh=EjkITLXyNWDDCTnEmWuqo6H79NQjrvKt7URBqdB9VYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b0ufJOdGwZJ1cWrNFYuhjclXEUAYwLQlAuij8ODC5vGVnw4UK3BRuZ6fHoK0uG1oc
	 FemW6c4wRdZS9FkjFK0zid/kIma/NwgSEy0HJyGmxavVYtQvT/7G1MQijazE36hdEu
	 1DFHAee+kFVyIq3HlNCS3Wuty8FNd97C6iEi8H8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfKDVsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfKDVsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:48:00 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C4E20869;
        Mon,  4 Nov 2019 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904080;
        bh=EjkITLXyNWDDCTnEmWuqo6H79NQjrvKt7URBqdB9VYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLUaJJ7vIh594JnacPWymrFf8HrmlsrUWxyRgg1p9ETObggaUeVVvuG7BLoskZP2c
         gGV1/DJSLo3OONPzP2vEeM3W+OpkaJkoWqo79ZzSeg8pp0ARRN94055JwLIinmTfOx
         9M99FSDuLFH6GxxgA2flf11liDWJyrepPPU/XF6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 14/46] serial: mctrl_gpio: Check for NULL pointer
Date:   Mon,  4 Nov 2019 22:44:45 +0100
Message-Id: <20191104211843.542219979@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 37e3ab00e4734acc15d96b2926aab55c894f4d9c ]

When using mctrl_gpio_to_gpiod, it dereferences gpios into a single
requested GPIO.  This dereferencing can break if gpios is NULL,
so this patch adds a NULL check before dereferencing it.  If
gpios is NULL, this function will also return NULL.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Yegor Yefremov <yegorslists@googlemail.com>
Link: https://lore.kernel.org/r/20191006163314.23191-1-aford173@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 02147361eaa94..2b5329a3d716a 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -67,6 +67,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
 				      enum mctrl_gpio_idx gidx)
 {
+	if (gpios == NULL)
+		return NULL;
+
 	return gpios->gpio[gidx];
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
-- 
2.20.1



