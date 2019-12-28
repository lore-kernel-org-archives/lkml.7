Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F578C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2170E20838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 14:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXzvdD90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfL1Ohx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 09:37:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34774 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfL1Ohw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 09:37:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so28690206wrr.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 06:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pyGdJRwo6Y5rfYRQzWh9hhmSSSQyZwjpG1KsAjDx5is=;
        b=PXzvdD90skNwJyFrE38+JpzWwSgFh+hrdjustCqzWFCtP0ARlY3ABJ4ENx2cclJUlU
         ev71nYK+nejEJ9Yp/xn7Hgki5Y17JrlqtZVy1mpN8r5dBH+DTydqkbp7YLNlFAj3FB39
         JAuFzNomus3czQFTIIMv3K/Z2g0BFSuPhFX2Bq8ajxlmMXVZp2m+u0lrB7zgWrgkVjwg
         CXeM7BD4E9Z8z+gS175fwPKEMoE45ZpFz1eHt2KBcRUXUkfzleFoSd/Oi39qrQQfz2r2
         AoY9Ay+KQoevv1nmgsHbUcc/9CMiwFxv0OTYaZGTKu8afWw6K2k5FYCo9tioRuvEXiUa
         y/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pyGdJRwo6Y5rfYRQzWh9hhmSSSQyZwjpG1KsAjDx5is=;
        b=D+aysgN0bjhljQELmVso3WGeC64kq36F3y/PRVzoiln1R2DSsO5+8+3irxpi4jztTL
         WzxpShYS77DKpzF6eZcW8HKdjMObdxSmYoNpl+fsBxl1AC4PVVp3TA9ABIBlEvdtRmr+
         59xp3+uUBpZodQjcbKxHLlA7dZDLeDynPlaGJNELTY2ERp1bUEiekTpJ7uXXWE1Sg8Qu
         b3LWYZVaJ5VKA8XSnDCo9ZpMUsqyhq2W92GeT6aOxdVmvy70eUBSekxXeCYUhh8d0wgP
         tza9g2vXE/7MDM5nQp4/RCkok+6uqIfziPLbmGzECHtVM6t24cwmmGFt75dLr4HO7c5+
         7DOA==
X-Gm-Message-State: APjAAAWH96vDTPR47o+WucnI3B3uvZbKkY8yqaGdCwKHF0PPcx1by6Yo
        orHoIQrdqsgs0FYBISdHOOM=
X-Google-Smtp-Source: APXvYqxSqUH0DLFp50ljpmbSMRDYQPOR6MXzvuaJATmfZGd69U33SELNkjs8i7PpsG53EyT5Pde5XQ==
X-Received: by 2002:adf:806e:: with SMTP id 101mr58779002wrk.300.1577543870961;
        Sat, 28 Dec 2019 06:37:50 -0800 (PST)
Received: from localhost.localdomain (dslb-088-070-028-178.088.070.pools.vodafone-ip.de. [88.70.28.178])
        by smtp.gmail.com with ESMTPSA id u1sm14308940wmc.5.2019.12.28.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 06:37:49 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Add device code for TP-Link TL-WN727N v5.21
Date:   Sat, 28 Dec 2019 15:37:25 +0100
Message-Id: <20191228143725.24455-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device was added to the stand-alone driver on github.
Add it to the staging driver as well.

Link: https://github.com/lwfinger/rtl8188eu/commit/b9b537aa25a8
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index a7cac0719b8b..b5d42f411dd8 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -37,6 +37,7 @@ static const struct usb_device_id rtw_usb_id_tbl[] = {
 	{USB_DEVICE(0x2001, 0x3311)}, /* DLink GO-USB-N150 REV B1 */
 	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
+	{USB_DEVICE(0x2357, 0x0111)}, /* TP-Link TL-WN727N v5.21 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */
 	{}	/* Terminating entry */
-- 
2.24.1

