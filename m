Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F54EECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3705D21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VvBzXKS3";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VvBzXKS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfJOCLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 22:11:10 -0400
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:5051
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfJOCLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 22:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyUW4Zl2E6lY9bQXwmH72tV+7kAhIQ9vDJpnPnK6F8E=;
 b=VvBzXKS3AJbdg3FvOp59ypxot0pIzwlA2HJsF8G8XD5BL0nEbRVLD8wzZt6v8YTYWZ0yxLDS6n/RR19BpEgP0+A6k1Myc8wdV7YpvOu78F/O7dOmvzMTAn/sUpBlRuxkjXVPVwAR1T5XtJ2zVTao7mj/0z2bVih6NYGdk5MwAKU=
Received: from VI1PR08CA0095.eurprd08.prod.outlook.com (2603:10a6:800:d3::21)
 by HE1PR0801MB2009.eurprd08.prod.outlook.com (2603:10a6:3:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Tue, 15 Oct
 2019 02:11:00 +0000
Received: from DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VI1PR08CA0095.outlook.office365.com
 (2603:10a6:800:d3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 02:11:00 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT039.mail.protection.outlook.com (10.152.21.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 02:10:58 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Tue, 15 Oct 2019 02:10:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: eb5f4b8550791a4d
X-CR-MTA-TID: 64aa7808
Received: from 30e84cc9cbdb.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FCCEB9F9-2B11-484C-A267-3F11C8DFBDA3.1;
        Tue, 15 Oct 2019 02:10:47 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2053.outbound.protection.outlook.com [104.47.9.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 30e84cc9cbdb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 15 Oct 2019 02:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQkKI0McIJUInssDoX1UckINkqsP2pVLVpKsj0PocsoDOh19B0DMaJlKoJfAUahZyL1msoFNP35QcDWstuO65iYztsgFJLSHHu1frVLTT/2Ein65Xtu6Zpq+ub1e0XDKkybmaJGMpXthsTrxbdGGZ1PEuFW+d6CXy5xelA+LI2+xASwG4cPLMjSDiy6OZ7vEkbILh5zHj/MfMN7iM1dvBC1mXZvHXVFIH+L4cFt9wEn7e/Bwjia4IrTgxDoiLw4/RUPafmeMHe3Nxm9Bd75gBn1WBvXPYV0wXNnR2RnDWbSSyvEK7AOu2PzcYBbSvKoMX/TZBjKJ65t0Zk5LdMg/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyUW4Zl2E6lY9bQXwmH72tV+7kAhIQ9vDJpnPnK6F8E=;
 b=k9QDRv50pQoTZICdWlA6HlUZAnd2WYJPMYBDjJ/jC3pHd1JGO0ZnWZYN7hZ/biZV2sfHahe91FOKDXv1yjJu+tkRYROMKOhISbqrAaR7xgaji0gDz+yr0ifLCWapIL8R8B36jl/VTQjqmZ7pYwfCLYW32oiFJDy1/G0xl1+dHk3lhu3a55bQoo8otnHhNUWhT7pgTd4UyIbSVQhIyPBguF+KaeC6ZvFAqe43Q0Y2ArEjnov86sYBEIOjV/Jfrp+MowbZb4dTHQEc1zm1kKjOpH3F7e6cl9jupfQjaNUl09h7ZoNjhU2qsktuf/IeTffOmo6WmL4Q/pcRhrhNhyLm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyUW4Zl2E6lY9bQXwmH72tV+7kAhIQ9vDJpnPnK6F8E=;
 b=VvBzXKS3AJbdg3FvOp59ypxot0pIzwlA2HJsF8G8XD5BL0nEbRVLD8wzZt6v8YTYWZ0yxLDS6n/RR19BpEgP0+A6k1Myc8wdV7YpvOu78F/O7dOmvzMTAn/sUpBlRuxkjXVPVwAR1T5XtJ2zVTao7mj/0z2bVih6NYGdk5MwAKU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4799.eurprd08.prod.outlook.com (10.255.115.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 15 Oct 2019 02:10:46 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 02:10:46 +0000
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
Subject: [PATCH v4 1/4] drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v4 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVgv3BWlwKETCEA0mEVRVx1dwUKA==
Date:   Tue, 15 Oct 2019 02:10:45 +0000
Message-ID: <20191015021016.327-2-james.qian.wang@arm.com>
References: <20191015021016.327-1-james.qian.wang@arm.com>
In-Reply-To: <20191015021016.327-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b3b46695-ca59-448d-3795-08d75114eb8a
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4799:|VE1PR08MB4799:|HE1PR0801MB2009:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2009E55A15301C94CB785360B3930@HE1PR0801MB2009.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3276;OLM:3276;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(66066001)(476003)(76176011)(110136005)(54906003)(66946007)(64756008)(66476007)(66446008)(71200400001)(66556008)(26005)(103116003)(2201001)(86362001)(6512007)(186003)(71190400001)(316002)(36756003)(6506007)(446003)(11346002)(386003)(2616005)(486006)(2906002)(256004)(52116002)(55236004)(102836004)(2171002)(8936002)(14454004)(478600001)(6486002)(81156014)(81166006)(305945005)(50226002)(2501003)(4326008)(8676002)(7736002)(5660300002)(1076003)(6116002)(3846002)(25786009)(99286004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4799;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YvWjXFyzqCm+tq74pRLpBY80nNyqUBV0PKWsr1UCGW3qGFHwsOR8k3lv7D2VNFpuWp+mCZGiWzT0kMSlK758jNdbTmfGJMW8D15q7ic4edgbBGv6DwHio2o69yTO4lp18ZOUn/L3cR4//8uMbnZC0zAJqL4IKBS0GxqrCoU5gw/iQhr4kSuqeaFUi2gB3krl8I3PlW9YAWTXas1cle1fASTwJJH+KUnlcVQYWKF3bcBiBfqcJ1pGmIa2p9+Qiw9sQdtzwRVxZryVBjIa9f2sHkeePEVn/Aq015VsG9D6ZKjgGJpKMPDAhppatQLu12bN25E5s4SW9dbHU9iMeQOJn702tj2Ku0CJVR2nwSRRfnOctvRuCRH2LU74nWm148SU4ui3/J43ii/xs+SZDfa3f5grQDkyaI4Gq2Vt9GqGoAw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4799
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(22756006)(76130400001)(8936002)(70206006)(50226002)(8746002)(70586007)(316002)(86362001)(5660300002)(54906003)(26826003)(478600001)(110136005)(81166006)(103116003)(7736002)(305945005)(66066001)(23756003)(47776003)(1076003)(8676002)(81156014)(126002)(356004)(6116002)(3846002)(63350400001)(25786009)(11346002)(4326008)(446003)(2906002)(36756003)(336012)(14454004)(6512007)(2171002)(486006)(107886003)(2616005)(476003)(50466002)(2501003)(2201001)(6486002)(386003)(6506007)(26005)(102836004)(99286004)(186003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB2009;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c26dfc5-12b1-4e5f-ba3a-08d75114e385
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVsuEn7PBY9FH2tUJAcvOjMgBxY3y/wUI+wcuSGHD7Hnz2BJcft4OWAOa38rJ9yEZqq+5Umu6Ly/hN/jAH1WMcRGLrNbqRYTsJV55a0RyrGx6VubGnuhRdcleHhpD1ySg0s01TCgwlTFA/qVJl1D2Ggo+Z/ROpP1UQ4qRY/rQUeJ9wmUmWAAg1zBM5rCCO7yVG/kncZM6gnvmBYryUaqY42C1nCrr07CR59sKWqjeZfv3SgYtIiFMm3oUndTIniIN8yPoUcmAPylJyENSZrVW/o3biOrix+TXxp4j+p3lkb9nBng5Uc39sXKsucdvmzldWbTJKZ4MvF32JM7oMT5XpanH7DmzKI1sGCgu8auuSRFPYf62FCvKsLuAlD+K4V0z7UT3+8/ODqtHvkLiCln3Jf5zcgjUYH8sBwVUg4UW3s=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 02:10:58.8603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b46695-ca59-448d-3795-08d75114eb8a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
hardware.

V4: Address Mihai, Daniel and Ilia's review comments.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_color_mgmt.c | 26 ++++++++++++++++++++++++++
 include/drm/drm_color_mgmt.h     |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_m=
gmt.c
index 4ce5c6d8de99..a6d78b247713 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -132,6 +132,32 @@ uint32_t drm_color_lut_extract(uint32_t user_input, ui=
nt32_t bit_precision)
 }
 EXPORT_SYMBOL(drm_color_lut_extract);
=20
+/**
+ * drm_color_ctm_s31_32_to_qm_n
+ *
+ * @user_input: input value
+ * @m: number of integer bits, doesn't include sign-bit, only support m <=
=3D 31
+ * @n: number of fractional bits, only support n <=3D 32
+ *
+ * Convert and clamp S31.32 sign-magnitude to Qm.n (signed 2's complement)=
. The
+ * higher bits that above m + n + 1 are equal or cleared to sign-bit BIT(m=
+n+1).
+ */
+uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
+				      uint32_t m, uint32_t n)
+{
+	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
+	bool negative =3D !!(user_input & BIT_ULL(63));
+	s64 val;
+
+	WARN_ON(m > 31 || n > 32);
+
+	/* the range of signed 2's complement is [-2^n+m, 2^n+m - 1] */
+	val =3D clamp_val(mag, 0, negative ? BIT_ULL(n + m) : BIT_ULL(n + m) - 1)=
;
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

