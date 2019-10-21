Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06CCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09962089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="T1NX/4te";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="T1NX/4te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfJUHXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:23:41 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:17702
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbfJUHXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=T1NX/4te0E46cFTcYzomNTVVtxWriVcYq2fOLauQ4Pv6BDfm1QW8lxm03b/NW1U5eIMZBYTans/PQHzziVjRb07lssV5lVqZPJs7qRBFH6cAENTEYhFRHdl1qnbZXdG6fRIbgMMIOFy5e0TsboH3HVf6sh9WoV/wN5Tm8PqmU2s=
Received: from VI1PR08CA0087.eurprd08.prod.outlook.com (2603:10a6:800:d3::13)
 by AM5PR0802MB2564.eurprd08.prod.outlook.com (2603:10a6:203:a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Mon, 21 Oct
 2019 07:23:33 +0000
Received: from VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by VI1PR08CA0087.outlook.office365.com
 (2603:10a6:800:d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 07:23:33 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT016.mail.protection.outlook.com (10.152.18.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 07:23:31 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Mon, 21 Oct 2019 07:23:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 770fbb7ace524f3e
X-CR-MTA-TID: 64aa7808
Received: from fae602638719.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9791980E-354E-46AC-846C-91DFE96FBF6F.1;
        Mon, 21 Oct 2019 07:23:22 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fae602638719.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 21 Oct 2019 07:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQz6ScPRp49Sou41ysKSM5FvnXaCfEmsDYw6TzXqOKh9PyLXanuXW+IMvH/Fawo+c+GwsyYzKWTPYal/WxJFmJouYoytJkA9CfsfewZdDJWPof/K0eBtle2tBkHZ1gTWlo+avBPivEaH/0Y50nlJo5eSMoDVtGyrfTUroMe5A47XulR86ICmNk1VE+46XrAxSvgE1Z5DuR/EwxqFUmu6AddPBGVkZa2kULNthwgCfwKvqwtOrQFxX8cKJy79TkunwqczbNbJ5gr+W8yHlGm7/1QGgoHl62Wo+zOk3148ZTUMpIgMUOtldpaUMTKs4DAMM8rwHhGV9BNh32WLt+DLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=RytdKtUpRG+RmgqI6xuAKm27LOZ/YYETg82RtMZpej4Z7FcjAm+FwOkeWwTubDPDQd0YWZEnHULBqOjMewdG2AgO2J17jgXFla8P4PBxmwHVQBlJJAdRcbCLwFjscVySdzC19eTBeUYF0dski8slxePRdBo+HYggYwACS9W0FJvU0+XuJ/IM6M+PKiNkTohAkqH0PiSgzODA86F1D36tWXyOy/A5HaGVYNFLJqfINzjMT9uojh6Ig++mr3qb6KuY145SfMOaN3ZOwoZs+lz7GijSLyMpCH09V/npTKGm2lT2dlM7jCQTiCdAYwNOmOg4nC/lBpZVSOR/5Rxa13R1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=T1NX/4te0E46cFTcYzomNTVVtxWriVcYq2fOLauQ4Pv6BDfm1QW8lxm03b/NW1U5eIMZBYTans/PQHzziVjRb07lssV5lVqZPJs7qRBFH6cAENTEYhFRHdl1qnbZXdG6fRIbgMMIOFy5e0TsboH3HVf6sh9WoV/wN5Tm8PqmU2s=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4831.eurprd08.prod.outlook.com (10.255.115.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 21 Oct 2019 07:23:21 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 07:23:21 +0000
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
Subject: [PATCH v6 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v6 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVh+BqsLSH/wZFl0yjO/mZcFyErw==
Date:   Mon, 21 Oct 2019 07:23:20 +0000
Message-ID: <20191021072215.3993-4-james.qian.wang@arm.com>
References: <20191021072215.3993-1-james.qian.wang@arm.com>
In-Reply-To: <20191021072215.3993-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d5e7181a-162f-4051-3c07-08d755f7938e
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4831:|VE1PR08MB4831:|AM5PR0802MB2564:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2564E974954418B7AA2697D3B3690@AM5PR0802MB2564.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39850400004)(396003)(136003)(376002)(199004)(189003)(110136005)(6506007)(6486002)(386003)(66066001)(4326008)(8676002)(66946007)(54906003)(99286004)(103116003)(36756003)(6512007)(6436002)(66446008)(64756008)(66556008)(66476007)(55236004)(2171002)(102836004)(2501003)(26005)(14454004)(186003)(81156014)(81166006)(2201001)(478600001)(11346002)(446003)(316002)(2906002)(7736002)(86362001)(71190400001)(71200400001)(256004)(6116002)(25786009)(305945005)(486006)(3846002)(76176011)(52116002)(5660300002)(8936002)(2616005)(476003)(1076003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4831;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JYP/2F8ql3ReP+WqFtop8aEapL76Fmdpf8q9t7VZKb31uJGA8KDyL9KYIU2yLCi4b+ttkTNXXXPaXaSQV52siaOAuwbPtZ3Yf7AfU47ML91pNADPiqGeWDrwuZI0GerIDdxfVS6mZzwPsBkoANOETqP6UMhC2K+uV7cqFMoj2d4JsJj0EDMhkC+YUuImbJY2NP0jq8yuwdJxEGVQy9LkOPEc28PLDvWtzkp4fb6PQvlq+9tzunQmFSPd04P/x2fTwqupNU1EQpGaSXaxwY6x3/yI0niqbPAVcmguAe9jKiFiHf7c1ScEa2Q3gtKpJlIuQDiIaYzyW4+wXB4Qyw4EWRmQL2X/UThvwJ2pTBtvVlSuWbwDAuG2KK4dv5pWL/1tfz8U58B4OQ1gaWv29Kth5u+xCtLPb2v2cffG1VtscU4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4831
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39850400004)(199004)(189003)(36756003)(6486002)(86362001)(2906002)(5660300002)(70206006)(4326008)(2171002)(50466002)(6512007)(6116002)(66066001)(3846002)(2501003)(2201001)(76130400001)(1076003)(316002)(70586007)(36906005)(47776003)(186003)(23756003)(2616005)(476003)(50226002)(22756006)(26005)(356004)(11346002)(110136005)(126002)(478600001)(446003)(8746002)(54906003)(305945005)(7736002)(25786009)(386003)(103116003)(6506007)(486006)(99286004)(102836004)(26826003)(81166006)(8936002)(8676002)(14454004)(336012)(81156014)(76176011)(63350400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0802MB2564;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a8de9c36-8413-4d50-57c1-08d755f78cde
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTEQN0LXeUzxoO/1OUiUALqwKw+j3h7B2OJmr+EUTt97tC4HZZpnweyqkVEHigvM8s256ArsywVQ12h9mMwK0uZyJAeBNuup5VFUaDwer1H+AF+HT5ADRsfzWEnlR+E020PuQQiPBxpaO2SD27hHvJ/efxvH4DIuIEL5js7k9z97R1gZG8TfrxSj6q4egDArI1G4yBKzqvZIRXRuMryVyIIFYhYC89ha3EotKI9TwYlKRNR4AvgxDF+hsaBY8q2ulhiyiV6aDDqn7F+Ir/QNvoXkfEE9c2z2zazykpfDn6l3miQDRTcy9e1tcGR3TtmJWCyoO4+GkYa/97hEN/Vsxq7NhaQEzMdXSEd0PY4mbTKFGhWFG5VGlzH5gO5YIiGWAtkRacSWqYFM/H2qq87C5y/MlrTBI/hyB0zi4HonQom5WCo/+h2erNFJQIOsyQ/0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 07:23:31.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e7181a-162f-4051-3c07-08d755f7938e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2564
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
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c | 14 ++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index c180ce70c26c..d8e449e6ebda 100644
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
+		coeffs[i] =3D drm_color_ctm_s31_32_to_qm_n(ctm->matrix[i], 3, 12);
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

