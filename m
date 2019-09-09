Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CEBC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8061218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4j9gSV1r";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4j9gSV1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfIINnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:43:14 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:35249
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729438AbfIINnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U+Kp7j0Vten/8eIthI/ESn+K0b85q2UTsQo503LFUM=;
 b=4j9gSV1r+V7XlAhd/kOyysYAOdDg+D8LpxAxOllG593gPRs9iCrWJMNuAfSzeLOMFart36o7gDIy9eURxTUTTehLwTgrbQhLO54rLsMYsUN9o0FyScsCcHgp0eU+ely1qEAA4Q0ZUd2kX9sz0sLWG8eqsIFsgrZjDpFQG+ZCNuo=
Received: from DB7PR08CA0017.eurprd08.prod.outlook.com (2603:10a6:5:16::30) by
 DB6PR0802MB2359.eurprd08.prod.outlook.com (2603:10a6:4:88::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 13:43:08 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by DB7PR08CA0017.outlook.office365.com
 (2603:10a6:5:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14 via Frontend
 Transport; Mon, 9 Sep 2019 13:43:08 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14 via Frontend Transport; Mon, 9 Sep 2019 13:43:06 +0000
Received: ("Tessian outbound d0dc33d5ba29:v28"); Mon, 09 Sep 2019 13:43:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9ebc2e788f7d56d6
X-CR-MTA-TID: 64aa7808
Received: from 35bc2df2515b.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 79C46C8D-D20C-467E-9052-5127A5B0F7EE.1;
        Mon, 09 Sep 2019 13:42:55 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 35bc2df2515b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 09 Sep 2019 13:42:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMhR4WD3Bsuo0rqWNNSfl0RiBOcdulWtO77SxzFwv9fqoqozGUDebevEw/fb2XsbfZZ5P17FYHrqFtptquD38ASK5UCL8q8JCekg6UAiSYPvSMjXx3rhUrkla0xpiVE2+dCeeFUxfseKCuHN1WgdDs5TMRdpZH0/T5P9n4EXZ1VjXSKh1ugoN7Imrq7jY6rscPVCvVCRGVxjP9/gZd0Osjk3QX22S4sE5C67aPkzm3TCMOx/80YrgdN87t8CfV4QJS2WgfHvWSEMvYrdyIEuHpe11ZZX6SSlo72Hlo+pDU5OAunUNymgZb1Lbav2lWt1/eEn9QQjWFt7D8oj2ATYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U+Kp7j0Vten/8eIthI/ESn+K0b85q2UTsQo503LFUM=;
 b=HxCRcQ8j/51GUsMnniTiIpD2F7HmzPYY/gkSITAIy0cd0CkVH+g3B3KMgvVnVtIueBbTj5ZfTzrtdarNGBwxeAqwYDrtjOp3wvg3jk+9jCuMbhMIrjBLhIa1KMBtQskpGHBk1cTw9oGbWGgXA6CqTf4m64Hu6dOzay4d2FiAu7omymqw1sBDo1PuPrr2gpe/wkfLn/lgQ18kJOVOMhwNgsfIokC+euLKAcOWy9nqCPbKoQqyAK1W42wDoSJo3t7T4gszbsSMSNqjgpJquRA0WYNXz7Mjmcf31AQIAT3Kf+vjCn7FoXcY+yoV49k7Yde/nGdprzAUvKRyVXByEYqUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U+Kp7j0Vten/8eIthI/ESn+K0b85q2UTsQo503LFUM=;
 b=4j9gSV1r+V7XlAhd/kOyysYAOdDg+D8LpxAxOllG593gPRs9iCrWJMNuAfSzeLOMFart36o7gDIy9eURxTUTTehLwTgrbQhLO54rLsMYsUN9o0FyScsCcHgp0eU+ely1qEAA4Q0ZUd2kX9sz0sLWG8eqsIFsgrZjDpFQG+ZCNuo=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.212.135) by
 AM0PR08MB3793.eurprd08.prod.outlook.com (20.178.21.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 13:42:53 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::a820:853d:e981:a76c]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::a820:853d:e981:a76c%2]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 13:42:53 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [RFC PATCH] drm:- Add a modifier to denote 'protected' framebuffer
