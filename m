Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B0C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE2F206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn5UuSqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbfEWUc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:32:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45835 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbfEWUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:32:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so10965105edc.12;
        Thu, 23 May 2019 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbyTMyBrIo+yvxCvX9uVkQnxu68Ol7euvxd3/vnXWtI=;
        b=Jn5UuSqYk8Indc7KwNtPaew1ji8w/TtQeNInDX55q8QoJG99nyFYXkP8yQnCJ1KbWz
         du8e1jLYsXtmDoks22auMI1KXG7l0XznTzQ6ybChRPyjZBSYoz0COIzkhTIkE2rNUm3U
         XF96dd6TWsYSJMtHJLKNzCr4qR6DjXuSAaahAD3BEi53pCALYtOULTxagjrlMPkO8S10
         ETh7iEf0tfAVx36OmwtLkeSSVFSQNo+aLUwmFDHSppQCSavTOnW4b4X74Q3tm7qCTjFL
         MlDRi2NQoCbAoSsEEB9b+MJAA9embDEoxx7MyZYpUy0fRfrge3OBV8AGosd8O6A4Iv4r
         t5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbyTMyBrIo+yvxCvX9uVkQnxu68Ol7euvxd3/vnXWtI=;
        b=iLjmGnERpAqZRzUglFLsYFjTC499S5YBAs25/idsZhIIYIAZePusDwojsRsmtmQGDd
         w8mMruoLsLTY462UwTrdJLMvV4qQUsDF/voPcJnzIuv2DbOPLfd3fVGQAUIaf/5xDFPY
         MgIcmpFxrSK/2Nh9esxRzIsbW8pJt3fN0rB1yJ0CO7skjZrd1YjpLI4cSFQ8IgKlwDOO
         8kP0G+/wLKxP7o3BTUYQ3fdvKPvrxwRRzlW44gyXVN29wCdvLStS8MG+6swliFACy9MN
         oM6964xy1eb9KvgkyaF9FAECPQKrHa4eLfJoufNTfPGMCQDMJ5yMUHuwFmlpcvgxOPi8
         7PLg==
X-Gm-Message-State: APjAAAVDnuEcOAWvrHvbf4FF5exy5OshzKea4G3R+kspmsXNxAl2iago
        SRsRaelUV8Qq3p17J7bFIh4=
X-Google-Smtp-Source: APXvYqxGaRzymiV0GAzLYb6gzN6+hamMkpZTGP2XD/nmw4qF8G0AXQ+dLAs+01AtGwCo+kuKKTRI9A==
X-Received: by 2002:a17:906:c826:: with SMTP id dd6mr78267591ejb.152.1558643544010;
        Thu, 23 May 2019 13:32:24 -0700 (PDT)
Received: from kiddo.lan ([2601:602:9400:ac45::eee])
        by smtp.gmail.com with ESMTPSA id i45sm136751eda.67.2019.05.23.13.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:32:23 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH] Bluetooth: Add new 13d3:3491 QCA_ROME device
Date:   Thu, 23 May 2019 13:32:01 -0700
Message-Id: <20190523203202.26957-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the QCA ROME setup routine this adapter fails to establish a SCO
connection.

T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3491 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ff44622ea10d..4c9f11766e82 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -279,6 +279,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x301a), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x13d3, 0x3491), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x13d3, 0x3496), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME },
 
-- 
2.20.1

