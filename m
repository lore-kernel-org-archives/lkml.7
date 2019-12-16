Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DD3C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9DE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520789;
	bh=40JMI6VQBZQYGPRBCqC1Q5JsXnBsyZXglDSKlZdoUug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yKQv35/fzUugbqr8h8A5nDz4G+0pUmzCQhQDv3zBSQe7yEMWd41hEZBhX4WJGwX/6
	 aR7SIo8xxTyIYiuDmSx72d9pNEBoTuTefjGHYFtzgbAVdGXLlx7jI6aCPYUXz1OYLT
	 M2xrNV5ts1GxxxUGMoBvPq7e8vA+CueAnw1tFjKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfLPSRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731443AbfLPSQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:16:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355A2206E0;
        Mon, 16 Dec 2019 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520215;
        bh=40JMI6VQBZQYGPRBCqC1Q5JsXnBsyZXglDSKlZdoUug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqqvwAxuMbYF0xWA12S/VjZ66uQ8xv0srKRv31D0lm4xvQTeBZWjnN1TNZSidzG5D
         7vMOXp19t0qRADgL8hLf1TbTyn0zMdXKwf8KH9LTWc6F2NgHyPOv8sza5oeww4SrH/
         x58MMnJTgGD1HCrLeCQtzDiT4L8Wp3UniwTOyGS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5.4 063/177] phy: renesas: rcar-gen3-usb2: Fix sysfs interface of "role"
Date:   Mon, 16 Dec 2019 18:48:39 +0100
Message-Id: <20191216174832.207394103@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 4bd5ead82d4b877ebe41daf95f28cda53205b039 upstream.

Since the role_store() uses strncmp(), it's possible to refer
out-of-memory if the sysfs data size is smaller than strlen("host").
This patch fixes it by using sysfs_streq() instead of strncmp().

Reported-by: Pavel Machek <pavel@denx.de>
Fixes: 9bb86777fb71 ("phy: rcar-gen3-usb2: add sysfs for usb role swap")
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/string.h>
 #include <linux/usb/of.h>
 #include <linux/workqueue.h>
 
@@ -320,9 +321,9 @@ static ssize_t role_store(struct device
 	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
 		return -EIO;
 
-	if (!strncmp(buf, "host", strlen("host")))
+	if (sysfs_streq(buf, "host"))
 		new_mode = PHY_MODE_USB_HOST;
-	else if (!strncmp(buf, "peripheral", strlen("peripheral")))
+	else if (sysfs_streq(buf, "peripheral"))
 		new_mode = PHY_MODE_USB_DEVICE;
 	else
 		return -EINVAL;


