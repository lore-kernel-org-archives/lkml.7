Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C2C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFAD20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op8opcDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfEPPJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:09:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46716 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfEPPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:09:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so3766031wrr.13;
        Thu, 16 May 2019 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GldHbOnZfCgrNxHCEakDvlEgb285OgaglO7DDWQycHU=;
        b=Op8opcDSLOpQgGoRUbw/CP/yYvjtufKY8C3gwNH9bacemHQ50w624XxNsiMJE+4/Op
         cbr24jzCXRY5KsAXJsv64Wg/oKZI+3DbaIj4cwmWNAZ4PPWO0mQHAnVXEI3vA7mJeWH8
         n9ZxEYnd+mleHU0Fy59rMJqMjnOw+ihgWCaHP/qxrKAy9mIrXmMTB76SMD0w2VBfZW9A
         uQrSqMbsWZjAAnGDHF/8qEokPZifppPJhcXV79xUE5Dow35uBkWnXLw3qu7Mf3oFIgDw
         LJNyIK3sGgxXuaX58+3NVIrL24UmgecM7Ki1j2X4fW7Y58ixSvsP9gA//PpOAx+yECoH
         LZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GldHbOnZfCgrNxHCEakDvlEgb285OgaglO7DDWQycHU=;
        b=oScNxkxxtqU3rGfjcvko3GIXGF9aCJK8WuUTxqxw1luONhGpk3GBTwPShf5BxvptP3
         aOuP8u8LNK0T8bUJmGC381QW1vEDQjBPjGX21VT3AeH/OKN0zR2QpL2oeQvZQEax27S4
         +QrT3CBm7TE8Q+lnMZ0gpHk2c7G8oD7PPqhxzu0spsYQOSoBclL7DFG+6tIItTC9N8BK
         SG9laLCvMcTjiViuqS6ReML7DfDwuC3vKalVoxbMZd6xYmnU9gatPnwK5itAVD3rglkD
         OgTB5GBIThf6n9JJQW1/IWjV65R/Ck0X63zKN99GiN4Io9gO6nswdZ/jutLK5eoolCBk
         BP2g==
X-Gm-Message-State: APjAAAW/dmxmzRKv0ADXTWcsk1nFuh4qdGpH9d004j/0avDXl5ICg7oM
        5ePt8VV614+E/cAZIPJzICA=
X-Google-Smtp-Source: APXvYqwNv4y1/E2lS+3B9LHQr1a7DDHE3rix4cnwzwdgALxZNwUQM/lrC0UHLBo5uvZw9LGUuRN8+A==
X-Received: by 2002:adf:fc8f:: with SMTP id g15mr32536353wrr.122.1558019393216;
        Thu, 16 May 2019 08:09:53 -0700 (PDT)
Received: from xws.fritz.box (pD9EA30D0.dip0.t-ipconnect.de. [217.234.48.208])
        by smtp.gmail.com with ESMTPSA id t6sm4963423wrn.3.2019.05.16.08.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 08:09:52 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Harry Pan <harry.pan@intel.com>,
        =?UTF-8?q?Maxence=20Dupr=C3=A8s?= <xpros64@hotmail.fr>,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Nico Sneck <snecknico@gmail.com>,
        Emmanuel Pescosta <emmanuelpescosta099@gmail.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Add LPM quirk for Surface Dock GigE adapter
Date:   Thu, 16 May 2019 17:08:31 +0200
Message-Id: <20190516150833.119745-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without USB_QUIRK_NO_LPM ethernet will not work and rtl8152 will
complain with

    r8152 <device...>: Stop submitting intr, status -71

Adding the quirk resolves this. As the dock is externally powered, this
should not have any drawbacks.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 8bc35d53408b..6082b008969b 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -209,6 +209,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Microsoft LifeCam-VX700 v2.0 */
 	{ USB_DEVICE(0x045e, 0x0770), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Microsoft Surface Dock Ethernet (RTL8153 GigE) */
+	{ USB_DEVICE(0x045e, 0x07c6), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Cherry Stream G230 2.0 (G85-231) and 3.0 (G85-232) */
 	{ USB_DEVICE(0x046a, 0x0023), .driver_info = USB_QUIRK_RESET_RESUME },
 
-- 
2.21.0

