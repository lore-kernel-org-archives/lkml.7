Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE79ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF4621920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ss9vkVBM";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ss9vkVBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbfJAOWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:22:01 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:12701
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388942AbfJAOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfw2sf2si3Nv0iHorWaRwlKjiK8IurKK498KgNpOP6Y=;
 b=Ss9vkVBMXO2QGntX2fvGSQdIL8AQT/I/CT4hr8DrKYWLXudKFgg5Rvwkqf9wB7u/tIY2vZBxwBbcuk81MaQ4dFIoLRheBeNI7NXP7tTKHUtXk4DvuSdtoMJZHXBQfQ9DhNg7OTf0NkuG7RM/SNr6m+jzmCfDOOVRCAkBQ2wmdbA=
Received: from HE1PR0802CA0016.eurprd08.prod.outlook.com (2603:10a6:3:bd::26)
 by AM0PR08MB5090.eurprd08.prod.outlook.com (2603:10a6:208:15c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Tue, 1 Oct
 2019 14:21:54 +0000
Received: from VE1EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by HE1PR0802CA0016.outlook.office365.com
 (2603:10a6:3:bd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Tue, 1 Oct 2019 14:21:54 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT014.mail.protection.outlook.com (10.152.19.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 1 Oct 2019 14:21:52 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Tue, 01 Oct 2019 14:21:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b0146f8dab5cec7e
X-CR-MTA-TID: 64aa7808
Received: from 8e07f4a7b67a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 61B73AB9-26D4-4915-92E6-F645E6A410B8.1;
        Tue, 01 Oct 2019 14:21:42 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8e07f4a7b67a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 01 Oct 2019 14:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3yA57ehSL/PNAvmjtzej3gyYX91Fc7beDpzoVA7WN0+wGhx5eevXexwjRW49g9Jog3fWg42DwBTFYeTn3nGPIXUusF800TZC0AWAnyn+uHh/FWsyx+zQWYxqe1MZx6q5xh4dLaBaMOUeGWIJwz+q5qJOpiph6Xqbnk+hQD8iv11XPuTZLnRQDhGzATdlkJ8mB1Z0/g5PS0DLxUP+Fr1dP0xNqSsoxnZR3/MCx4ZXk1/2fwHNqszZjOM6hy3o1+QjDVOEwynr3pjNZZzpI81XYBio9A/LIyBQWpxLembMftQGwRgcSwYI0st6T7lKhSg0kUPMiYdMd5hiSRwT8aJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfw2sf2si3Nv0iHorWaRwlKjiK8IurKK498KgNpOP6Y=;
 b=GDzLaA2aJV09XDjIgU4qL2bHO6sdemCU2974ibDIWj8YOr2YjR+2DtiQ0xuBGMzOcsrS3uXLrsqLcD+kh8W20fmTtaJZaxghnMrxXleGqAhgkdl8S0rUDf4VrNOmOFW7ugNcFDV35xO4W1tXdjDSvX5FWy1jRDQ5oclWx8mkjjcgKT2Ec2HNATv/UWx2dEmpZAynyyB8XSoSrVRh/JGtoasqS0ut7bGU3vAKVAyMwuzVMchFZO5Rp5LPMjHJZ1MVy8TzBoqZXaaB4g88EoBoiRB53r3XbjCMgPb8uMDLY72w2/5QvRBgb1dtT1nvhlAloy2jQI7EaoD5Vl91OWczmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfw2sf2si3Nv0iHorWaRwlKjiK8IurKK498KgNpOP6Y=;
 b=Ss9vkVBMXO2QGntX2fvGSQdIL8AQT/I/CT4hr8DrKYWLXudKFgg5Rvwkqf9wB7u/tIY2vZBxwBbcuk81MaQ4dFIoLRheBeNI7NXP7tTKHUtXk4DvuSdtoMJZHXBQfQ9DhNg7OTf0NkuG7RM/SNr6m+jzmCfDOOVRCAkBQ2wmdbA=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4350.eurprd08.prod.outlook.com (20.179.27.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 14:21:40 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 14:21:40 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 RESEND] drm/komeda: Workaround for broken FLIP_COMPLETE
 timestamps
Thread-Topic: [PATCH v2 RESEND] drm/komeda: Workaround for broken
 FLIP_COMPLETE timestamps
Thread-Index: AQHVeGOLfzM60ocEQ0aSA9ftqtg50Q==
Date:   Tue, 1 Oct 2019 14:21:40 +0000
Message-ID: <20191001142121.13939-1-mihail.atanassov@arm.com>
References: <20190923101017.35114-1-mihail.atanassov@arm.com>
In-Reply-To: <20190923101017.35114-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::31) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b2fabab6-32ba-42a1-4ec1-08d7467ab4ae
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4350:|VI1PR08MB4350:|AM0PR08MB5090:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB509073AA7D1DCFF2CF76F8E18F9D0@AM0PR08MB5090.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 0177904E6B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(6512007)(305945005)(66066001)(446003)(2501003)(11346002)(2906002)(36756003)(54906003)(7736002)(6486002)(316002)(4326008)(6306002)(2616005)(5640700003)(476003)(2351001)(486006)(44832011)(256004)(14444005)(478600001)(6436002)(52116002)(1076003)(99286004)(6916009)(76176011)(66946007)(64756008)(66446008)(66556008)(8936002)(66476007)(386003)(102836004)(71190400001)(71200400001)(5660300002)(50226002)(6116002)(3846002)(26005)(86362001)(186003)(6506007)(8676002)(14454004)(81156014)(81166006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4350;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tpz8KFK97e9mXWTPAuP5J0bXrMPhWCtDSm18DJXiwrQwtEdhnjVqWAzXoOoZn1bqEO+0rgMyBk3r6N4JZAS+rw4JZY0tknM7TV7o0yF+jJYTiPnegEDSKn3QiwLzsx9W79QWAHyRvcP7MXc3zAUTfDIJ5lFBie3+PScl9Cxy4HVjEzyfmurvl4JIapvI+q86feKUTvNjz/C15BoRb4R9BblWeopTAhGFX9H1tysvbgvUB0hrOTLchk3F//u11GtZJ8SylhO3dr36x1PdqKIQydYjQztD/QihFFBQmYb2oc3NCT7XiTGXkqbl0LWeM3KuWqqCRrRegzo9/FeFT/h5NxhmqboUpv4h6KTr/oq7r81WtDFGY0CbqJzXlqGRrvfjHOJl/EI/s2WLyGdhsxHVxEJSC5QX9YRBlfsVYhpOJJQ6mEfHHU+46iD6VQM+7Ud0F5t9L00eWgBXn+WOERTG5w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4350
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(70586007)(2351001)(25786009)(36756003)(50466002)(81166006)(70206006)(76130400001)(5660300002)(1076003)(6306002)(356004)(8746002)(86362001)(478600001)(4326008)(6512007)(8676002)(5640700003)(2501003)(26826003)(305945005)(8936002)(81156014)(3846002)(14454004)(7736002)(6862004)(14444005)(486006)(2906002)(11346002)(446003)(66066001)(6486002)(63350400001)(126002)(316002)(76176011)(386003)(6506007)(186003)(336012)(6116002)(2616005)(50226002)(99286004)(476003)(54906003)(22756006)(23756003)(102836004)(26005)(36906005)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5090;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 985c1580-a18c-43f5-77e2-08d7467aad68
NoDisclaimer: True
X-Forefront-PRVS: 0177904E6B
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vf6RMjXZBROKJAgkKnk4R8ej2RWxvWl58WNhxYdecVZ07sUWntx8BTzXMIk3ne9FU+1qgdf8zGxgvjBrWVut1Foc4CNhp8vm05dEBwk76QD5kl6EbxmQWfBzvsVdukY00jjGlA41z4N3KktSkrfRFYkSXXtRImc8KKanybiXt+cUyuOIeufCg1U4oTrSoOJ4iGllXe3IELTVLingwz2J3IUcdGldGhCSXJZa2hKz9cCEqjoVhCGt05Rfm3BGZ89v/oqWxBe2MMtFSfRbrbySGodWSfhAcC5W/bmcDEiZU6nAUnhii+Dz2FJsD1P2nLwDH2Y8tVUSHYD160Bom0QIXAC8XwUAYxUHntFzqo4f0kBJXm9BJHkj/muxvr7+avRwclLaK9wQXO4fJE/MBcPrmJC5uISBbAjLshW9OYfKWzW49zkebjA6f8KxhDPVVg4mGfsCH8ql5hc5qC/gsTOXFw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2019 14:21:52.6370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fabab6-32ba-42a1-4ec1-08d7467ab4ae
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initially turning a crtc on, drm_reset_vblank_timestamp will
set the vblank timestamp to 0 for any driver that doesn't provide
a ->get_vblank_timestamp() hook.

Unfortunately, the FLIP_COMPLETE event depends on that timestamp,
and the only way to regenerate a valid one is to have vblank
interrupts enabled and have a valid in-ISR call to
drm_crtc_handle_vblank.

Additionally, if the user doesn't request vblanks but _does_ request
FLIP_COMPLETE events, we still don't have a good timestamp: it'll be the
same stamp as the last vblank one.

Work around the issue by always enabling vblanks when the CRTC is on.
Reducing the amount of time that PL0 has to be unmasked would be nice to
fix at a later time.

Changes since v1 [https://patchwork.freedesktop.org/patch/331727/]:
 - moved drm_crtc_vblank_put call to the ->atomic_disable() hook

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
---
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 9ca5dbfd0723..75263d8cd0bd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -249,6 +249,7 @@ komeda_crtc_atomic_enable(struct drm_crtc *crtc,
 {
 	komeda_crtc_prepare(to_kcrtc(crtc));
 	drm_crtc_vblank_on(crtc);
+	WARN_ON(drm_crtc_vblank_get(crtc));
 	komeda_crtc_do_flush(crtc, old);
 }
=20
@@ -341,6 +342,7 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
 		komeda_crtc_flush_and_wait_for_flip_done(kcrtc, disable_done);
 	}
=20
+	drm_crtc_vblank_put(crtc);
 	drm_crtc_vblank_off(crtc);
 	komeda_crtc_unprepare(kcrtc);
 }
--=20
2.23.0

