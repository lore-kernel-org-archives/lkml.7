Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24099C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99512070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBl9D8JI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfCRKYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:24:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51883 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfCRKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:24:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id n19so12376037wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LO3S3X4XvXbiE5N8LKTKOeln1nnCy75dy5K2i/8V7jg=;
        b=aBl9D8JIAlDScjr1YBJH9PM3vufbd2j4o+0gdPqxx66QOCjRCkXk1hoypI9qjS6x6d
         AyGhjNLHkuBErqbCgt2ZFab7jwrmWEUDZzsPQEuvhJYw80HblVn45huiJhoU3hr7bCJN
         5GGn1InAIpY4NH78bGw9/KJF/lTvoSzPeGlE7ItyOX0KwmlI83iAyXAgVjQVlTrn0XDE
         qJ9R98wRwJhgCRP+ER5UraaMtZrrxjUAFXv809ptZRjh7QAuN4Er9eQO8o3w2zGtvGfA
         HXVpo1vjjXHnFgCZflYTec+BSREcf1zQu0YxgFKTVscdZSq/KqSc7qN4dhqv9iBd9HUe
         QFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LO3S3X4XvXbiE5N8LKTKOeln1nnCy75dy5K2i/8V7jg=;
        b=gbiQ7DKzGr21oE4MQtwhQUY9GvoCBV/7X64i+uDMkhIV8JARmVkvZXgZPxFSOvruXZ
         j9VwybBp2973IcybxFuwQM6bJJYviJINv96TEnhno9jfU0BAHscqSFVZaWqFO3Efj8OV
         fbDzIPG3hdfD45oXEIps0MbvPxARaVmr70gUarNVGXPNXGNfe9WUKE3PZNvjccT+or4X
         vBG5y7SdMuXHnPmND+4WZsj1xfoPCLevD4IRUvUlJCxs7wyZti3hYsTS8rC3K65IvXUk
         GlMI0H8e/GwTP7SgXIRdQENufrJQ4LOVjTQOUciInm+W0cMEEx+K2cJRTrzGdpBN+E4M
         fMtQ==
X-Gm-Message-State: APjAAAU8dmLEDleTJtNMz1RXi7H0Wp+Y1USP0bYhdY418SDUdG1nhqjs
        AEbpuTNBLyVxsbJVZNm3yVw=
X-Google-Smtp-Source: APXvYqwvFhiWWUhkbdnyE/9Ndjpxe+KOswVU0UiCBRD3IVNw746ZCneylvhHQifEFcxHGr7sudJ5vA==
X-Received: by 2002:a1c:f50d:: with SMTP id t13mr10601968wmh.81.1552904651481;
        Mon, 18 Mar 2019 03:24:11 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba7.dynamic.kabel-deutschland.de. [95.90.187.167])
        by smtp.gmail.com with ESMTPSA id v12sm7158722wml.29.2019.03.18.03.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 03:24:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unused defines from wifi.h
