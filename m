Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970FEECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5029A21D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EeI9cSGd";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EeI9cSGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfJKFpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:45:47 -0400
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:57831
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfJKFpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg5FqZcXN1Q8PYyDwUWcRuC6JhC60pEQl00Wv88LR5o=;
 b=EeI9cSGdeSucDS2FIuk33MCGsS7//zHVxiRlKdOtPXkCczahabF1ngjLiiW20AmxAn02r7pH7//omcR4Ijpi8C+U/S3kgVLhhKlmaDRXXtpSb7YdyPKx4qKc0w92IEPaXXEu44emGwaw/6MgUCFGJ0cKzzfn0bolVW1CRmg25es=
Received: from VE1PR08CA0030.eurprd08.prod.outlook.com (2603:10a6:803:104::43)
 by DB6PR0802MB2327.eurprd08.prod.outlook.com (2603:10a6:4:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 05:45:41 +0000
Received: from DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VE1PR08CA0030.outlook.office365.com
 (2603:10a6:803:104::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Fri, 11 Oct 2019 05:45:40 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT019.mail.protection.outlook.com (10.152.20.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:45:39 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Fri, 11 Oct 2019 05:45:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e3db94b223a7aa1e
X-CR-MTA-TID: 64aa7808
Received: from 0016c1b5f25c.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BB36F53E-3171-470C-9BAA-14A3D2F9E699.1;
        Fri, 11 Oct 2019 05:45:29 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0016c1b5f25c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 05:45:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEQxeexqiS4RYFzgegTIxOc421T3TU5DQOUmE2ECfPUQUdpniyCjS/cm25WulLRTqt6kSqPLUXk6nV0jvSLLiWJYNVHQeaPoNoA8ycb/BZCarDGRrYOg0T4Hq5js8mqNM0VOYvNC/L423fePniNNJFDwwLAxOyzGSgL+9kVIOMPM7m8hh2oTY1iN5p/AaVFKGaOPZhw1OcudVtIKQeraEUkArhq52dQuXOm+RqczPrjgzoFeRGG+exjbTOLZ9ID0L9qS9+ihlhp5gqy6mBOAAbkFBom8kUIGo7hQn7Plix2kIahhG34gkMdMz0I5siUDmk/K8fDD+gWQ1meiszo70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg5FqZcXN1Q8PYyDwUWcRuC6JhC60pEQl00Wv88LR5o=;
 b=iPRwWhNKYhy/kSGjEcYev+lmosEMXnrRsYb4qTRjDKLz6v66Yq3lNdH5Xrckmb4GX2k/G02K9XyP08suCdVroZY3fdbPo2fmi4akRW0zMvY+X6FMNS90BP96VGpogBExfX6F61a1VZoPF3PewL0Gz8qBVnd7ZZL2tLaXj5sJml0b4DS0iGfWvZR2rdFqlDcN61Rq1BIc4RJIXT6673St0wwZKsLNXsGa57xQ2Md36zt+yuk4PAgj1DIUbrdbcFjMBdseJLlzsgwri9G5o7iEkpN9fO+Fp0R9nO4YIPjxLWDqmfSiqcOquZ5ye4enicfDBgfjYtr+MSoET93fYnmOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg5FqZcXN1Q8PYyDwUWcRuC6JhC60pEQl00Wv88LR5o=;
 b=EeI9cSGdeSucDS2FIuk33MCGsS7//zHVxiRlKdOtPXkCczahabF1ngjLiiW20AmxAn02r7pH7//omcR4Ijpi8C+U/S3kgVLhhKlmaDRXXtpSb7YdyPKx4qKc0w92IEPaXXEu44emGwaw/6MgUCFGJ0cKzzfn0bolVW1CRmg25es=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4816.eurprd08.prod.outlook.com (10.255.112.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:45:27 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:45:27 +0000
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
Subject: [PATCH v2 1/4] drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/cV8wl8pZbk8kmsplok4zd2Gw==
Date:   Fri, 11 Oct 2019 05:45:27 +0000
Message-ID: <20191011054459.17984-2-james.qian.wang@arm.com>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
In-Reply-To: <20191011054459.17984-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:2e::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 35edbd40-2bad-459b-eba6-08d74e0e3f58
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4816:|VE1PR08MB4816:|DB6PR0802MB2327:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2327FFEEF2F829B629C38D72B3970@DB6PR0802MB2327.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(4326008)(2201001)(2171002)(86362001)(2906002)(103116003)(36756003)(6512007)(1076003)(316002)(110136005)(81156014)(81166006)(8936002)(6436002)(54906003)(99286004)(50226002)(305945005)(7736002)(8676002)(3846002)(76176011)(6116002)(5660300002)(52116002)(6486002)(66476007)(6506007)(386003)(66556008)(66446008)(64756008)(14454004)(446003)(186003)(11346002)(256004)(26005)(102836004)(71200400001)(2616005)(476003)(486006)(66946007)(55236004)(25786009)(71190400001)(2501003)(66066001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4816;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: kZseXxyq3+7BV1f66OK9E+I9JtdhGNwjl4tARhiY6Zg8TKORfT27y4FP8rMVTdnbYeXdhUhU5LPp9ETFajKpKkOaQS2wt50eLV9Hu+djsYHdZeXN8b+d3wNAh9xZ2p6BTZB+bnGSckiMAeIX7n78dLtlauSMtvbXlBreliv/oVH4Q2ibvdBDp+BPZty1i6b+wW//urY4kzUP+YRWMLiouLVeDcJjxn4OJq68zyCLwKOCvvDd+PUSGJyB7dvCRI/O3Vvqtb2nxyIxkW8P1i+5o7kGOtbIqMJ4TkSEQo3QwLbpD5CqW0Tu8QbBi3xTNHGSSLOvUIIDlo7kXk6NSZjMPYklfPstp1Flc+6zzixZwBK9etbiBIjMgNa7CW4kYFnfRrrYmPgAFWg6M8x3m0K5FAcT2y3U0wiEPvqKMQjdomM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4816
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(110136005)(5660300002)(186003)(54906003)(316002)(50466002)(47776003)(50226002)(8746002)(8676002)(81156014)(36756003)(8936002)(1076003)(356004)(6116002)(3846002)(2201001)(66066001)(11346002)(25786009)(6486002)(305945005)(126002)(6512007)(86362001)(486006)(336012)(81166006)(446003)(476003)(2616005)(63350400001)(23756003)(7736002)(22756006)(2171002)(76130400001)(6506007)(14454004)(386003)(102836004)(26005)(26826003)(2906002)(76176011)(70586007)(70206006)(103116003)(99286004)(4326008)(478600001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2327;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 569d4c24-4bc1-4db0-0474-08d74e0e3817
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FsnXNE0LSqFHNgHAfaGpcqQMrAz34nDFWaEly9BXdUduDelUKZ8tTjoPeWbqKLWJVAjSYV1870NBLmo43UilQ02TExPOOCSkpCSEIV9K55l5gnOpj1nvNBbJ+fv6JAlO09xaztLRNvbZ4YeYiRtZyAx/ZkEHJ5YAJJikei8Kcll2oAP0zYWHfsD3shvXRd//wjd7vJLSjnPYjLenCUUIssPJr1WAqoi5Gpc6HIIdgRQbTm22WZKPkv12WL/NLIbPp/rsEmenfoVNq+CLaHgf/9kNL/I2y0cHr3dgTHZQdd5GPNGfpklUw63fsxwoIKiqZU8BHvyP/jhwe3YpZq4TgdsUHAyW3g05dEoO7rmesYqbZK4JEfyFzMsirUhoUP9gTdZln/zi0O6t/4usYFrp3fJkewA6BFctNyAVMQZ0xyI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:45:39.5004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35edbd40-2bad-459b-eba6-08d74e0e3f58
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2327
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

 uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_precision=
);
+uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
+				      uint32_t m, uint32_t n);

 void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
 				uint degamma_lut_size,
--
2.20.1
