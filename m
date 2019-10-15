Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE072086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="x5gklzNl";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="x5gklzNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfJOLA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:00:58 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:24231
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfJOLA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYyBqhKxFW5041qLOlY+lX3EJGvwA8fCFNeZ+Ubc0AU=;
 b=x5gklzNlVYXB0jgqLb0M1CIyS8MB2netszbbh82zLQt4mIbROCjQ1nh0Rr2/SzHFp7171pw+vRFfauURTHiV4iaxtvXVM/AZIrcocFwrkYOGWn5kEg8+lVmNs8Js4zQnAf6W8jcshkU9MD7NNk15eQhP77StUAAwEng5HBG6opE=
Received: from VI1PR08CA0221.eurprd08.prod.outlook.com (2603:10a6:802:15::30)
 by VI1PR08MB3214.eurprd08.prod.outlook.com (2603:10a6:803:47::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 15 Oct
 2019 11:00:50 +0000
Received: from DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0221.outlook.office365.com
 (2603:10a6:802:15::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 11:00:50 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT013.mail.protection.outlook.com (10.152.20.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 11:00:47 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Tue, 15 Oct 2019 11:00:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 97bb444ab06e9fc6
X-CR-MTA-TID: 64aa7808
Received: from e8ec66aa6b36.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6D5FDF9E-E1B6-465F-9FE5-CB1B84FC618E.1;
        Tue, 15 Oct 2019 11:00:07 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e8ec66aa6b36.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Oct 2019 11:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8V3xhc3jJ/w2SzGKYaQnRJ30wnzDmPjZpqXm25Gebw/1VCJnTEcCIBKvXahqpb2tHGAzUXpbAw+6drejAIdGieNoQlUiglgazjiym9k4Rfx3ikMrU808lemLvKQFjYzrRyKseng+W+xribcrbKDjdxRp9E7gwOsIEzO0KtswkeSCHHI/WJki+iDkbbV/+uxVXRNtPH2OLsQNz3THE7VJp/QbyqboRng6PAZb27GeJ3Og8RKzqBQE215t1CywAGZNSMUVukQZ9wToEmxL3U0LJGjZOIbQzXYu5Acq3iPTJrqE2mmfZJ1a01K7Ge+e3Pw1Rw5qbu9Dqq+jzQTWLNjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYyBqhKxFW5041qLOlY+lX3EJGvwA8fCFNeZ+Ubc0AU=;
 b=HaQQT0pLUPPYOx5KIPJyXgP4w2ynnpHYHyvaYMH7HorbttdJvuLT5LxshLsB3JoHNHehaokRkEJgM/AX4uW/FY4i0Pjpxg2qqxfnUyP9/bLV0rNWSZxfz2TzdVg+eDlCIGtRQ2fPoYzilu7vYuB9izjlitZQqL+/3Kh2QakEMA88iCNiuoFLSHn7q/+RHKy4TlPwyseNmQ+K93QE3cGy3zwFDd4ZHrQE3CWlnVMBvg9Q1f7OcdvQJBS6jocEzeKhd6/wdloVHBMFA0XKllzMBDcqbXQd1r60SW3ykgs6ZvfW/CAF63j7Pb2HjHvDnj0csBWdwNVbI/aDPfYo359iEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYyBqhKxFW5041qLOlY+lX3EJGvwA8fCFNeZ+Ubc0AU=;
 b=x5gklzNlVYXB0jgqLb0M1CIyS8MB2netszbbh82zLQt4mIbROCjQ1nh0Rr2/SzHFp7171pw+vRFfauURTHiV4iaxtvXVM/AZIrcocFwrkYOGWn5kEg8+lVmNs8Js4zQnAf6W8jcshkU9MD7NNk15eQhP77StUAAwEng5HBG6opE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3117.eurprd08.prod.outlook.com (52.133.13.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 11:00:02 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 11:00:01 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/komeda: Dump SC_ENH_* registers from scaler block
Thread-Topic: [PATCH] drm/komeda: Dump SC_ENH_* registers from scaler block
Thread-Index: AQHVg0exxDUkact8DUWV7vjAi8CRug==
Date:   Tue, 15 Oct 2019 11:00:01 +0000
Message-ID: <20191015105936.50039-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.49]
x-clientproxiedby: AM3PR05CA0118.eurprd05.prod.outlook.com
 (2603:10a6:207:2::20) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f21e0b86-4457-4566-af26-08d7515eeedb
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3117:|VI1PR08MB3117:|VI1PR08MB3214:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3214CBA9540E687C78DE55208F930@VI1PR08MB3214.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:261;OLM:261;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(2616005)(52116002)(476003)(86362001)(316002)(5660300002)(6436002)(6486002)(66066001)(6512007)(3846002)(6116002)(99286004)(186003)(102836004)(54906003)(26005)(14454004)(256004)(14444005)(71200400001)(71190400001)(386003)(6506007)(486006)(44832011)(1076003)(305945005)(25786009)(7736002)(1671002)(478600001)(8676002)(81166006)(8936002)(36756003)(81156014)(66556008)(66476007)(64756008)(66946007)(66446008)(4326008)(109986005)(2906002)(50226002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3117;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4hZBVsYCMYP99HlfrO5ivZ6Dv0ilc6Gjx201wOF3qqU74hrPFRwDP1bj/6PjKtWD1zp1C/W83GAdz64RwJb5kcmhLuu9JYL1i/LVBM0yQ4/Ppg4t3O2Yztv4Rw5ELw9fyAtzgxJkpxU2k9Ui4ijlwi1PA6Axxq+YSIwErF4y7wMTvzESuLSE4B5f4Z8QEJOprVSUHhpaGYp3q7m9lSIFFLSd27capwj1cqFXt8Qx5NQgUC9EsYc56Z20kdd8cbm4S9GQt1P87kbuTOKaNedNzr8f0sWAFH5eMimTwHEllOf+y8WIWZ9hxFKJHuBYrVEScb24tvDUPbS2RZC655Cth6RcSC//8rrlWKMwqeuQ6VTiktamgLx0EvPJpf+vxE21B88kZMI61Ftq8cjWq9YLS7CxWFwzqTFymyzxxqYvPlI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3117
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(66066001)(63350400001)(126002)(47776003)(476003)(70206006)(4326008)(1076003)(70586007)(81156014)(486006)(2616005)(478600001)(26826003)(316002)(336012)(186003)(54906003)(26005)(14454004)(22756006)(25786009)(14444005)(50466002)(1671002)(386003)(6506007)(86362001)(356004)(8936002)(50226002)(8746002)(36756003)(7736002)(81166006)(8676002)(102836004)(6512007)(2906002)(305945005)(23756003)(3846002)(6116002)(99286004)(76130400001)(6486002)(109986005)(5660300002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3214;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 29ac9219-f59c-45bc-2853-08d7515ed398
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LA3ZeXhzKYdYPgv3O6LjnNI4tswcZeT0Qv78WQ8jgQvHMbHwR0DW3v5yg67cyW2KrhVAryL4zwabsmz7mI0c0I7HpAkbNtCjfVhTmyqObd+KCRdOkWWdkkl/+1W67KJHGxogQuOGN6ZwU+zKZOB6vH5fhlrZfh9Q08lBggsxZEJBuPyqfJxNdk5mFjcwBSsywNOUn4cgrogq9ozFLzb0vM74+dlQbWs05iMlI5B69NOImccZ0EBTh+UVBWrldcncVsHbmxDeqO9mFSXgk5vIuKNDP8VT/jWlLceXnydQ/O92hjlmuuwisMaeW0yRlUbHPxZ+OyWMXszerBMoZJxKmK67hV4La3r4mUZpX780jSTlQsRbOcNCpoYhESoqLLJPpXW6JuwubRRJVbLp/t9F8WKu3F0DECROQAPunHDgEY8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 11:00:47.1584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21e0b86-4457-4566-af26-08d7515eeedb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3214
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_component.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index c3d29c0b051b..7252fc387fba 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -703,7 +703,7 @@ static void d71_scaler_update(struct komeda_component *=
c,
=20
 static void d71_scaler_dump(struct komeda_component *c, struct seq_file *s=
f)
 {
-	u32 v[9];
+	u32 v[10];
=20
 	dump_block_header(sf, c->reg);
=20
@@ -723,6 +723,18 @@ static void d71_scaler_dump(struct komeda_component *c=
, struct seq_file *sf)
 	seq_printf(sf, "SC_H_DELTA_PH:\t\t0x%X\n", v[6]);
 	seq_printf(sf, "SC_V_INIT_PH:\t\t0x%X\n", v[7]);
 	seq_printf(sf, "SC_V_DELTA_PH:\t\t0x%X\n", v[8]);
+
+	get_values_from_reg(c->reg, 0x130, 10, v);
+	seq_printf(sf, "SC_ENH_LIMITS:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "SC_ENH_COEFF0:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "SC_ENH_COEFF1:\t\t0x%X\n", v[2]);
+	seq_printf(sf, "SC_ENH_COEFF2:\t\t0x%X\n", v[3]);
+	seq_printf(sf, "SC_ENH_COEFF3:\t\t0x%X\n", v[4]);
+	seq_printf(sf, "SC_ENH_COEFF4:\t\t0x%X\n", v[5]);
+	seq_printf(sf, "SC_ENH_COEFF5:\t\t0x%X\n", v[6]);
+	seq_printf(sf, "SC_ENH_COEFF6:\t\t0x%X\n", v[7]);
+	seq_printf(sf, "SC_ENH_COEFF7:\t\t0x%X\n", v[8]);
+	seq_printf(sf, "SC_ENH_COEFF8:\t\t0x%X\n", v[9]);
 }
=20
 static const struct komeda_component_funcs d71_scaler_funcs =3D {
--=20
2.23.0

