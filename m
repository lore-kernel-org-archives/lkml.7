Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94186C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7074D233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfIAQOm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:14:42 -0400
Received: from mail-oln040092072023.outbound.protection.outlook.com ([40.92.72.23]:49477
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfIAQOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 12:14:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfq5qrgvJcB0AIw9xKECdaU0bgm2dOOph9PzcmPLMx12yjf4nVe2CCOCAvuF4YXIkiRL1vh1RqTvW5tiKaKvzoqFQ19qxVG1mdV3/3yJyJmfjdGJQ9bulfYL0gNUlJHUNMYwQBQx1fPTSmF4BhB9DfxIx+NmM5acgXa2AegVYAb3PtMh6jaU+vVErHW/S+Wn9YxWZA8kcEk0gs8QQ9DsSAq8woIWUoU+MnzIpvTjzSRgJDn+Ashg+zwOIomLLcl8iaI+Gz/oNp7omaNa+mYLMXsPIBvIgREqzxuuVxDPm52CcvhyckqCPtvB/xegDIBtbZX74ziwNwyZOyvL7RIm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsXKj14BbN3yO6ooEs4gfQiqF04TtDyDFlyX3vv8+Ig=;
 b=Rp3MzqbxhI3KugmQ8GVBdxXiY+h4hflFNKdEkVAvyzoMFH7pe5jbw4K/rTouRauz2HejCZSKFOeeFis2VRjhMWUJ+yCdN8MAGAUHPOj3Gh7kstfcL6XGQzBEgc0WorjFqUvyHfV0MCmiK7bnalsA4UfkDronV5zo4QQlugxbpvws+zL1uUVnH5E0mshU4GE7VEfJfnhwpZ7dv+c5N78k/2gm7u5oVqX4L8WtANvczO1xNONjqMmJ/47riT0s9R52PAAaJWNdXSR0qfCMMlshpuO/ysPSVKdFllXMT7JHFcBNf2nuWN2F/jlLnYX7wkKQn7WZ+gpBhhPzQ2JjbYXHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (10.152.16.51) by AM5EUR03HT063.eop-EUR03.prod.protection.outlook.com
 (10.152.17.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.16; Sun, 1 Sep
 2019 16:14:38 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com (10.152.16.51) by
 AM5EUR03FT031.mail.protection.outlook.com (10.152.16.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 16:14:38 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87]) by AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87%5]) with mapi id 15.20.2220.021; Sun, 1 Sep 2019
 16:14:38 +0000
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
Subject: [PATCH 1/5] drm: dw-hdmi: extract dw_hdmi_connector_update_edid()
Thread-Topic: [PATCH 1/5] drm: dw-hdmi: extract
 dw_hdmi_connector_update_edid()
Thread-Index: AQHVYOBa+gt+lOgjFEWqXGzvKljODQ==
Date:   Sun, 1 Sep 2019 16:14:38 +0000
Message-ID: <AM0PR06MB4004C3231CA859341E6CF8B9ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
References: <AM0PR06MB40049562E295DD62302C8DB7ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
In-Reply-To: <AM0PR06MB40049562E295DD62302C8DB7ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::32)
 To AM0PR06MB4004.eurprd06.prod.outlook.com (2603:10a6:208:b9::12)
x-incomingtopheadermarker: OriginalChecksum:F1ECB234EA06E1118480C8CA772F9979C2A14A33673757250464D489195B8BE6;UpperCasedChecksum:2F23F3DFF9C32C165CF49CEFCB7187F12D2B02DAC863E49B7FBB9671E8B71B94;SizeAsReceived:7995;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [AWGFRvZjHhoglXqlRsFM3Re0vav0xUWH]
x-microsoft-original-message-id: <20190901161426.1606-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR03HT063;
x-ms-traffictypediagnostic: AM5EUR03HT063:
x-microsoft-antispam-message-info: I6au+WBFuYG8wZbNlYp+TaLC3oNMojTwaMU+Jcs7jiszbPqKRs16mEHK4rtIePgx7Tsyx8cv4BG/vBF2IfgH9Lvn3u6TypJ5yrsE6OZ2b1GrE9zQYR67azJaMM8cmtq7SC0skurDFt2uEE+IBoBqtu+/32jKJJIwJi7vict8szzzzmJpOi2trE+ur4DiAEZg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 741be15a-ca1a-43fb-ae7e-08d72ef77ca2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2019 16:14:38.2258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract code that updates EDID into a dw_hdmi_connector_update_edid()
helper, it will be called from dw_hdmi_connector_detect().

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 521d689413c8..8ab214dc5ae7 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2171,7 +2171,8 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
 }
 
-static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
+static int dw_hdmi_connector_update_edid(struct drm_connector *connector,
+					  bool add_modes)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
@@ -2190,7 +2191,8 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
 		drm_connector_update_edid_property(connector, edid);
 		cec_notifier_set_phys_addr_from_edid(hdmi->cec_notifier, edid);
-		ret = drm_add_edid_modes(connector, edid);
+		if (add_modes)
+			ret = drm_add_edid_modes(connector, edid);
 		kfree(edid);
 	} else {
 		dev_dbg(hdmi->dev, "failed to get edid\n");
@@ -2199,6 +2201,11 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
+static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
+{
+	return dw_hdmi_connector_update_edid(connector, true);
+}
+
 static void dw_hdmi_connector_force(struct drm_connector *connector)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
-- 
2.17.1

