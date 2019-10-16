Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB06FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBAD20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qyYw51jI";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qyYw51jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbfJPKea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:34:30 -0400
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:61155
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387797AbfJPKea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwNLApKNkl72Wy0e6O+y5NOzqaHS2uIq08CitOENDfA=;
 b=qyYw51jIRqHS3M75guWYLGoq3R0k0OelhTBsqbEbij1wgXcotnO2ia1p1uY7iH0PhYIHDmbaEpnChU1bZGfxgc1M33nQ4r45n82Vqse4N6zbME2xatHo2kZMp2ek4Rgqo9Lj6EJsAk61+ESk9FcNb/nwPdDiXSWrEOIcpPjGMIE=
Received: from DB6PR0802CA0038.eurprd08.prod.outlook.com (2603:10a6:4:a3::24)
 by DB7PR08MB3273.eurprd08.prod.outlook.com (2603:10a6:5:28::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Wed, 16 Oct
 2019 10:34:23 +0000
Received: from VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by DB6PR0802CA0038.outlook.office365.com
 (2603:10a6:4:a3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 10:34:23 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT017.mail.protection.outlook.com (10.152.18.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 10:34:21 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Wed, 16 Oct 2019 10:34:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 99346b773049ac19
X-CR-MTA-TID: 64aa7808
Received: from 4cddd178ccbc.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 34A94619-5420-4B7C-A6B7-977AAED1B35D.1;
        Wed, 16 Oct 2019 10:34:10 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4cddd178ccbc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 10:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXf/QUlr4G3hZYPvJDdPHGY9wideFWLUnAnXMFIBPiS87pRC7GPSCmeHOjOhVjHtMrP4X2WbV8UePddjOGeG8jfuxGpF0rcbpUf+l1VZ3WWHG/MwqfTYAyRpHrXkpHWw2kU6O9zBWQfQg5EwUq+4qZH6+ViNmvsq8KRkCxzA+H10G4wf+P+vjOcAjOhellxtbzK3qbINeLxzuXT9u14WlPOorXjIouNAXvPWB0oB+jyzz+mUMmeOvEIlmdTK6RwC/boXXQ5iO38vpAt2pyNaNxrq6loh5q4AdGtqZ3aC7nT8fh0ohDu8549KQYDCzpLXPe5P2Sg+sUoB+C9QtWQMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwNLApKNkl72Wy0e6O+y5NOzqaHS2uIq08CitOENDfA=;
 b=gyvtHpIv4cauAZDYIDkhbMXffAIf1ncW4VLAcd9N2SSe3fiYGHfCf0v6AyOCmfqWUjH0PVcXLa5OP8aEDW4oqVXblctRmtws1B9MTX+wkT1wgjZSaGsLwcZaC7Qq/H8FGzUE0hq0iKlye8r5AooKdEo2L8wF8R46ofYtU+Y3loDOMxLYqfRQwEBpspl+vHWajM/nYCPzM3rmqmUZXnBtkJx7aIS7yny75mspJl2CuPvhmaXvnUwc9bfEW+BvFMaSJi2XghK5nPUeRO9nMgbN3DQQUNJahgmtK4m6/NLXX8UW9w9Ibas67v7yYWrX1B8K5iNPhPeT9PSDpOCBNa3lwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwNLApKNkl72Wy0e6O+y5NOzqaHS2uIq08CitOENDfA=;
 b=qyYw51jIRqHS3M75guWYLGoq3R0k0OelhTBsqbEbij1wgXcotnO2ia1p1uY7iH0PhYIHDmbaEpnChU1bZGfxgc1M33nQ4r45n82Vqse4N6zbME2xatHo2kZMp2ek4Rgqo9Lj6EJsAk61+ESk9FcNb/nwPdDiXSWrEOIcpPjGMIE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5182.eurprd08.prod.outlook.com (20.179.31.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 10:34:08 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 10:34:08 +0000
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v5 1/4] drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v5 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVhA09wVtvHgqrOkmWUho1ovfOOQ==
Date:   Wed, 16 Oct 2019 10:34:08 +0000
Message-ID: <20191016103339.25858-2-james.qian.wang@arm.com>
References: <20191016103339.25858-1-james.qian.wang@arm.com>
In-Reply-To: <20191016103339.25858-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 973c1912-5df4-4001-25f7-08d752246818
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5182:|VE1PR08MB5182:|DB7PR08MB3273:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB327315EAA70E20A9A0B9EF30B3920@DB7PR08MB3273.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;OLM:4941;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(199004)(189003)(1076003)(64756008)(66446008)(66946007)(66556008)(66476007)(2171002)(6486002)(66066001)(71190400001)(8676002)(2201001)(14454004)(6436002)(71200400001)(5660300002)(76176011)(81166006)(81156014)(36756003)(2501003)(52116002)(386003)(6506007)(86362001)(25786009)(256004)(476003)(2616005)(305945005)(3846002)(8936002)(186003)(103116003)(11346002)(446003)(6512007)(478600001)(6116002)(55236004)(2906002)(486006)(54906003)(50226002)(4326008)(7736002)(110136005)(26005)(316002)(102836004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5182;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hBWEbJzky5IBufOc+HQF2LPlVDayfB7/yOzKhZfznZwRF6QawGbPfdj1f4MPREYCL4O8LG5uJMPN5rkxkSQ79Y4HlYq+JwpShnFKVYBYSCVJGVvKPsBqGikQtNuBtt0XpNBCIlKGV0byx1bX+JcLWaEDaDiOrxftbch5SdgtZKhTZBvRRmG0jiud4wTb8YoYP8qgngU7Bl8DS9w+j+7YDZJge1bAuD86+fKKRIdSUrT2umOf/YbNcGgYeLEcDD/CchpdVHjwd9vByK3bSDN+mkoyAoM1BvFxAk/WUVxnsJcTbFaRzAsBjEwJA7nWKksRgSLk3zkVPRwBCzB/8/96QWsTNfmNzkTzDiS1ap4d4ImtD+evZD6ZyxMugw1ZFP6VPLg5FcJvVVc+3sRpUpnACchwUQHnSmMnZ53J+Q8jXbA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5182
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(76130400001)(50226002)(7736002)(54906003)(70586007)(305945005)(22756006)(86362001)(36906005)(8746002)(478600001)(5660300002)(26826003)(316002)(8936002)(103116003)(81166006)(110136005)(66066001)(70206006)(47776003)(23756003)(1076003)(8676002)(81156014)(3846002)(356004)(25786009)(11346002)(486006)(4326008)(14454004)(446003)(63350400001)(50466002)(36756003)(6116002)(2906002)(126002)(2171002)(107886003)(2501003)(2616005)(476003)(6486002)(2201001)(6506007)(102836004)(26005)(99286004)(386003)(6512007)(186003)(336012)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3273;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: aeac93ca-8c58-47e9-a67d-08d752246034
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uu8dK8kUi1cjx5L0IQCXb0+qcm4RdLXulQE9WeZ+M/uzLPeJzX4b6QOYDVcC25muBk7GzsKSiSsfvxwLEHz+4Qh2D2V+8bJyRugJ7EF/ukTrg0H+IXxJTcWIAZkxmG8syq2eMEikTo8vhyWN11u9ap+mpOcAX/GDawcZs4qS66dkzB9hadNllzSmbgZCFsY0TzjI7LdCTITEA0uAaIoPKkaVYljspWYEbLDQQd3SCMOwiuAESsaouKfXW+sdWgaWyn33fF/8JDZ2/5R0hl0//S6EHeSwt0gCKUg/UiHQVQkJuJSxIvA4UrAAUPVCaOfXCeMpJUHJCfbGOtCS1NTlMvbNim28O2o1n8Fa2WpHc7GVwjxWF5Bgt0picxr+MADFEbLFGswJU/NAvHhuvXiv8s3iHE/z97weKk5LA4CLhsw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 10:34:21.3466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 973c1912-5df4-4001-25f7-08d752246818
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3273
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
hardware.

V4: Address Mihai, Daniel and Ilia's review comments.
V5: Includes the sign bit in the value of m (Qm.n).

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_color_mgmt.c | 27 +++++++++++++++++++++++++++
 include/drm/drm_color_mgmt.h     |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_m=
gmt.c
index 4ce5c6d8de99..d313f194f1ec 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -132,6 +132,33 @@ uint32_t drm_color_lut_extract(uint32_t user_input, ui=
nt32_t bit_precision)
 }
 EXPORT_SYMBOL(drm_color_lut_extract);
=20
+/**
+ * drm_color_ctm_s31_32_to_qm_n
+ *
+ * @user_input: input value
+ * @m: number of integer bits, include the sign-bit, support range is [1, =
32]
+ * @n: number of fractional bits, only support n <=3D 32
+ *
+ * Convert and clamp S31.32 sign-magnitude to Qm.n (signed 2's complement)=
. The
+ * higher bits that above m + n are cleared or equal to sign-bit BIT(m+n).
+ */
+uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
+				      uint32_t m, uint32_t n)
+{
+	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
+	bool negative =3D !!(user_input & BIT_ULL(63));
+	s64 val;
+
+	WARN_ON(m < 1 || m > 32 || n > 32);
+
+	/* the range of signed 2's complement is [-2^(m-1), 2^(m-1) - 2^-n] */
+	val =3D clamp_val(mag, 0, negative ?
+				BIT_ULL(n + m - 1) : BIT_ULL(n + m - 1) - 1);
+
+	return negative ? -val : val;
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

