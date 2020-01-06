Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB2DC33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDC921744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgAFUtb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:49:31 -0500
Received: from mail-oln040092072034.outbound.protection.outlook.com ([40.92.72.34]:60757
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbgAFUt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:49:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTGtOHpCIjqvEW20jKHDItiMHIqATZb1FAx4axZfqGCiHyvhiinLp4sMMwDgVkq7dYL9E+4OJkEiR6USDcxee7T8wRWmB1BpeDfNcO7/h627ipvhRyfelIKUPwQlqsDkxwoqSh7DuISrMCRW36Lh1pM53Si9lZ8d8OqDSQCpPFNOdtJcEMSNDzfPJiE7CQoY++46vQbnNd90UnALSDu+CR48CDGWjiqjXJN3+tbN8RAW7VMqussBLKnDG9uX3O2KMECc9fTUIORsAvURkairAS01k91p6ayN83oeb2lHUzhu5pUBmJPbZIRc8T9iwlOMzhc4IyG1XEWTCHuimfA5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77VAQ6ltsxf1vmmJvDLdeb07Dja0Us6jfV4fVQe4U6g=;
 b=juiMwu79bDq8aRV5ifTWmGd/QunsMIUx0IYWwBuFIUJ/oVvwJjtrwBi40SJ7EnOsVCKLC3tFolsEy4yFpBxavC2xZaaowLgX0cPPxXNy+tVL0XiYf0MP3YRO29d5zbZeJLuGEC0LugJju55+hCAsdgNzNdhFflEKlYHrx4f4KT/HHlmr7RKiU11LLda18ZF0c1SzW9tPFbN3N89an9jINDONdJbIBYGyODzr+LbYJYgojc2DIeXVmqPk3mriTOZO34AAziZUquOGn/pfADecnySbJ4TRLHBXKm2fPy5aCFtXaZXQKYQRec/q4sV3S3pSSscx0GEt1Hz0E/Muu5YZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (10.152.18.56) by VE1EUR03HT174.eop-EUR03.prod.protection.outlook.com
 (10.152.19.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 20:49:26 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.18.51) by
 VE1EUR03FT047.mail.protection.outlook.com (10.152.19.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 20:49:26 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 20:49:26 +0000
Received: from bionic.localdomain (98.128.173.80) by AM6PR0202CA0044.eurprd02.prod.outlook.com (2603:10a6:20b:3a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 20:49:24 +0000
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
Subject: [PATCH 10/15] arm64: dts: rockchip: increase vop clock rate on rk3328
Thread-Topic: [PATCH 10/15] arm64: dts: rockchip: increase vop clock rate on
 rk3328
Thread-Index: AQHVxNLI2YBBKIutH0iqNWK3NiuMSg==
Date:   Mon, 6 Jan 2020 20:49:25 +0000
Message-ID: <HE1PR06MB40111D34406A43C1472C4B3DAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB4011254424EDB4485617513CAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20200106204914.6001-1-jonas@kwiboo.se>
In-Reply-To: <20200106204914.6001-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0044.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::21) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:F6A0113E209C19C1AC0E3B9BA6059377FE0A1BA6DAFCCC1FC9E6DFF6D5DD8E42;UpperCasedChecksum:40E4EED46AB85A325DD5358FDB91228939631B74F028AC975E6B3F15FBF5E7B5;SizeAsReceived:8189;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [KYN4liLaYG1opX/u099oZRxdPkq4XUs+]
x-microsoft-original-message-id: <20200106204914.6001-2-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 5bd42f31-0839-4153-9c2b-08d792e9ea2e
x-ms-traffictypediagnostic: VE1EUR03HT174:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBZByNdeeRdLfcVNBVcXl/LAqbRBFZKDgp0DQNfaUvfFGeZheGTQ12pL2Sc8sxZ0bBdn5GcAhsyo9N2y2zNvOGyofZIugS9ySNjN7iR7DIgH7SdkOSEfNCU4sQ8vLN2+jvFzoVeYIg871K6LcdD21HjGMTJR46lFHjL8oHDbNFsGcKKnXkLsnGZG++UdM5jt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd42f31-0839-4153-9c2b-08d792e9ea2e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 20:49:25.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VOP on RK3328 needs to run at higher rate in order to
produce a proper 3840x2160 signal.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 91306ebed4da..ee4b6170a9e6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -786,8 +786,8 @@
 			<0>, <24000000>,
 			<24000000>, <24000000>,
 			<15000000>, <15000000>,
-			<100000000>, <100000000>,
-			<100000000>, <100000000>,
+			<300000000>, <100000000>,
+			<400000000>, <100000000>,
 			<50000000>, <100000000>,
 			<100000000>, <100000000>,
 			<50000000>, <50000000>,
-- 
2.17.1

