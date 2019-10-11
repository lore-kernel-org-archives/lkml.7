Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6513FECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296DC2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="in6AxU8A";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="in6AxU8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfJKFny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:43:54 -0400
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:29251
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727014AbfJKFnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwjboglvKAq6uiIJDn2YUD84pCdj+UuHqWJb/1SqjLc=;
 b=in6AxU8ACzOUEDCj04ROWClmtYWC9G/qA0bErD8NSzd7BazPS5sp3wixIOk9RILJhjAexJm7AEpDEMPcuxdmCb8m4e7bzgm98Kqebk3M9tdwbwYptWzhGRPEu2+I0MmZSPyBMIKzxayZehzCFspAy2WBGws+vZq4iuSMYJVdjpo=
Received: from AM4PR08CA0059.eurprd08.prod.outlook.com (2603:10a6:205:2::30)
 by DB6PR0801MB1765.eurprd08.prod.outlook.com (2603:10a6:4:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 05:43:47 +0000
Received: from VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by AM4PR08CA0059.outlook.office365.com
 (2603:10a6:205:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 05:43:47 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT003.mail.protection.outlook.com (10.152.18.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:43:44 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Fri, 11 Oct 2019 05:43:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 38a8f3ea0075de2c
X-CR-MTA-TID: 64aa7808
Received: from a6bf254ba81f.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A2C02209-4D5F-415B-9689-BDE2A69C4FAE.1;
        Fri, 11 Oct 2019 05:43:27 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2053.outbound.protection.outlook.com [104.47.0.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a6bf254ba81f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 05:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJ3STHbc5tZUBv+Kba2WQ30cFt4QmpNO4XXkgfK36Tw7woiKe5/FZ6T6fnNVQ2k1WhSzbZOYIzg3TPMjIUcMJg/UehwnehokGqukoG6g/CPLaOXYLNabBA0ySMVrWI7G6nu9abKS/P95r2i29LXv/3rSil2uOWK3kseKPLetBt56RYpi8pFu4XXU8nysPsdM+N6nRPIvl7Pjkez9VysJJOysFrde4IFcI46LijW1lDqtt4tpuIB+B+M71BmUxCcM3LyF+48Oo4SC2Fpxx4eE6W8U90Ppzo7wFf1MnZum3rYZFwtXBpumSUBUzbQNaPt1FVamZabakNAQlg1NJsT5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwjboglvKAq6uiIJDn2YUD84pCdj+UuHqWJb/1SqjLc=;
 b=XWeZzTv+LjceiGyOtK37RKQDnMyfL2W4Z1Rkab8NBA6j+cDbzx6qdki6tTmlJ2eZ6nmwsWYAz4rrKMXNGucULMDgXD88r/ht0zNcB0UXxLvwSIeSjDfa/Xla8x3pbvYoE6Pp5FuxniYnzaJEojtSQ5JxKSDD8RpArKSomyLsC2AObZKe5VTyhzW9CIdV9+jLy2Jvc0HmZ6ZV4ENrkxOvJbbRzSdvcHdwVU5G3pEgQzN9Mf5uL0+oo9WGglerLReLSJd6LsKjDWVaNpwmGqTcUEChYy9aYdmaOaIDpE5JQQFt3O7aeZs7GQL8SEU2b34WTBF/ZqlYBTtHaE5lStFW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwjboglvKAq6uiIJDn2YUD84pCdj+UuHqWJb/1SqjLc=;
 b=in6AxU8ACzOUEDCj04ROWClmtYWC9G/qA0bErD8NSzd7BazPS5sp3wixIOk9RILJhjAexJm7AEpDEMPcuxdmCb8m4e7bzgm98Kqebk3M9tdwbwYptWzhGRPEu2+I0MmZSPyBMIKzxayZehzCFspAy2WBGws+vZq4iuSMYJVdjpo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5134.eurprd08.prod.outlook.com (10.255.158.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:43:23 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:43:23 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v2 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVf/bLcMR8w2F0B0+It1k1COYv8Q==
Date:   Fri, 11 Oct 2019 05:43:23 +0000
Message-ID: <20191011054240.17782-4-james.qian.wang@arm.com>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
In-Reply-To: <20191011054240.17782-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 359796fc-deb9-4840-5cbe-08d74e0dfab6
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5134:|VE1PR08MB5134:|DB6PR0801MB1765:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1765D9C52D2DC521DA284525B3970@DB6PR0801MB1765.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(199004)(66066001)(486006)(386003)(6506007)(64756008)(99286004)(50226002)(52116002)(81156014)(6486002)(8936002)(81166006)(66946007)(102836004)(8676002)(305945005)(55236004)(26005)(66476007)(71200400001)(6116002)(3846002)(66556008)(6436002)(71190400001)(7736002)(76176011)(36756003)(186003)(2906002)(256004)(476003)(6512007)(2616005)(66446008)(446003)(11346002)(54906003)(25786009)(14454004)(2501003)(103116003)(110136005)(316002)(4326008)(5660300002)(86362001)(478600001)(2201001)(1076003)(2171002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5134;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JkZ/G8Hi75jgNaZzV2Wi1x311SjgBaNPNvFUGMP9hBk/mOdNCR3R9BMx7qStzRT2fbLE5nBFylhX4gw9AJ4zTeatqO6FG7LG+1HAF/oZKbuFp0EqLqkGL/r4XE7cx7xx4zCKXOjcK9iBj6hWNkHJaxbQGrU2UGHu6+Q4Bc0uv2FSI6aOTPk6YvjoKBOrdDs5acd0a+GqvgEWlw0v9jEf6DeGkVil2CzON+bDsGeT4LU8nIzqIhMULT+DetZji0OliewPQ4NlmlZq6cxIeHa4MUcoB2YnHNyimaWDEIE3t4s/CxHObKcT3xGJ+6Z67iIUnbycK4zYvxiKpAdLTV0+GAEt17R0ky4L9mIjIixUdBRYkdVp/n/Stmc/f7hejKbntfyQKaR/1qU+h3ei1pLyuC7jMOj+QADKswwpQ66C8AY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5134
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(8936002)(14454004)(99286004)(478600001)(23756003)(2906002)(54906003)(486006)(476003)(50226002)(6512007)(47776003)(66066001)(6486002)(126002)(4326008)(25786009)(356004)(81166006)(26826003)(81156014)(8676002)(36756003)(316002)(22756006)(2501003)(1076003)(36906005)(5660300002)(110136005)(386003)(6506007)(2171002)(186003)(103116003)(76176011)(11346002)(446003)(305945005)(2616005)(63350400001)(336012)(70586007)(70206006)(2201001)(76130400001)(26005)(6116002)(3846002)(7736002)(50466002)(102836004)(86362001)(8746002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1765;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e6fe4a50-761d-4487-2052-08d74e0dee2f
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVSmo0Wo0pvXR6FmaaPGr610/jId1aK2RVaoMYI29wjDKjWOalGAd/ea4olJ8Ge49kIt16AykDgz+zqxsUEC2ZwnacHB/GLJN1aDxD7puoaGMJN2MJRaXgZi8eZj2HOcpm/XSCINPfP3JMhKXnCGiUE7vgdikWVDsyO7iH/gtMPQOBmJCdHWzq4tZ30DbHS+PGHn3/ZeY1n/WGexk1o3yU6ROpq9JvILfskSEvFz9P/En0I3mMdKAafIqZlsx3xw2VJ+TATYbuupD45Jnk78G0JndOGEhQNXFRKo92/nzHgCbnXnCLWz6LTeM8rIqG8zSMqUE0md9oNfjwhDdqK/z4T4YsBZnqN9NEraYfI/guWpY4WbUW/bcpiMhVkJ9fnNUJQpQxyCLsXoMRHWt4qhQgVClIPp2QxyneYCLB+FeOM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:43:44.2600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359796fc-deb9-4840-5cbe-08d74e0dfab6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1765
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is for converting drm_color_ctm matrix to komeda hardware
required required Q2.12 2's complement CSC matrix.

v2:
  Move the fixpoint conversion function s31_32_to_q2_12() to drm core
  as a shared helper.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c | 14 ++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index c180ce70c26c..ad668accbdf4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
@@ -117,3 +117,17 @@ void drm_lut_to_fgamma_coeffs(struct drm_property_blob=
 *lut_blob, u32 *coeffs)
 {
 	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl));
 }
+
+void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs)
+{
+	struct drm_color_ctm *ctm;
+	u32 i;
+
+	if (!ctm_blob)
+		return;
+
+	ctm =3D ctm_blob->data;
+
+	for (i =3D 0; i < KOMEDA_N_CTM_COEFFS; i++)
+		coeffs[i] =3D drm_color_ctm_s31_32_to_qm_n(ctm->matrix[i], 2, 12);
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
index 08ab69281648..2f4668466112 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
@@ -18,6 +18,7 @@
 #define KOMEDA_N_CTM_COEFFS		9
=20
 void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs);
+void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs);
=20
 const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_rang=
e);
=20
--=20
2.20.1

