Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A141AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673592196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Lvk7ZBam";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Lvk7ZBam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfJKFn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:43:28 -0400
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:42486
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfJKFn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MROpJRQlAYcnH6kxPcSNEQcaOoQ01vB9i7fkB8VnXF4=;
 b=Lvk7ZBam/+KrJiBvhFlW/yzp3KzI2Choq0oJsjV98JstYqM9xP6lFePXjDwYq/1Z0/AC2fTQlNMSEpN8HVGm5xvzExTO+sTAnUl05pKNWK0AuD2WpfWTG1J2jI1/nenk8aFiBGkBkl9fHtk4Vhat4NupyP9l90GNkJz4zVzcJ9U=
Received: from VI1PR0802CA0015.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::25) by AM6PR08MB3144.eurprd08.prod.outlook.com
 (2603:10a6:209:48::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Fri, 11 Oct
 2019 05:43:21 +0000
Received: from DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR0802CA0015.outlook.office365.com
 (2603:10a6:800:aa::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 05:43:21 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT018.mail.protection.outlook.com (10.152.20.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:43:20 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Fri, 11 Oct 2019 05:43:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4416ce3dc06705bf
X-CR-MTA-TID: 64aa7808
Received: from 409fc30ad3a0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7B73E81B-7DA7-4424-BCAD-AE93652C5A61.1;
        Fri, 11 Oct 2019 05:43:11 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 409fc30ad3a0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 05:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhsAP9maEmuMzkLff2QVmr4nGIrkxlwyBfMlGBvQQIeZCIfrJeLsDkCqozT9DBk3M0U6gQJUB7bFHIi28AMCwp9qRqjn85quThue068vqUQZKpMd6kpyGLcPGxsnji+BEX8Gm3uqMg2lv63LDIur0qOr2GP2qbFjkd7RkVBA4VlqYkPkLzg5zDVqg+DNsnX4mQNPNjoFJwnDOcgK0PX6mfpXqhXh+Q63E4JCensIDJP+nx81tC5VVi+NIRAP7EimNKR32839Gt/Bdx/P6M970MeoUafQ44HTgB2qfyZJiG6JZmiDbif72zuAzNfrYjMXKpogjv1FNqlMt3lR1Wwx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MROpJRQlAYcnH6kxPcSNEQcaOoQ01vB9i7fkB8VnXF4=;
 b=oczJEaFE2H9FHUkdiGc9gwaASoIj5/XuetAP16zSRy49cD29glguKxrYLq3FkGU4JejF8cpKK/E2LY+toJaQ4ODqd6di0Xkd7hcBZUbeVNl8jb4yKYq+BNCphwlwX0mwRJ/VXbd5Ntj728vg8G4K5u63H6SGgxvsBP0Sf0zDe4pgG8dPLD5BHBTGdJ0wpjUPZdvmIYPuhm/iQPf75MFcqe1FfunHa4BLt74lDg03I+/0/Gmv4E5KET9Stesur7RIpD8vaYtfY+nFXIJSCnBl4Je2HcAytT4lgS21Zmmcj19JLHAoy2p+MWs+r0OsHtJoV0O7dijpggXU4VO9C5SyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MROpJRQlAYcnH6kxPcSNEQcaOoQ01vB9i7fkB8VnXF4=;
 b=Lvk7ZBam/+KrJiBvhFlW/yzp3KzI2Choq0oJsjV98JstYqM9xP6lFePXjDwYq/1Z0/AC2fTQlNMSEpN8HVGm5xvzExTO+sTAnUl05pKNWK0AuD2WpfWTG1J2jI1/nenk8aFiBGkBkl9fHtk4Vhat4NupyP9l90GNkJz4zVzcJ9U=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5134.eurprd08.prod.outlook.com (10.255.158.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:43:09 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:43:09 +0000
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
Subject: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/bDNAzoDxuLVU+by7UkFix6lA==
Date:   Fri, 11 Oct 2019 05:43:09 +0000
Message-ID: <20191011054240.17782-2-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef0ee2a3-ee4e-429d-0f77-08d74e0dec3c
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5134:|VE1PR08MB5134:|AM6PR08MB3144:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3144D8557A97B4EA6C05C670B3970@AM6PR08MB3144.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(199004)(66066001)(486006)(386003)(6506007)(64756008)(99286004)(50226002)(52116002)(81156014)(6486002)(8936002)(81166006)(66946007)(102836004)(8676002)(305945005)(55236004)(26005)(66476007)(71200400001)(6116002)(3846002)(66556008)(6436002)(71190400001)(7736002)(76176011)(36756003)(186003)(2906002)(256004)(476003)(6512007)(2616005)(66446008)(446003)(11346002)(54906003)(25786009)(14454004)(2501003)(103116003)(110136005)(316002)(4326008)(5660300002)(86362001)(478600001)(2201001)(1076003)(2171002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5134;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ndGrfEnsw4RRr1scCRcgej+L0luzMHm1bQa33tlKL9+Dz/sZOFD47eFSSpN6OnHsYKa5urJrJz5z7G88LJAEnoEsPna6sLyOKxoVjOdKJDy8pmx4+Of26YEuNZtKZMS+V4Zfooy9PzANEUaeMx75FaMvuJCfodljj1qgWPMoUtHYYkOaDEFI882+pj1DHVuZ7K73Mz4ODIbyuPouvRWgTqiiS/yIrKnPOANCbeS6kFW8rzudRkkMkGx8Eh0Kaxp7VY0cqrTgoOIAzDAUik0mtV9bxuNYeu2+Id08sIef7HYpRxLuqP2l/V0C/QL9ATSBIU/Y1D4UJmGEekCUVQmrp3A+1wKlTH3HPUyKi4Qb0PonxtYp8REXeg9XiCZ/UMvcKECMM5nTrM/ZwqNvE24QQouoGx5hgy/X1Pdfctn7PNc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5134
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(54906003)(70206006)(6486002)(70586007)(76130400001)(2501003)(8936002)(81166006)(81156014)(8676002)(8746002)(22756006)(1076003)(110136005)(14454004)(50226002)(478600001)(356004)(26826003)(5660300002)(23756003)(25786009)(50466002)(3846002)(386003)(6506007)(36756003)(86362001)(186003)(103116003)(2201001)(99286004)(11346002)(446003)(2171002)(102836004)(26005)(76176011)(316002)(6512007)(66066001)(486006)(2616005)(4326008)(2906002)(126002)(6116002)(336012)(7736002)(476003)(305945005)(63350400001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3144;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0573589d-19dc-4e45-9d87-08d74e0de57e
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ly/a6GzZQDoSakrbhGa4kFzTIvs7XB8WjN4FfY5dA88RNltc27Brn9KohP4vjJCGIreno4tXM3O/BUnXmeSm+c8ai1mWie18/4pNjEUlojxdj7kwbMm6c6DbOGjqXgV5/AvheaFYC0OTnA1R34v5cXPO5thklbhU01pQLkSvEEiZ2YHn9LiUdd7G5dbJB67WJWgxYnJTNd49D/mZpEv247J9H4vD8hQNY5JpbrmU3s6F4NJvTeVMtq4jeflAZ9cf8RUeObZLOOYmAzqlVAEVpZncZ0zNiqgPbVqIWikrla8BmYWxyuai3n3eD8zpnMS7DVjBsfD2w/ii+mLjVzBTkfX6FuT0CT/Jt+0Hcmue9r54yWZu7Acw9u3wbMY+WWBDNo2r4Kfg316ptB1SGy15oC4K/ZzajOuLT8SeswpnAoM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:43:20.0624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0ee2a3-ee4e-429d-0f77-08d74e0dec3c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
hardware.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/drm_color_mgmt.c | 23 +++++++++++++++++++++++
 include/drm/drm_color_mgmt.h     |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_m=
gmt.c
index 4ce5c6d8de99..3d533d0b45af 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -132,6 +132,29 @@ uint32_t drm_color_lut_extract(uint32_t user_input, ui=
nt32_t bit_precision)
 }
 EXPORT_SYMBOL(drm_color_lut_extract);
=20
+/**
+ * drm_color_ctm_s31_32_to_qm_n
+ *
+ * @user_input: input value
+ * @m: number of integer bits
+ * @n: number of fractinal bits
+ *
+ * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
+ */
+uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
+				      uint32_t m, uint32_t n)
+{
+	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
+	bool negative =3D !!(user_input & BIT_ULL(63));
+	s64 val;
+
+	/* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] */
+	val =3D clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m) - 1);
+
+	return negative ? 0ll - val : val;
+}
+EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
+
 /**
  * drm_crtc_enable_color_mgmt - enable color management properties
  * @crtc: DRM CRTC
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index d1c662d92ab7..60fea5501886 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -30,6 +30,8 @@ struct drm_crtc;
 struct drm_plane;
=20
 uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_precision=
);
+uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
+				      uint32_t m, uint32_t n);
=20
 void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
 				uint degamma_lut_size,
--=20
2.20.1