Thread-Topic: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
Thread-Index: AQHVZxR6T7KOwVbC3kmqPMMH1PUhIA==
Date:   Mon, 9 Sep 2019 13:42:53 +0000
Message-ID: <20190909134241.23297-1-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::18) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::7)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 77a7a6f9-7fe7-4d57-40c2-08d7352ba519
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB3793;
X-MS-TrafficTypeDiagnostic: AM0PR08MB3793:|AM0PR08MB3793:|DB6PR0802MB2359:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB23593822409EA54164B65470E4B70@DB6PR0802MB2359.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01559F388D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(476003)(81166006)(5024004)(256004)(316002)(186003)(6512007)(64756008)(66446008)(6436002)(66476007)(86362001)(66946007)(26005)(66556008)(2201001)(14444005)(52116002)(2906002)(6486002)(36756003)(71190400001)(71200400001)(99286004)(53936002)(3846002)(6116002)(386003)(102836004)(6506007)(7736002)(1076003)(2616005)(486006)(305945005)(14454004)(4326008)(5660300002)(25786009)(478600001)(81156014)(50226002)(8936002)(8676002)(66066001)(44832011)(110136005)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3793;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: MREsJVijiAVzR0+bFfjpfF6OqIM4gL1C5OyJr8ob1iLOFbn9B5QBW1wgSexwVtyC2h/TMIAtwv5dDsvJ5/vqLsiGH5yX0AafDkfnJVqT3e47YrKnbdqO6j7zh84tJAeV/wGOgB5WAlRygCtXflzHKMucbAAagIQuGcTdfNa1nSmurF5b+fa33aZccyyOTa4dPXKM6rUr8Azll++lFJirh28V8rKouxhgX23fTn5wxklasLChbvcI99/S2wzxlNJm2rWZ9fWd38j2ofzfxp7XwU7M7rsmHAMMqvDxAJqhoPAt9IxP6vy9Ax01cLqEQ4AKxXASi1zWoWuoXYrqGMogdbQQ0IymuLOIAeD/1wOhXllofX+G2rencAEo1qJcgPdTCYkGEt2WQ3VJdIrjzQj0t2PbId545aaiovqrUbh52+Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3793
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(189003)(199004)(50466002)(26826003)(70586007)(2906002)(76130400001)(22756006)(70206006)(6486002)(6512007)(102836004)(81166006)(81156014)(186003)(4326008)(8746002)(476003)(99286004)(8936002)(486006)(2616005)(25786009)(36756003)(86362001)(336012)(8676002)(6506007)(50226002)(26005)(386003)(2201001)(63370400001)(63350400001)(7736002)(110136005)(478600001)(305945005)(126002)(14444005)(5024004)(356004)(36906005)(3846002)(66066001)(47776003)(6116002)(5660300002)(23756003)(1076003)(316002)(14454004)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2359;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5ff8026c-0ddf-48d9-2a8b-08d7352b9cf5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR0802MB2359;
NoDisclaimer: True
X-Forefront-PRVS: 01559F388D
X-Microsoft-Antispam-Message-Info: F4sbbcEB9KXcz0PXeflN3DYu3IjXSD1z1GtADSMXuGcGSjAAlQUY1ivXoF7ZcceH57fHrXki77hEHN/J8YTLHBu+UfglsNrgIo7q9coX/d+GunepX2+Dj6BCxS68soVRMx7rDnYtIycha9JM9/pQFPUxJRhi6xeq0XfgsKzPTp0liZXz049M9TMtenJce/HPH9n9R1dJfjG5+Owb5rlndKvB3kfiNly1uvXuCuJIPxHxdloLSczD2wGdx8wEKStjNOOJNEhs3bkaZ3o/n3OldEfJ6aGOEiCDjKW4odSi1Es3P2g0BmiI33Xb/4LeLDaWgWcxhXcQBRy9Arc8t2DaqNDQE+26oVxoa9tEZXOENUuTSwCyH/ZdjA7r/m7es1GZGVhyD/aSY7JLRONePWKIAxYjIkoEi67igYI29lEctC4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2019 13:43:06.4845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a7a6f9-7fe7-4d57-40c2-08d7352ba519
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a modifier 'DRM_FORMAT_MOD_ARM_PROTECTED' which denotes that the frameb=
uffer
is allocated in a protected system memory.
Essentially, we want to support EGL_EXT_protected_content in our komeda dri=
ver.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

/-- Note to reviewer
Komeda driver is capable of rendering DRM (Digital Rights Management) prote=
cted
content. The DRM content is stored in a framebuffer allocated in system mem=
ory
(which needs some special hardware signals for access).

Let us ignore how the protected system memory is allocated and for the scop=
e of
this discussion, we want to figure out the best way possible for the usersp=
ace
to communicate to the drm driver to turn the protected mode on (for accessi=
ng the
framebuffer with the DRM content) or off.

The possible ways by which the userspace could achieve this is via:-

1. Modifiers :- This looks to me the best way by which the userspace can
communicate to the kernel to turn the protected mode on for the komeda driv=
er
as it is going to access one of the protected framebuffers. The only proble=
m is
that the current modifiers describe the tiling/compression format. However,=
 it
does not hurt to extend the meaning of modifiers to denote other attributes=
 of
the framebuffer as well.

The other reason is that on Android, we get an info from Gralloc
(GRALLOC_USAGE_PROTECTED) which tells us that the buffer is protected. This=
 can
be used to set up the modifier/s (AddFB2) during framebuffer creation.

2. Framebuffer flags :- As of today, this can be one of the two values
ie (DRM_MODE_FB_INTERLACED/DRM_MODE_FB_MODIFIERS). Unlike modifiers, the dr=
m
framebuffer flags are generic to the drm subsystem and ideally we should no=
t
introduce any driver specific constraint/feature.

3. Connector property:- I could see the following properties used for DRM
protected content:-
DRM_MODE_CONTENT_PROTECTION_DESIRED / ENABLED :- "This property is used by
userspace to request the kernel protect future content communicated over
the link". Clearly, we are not concerned with the protection attributes of =
the
transmitter. So, we cannot use this property for our case.

4. DRM plane property:- Again, we want to communicate that the framebuffer(=
which
can be attached to any plane) is protected. So introducing a new plane prop=
erty
does not help.

5. DRM crtc property:- For the same reason as above, introducing a new crtc
property does not help.

--/

---
 include/uapi/drm/drm_fourcc.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 3feeaa3f987a..38e5e81d11fe 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -742,6 +742,15 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
=20
+/*
+ * Protected framebuffer
+ *
+ * The framebuffer is allocated in a protected system memory which can be =
accessed
+ * via some special hardware signals from the dpu. This is used to support
+ * 'GRALLOC_USAGE_PROTECTED' in our framebuffer for EGL_EXT_protected_cont=
ent.
+ */
+#define DRM_FORMAT_MOD_ARM_PROTECTED	fourcc_mod_code(ARM, (1ULL << 55))
+
 /*
  * Allwinner tiled modifier
  *
--=20
2.23.0

