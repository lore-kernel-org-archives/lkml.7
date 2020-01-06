Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0586EC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C913F21744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgAFUsd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:48:33 -0500
Received: from mail-oln040092069103.outbound.protection.outlook.com ([40.92.69.103]:45550
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbgAFUs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:48:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLkDw4LO6rpf1luGNS0wuPa/R7WOqPb2jW20EVJKiMFuVnH7NHHZHt5MGqyfVGX9bT8Xf7wYqyTuKP6N1F/m46wgvO5ghBiIzC6qol9iPUYpDlyRsLwGa923tBnuyfO3aUDKhn0MIx/taL4fLG+uktoKrpPo6u6lbZETpd7lpkfMmsjTlj52z5610Km4wBY0iduaqLAiyrucGCBKcUXKjTCR8xm9n8XaVFDIfYeI0IWSs/EVdgQyz1Iz2wAyF5QTLvNebf8hqRgy6rXAUG7ZhG1S4jZQbRAvC0VRZEmghpm6RvTlSGOyehU4IvhxYx+Iexad6Yg4xk9Z/R7FC+kCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ1HU4GgOzE2q6VcTb2rNrG1Uxl4PqbCo6wRUzlb+pU=;
 b=VOlJO4UMFdys0/g/AyZZp9wIrcqSbk4H3dJSoSwTnF6eaRMLo+9PYxIMywQFd9BxWmFKiCQFmET95uvXmC6C3DelusqGGtOwF4+syCUHXatV+3E2poQewjHGr6/h2g5xEq7Qd1sCLKfCwzTFBhDcSUgyNISfZk8dHweVUKLgNmGd9RtYCm75puMaHhDXEGPMGjtHYkO5CwYY5lgLk1bJEKFquIExy7+cZLuFvOllhwZpwbDE4biCo6UbRUlraz24EDcSY3npwWp0Th2KFpMz2Mjzb0HhthM7UgaB+QuoQp1syVVgcYys6AiF9poQ88xeU8s6iDmqDMgMNVUusTxgpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (10.152.12.58) by VE1EUR02HT176.eop-EUR02.prod.protection.outlook.com
 (10.152.12.237) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 20:48:25 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.12.60) by
 VE1EUR02FT060.mail.protection.outlook.com (10.152.13.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 20:48:25 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 20:48:25 +0000
Received: from bionic.localdomain (98.128.173.80) by BEXP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 20:48:24 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
CC:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zheng Yang <zhengyang@rock-chips.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/15] drm/rockchip: vop: limit resolution width to 3840
Thread-Topic: [PATCH 06/15] drm/rockchip: vop: limit resolution width to 3840
Thread-Index: AQHVxNKkwe23wXzA60yXF+y5CyRgVg==
Date:   Mon, 6 Jan 2020 20:48:25 +0000
Message-ID: <HE1PR06MB40111E90F5DA4718126E6A92AC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB4011254424EDB4485617513CAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20200106204812.5944-1-jonas@kwiboo.se>
In-Reply-To: <20200106204812.5944-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BEXP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::14)
 To HE1PR06MB4011.eurprd06.prod.outlook.com (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:15B96F3D54902A85D3878E2BE3FCE0CF15F9BF7CFD3C14DFD77878E3A1B7693A;UpperCasedChecksum:0E394DAED4A4CB10C0E225483B0D20F45B66EC475A8C6C794130379A063EE418;SizeAsReceived:8127;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [CPq4U8hH96g/DHwsOcZ/civnrMCdwfXV]
x-microsoft-original-message-id: <20200106204812.5944-2-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 12084a39-96a1-4ef9-a87a-08d792e9c647
x-ms-traffictypediagnostic: VE1EUR02HT176:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m9455D6ZUFOKswWQkACY7t1heILE5uPHfTbYYE9Rc5TZkmLUMO7U/daxwHPE0q5Alr0S4HeqgTWZ2p+Gcm2lDQIrGcj1uYSkwUtxa/zyDo/HMEapwxt/PnBGaA9fAwzkaLydudh7uTD4TbmLHIky8NLoET2OA2UKZxtDtyZh7bnROmEFitl0RRTXfx4TMS5z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 12084a39-96a1-4ef9-a87a-08d792e9c647
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 20:48:25.1852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a destination width that is more then 3840 pixels
is not supported in scl_vop_cal_scl_fac().

Work around this limitation by filtering all modes with
a width above 3840 pixels.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index d04b3492bdac..f181897cbfad 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1036,6 +1036,15 @@ static void vop_crtc_disable_vblank(struct drm_crtc *crtc)
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
+enum drm_mode_status vop_crtc_mode_valid(struct drm_crtc *crtc,
+					 const struct drm_display_mode *mode)
+{
+	if (mode->hdisplay > 3840)
+		return MODE_BAD_HVALUE;
+
+	return MODE_OK;
+}
+
 static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 				const struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
@@ -1377,6 +1386,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
+	.mode_valid = vop_crtc_mode_valid,
 	.mode_fixup = vop_crtc_mode_fixup,
 	.atomic_check = vop_crtc_atomic_check,
 	.atomic_begin = vop_crtc_atomic_begin,
-- 
2.17.1

