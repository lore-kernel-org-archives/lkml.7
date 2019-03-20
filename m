Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C64221841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyF4LwKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCTIus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:50:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53026 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfCTIus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:50:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so5623963wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJjh0jo2CwGPWxpOafRxA0GoUtLGduiD1ELGGDvBdCU=;
        b=lyF4LwKfYzTSzv2AnpXchalsr1mvQSJlzZ+I14UrarvyxjD8K7D7plRlWtKiU7dknH
         QhBotS5W6KH2/jmOEOwF3zzWFioDFS7L+FusUFaJd92Nho0dRH0eyC2cQyyJ9lJSkrgl
         6afaNrU5lD56kgXNE0O0fYEUay0VuqMYEdtaMRPCwBgf9VSvViVBjkGjHJpAbtbxo8AK
         ggVA6EsKEPiTu6Emh5UbAvl9OmUbQ15y3I/HUxS/4OhImEjkWmQ6l4YYTiZn+PA5va2Z
         0WEEgROrm9SVKv6bCfNr6hfTZozHlXS2MWs4qrdm6UBzie9G9KUWfV+8nUENrQeWHq87
         SLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJjh0jo2CwGPWxpOafRxA0GoUtLGduiD1ELGGDvBdCU=;
        b=kp0oYXzixRhaE665eYTfnR/BPJ5RnuUUK7Mw4duu0YFm0328rlTxXwE1Q79djcOFSU
         LVRTR/a6EH3nJ9BCsrJZiWxxvWZZ9qvjJWO0v68ymSRksiW1563OYKDNBwXXDkbUG3C+
         hPhLVJBudJ4P0gAgm/xZVml8yhLcfzKsCx/weBbujwuFQEiljWA2VU/8LoxOEygBveAs
         FX1n2niI5Oyx9aaaWj1vRdBJVhvmxgJ4wt7jvPUeLUsyNapSz+mpN8hE0QvJNrZAffRx
         rsBLABxejyLHP1jIC0WY54OenUPhr0a7v+uv406pX+/ax9Tk+clXTOwV1lmwcxE0aR9/
         wSLA==
X-Gm-Message-State: APjAAAVGFlIFYJ11WFcmd+jEBpIdbxRVxOcyxrZQ7HQUiGcQjY5lffdY
        NvruqVDBQ+GNbsHCk8yvzG0=
X-Google-Smtp-Source: APXvYqzaw0LE09pEVC2cqzCgVNtgl37Nh47rsUcJml6fcmfSzQvXY0qSNp8JDGj5/o/BEDzNG5Fqbw==
X-Received: by 2002:a7b:c5cf:: with SMTP id n15mr7227181wmk.106.1553071846742;
        Wed, 20 Mar 2019 01:50:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb85.dynamic.kabel-deutschland.de. [95.90.187.133])
        by smtp.gmail.com with ESMTPSA id g10sm1224907wrq.61.2019.03.20.01.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 01:50:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unused WFD defines
Date:   Wed, 20 Mar 2019 09:50:29 +0100
Message-Id: <20190320085029.21025-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All defined WFD* in wifi.h are unused in the driver code,
so remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/wifi.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 5f6b04b5016c..d059240b836f 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -681,26 +681,6 @@ enum ht_cap_ampdu_factor {
 #define	WPS_CM_SW_DISPLAY_P		0x2008
 #define	WPS_CM_LCD_DISPLAY_P		0x4008
 
-/*	=====================WFD Section===================== */
-/*	For Wi-Fi Display */
-#define	WFD_ATTR_DEVICE_INFO		0x00
-#define	WFD_ATTR_ASSOC_BSSID		0x01
-#define	WFD_ATTR_COUPLED_SINK_INFO	0x06
-#define	WFD_ATTR_LOCAL_IP_ADDR		0x08
-#define	WFD_ATTR_SESSION_INFO		0x09
-#define	WFD_ATTR_ALTER_MAC		0x0a
-
-/*	For WFD Device Information Attribute */
-#define	WFD_DEVINFO_SOURCE			0x0000
-#define	WFD_DEVINFO_PSINK			0x0001
-#define	WFD_DEVINFO_SSINK			0x0002
-#define	WFD_DEVINFO_DUAL			0x0003
-
-#define	WFD_DEVINFO_SESSION_AVAIL		0x0010
-#define	WFD_DEVINFO_WSD				0x0040
-#define	WFD_DEVINFO_PC_TDLS			0x0080
-#define	WFD_DEVINFO_HDCP_SUPPORT		0x0100
-
 #define IP_MCAST_MAC(mac)				\
 	((mac[0] == 0x01) && (mac[1] == 0x00) && (mac[2] == 0x5e))
 #define ICMPV6_MCAST_MAC(mac)				\
-- 
2.21.0

