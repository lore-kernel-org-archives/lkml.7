Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F07C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0601D21872
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfIAQOz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:14:55 -0400
Received: from mail-oln040092072097.outbound.protection.outlook.com ([40.92.72.97]:38818
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728987AbfIAQOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 12:14:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQz4wZyNJrmnGXCDKOXuoiHHuvldMnNO2Z7HdgUzvjDWKiWBUDbEEiJ6v3NXfN/5LXPs0wLSxjnGzkmW7AAMhUn1F3g7+afvTp1BZcq5rBqmIcXU6pq0ri0gjK5SmyHi2v0hnyVFOCBIHS24qBCz70o13zLGJbStabL5iBk5FM8xa+6FwLE5dSnfVqJE5QYR/wFkHFfqmI9pQ31SKv/ZwCC2spQkjcY5jJM0N4+NAjYTANmxwpCG5roy96Qs3/uviv1O+A/NdaCxqp7DHhMBXzbsSo2U3knKI8ULh8b/X2wRxeyneoF538IcT1g9E9hjI1aD18Q7iLuEeZA3in5hZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7+j1nmikidvbNuu5X4+/mCMSmolAUwcL80L9V6+pUk=;
 b=lSd3XQDB93uMb76BrL6t7PZJkAwbjvUQGlVvVXgv3HBmLSQiq0ALwBqKxnML/oiRP5DD4CofVJYiSexrbwpCNL5jRseGG60PgxGrkXV5UXp245O0UloezZCk6jwuQJ8lIcOyFYOV9fvljXWM8U62elx1NhON/JNJcEYSeohKgD1QarvRleluypjad3AaIyjetl7yHC8ucpmOzaPdDrgdz26xUo2Hn/AFcavHBusq+8i07HP+Kv66oP9dZEpVO0qMqXjVPANY5kEJUk2vH2XlDTc+BjdTbIlu4eAG7BgNavX5gI6THrR+0i+rzNtQGXd+PwShum6D6rbF7usa3W1oUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (10.152.16.51) by AM5EUR03HT010.eop-EUR03.prod.protection.outlook.com
 (10.152.16.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.16; Sun, 1 Sep
 2019 16:14:42 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com (10.152.16.51) by
 AM5EUR03FT031.mail.protection.outlook.com (10.152.16.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 16:14:42 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87]) by AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87%5]) with mapi id 15.20.2220.021; Sun, 1 Sep 2019
 16:14:42 +0000
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
Subject: [PATCH 4/5] Revert "drm/edid: make drm_edid_to_eld() static"
Thread-Topic: [PATCH 4/5] Revert "drm/edid: make drm_edid_to_eld() static"
Thread-Index: AQHVYOBcGargGv3pdUKSwYRRFKPbWw==
Date:   Sun, 1 Sep 2019 16:14:41 +0000
Message-ID: <AM0PR06MB4004968EE64C136494040B7AACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
References: <AM0PR06MB40049562E295DD62302C8DB7ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
 <20190901161426.1606-1-jonas@kwiboo.se>
In-Reply-To: <20190901161426.1606-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::32)
 To AM0PR06MB4004.eurprd06.prod.outlook.com (2603:10a6:208:b9::12)
x-incomingtopheadermarker: OriginalChecksum:A876AAF0C97CFF5DEEAEDE94252B9F3B16BFE03E299D28D6D889942E980504EE;UpperCasedChecksum:A2A9ED068A7714748BDC405D4FD51D91EA52804D0B81BDF848E961FB1FEB78D7;SizeAsReceived:7997;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [jsfD4U4z9ssKIvMd5aUK+zRaIHoInldo]
x-microsoft-original-message-id: <20190901161426.1606-4-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR03HT010;
x-ms-traffictypediagnostic: AM5EUR03HT010:
x-microsoft-antispam-message-info: D1eB9Lp9oz3SLvTRK0Uiy4yyhGP0QuwAU85eub396NwfCbpYDlBZuVWhIpFokAe9lldeThJZkA/KkqrQpHaoXqtANY66CmSvSZpnAuRwCnAjgSgoLdYXB2jfNDrR/bh65dc2mMQgnPGdVrrHVg/7m31vvm0IjR1QXz4tUuylPnQ/hVdBMIpvpFPj1J1z6r45
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c0453a07-a331-48d7-bb60-08d72ef77eb8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2019 16:14:42.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_edid_to_eld() is needed to update stale connector ELD on HPD event.

This reverts part of commit 79436a1c9bcc ("drm/edid: make drm_edid_to_eld() static").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/drm_edid.c | 5 +++--
 include/drm/drm_edid.h     | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 82a4ceed3fcf..47c409af0903 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4069,7 +4069,7 @@ static void clear_eld(struct drm_connector *connector)
 	connector->audio_latency[1] = 0;
 }
 
-/*
+/**
  * drm_edid_to_eld - build ELD from EDID
  * @connector: connector corresponding to the HDMI/DP sink
  * @edid: EDID to parse
@@ -4077,7 +4077,7 @@ static void clear_eld(struct drm_connector *connector)
  * Fill the ELD (EDID-Like Data) buffer for passing to the audio driver. The
  * HDCP and Port_ID ELD fields are left for the graphics driver to fill in.
  */
-static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
+void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 {
 	uint8_t *eld = connector->eld;
 	u8 *cea;
@@ -4162,6 +4162,7 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 	DRM_DEBUG_KMS("ELD size %d, SAD count %d\n",
 		      drm_eld_size(eld), total_sad_count);
 }
+EXPORT_SYMBOL(drm_edid_to_eld);
 
 /**
  * drm_edid_to_sad - extracts SADs from EDID
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index b9719418c3d2..49987818fe23 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -337,6 +337,7 @@ struct drm_connector;
 struct drm_connector_state;
 struct drm_display_mode;
 
+void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid);
 int drm_edid_to_sad(struct edid *edid, struct cea_sad **sads);
 int drm_edid_to_speaker_allocation(struct edid *edid, u8 **sadb);
 int drm_av_sync_delay(struct drm_connector *connector,
-- 
2.17.1

