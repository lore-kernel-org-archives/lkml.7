Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8038022BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033265;
	bh=8ZDc2A+eJYtSwTH+qWvv5n5v6BuqQPfzwEJCxmqGHRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kiY0JxZRms/fGf30UREVJyOTM6s9hNH27yMvDWk7H+bHVP05YX4zr7djZGiHc79OU
	 tKkMj5fgG+nFcoeqZ47PviiA1nYR1svawDnpt6Cha0hGPghcvVObSsmnaWPuWdHnu3
	 jU2KX/yeCkdCSMFHIkIq/5XWukk9W93UvSKqWZt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404519AbfGYFlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390756AbfGYFk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:40:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCAF22C7D;
        Thu, 25 Jul 2019 05:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033258;
        bh=8ZDc2A+eJYtSwTH+qWvv5n5v6BuqQPfzwEJCxmqGHRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuq6+0+ePl+WyJenxKO2KNePe7T714QQiTWNTWTk/7kr2jSix3rDqnQLapxdflW65
         UQQlLkOguxxYTKXXtHULu3VQASBqXvd+S01qj87CGPATNy/OKIKXu+e95KYdD4cZ3c
         nuWG2noUF9y8TnILifrpE3z5TrVf8DEXE2DZNCyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 147/271] Bluetooth: Add new 13d3:3491 QCA_ROME device
Date:   Wed, 24 Jul 2019 21:20:16 +0200
Message-Id: <20190724191707.780822044@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 44d34af2e4cfd0c5357182f8b43f3e0a1fe30a2e ]

Without the QCA ROME setup routine this adapter fails to establish a SCO
connection.

T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3491 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 40a4f95f6178..f494fa30a912 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -277,6 +277,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x301a), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x13d3, 0x3491), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x13d3, 0x3496), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
-- 
2.20.1



