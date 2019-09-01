Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D7DC3A5A7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE709238C4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfIAQOq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:14:46 -0400
Received: from mail-oln040092072097.outbound.protection.outlook.com ([40.92.72.97]:38818
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729002AbfIAQOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 12:14:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e683ItcRYinKaRmiczp4ybWfQg5fjGqSAFjtELsrCT9L7bgZi+FDdu1t8gGgei2hqIsTWgoxsKVQ2qPpVZ8vSi/IBXMvgHPFqmDfP+0dBEQc4tQXl1luf+P+pxESV+ckMeFzCnlETk4PBLuvrLzxtpUcC12vHOV3vOpRSJ3OpVukvRVdv62vCy+kRyuNaqACIwPmCBhfE7yW1HzvQitZpb5ssCL7kKobWUjtGxILOxmkzdG+5HrWyZZHWTvCT9mrTDqyrSBF+cuJfj497o+oJCnbJLmTNaDfsJJQwLYqQxWnKyAf8Q7l0JOH3iBC/JQQIup3TDcbGyTHeq87G0Uz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBbW2es+zEVxi1PJa2RuUXYr8tKyOCXV1lnyjw2zDHU=;
 b=hDNSVfSHodI6fmkCCCrqub1BAWWY+cKPEn/wtZJHLjBlpZLnMC3LlEmovuyar+eHfVVPtMvPGF2h/4akzf+65n+MJ3PFtOndazH+fgzcKpwq3CRHazbawtVaEx6chyLQZgYSGTdnw/fAn8NdzzeO80MmYMIGxUrit6Qal1PqlULOlDf8Hcm3uD51TYTQUInnza04NCRJHp18TkclcZWYzCWyVTnVQ4l4Z4ru8au3XJh3N9MXweO/Nx79of4t9GaAgtnyCP1TWEbYYFvDpRO3WYJBw1F7jKLRl+VgFmhiMXvtdOcZNH5XyNUvZlAJHqv/joyvf0qFDCQLWySpwSs56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (10.152.16.51) by AM5EUR03HT010.eop-EUR03.prod.protection.outlook.com
 (10.152.16.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.16; Sun, 1 Sep
 2019 16:14:40 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com (10.152.16.51) by
 AM5EUR03FT031.mail.protection.outlook.com (10.152.16.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 16:14:40 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87]) by AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87%5]) with mapi id 15.20.2220.021; Sun, 1 Sep 2019
 16:14:40 +0000
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
Subject: [PATCH 3/5] drm: dw-hdmi: update CEC phys addr and EDID on HPD event
Thread-Topic: [PATCH 3/5] drm: dw-hdmi: update CEC phys addr and EDID on HPD
 event
Thread-Index: AQHVYOBbQpm/ZMlRykOhaECOU9r4vA==
Date:   Sun, 1 Sep 2019 16:14:40 +0000
Message-ID: <AM0PR06MB4004285BAA935D14F1A68787ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
References: <AM0PR06MB40049562E295DD62302C8DB7ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
 <20190901161426.1606-1-jonas@kwiboo.se>
In-Reply-To: <20190901161426.1606-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::32)
 To AM0PR06MB4004.eurprd06.prod.outlook.com (2603:10a6:208:b9::12)
x-incomingtopheadermarker: OriginalChecksum:1F463C3D5BCABB046F9B08A9F9A9F40717038D88F37E3A3E8C7A6F2C4358B9BD;UpperCasedChecksum:F0FC40B25BB6A19D03E18C0A4EE87F0CA72A035A82E5C8BF327C10A3133D4FF3;SizeAsReceived:8000;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [liv2rWy4Iqf8mgR7TuwgLhMEU2c1XhDZ]
x-microsoft-original-message-id: <20190901161426.1606-3-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR03HT010;
x-ms-traffictypediagnostic: AM5EUR03HT010:
x-microsoft-antispam-message-info: CpBoPcxYXPGfvClL52zJAtARGuaXXSmUVZ2TzMwe5YSBrlyv7B5a8rLJuM4Fgl/wotl0k57z/9CieXw9QAWzSOPZE1ZjLwwkOv6WUCtptqxH+oP5n5DMCcQSRXU0RqRgYa+FOlffR+QENfserfhVP2T0VluVqkJ/ruWImFlhpRcWVCQT8/bXTi+LvoflHeDk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a36b18-5bcd-41a9-d563-08d72ef77e07
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2019 16:14:40.5565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update CEC phys addr and EDID on HPD event, fixes lost CEC phys addr and
stale EDID when HDMI cable is unplugged/replugged or AVR is powered on/off.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 91d86ddd6624..0f07be1b5914 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2189,6 +2189,7 @@ static int dw_hdmi_connector_update_edid(struct drm_connector *connector,
 static enum drm_connector_status
 dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
+	enum drm_connector_status status;
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
 
@@ -2198,7 +2199,14 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 
-	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+	status = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+
+	if (status == connector_status_connected)
+		dw_hdmi_connector_update_edid(connector, false);
+	else
+		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
+
+	return status;
 }
 
 static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
@@ -2438,12 +2446,6 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 		dw_hdmi_setup_rx_sense(hdmi,
 				       phy_stat & HDMI_PHY_HPD,
 				       phy_stat & HDMI_PHY_RX_SENSE);
-
-		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0) {
-			mutex_lock(&hdmi->cec_notifier_mutex);
-			cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
-			mutex_unlock(&hdmi->cec_notifier_mutex);
-		}
 	}
 
 	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
-- 
2.17.1

