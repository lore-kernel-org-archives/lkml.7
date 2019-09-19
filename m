Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D020C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B79421D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Oof3RtY5";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Oof3RtY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389991AbfISNaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:30:24 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:59765
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388721AbfISNaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9I+5xCgF7GzoOP7Rozly63quyjihAUCy1HrvQlGWj8=;
 b=Oof3RtY5t0OsqzEugsK9f9kXXpXPmjmGiZUyBRr9HeIcwy+GgOEOOX3DnSIlfQPe+eRXrM1DXtZzzccAt+10EhiTYPniW1o4bWq1MZob/Iy6x6kU6seiVhhWEm185HHbX8RZ2ZT1ZrET6q1Ng5mlvD1u5/IJ3J2Z84saKkR6ZNk=
Received: from VI1PR08CA0127.eurprd08.prod.outlook.com (2603:10a6:800:d4::29)
 by VI1PR08MB3120.eurprd08.prod.outlook.com (2603:10a6:803:46::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21; Thu, 19 Sep
 2019 13:30:16 +0000
Received: from VE1EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VI1PR08CA0127.outlook.office365.com
 (2603:10a6:800:d4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.21 via Frontend
 Transport; Thu, 19 Sep 2019 13:30:16 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT054.mail.protection.outlook.com (10.152.19.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 13:30:14 +0000
Received: ("Tessian outbound 968ab6b62146:v31"); Thu, 19 Sep 2019 13:30:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e39eb3f5e2db9d4b
X-CR-MTA-TID: 64aa7808
Received: from 89a7ef77e105.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B6C1D978-6BE4-4BC7-8366-47303AC00B9A.1;
        Thu, 19 Sep 2019 13:30:04 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 89a7ef77e105.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 19 Sep 2019 13:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fbnfar14x+TN/yvAhpH/dTYMLqVHoeMB5jk7LlKghTwrnKIKo0GdcJgj46ymwQnpW0jwBz0+Q4EYWmyAkjKqUPNB1NOR9ss6NifRsXkVT7EjWJEz4hG6ogv+qn56WfcofOWt5UJnxiUfAPdn1e5XJpIgYvv1skFAfT49Gkv6+C/NmFtoG3ALhlJnZ7Wf5vuFCq81G5shFtTvm31RMdk4m7A5MlPBtNlQ+72m9HsIB68lonZh6B+3FyglhrK3qs6mtF7mk4kc3jpUJLdsxXObhg2Oe/8q5Q7ZKCtz2y/IpuNyheiMr9AevsLEQdGHN9t5AAoa1iSTvdQc/RtdwWmqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9I+5xCgF7GzoOP7Rozly63quyjihAUCy1HrvQlGWj8=;
 b=JXd+DJuyjPNnkDYDz65KkdVUIgQzxFRywBozbLF3ZEIvmZtse2ZqLX4g6+gPkoo+edemNPewsVQmhPQ1nrQZoSj1Ye+GIkbOmu9vmuAJ4OJYueFNU5aPxi6xalsLuHqdR92EkC1y3Ks5iIaw85o/jEOWFzJfKAAMr+ed6Adubm8gjCH0imYRATj7QBQKFoA7lZDoVp7KcQN1nSjLO3yDnNB1liJxnNeqmSrTrDSor0VvbJCcLmp5YVMk6tnrcSQ1+YROn8QUiNCWN7VUX617uoPV1in3qQkd24mw3r7aPivdCzORiGIXLSsjcFz1bb07/h0tYemLZuu6+LEwvTEZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9I+5xCgF7GzoOP7Rozly63quyjihAUCy1HrvQlGWj8=;
 b=Oof3RtY5t0OsqzEugsK9f9kXXpXPmjmGiZUyBRr9HeIcwy+GgOEOOX3DnSIlfQPe+eRXrM1DXtZzzccAt+10EhiTYPniW1o4bWq1MZob/Iy6x6kU6seiVhhWEm185HHbX8RZ2ZT1ZrET6q1Ng5mlvD1u5/IJ3J2Z84saKkR6ZNk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB5376.eurprd08.prod.outlook.com (52.133.244.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 13:30:03 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f%7]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 13:30:03 +0000
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
Subject: [PATCH] drm/komeda: Fix FLIP_COMPLETE timestamp on CRTC enable
Thread-Topic: [PATCH] drm/komeda: Fix FLIP_COMPLETE timestamp on CRTC enable
Thread-Index: AQHVbu5XybbezBNH+kaEyHcWelehfw==
Date:   Thu, 19 Sep 2019 13:30:02 +0000
Message-ID: <20190919132759.18358-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a17cc2fb-72be-4819-0319-08d73d058157
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB5376;
X-MS-TrafficTypeDiagnostic: VI1PR08MB5376:|VI1PR08MB5376:|VI1PR08MB3120:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB312071200CD548CCBCE387908F890@VI1PR08MB3120.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 016572D96D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(6916009)(6486002)(25786009)(476003)(6116002)(66066001)(99286004)(71200400001)(71190400001)(6436002)(6512007)(7736002)(2501003)(50226002)(186003)(86362001)(2616005)(26005)(4326008)(8676002)(81156014)(66556008)(66446008)(305945005)(486006)(386003)(5640700003)(316002)(44832011)(478600001)(8936002)(102836004)(1076003)(6506007)(2351001)(54906003)(66476007)(3846002)(2906002)(5660300002)(256004)(14454004)(66946007)(36756003)(81166006)(64756008)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5376;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 821jgBgaCEODxjT3BMGCDKb9ct2ZvvtxDysN711bzYSBrc9M4c87jNsaax68BnCnFHoijHXT2h/VaAYeLW9UM5YYWBZNBv01u8Wora4r87P6qpQmaZHuK1ASCXo3s1tNRaKICrdE+98V/ys4iqVJQpsBrIABWVR/19AISKQ89NPVb7gQp6wf2rFQQHJRpBRC2EtYGtqIhT/mcLPF/s67+TeVBBe9HhCeIBSjXcqLCjr210DtnNGwBCvx676mtphtvdxufWQ2yQuMSzOk5xta1ZAdg2v3GIzT67VcQq66erWmg4uGTyn0k9C4Y9RpotEkUgeeG/GbBPAGAWBaJlNGvCBEIHSXWaZkctIWaNVqES4R1V6LidvfFls4a5mkBEKUYep6eLf7OkKHQySAUJ3fBAlLZbhbEqdXJlAUOWfjotE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5376
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(54906003)(5640700003)(6512007)(76130400001)(6486002)(316002)(23756003)(36756003)(50226002)(6862004)(2351001)(486006)(126002)(2501003)(8746002)(8936002)(81166006)(70206006)(70586007)(8676002)(36906005)(81156014)(63350400001)(25786009)(99286004)(5660300002)(66066001)(14454004)(305945005)(7736002)(26826003)(478600001)(50466002)(47776003)(86362001)(2616005)(1076003)(26005)(386003)(6506007)(102836004)(186003)(356004)(22756006)(476003)(6116002)(3846002)(2906002)(4326008)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3120;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8cf62777-ffce-496a-7fa8-08d73d057a00
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3120;
NoDisclaimer: True
X-Forefront-PRVS: 016572D96D
X-Microsoft-Antispam-Message-Info: aa1X6aH2kll71GQCsS0qoo/TSo4nfZoDBx154Cm9+y+dJ+SCPwTtaRfiVvU0hgf7P0Ya+SwejAt/eAI2oQvRskusS24jkrALUuIlexDa6en4EgtGSUtFPI9cJfA6ImZd7Jl65nk4t+6dO3GAWF/SYG934reV6j9wC4OIuuCB9SQhdJlqWqLDv4Y9hUkZI/cGONlFr/WdRrNZHxRkFm6dqo43JcCAgi7WDmxat4etsHZdS5qRSViBwPyAaoiAb7cjbWaKGF7dvxrW1pfydPMwlY6IF63c3+w0yBXljdFiELM00wxPxWKWc9Ju//khe1YEPrglRatEuhIZPF8ewFmGC1WeIHF603SWlh0ZzMEASR/5Hi8P4lgTZcz++bD3EyhhPG2vp3Ag89ijBER67+VP8uLDksGckS+luPbHvcHlRUc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 13:30:14.9307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17cc2fb-72be-4819-0319-08d73d058157
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3120
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

Wrap the call to komeda_crtc_do_flush in ->atomic_enable() with a
drm_crtc_vblank_{get,put} pair so we can have a vblank ISR prior to
the FLIP_COMPLETE ISR (or more likely, they'll get handled in the same
ISR, which is equally valid).

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index f4400788ab94..87420a767bc4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -258,7 +258,9 @@ komeda_crtc_atomic_enable(struct drm_crtc *crtc,
 {
 	komeda_crtc_prepare(to_kcrtc(crtc));
 	drm_crtc_vblank_on(crtc);
+	WARN_ON(drm_crtc_vblank_get(crtc));
 	komeda_crtc_do_flush(crtc, old);
+	drm_crtc_vblank_put(crtc);
 }
=20
 static void
--=20
2.23.0