Date:   Mon, 18 Mar 2019 11:23:59 +0100
Message-Id: <20190318102359.21859-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All defined P2P* in wifi.h are unused in the driver code,
so remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/wifi.h | 110 -----------------------
 1 file changed, 110 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 5e91b9428c16..5f6b04b5016c 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -667,116 +667,6 @@ enum ht_cap_ampdu_factor {
 #define WPS_ASSOC_STATE_ASSOCIATION_FAILURE	0x03
 #define WPS_ASSOC_STATE_IP_FAILURE		0x04
 
-/*	=====================P2P Section===================== */
-/*	For P2P */
-#define	P2POUI					0x506F9A09
-
-/*	P2P Attribute ID */
-#define	P2P_ATTR_STATUS				0x00
-#define	P2P_ATTR_MINOR_REASON_CODE		0x01
-#define	P2P_ATTR_CAPABILITY			0x02
-#define	P2P_ATTR_DEVICE_ID			0x03
-#define	P2P_ATTR_GO_INTENT			0x04
-#define	P2P_ATTR_CONF_TIMEOUT			0x05
-#define	P2P_ATTR_LISTEN_CH			0x06
-#define	P2P_ATTR_GROUP_BSSID			0x07
-#define	P2P_ATTR_EX_LISTEN_TIMING		0x08
-#define	P2P_ATTR_INTENTED_IF_ADDR		0x09
-#define	P2P_ATTR_MANAGEABILITY			0x0A
-#define	P2P_ATTR_CH_LIST			0x0B
-#define	P2P_ATTR_NOA				0x0C
-#define	P2P_ATTR_DEVICE_INFO			0x0D
-#define	P2P_ATTR_GROUP_INFO			0x0E
-#define	P2P_ATTR_GROUP_ID			0x0F
-#define	P2P_ATTR_INTERFACE			0x10
-#define	P2P_ATTR_OPERATING_CH			0x11
-#define	P2P_ATTR_INVITATION_FLAGS		0x12
-
-/*	Value of Status Attribute */
-#define	P2P_STATUS_SUCCESS				0x00
-#define	P2P_STATUS_FAIL_INFO_UNAVAILABLE		0x01
-#define	P2P_STATUS_FAIL_INCOMPATIBLE_PARAM		0x02
-#define	P2P_STATUS_FAIL_LIMIT_REACHED			0x03
-#define	P2P_STATUS_FAIL_INVALID_PARAM			0x04
-#define	P2P_STATUS_FAIL_REQUEST_UNABLE			0x05
-#define	P2P_STATUS_FAIL_PREVOUS_PROTO_ERR		0x06
-#define	P2P_STATUS_FAIL_NO_COMMON_CH			0x07
-#define	P2P_STATUS_FAIL_UNKNOWN_P2PGROUP		0x08
-#define	P2P_STATUS_FAIL_BOTH_GOINTENT_15		0x09
-#define	P2P_STATUS_FAIL_INCOMPATIBLE_PROVSION		0x0A
-#define	P2P_STATUS_FAIL_USER_REJECT			0x0B
-
-/*	Value of Invitation Flags Attribute */
-
-/*	Value of Device Capability Bitmap */
-#define	P2P_DEVCAP_SERVICE_DISCOVERY		BIT(0)
-#define	P2P_DEVCAP_CLIENT_DISCOVERABILITY	BIT(1)
-#define	P2P_DEVCAP_CONCURRENT_OPERATION		BIT(2)
-#define	P2P_DEVCAP_INFRA_MANAGED		BIT(3)
-#define	P2P_DEVCAP_DEVICE_LIMIT			BIT(4)
-#define	P2P_DEVCAP_INVITATION_PROC		BIT(5)
-
-/*	Value of Group Capability Bitmap */
-#define	P2P_GRPCAP_GO				BIT(0)
-#define	P2P_GRPCAP_PERSISTENT_GROUP		BIT(1)
-#define	P2P_GRPCAP_GROUP_LIMIT			BIT(2)
-#define	P2P_GRPCAP_INTRABSS			BIT(3)
-#define	P2P_GRPCAP_CROSS_CONN			BIT(4)
-#define	P2P_GRPCAP_PERSISTENT_RECONN		BIT(5)
-#define	P2P_GRPCAP_GROUP_FORMATION		BIT(6)
-
-/*	P2P Public Action Frame (Management Frame) */
-#define	P2P_PUB_ACTION_ACTION			0x09
-
-/*	P2P Public Action Frame Type */
-#define	P2P_GO_NEGO_REQ				0
-#define	P2P_GO_NEGO_RESP			1
-#define	P2P_GO_NEGO_CONF			2
-#define	P2P_INVIT_REQ				3
-#define	P2P_INVIT_RESP				4
-#define	P2P_DEVDISC_REQ				5
-#define	P2P_DEVDISC_RESP			6
-#define	P2P_PROVISION_DISC_REQ			7
-#define	P2P_PROVISION_DISC_RESP			8
-
-/*	P2P Action Frame Type */
-#define	P2P_NOTICE_OF_ABSENCE			0
-#define	P2P_PRESENCE_REQUEST			1
-#define	P2P_PRESENCE_RESPONSE			2
-#define	P2P_GO_DISC_REQUEST			3
-
-#define	P2P_PROVISIONING_SCAN_CNT		3
-
-/* default value, used when: (1)p2p disabled or (2)p2p enabled
- * but only do 1 scan phase
- */
-#define	P2P_FINDPHASE_EX_NONE		0
-/*  used when p2p enabled and want to do 1 scan phase and
- *  P2P_FINDPHASE_EX_MAX-1 find phase
- */
-#define	P2P_FINDPHASE_EX_FULL		1
-#define	P2P_FINDPHASE_EX_SOCIAL_FIRST	(P2P_FINDPHASE_EX_FULL+1)
-#define	P2P_FINDPHASE_EX_MAX		4
-#define	P2P_FINDPHASE_EX_SOCIAL_LAST	P2P_FINDPHASE_EX_MAX
-
-/* 5 seconds timeout for sending the provision discovery request */
-#define	P2P_PROVISION_TIMEOUT		5000
-/* 3 seconds timeout for sending the prov disc request concurrent mode */
-#define	P2P_CONCURRENT_PROVISION_TIME	3000
-/* 5 seconds timeout for receiving the group negotiation response */
-#define	P2P_GO_NEGO_TIMEOUT		5000
-/* 3 seconds timeout for sending the negotiation request under concurrent mode */
-#define	P2P_CONCURRENT_GO_NEGO_TIME	3000
-/* 100ms */
-#define	P2P_TX_PRESCAN_TIMEOUT		100
-/* 5 seconds timeout for sending the invitation request */
-#define	P2P_INVITE_TIMEOUT		5000
-/* 3 seconds timeout for sending the invitation request under concurrent mode */
-#define	P2P_CONCURRENT_INVITE_TIME	3000
-/* 25 seconds timeout to reset the scan channel (based on channel plan) */
-#define	P2P_RESET_SCAN_CH		25000
-#define	P2P_MAX_INTENT			15
-
 /*	WPS Configuration Method */
 #define	WPS_CM_NONE			0x0000
 #define	WPS_CM_LABEL			0x0004
-- 
2.21.0

