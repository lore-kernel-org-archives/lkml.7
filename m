Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F48C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553AF21872
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfIAQOt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:14:49 -0400
Received: from mail-oln040092071065.outbound.protection.outlook.com ([40.92.71.65]:5276
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729058AbfIAQOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 12:14:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCBFol1FSo+jVaGGeDDFGryn1DV7XxRrKzg+jynplZfH/X331wW6694G89oMx5QnIwq6+tFbz6uih2MwbGLYZiiDqx92flwgcRQXEDc9r8yVNaIRAADSpk+uRuBZ5UF9Gq0ptQSqK+GeaFnbe9rV/1INHTEdJwwCsEmI0bf3R1W1LPtKlhsPSr4Q86EoPUsWH4IEGK8nGa9oFcPwCf3ieX1LR0Suzt9zGqQtyYJ99tfiaqCuJigYXvLMeABDwG87d33uasNPSGQMUxbADKP69CE6h6GPyPF0AaobLjYgQKYgt4iPt+n1CPU6tOlL6v+/jRjBcf9Djwnkucb2UAB6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tVyJsnYu/muSVK4U3I+XApY3wyLPrfPJchIW7TdulA=;
 b=VC6zOzDn46MIcsx6ke1dD+7AB+2srx5f/sr6eXYV2CCRWR/undN2iiOoV0vGhusqCyeaz0pNyqgsUCRqjYXY9PrzcIIdvEDnDQnlghtED8DaFNPtMGcLHGa5CZsS3Nn29nNemMfqaNYsmjLi0uNnkMYnJ2aZqdbQPbV23Y+xTPSOqqldAUHie0QXxEKWf35ULH6E3sOhq2WRJTAiZfGrtZtMURBuBjNieH8XN7B6DJY+wPh136YK39K5r/MKk7aKiBjXHYIp3M9C4zHcUsbpVFCzYt7Mt7wF9sVXUfcZxcblxLHTd2kVunPNN0IA2qJ9qAeLAhxGCK0EpsNmZx8yPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (10.152.16.54) by AM5EUR03HT176.eop-EUR03.prod.protection.outlook.com
 (10.152.17.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.16; Sun, 1 Sep
 2019 16:14:43 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com (10.152.16.51) by
 AM5EUR03FT031.mail.protection.outlook.com (10.152.16.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 16:14:43 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87]) by AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87%5]) with mapi id 15.20.2220.021; Sun, 1 Sep 2019
 16:14:43 +0000
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
Subject: [PATCH 5/5] drm: dw-hdmi: update ELD on HPD event
Thread-Topic: [PATCH 5/5] drm: dw-hdmi: update ELD on HPD event
Thread-Index: AQHVYOBdkwNWYL4fs06Sbdhw7LQShQ==
Date:   Sun, 1 Sep 2019 16:14:43 +0000
Message-ID: <AM0PR06MB4004F589E60DA4BA958FD316ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
References: <AM0PR06MB40049562E295DD62302C8DB7ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
 <20190901161426.1606-1-jonas@kwiboo.se>
In-Reply-To: <20190901161426.1606-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::32)
 To AM0PR06MB4004.eurprd06.prod.outlook.com (2603:10a6:208:b9::12)
x-incomingtopheadermarker: OriginalChecksum:19D77B1354EF3F02A9F8EE716E58885A525A7D27BB7CEB51996A298DCAEFA5DC;UpperCasedChecksum:63B0D6274CA04E015BA5AB2DFE8D3B7ECAACA3DEAA6B5846DC6F94129B9FAEE6;SizeAsReceived:7959;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [LDAB+wgiQHiH+8AK7nSWcgFSAtLnhZUO]
x-microsoft-original-message-id: <20190901161426.1606-5-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR03HT176;
x-ms-traffictypediagnostic: AM5EUR03HT176:
x-microsoft-antispam-message-info: 4RjpoEJcrk89gZdtEgSA2WDDlSbvxUtvPpx7urS02vhxKE1DqVA+6XLkb4KxOSr1ULDKywsEW5u+WHmd8zGG+2mvnqv5axP0KDrQ9whXMsQ+0XQ1xinsuMlGPmJ0RpnQtVc3NQUlFKFE4IyOyA4U9mbDa4f4zvs3FGRXs3TOSpGIvZuTpM214uOr+tPLu9H3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 281d4fbc-de83-47ac-359c-08d72ef77fd6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2019 16:14:43.6576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update connector ELD on HPD event, fixes stale ELD when
HDMI cable is unplugged/replugged or AVR is powered on/off.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0f07be1b5914..0a8268b20561 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2178,6 +2178,8 @@ static int dw_hdmi_connector_update_edid(struct drm_connector *connector,
 		cec_notifier_set_phys_addr_from_edid(hdmi->cec_notifier, edid);
 		if (add_modes)
 			ret = drm_add_edid_modes(connector, edid);
+		else
+			drm_edid_to_eld(connector, edid);
 		kfree(edid);
 	} else {
 		dev_dbg(hdmi->dev, "failed to get edid\n");
-- 
2.17.1

