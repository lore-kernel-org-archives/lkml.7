Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B584C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30CD206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR+v5mVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbfEWUc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:32:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40340 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbfEWUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:32:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id j12so10984566eds.7;
        Thu, 23 May 2019 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7G2zfRcxVCdlSQ+5QRs10qg+zaDyoLuwyhOZFdKLzQ=;
        b=XR+v5mVn8dF+FSKd4omRz9GH5MSOgKMhUBex7SuFKuqwzcdJN6s/bOJfxmfBexCE8t
         z/AM+7qwkCdFxImCL//TjsErNO4hQT1/9Vt20eO8X0DT8HVA/1rp5JeASLbCkghDpnC6
         FdJ1Uv4XX6Y1DROJPFKLjv3FBjnpDzgN8AddKeKFh25YIvddYgfj5YrVzhMusEIOU6bm
         DZdVzu3ErBqjqI5peKXnpa3Du5g3KTQT82b1YDslG6l3IyAM3QDc1Z2pN0vNTMib7r8s
         Uq/T5cMuc+LnD9NZt6CnSwNHqr4GIi6H9bfcBXc/5vIVNA+G8lIFVees07z9ow9Qt1Gd
         rguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7G2zfRcxVCdlSQ+5QRs10qg+zaDyoLuwyhOZFdKLzQ=;
        b=OSSy6jSSF+MRMWlR6U2oMOd92HUHnbzTby7bIJghHfv/hL6jXecVe5LbTB40qQg02P
         pKZOWNQpepq6U/HQpyG7BObgxImz0vXBBbKCdHmAuMbywVlinZyQ5/h/xcRKz7+FEh25
         SBG0nEEXu+pDHD/8OcQ+h2xplJt/fel+vnGyixF0IaSgppn85sxVOG8hmhNK7gQEa3Ps
         d3HRBZwrrn7mgs1c83rU62s0JV7Gg1pvd44D2WdN8DshteEJz/yDxbIm4aJdQJCA5Xsm
         GZRO0puqLA07yTlQcHrRys93vVDhAawnnJDEiPVWR+JNRPJf7oz/cjyvr99/omqFj8xV
         3uyw==
X-Gm-Message-State: APjAAAXhyzIok8MOtmo/YMvxR3WdFxkcQMxxp4P+sOeKntBGhlZ24vVm
        llYen0F0sIqIrMIp8y2RnCA=
X-Google-Smtp-Source: APXvYqwDY0FQKLmzFaFEp0K8x/qHhuFE3EB6OsqT0WR2pex/enXzFSlkZbsX7Zr1K6AHxXpt9IFAFw==
X-Received: by 2002:a50:fc97:: with SMTP id f23mr98891493edq.104.1558643546300;
        Thu, 23 May 2019 13:32:26 -0700 (PDT)
Received: from kiddo.lan ([2601:602:9400:ac45::eee])
        by smtp.gmail.com with ESMTPSA id i45sm136751eda.67.2019.05.23.13.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:32:25 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH] Bluetooth: Add new 13d3:3501 QCA_ROME device
Date:   Thu, 23 May 2019 13:32:02 -0700
Message-Id: <20190523203202.26957-2-jprvita@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523203202.26957-1-jprvita@endlessm.com>
References: <20190523203202.26957-1-jprvita@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the QCA ROME setup routine this adapter fails to establish a SCO
connection.

T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3501 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7db48ae65cd2..ff44622ea10d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -280,6 +280,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x301a), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x13d3, 0x3496), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.20.1

