Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A8C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16DB206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfIAQNG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:13:06 -0400
Received: from mail-oln040092071099.outbound.protection.outlook.com ([40.92.71.99]:36200
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfIAQNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 12:13:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rkhux6+AE/1DOHChi7fUlubTn3/6pSvBz/1rVnqovlg0oLFpSDyx2b2pyPfTsYWUftD5EAds1OQ5f8z2vLu4uYqtqylEbRAh/sobs4YuLGtYHtElytseivzkoj+ttQKqKdtKtbqeE5dproyXs+yDchetwwkRNh05VgrMfDyMhWRaVQOQzI99Q3Lgknz4HZObak721Vp9kYOiZFbUpRTErJdpgZj+rig/6ZCl+w2N8NaBdcRoFcFy+Q3GbcA143pT5CY1k6WqZAFF5023z3TTZiU45T+5L871OATB95v+Hroh3k5aRkMmZnMpQeDqwMhytTiqAkyUtQF7tNwQNDjXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLJtoCzDJNY/CcxNHHJl9o4t3FBNoV7rKe7pevnZ9m0=;
 b=AY7WLoSXV844bAgngg9zkkf9m5/4ahkUhUTD1hDukbsFtGr4W2OmdY02lieHCGhCgN48GUxIXjXgpeJIs4YhXiBeSNg/9PqWYnSG9QMcWAXwhRNywvJxmUQg4QIZHErf9Pr/H4Oot1Ks2r3NRgTm+HfvxdEcT1SXLWH5PxG+tDkGEdigF6vAEp4gL9UVXTzenxBxIqaNXQSErSjPmvA7cd4U0ns7+6BX++tE9VuEM4jzXylybRDfiy4S6fidOiY2DC99u+mDXDf42O4HyFB3QvzU1By2BPOwvjThJG+8VpOFNPSs8MRAxWizRFPDq28GHq6/zd81wal71K3aV5uV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (10.152.16.53) by AM5EUR03HT188.eop-EUR03.prod.protection.outlook.com
 (10.152.16.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.16; Sun, 1 Sep
 2019 16:13:02 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com (10.152.16.51) by
 AM5EUR03FT031.mail.protection.outlook.com (10.152.16.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 16:13:02 +0000
Received: from AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87]) by AM0PR06MB4004.eurprd06.prod.outlook.com
 ([fe80::f13e:4f8e:6777:bb87%5]) with mapi id 15.20.2220.021; Sun, 1 Sep 2019
 16:13:02 +0000
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
Subject: [PATCH 0/5] drm: dw-hdmi: update CEC phys addr, EDID and ELD on HPD
 event
Thread-Topic: [PATCH 0/5] drm: dw-hdmi: update CEC phys addr, EDID and ELD on
 HPD event
Thread-Index: AQHVYOAhowBdBz5xQkqSWjvcRAQJSg==
Date:   Sun, 1 Sep 2019 16:13:02 +0000
Message-ID: <AM0PR06MB40049562E295DD62302C8DB7ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0008.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::18) To AM0PR06MB4004.eurprd06.prod.outlook.com
 (2603:10a6:208:b9::12)
x-incomingtopheadermarker: OriginalChecksum:E4393DA71E2F410A12F8981015122C62AF4711F9ED2DFF715BC0D5C8D3F970C9;UpperCasedChecksum:F6DE029D5D00FC6FD7AEAE39E5F9E9D8625C04949083F24216688045CCD3EA41;SizeAsReceived:7840;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [a7AvW449qzZxs58lixq1hRuVn+jLdMQo]
x-microsoft-original-message-id: <20190901161251.1500-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR03HT188;
x-ms-traffictypediagnostic: AM5EUR03HT188:
x-microsoft-antispam-message-info: DRht/ZvSsUtZBQwTwt15AkWglj+1EvE3FQOK80HJ/2AoF+bFa+cYomVMFM6hJHtzeNRJ9+sRHtQRA+zE53HoM3MmT84a26/sYmvPu5rupVs0zxh7HJhT35KeZyLyLy8TnnPUG/a/98ElkowSZhzXyhVRsNNZjoP6XFkGC6PMc8By2FOzBL5v+LYiFBmLWCPQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c371f1c4-29dc-4be7-ed11-08d72ef74356
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2019 16:13:02.2351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series change dw-hdmi to update CEC phys addr, EDID and ELD on HPD event,
this fixes lost CEC phys addr and stale EDID/ELD when HDMI cable is
unplugged/replugged or AVR is powered on/off.

Patch 1 and 2 extracts code into a dw_hdmi_connector_update_edid() helper
and moves dw_hdmi_connector_detect() to be able to call this helper.

Patch 3 moves CEC phys addr invalidation from dw_hdmi_irq() to
dw_hdmi_connector_detect() and ensure connector EDID property gets updated.
I opted to not use cec_notifier_mutex after the move, please advise.

Patch 4 and 5 ensures ELD gets updated allowing userspace to query the latest
capabilities when a AVR is powered on and EDID gets updated.
This reverts a previous change to make drm_edid_to_eld() static, please advise.

Next step after this would be to add support for signaling
SNDRV_CTL_EVENT_MASK_VALUE to userspace when ELD changes.

Regards,
Jonas

Jonas Karlman (5):
  drm: dw-hdmi: extract dw_hdmi_connector_update_edid()
  drm: dw-hdmi: move dw_hdmi_connector_detect()
  drm: dw-hdmi: update CEC phys addr and EDID on HPD event
  Revert "drm/edid: make drm_edid_to_eld() static"
  drm: dw-hdmi: update ELD on HPD event

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 57 ++++++++++++++---------
 drivers/gpu/drm/drm_edid.c                |  5 +-
 include/drm/drm_edid.h                    |  1 +
 3 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.17.1

