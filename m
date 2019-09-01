Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592B2C3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD462342C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfIAQOo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:14:44 -0400
Received: from mail-oln040092070034.outbound.protection.outlook.com ([40.92.70.34]:18660
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728987AbfIAQOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 12:14:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjnK2TI7rVYUfkkbcTmzFNdApEKkjKrtVmai9SvbfeJTHy6JNr3ufUnUgEMrvN+vchIRrOm2oYTsYDjoLQ+u1VeLrrOrPwieulFyetqI/47oF82uAS09SD4CE/lKpRLRF+RvSCopnytrPVFOhyfhJ/6NPvD+Clgd1Pm9Q+ITSWJ1lcKkiABOLjVl9AyUv6RX7fT4G4SBms+XMat+ViOLtR70ch9QCAdSm2J/MmBc5Mr2BFI2SwsCkBnfA/DwIjkZBH4VY9RJv29A9fVdP7cI6QxRwQmntjgdtq90AATydbiBV0wqNlXzazh1GR691G+SPbDWiXBUFOwtmMDPBQ+lnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P437qGjgHJ4joyGOSSESljNIDRvC8H1crQnH6bic4xs=;
 b=MwmRTKkWMcN1o6H1O5JAhjsPBOv/YK10oxDpQlsd/DvR3K44ArkenSlOzXDWj1q5YOcDKs6PW4pzLf/IfWwM65btRBUkdcsbtlL/KhKZbJcw7XqWQua5tY4muS4K1iayFKsDGfYc9svuiEkOCs+g6aTkbHnJjXtVrsb0qRppU5fuRnkwRmS58eXfdiI3EfEc6QBXQIj2uEKr/UeykJh8xDaSFlvobov3I53t50a9anOXW8uMOzUKXtp/KELZ+wfdx3WjwBsa/lEln4ezWZpo7mjL0lu8OKJ7zY+l6LNgBv7CcpJH1kF8ovPawD7UDPRCS4tDEqMJE84O/mF2XJqk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (10.152.16.55) by AM5EUR03HT110.eop-EUR03.prod.protection.outlook.com
 (10.152.17.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.16; Sun, 1 Sep
 2019 16:14:39 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com (10.152.16.51) by
 AM5EUR03FT031.mail.protection.outlook.com (10.152.16.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 16:14:39 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87]) by AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87%5]) with mapi id 15.20.2220.021; Sun, 1 Sep 2019
 16:14:39 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/5] drm: dw-hdmi: move dw_hdmi_connector_detect()
Thread-Topic: [PATCH 2/5] drm: dw-hdmi: move dw_hdmi_connector_detect()
Thread-Index: AQHVYOBbWV8Th1TB7E6oSuxlJ5RnAQ==
Date:   Sun, 1 Sep 2019 16:14:39 +0000
Message-ID: <AM0PR06MB400415A45BFD6956950D9251ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
References: <AM0PR06MB40049562E295DD62302C8DB7ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
 <20190901161426.1606-1-jonas@kwiboo.se>
In-Reply-To: <20190901161426.1606-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::32)
 To AM0PR06MB4004.eurprd06.prod.outlook.com (2603:10a6:208:b9::12)
x-incomingtopheadermarker: OriginalChecksum:228A8DD11B64B3E7666AB60E5E47A2B6F77C29E963B1A868DA1A6232157C26FB;UpperCasedChecksum:CE7EBE31092929AE617E0B96A530497F27B0603AFC17793DD6D92C5394E2CCBC;SizeAsReceived:7966;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [bqiqt4RLDZA9AC3c+4twBG+KizakMsvz]
x-microsoft-original-message-id: <20190901161426.1606-2-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR03HT110;
x-ms-traffictypediagnostic: AM5EUR03HT110:
x-microsoft-antispam-message-info: wrbaIbi9jsAy3dAvoqRNBmc0A4G7l+kE0rxUCqQxkAdZ3h6NHyGsXjbkQt/H7LuQj6leFZuc3fuSvQDhhJ/JtwuQcdKpv1stlJWrph6MNN1ccYNqJwpAHvc24YeI1TM25sa5n2ZKjI4hWRLI57Nxp+RSim8nNTFUP83RxjTdr2sCkPD5ndUh37e+nXmyiHLV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bfefe2-773a-400a-57b0-08d72ef77d54
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2019 16:14:39.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move dw_hdmi_connector_detect() it will call dw_hdmi_connector_update_edid().

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 30 +++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 8ab214dc5ae7..91d86ddd6624 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2156,21 +2156,6 @@ static void dw_hdmi_update_phy_mask(struct dw_hdmi *hdmi)
 					  hdmi->rxsense);
 }
 
-static enum drm_connector_status
-dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
-{
-	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
-					     connector);
-
-	mutex_lock(&hdmi->mutex);
-	hdmi->force = DRM_FORCE_UNSPECIFIED;
-	dw_hdmi_update_power(hdmi);
-	dw_hdmi_update_phy_mask(hdmi);
-	mutex_unlock(&hdmi->mutex);
-
-	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
-}
-
 static int dw_hdmi_connector_update_edid(struct drm_connector *connector,
 					  bool add_modes)
 {
@@ -2201,6 +2186,21 @@ static int dw_hdmi_connector_update_edid(struct drm_connector *connector,
 	return ret;
 }
 
+static enum drm_connector_status
+dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
+					     connector);
+
+	mutex_lock(&hdmi->mutex);
+	hdmi->force = DRM_FORCE_UNSPECIFIED;
+	dw_hdmi_update_power(hdmi);
+	dw_hdmi_update_phy_mask(hdmi);
+	mutex_unlock(&hdmi->mutex);
+
+	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+}
+
 static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 {
 	return dw_hdmi_connector_update_edid(connector, true);
-- 
2.17.1

