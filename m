Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3DAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD0B217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="HPxAQbA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfICJMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:12:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38861 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:12:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so7642517plp.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MoQ/YzF/BXZU2pkUOeSlEfyBs1BxoTuutkdWFPwC+B4=;
        b=HPxAQbA6FqDQ6gJZCEOEliHdjeyaOGfEG+31HOMEG3ZzsV0gk/ILuuGpQf1aNnhaX5
         NwmU3AElGY5WsvPUqCCZRgRQA3zU7cxg5rMgrWbyb3BtyyfjAdCUGIfd8EFf4oqQxWdO
         qTtX24bP2cXY7RBTfi11vB6cjlrXQIUpgxyPnkrNTz5XqRtBEQBbZfufQps6YAG3bjGl
         bxSWFZYBkkdcDqaosgSeVYOa9T+lb1wymFbQzJoSzYG5hWZof5BVpiGNqlqMtTrPxA7A
         fMxTkdEihvERV6sEainork5JAuUlEl0yyCBMvlAZ77ANfR9PDy6knoqPmzOR4Ot1VcCk
         FzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MoQ/YzF/BXZU2pkUOeSlEfyBs1BxoTuutkdWFPwC+B4=;
        b=cHWeOGO5VywTboqEDwDiJ207z+kT3UOMlxbevcUOQDsAKi8A6Wv4rar7oLJCz6Wfl4
         xuC3+kS0axmGhg7cdcU9hS+XxQ9jqDrBoINcQNsey1CAMuzi/uBJbTNN46C3rW3qXL+4
         CqJN1nIb3YPL0MvJcuoLdpt/gwIaHZ/uA14IJk7htWCtGC76N+yat3mxGak8T5AyaYSw
         KvpLf/IKIx8W+H6hs/zWbj6anxiMym3mZ0smXkv5zQuu1O70STygIfBugJK/VEtA/x1J
         atkqOuJkWvSz4wwyZB2p2nWdQCpnEEFtreu++qH0JTyItbWX7LvuiOeQnwzS/BPGOVhu
         POOQ==
X-Gm-Message-State: APjAAAXy66GS21g8BMchZGX4dA5m3CDTrrWUgN58Zk+2BCDIcxz87N/O
        qc86yBFXdEk7HiLfiSTg3TboWg==
X-Google-Smtp-Source: APXvYqzFm2VsRYmVToawLTXEtQdNt6T/sq2myq1CA846ubpUEQ/9KguQBRxDv1DK6UL7KgUU5r2jEQ==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr9904062plr.201.1567501921283;
        Tue, 03 Sep 2019 02:12:01 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id m24sm4899121pfa.37.2019.09.03.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 02:12:00 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] Bluetooth: btrtl: Additional Realtek 8822CE Bluetooth devices
Date:   Tue,  3 Sep 2019 17:10:42 +0800
Message-Id: <20190903091041.13969-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS X412FA laptop contains a Realtek RTL8822CE device with an
associated BT chip using a USB ID of 04ca:4005. This ID is added to the
driver.

The /sys/kernel/debug/usb/devices portion for this device is:

T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=04 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=04ca ProdID=4005 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204707
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5cf0734eb31b..67c0ca9b1f63 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -384,6 +384,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3526), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8822CE Bluetooth devices */
+	{ USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK },
+
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
 
-- 
2.20.1

