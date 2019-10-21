Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2FECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1F821A4A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6jcl66n4";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6jcl66n4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfJUQr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:47:59 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:63694
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729405AbfJUQr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqjsYGtito0owHXQyV4kjHNN6CmmoCoNhwj27nXP6vE=;
 b=6jcl66n4LMmg2Lezx5wQs+mvEHCPf/eF10A6OrrfW70+kwdZ2q2ui/6z8C/D+3HZJG2XOGreDMkOsDS+YvqCnPBRo6NhbrzMqdFRVwzcn0q11y1qG+c6/XkP1xRqbup5QJS2MCICEKNU0x1FilPkQjneSjAcljQY0Xc37qOc2RE=
Received: from VI1PR08CA0250.eurprd08.prod.outlook.com (2603:10a6:803:dc::23)
 by AM0PR08MB3761.eurprd08.prod.outlook.com (2603:10a6:208:103::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Mon, 21 Oct
 2019 16:47:50 +0000
Received: from DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0250.outlook.office365.com
 (2603:10a6:803:dc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 16:47:49 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT033.mail.protection.outlook.com (10.152.20.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 16:47:48 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Mon, 21 Oct 2019 16:47:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e9a25194a78a757f
X-CR-MTA-TID: 64aa7808
Received: from 0883c3b38210.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CD9AD2BC-D4F5-4AA8-AE85-95C16E356AB9.1;
        Mon, 21 Oct 2019 16:47:37 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0883c3b38210.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 16:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh8A34tH++BdlsbHp71S4ooIsjM7Do4unGUK9U3vEFHYTp0J/6DF4u/q758XpDRZN9s7QfIkgjwXJhwbjR1HCiDLDzw9vmFhisBSNq5OSBVUl+La8cvwTA/1T4zOPVbHcEBQ0lEi/PCQp5l8gCm2EAglfqWMrLWvEHFN4px5e9/2Crt5RcBi02oTmXVfX8d35AFWvXpiYqJ2LFbs3VUcKzKNJgXzaGoxnw9FSOxuIIy8aiDFPevNQS0dJyMWzPUi0wpgjKsEGKN1rrg7+wSV6qhAu7ySCFqxX6HZZycNwczrVtO5XSHDZLZuS7JdyZGskdgcyrfRnyPPn+TZBDWZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqjsYGtito0owHXQyV4kjHNN6CmmoCoNhwj27nXP6vE=;
 b=jc/ujFe27o8obaY6EgiXW/6aO6XOpchsBej1qrWEp5ZwODa8cYQOhkYfotW8KDiJiLOnH139qTQb6FSTDeghCqG/TunGYM2hoVy+fOJ56I/Rqv8jFEW5USeJ1oly0bPdPUSxBP6LWiUNlAya0jkMJhdP2CEFs1jLihYE03ghRai+mjBrUb6xZ9FD9QC8yOB+GjVop/bdQ+icuwK0uAqVhst5wv1z5ES5Te78j5pDY82h1TywOKX3+gbPMEeCC2u5jCm5sIH8u2cMwgS7kEce/iimdZDupx0aXACn3HzHohmf9+UzQeeGEFvLIrWsNsMrm+0cbiNsXOUdDd7D6+Q/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqjsYGtito0owHXQyV4kjHNN6CmmoCoNhwj27nXP6vE=;
 b=6jcl66n4LMmg2Lezx5wQs+mvEHCPf/eF10A6OrrfW70+kwdZ2q2ui/6z8C/D+3HZJG2XOGreDMkOsDS+YvqCnPBRo6NhbrzMqdFRVwzcn0q11y1qG+c6/XkP1xRqbup5QJS2MCICEKNU0x1FilPkQjneSjAcljQY0Xc37qOc2RE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3693.eurprd08.prod.outlook.com (20.178.13.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 21 Oct 2019 16:47:35 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 16:47:35 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] drm/komeda: add rate limiting disable to err_verbosity
Thread-Topic: [PATCH 5/5] drm/komeda: add rate limiting disable to
 err_verbosity
Thread-Index: AQHViC89H1LXrklOHUu4e/U5aAFNnw==
Date:   Mon, 21 Oct 2019 16:47:35 +0000
Message-ID: <20191021164654.9642-6-mihail.atanassov@arm.com>
References: <20191021164654.9642-1-mihail.atanassov@arm.com>
In-Reply-To: <20191021164654.9642-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b57cd059-caff-4c93-bd8c-08d7564667c4
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3693:|VI1PR08MB3693:|AM0PR08MB3761:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB376136FCE85C211C136C6A2A8F690@AM0PR08MB3761.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2449;OLM:2449;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(11346002)(6436002)(316002)(54906003)(256004)(8936002)(6512007)(14444005)(2501003)(71200400001)(5640700003)(71190400001)(50226002)(486006)(2906002)(446003)(6486002)(2616005)(44832011)(5660300002)(8676002)(476003)(305945005)(66066001)(36756003)(86362001)(25786009)(14454004)(186003)(478600001)(6506007)(386003)(102836004)(26005)(4326008)(2351001)(81156014)(1076003)(6116002)(3846002)(66946007)(81166006)(66556008)(52116002)(66476007)(7736002)(64756008)(66446008)(99286004)(76176011)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3693;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: HLkzIMJEQxzlI9copX2NPj0yiWNa8wBN39G2iPJ9LYDFDKx3no8aPiV2lddOQ4qf0KSznQ+tIoReapEbfhW9rkAvw5Vq0rPPJwN8kx+h71IyKY5jKFXu07vJpZU388K01J8iNFhTdFfkcJOfhNfMKSVFOCO/RMwnG7md10/B9nGxm65wLLpJ0urrWMu+baCr/wLFXS1zG7JF/p/Kok3jltVYDNO3icOsx3PK26YVtXAasOPSrC+iS9RPfKQ5MRap8IYlvfhdn82AypvpxIepZhVnSpljhnEkq3NFnV9V4BQq/O97ANZ0VdPY6DYmT6D8r8Y723m9F3DYdYoU+DY15XiaS25552kSpl53J4L4ttVHNFCILA2ef5VgNp3m2boLhs9HhyBmUeV58Q/J33Jw3X8yiStOD+nYI/o8sJ6BcKaV1gv+JaMSeF9P6fHbdslF
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3693
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(6486002)(478600001)(2351001)(26826003)(70206006)(1076003)(86362001)(356004)(70586007)(76130400001)(2501003)(3846002)(6116002)(2906002)(14454004)(25786009)(305945005)(7736002)(50226002)(81156014)(5640700003)(8936002)(81166006)(8746002)(8676002)(50466002)(5660300002)(54906003)(316002)(14444005)(47776003)(186003)(6862004)(99286004)(63350400001)(4326008)(76176011)(26005)(102836004)(6506007)(386003)(66066001)(22756006)(2616005)(446003)(486006)(11346002)(6512007)(126002)(476003)(23756003)(36756003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3761;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a8b2873a-98fe-4272-17fa-08d756465ffd
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bv65fn5ZeTCtYa67PTlTF7mKpJUkqjdAsf0NsVgf9QNd6GyMm/68SJlEhLgdiU9TzNows9Id9WHxs9DAOvNMw2GJMJWMva4w7rUAxRLH0p7a2BEwd75oOX+XIrEG+dQI3Faqyj2xEdmoHRhXdkXJNmwJ+06rjX38fY27b5iFnBaSyKG2EkqUP5zbBNkHr7Q7ia7Yt5UEBvYiJjP1z2vcTIPHi1iL2F9Z5UuBw1pCUxIrlJQPZu4ZttJvlMQxgcc1Rh3M4dRFnNwvo3Y0Rrhv9wC4P+0OMDKhatacWyvJ6Mjd/FzGQfAuarkysowcR2xZ9TfHdVgkf1h0d/2lEBFWwhxjmwwsHZEwawVU8//JX5j9D2BqFll4slof5njpFwxD3d0yWBW7Hyfz3Cdfah5ILZr9uLSxb6MTFPEUGekLgWhUfAJ3erY/11Ik57ltTyt/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 16:47:48.4370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57cd059-caff-4c93-bd8c-08d7564667c4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to get multiple events in a single frame/flip, so add an
option to print them all.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 2 ++
 drivers/gpu/drm/arm/display/komeda/komeda_event.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index d9fc9c48859a..15f52e304c08 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -224,6 +224,8 @@ struct komeda_dev {
 #define KOMEDA_DEV_PRINT_INFO_EVENTS BIT(2)
 	/* Dump DRM state on an error or warning event. */
 #define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
+	/* Disable rate limiting of event prints (normally one per commit) */
+#define KOMEDA_DEV_PRINT_DISABLE_RATELIMIT BIT(12)
 };
=20
 static inline bool
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_event.c
index bf88463bb4d9..86e33fed8a91 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -119,7 +119,8 @@ void komeda_print_events(struct komeda_events *evts, st=
ruct drm_device *dev)
 	/* reduce the same msg print, only print the first evt for one frame */
 	if (evts->global || is_new_frame(evts))
 		en_print =3D true;
-	if (!en_print)
+	if (!(err_verbosity & KOMEDA_DEV_PRINT_DISABLE_RATELIMIT)
+	    && !en_print)
 		return;
=20
 	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
--=20
2.23.0

