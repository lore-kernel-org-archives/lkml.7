Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B978FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3C121929
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VxgilF6z";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VxgilF6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfJJKag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:30:36 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:61422
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbfJJKaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO3ca2kTzKqEQ4c4xLvysJUSS7b3CP42BXAWZNLISMg=;
 b=VxgilF6zcXrR6wwdjLPTiFsC0Fzo9ZtgWzBzxgqDhxoBBItsipi4LLzMX/9p4sy1yrCTFwIIivYAb8QjVNCQquPXhM6kzXdf3FVIQ1nMgy05qbRYk+/ANYlbBVRHkMmxMlr0ky8VEarbTLsSOhyZlFugOI5Zzl+kSopJ0q8uPhE=
Received: from VI1PR08CA0182.eurprd08.prod.outlook.com (2603:10a6:800:d2::12)
 by DBBPR08MB4346.eurprd08.prod.outlook.com (2603:10a6:10:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Thu, 10 Oct
 2019 10:30:27 +0000
Received: from VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by VI1PR08CA0182.outlook.office365.com
 (2603:10a6:800:d2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Thu, 10 Oct 2019 10:30:27 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT007.mail.protection.outlook.com (10.152.18.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 10 Oct 2019 10:30:25 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Thu, 10 Oct 2019 10:30:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4b6e63a8a16d55a6
X-CR-MTA-TID: 64aa7808
Received: from 9c9f4f447ad7.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 942B22FE-5A49-4879-8534-068B5C1C307E.1;
        Thu, 10 Oct 2019 10:30:09 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9c9f4f447ad7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 10 Oct 2019 10:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwknWVVUZKJRcNSpAbIpf/AI2AtbOqe8Gi9d5drX2l90ZQlP1zSUhMJHIXgQGNNx+6MRRWU+ZzZJazx4CRXRxOuFm5GkP0OksRoicaXhC20+PmHMd7mvOfQkU34MhNz0cydk5sUk9BVxOlJom9wk2IQtKK/qb1gkm0yzkNKofvm8mcWhMy7vKfs6+kHlZsUVTB9uvuIKJXJhCO/nismojMxE6Ky5/DUIVoNGa7R//c3z9n1UtAIB+hmObAk9kOhbi20Si2Cp2ay5yUnRbO6h6HkGCQF5tevkNMk6blKcOKOnYaz11Pt7xe7YqLkduUFzdkB62arlIArViVWSOBAQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO3ca2kTzKqEQ4c4xLvysJUSS7b3CP42BXAWZNLISMg=;
 b=XHLvxJnfYLHZ1s44fDSaBOGODS9nMVoiTns9tYXUVhjNCemd2AVBBZWSlJKTmSRvgmTgEo7Z7DLqGuHR4tTSAa9FZoEbinobo32I1ACHQ7SvThTTb0MCGBSgGnvSfY0T3Dsyp1FcbLaDGIoS4Av8EWTn5/YA66LUGo33e5OkBm6UPyiP4+pEHUiwbCDT7FEfSz/Ra+vf7aHd0UwXFmAYICtt+kj4wCKI7VT4VfsIcZ0cTG+HfrNuPMfJyn/uYFw+ouqrNVB8eGWFCF+H10o/xZ1LsG2u0udwThjYs72kVLoO06tlliytUuPnTBVAO/h16OzJSwDOSVwXO/hahEJHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO3ca2kTzKqEQ4c4xLvysJUSS7b3CP42BXAWZNLISMg=;
 b=VxgilF6zcXrR6wwdjLPTiFsC0Fzo9ZtgWzBzxgqDhxoBBItsipi4LLzMX/9p4sy1yrCTFwIIivYAb8QjVNCQquPXhM6kzXdf3FVIQ1nMgy05qbRYk+/ANYlbBVRHkMmxMlr0ky8VEarbTLsSOhyZlFugOI5Zzl+kSopJ0q8uPhE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB5552.eurprd08.prod.outlook.com (20.179.28.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 10:30:08 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 10:30:08 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/komeda: Don't flush inactive pipes
Thread-Topic: [PATCH] drm/komeda: Don't flush inactive pipes
Thread-Index: AQHVf1Wv2yHbm0bBS0KhNr2i/1d6YQ==
Date:   Thu, 10 Oct 2019 10:30:07 +0000
Message-ID: <20191010102950.56253-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0454.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::34) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 9073d643-5466-4781-0832-08d74d6cdd32
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB5552:|VI1PR08MB5552:|DBBPR08MB4346:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4346317037AFB028CEB354EE8F940@DBBPR08MB4346.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:210;OLM:210;
x-forefront-prvs: 018632C080
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(386003)(6506007)(6486002)(4744005)(14454004)(1076003)(5640700003)(2906002)(6436002)(102836004)(2501003)(81166006)(6916009)(8676002)(81156014)(50226002)(36756003)(486006)(476003)(86362001)(2616005)(8936002)(186003)(26005)(6512007)(2351001)(52116002)(44832011)(3846002)(71200400001)(6116002)(256004)(71190400001)(5660300002)(99286004)(14444005)(66446008)(305945005)(66946007)(54906003)(64756008)(66556008)(66476007)(478600001)(4326008)(25786009)(66066001)(316002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5552;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: O3E/VkTguXfS7hHZHCVxt4j3qrQ0dAJFdsiOidmum9Dil6J39bPPCAw+bejUfK65g7Gtt3Om0o8gZ3lZXKDUwSsMerM/rsT580FVxmgieZ3ZQQnTQ1BqrZ14hBwFZJ/aiTqA5Gkfxb/Q4UNNffQDEVlz0jbX8Zq2ky1V/Mxaq9XbGSOsc7Z0yUti5Yk7LuUp0kIh/wcK8Swqmd126oScPqp+WqLfsUMaV4M7YWYIW7ljZzUhWJ5J52oX4qZquCCX0fjDQwIMuZL1e1zt0/dH0pTOAxqZyKEm8lzeTZN/c+TFdzuI0CB4gTj2McSkFSjInXAcSvCGXrMG0vRJv77IDMaZhxnlr8Ri4tqOHtU4aTxX1q/O3zUZkE/vh2soQgjs8EATMXDBLY8fXcgGEYOyo0mwkn76w+5nDHx1EvapkcQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5552
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(6486002)(5640700003)(4326008)(2906002)(23756003)(336012)(2616005)(486006)(36756003)(126002)(476003)(6862004)(8676002)(81166006)(50466002)(6512007)(14444005)(76130400001)(81156014)(7736002)(70206006)(305945005)(356004)(70586007)(66066001)(2501003)(47776003)(3846002)(6116002)(63350400001)(4744005)(86362001)(99286004)(2351001)(6506007)(54906003)(386003)(186003)(102836004)(22756006)(25786009)(8936002)(316002)(36906005)(1076003)(8746002)(26826003)(14454004)(5660300002)(50226002)(26005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4346;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f486e70-896a-402f-f362-08d74d6cd257
NoDisclaimer: True
X-Forefront-PRVS: 018632C080
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nk/swiuTfCJDGo2Cy/smGcFOcgmDZFsrusfNUfqhMuVF/nwlYHvD/k3fyIAP3mbOHuy1VgwTS4+lsz3smA9aUB4TpQbv9dAv5oeQCNJsk6XCl1z660Do7F7RoT/Z50fGJGiVrlRawNpGp47X+MfC3ocrnrldZRnkRIQjA49OWp0EC6OA7ABPMyCP4rgCLGTRHj3xC88up3kRQqj+LOWto4WGU1QuHZRM21mkuIIYves8h0TC2qFBUuKcpgoAohESNIKdhbYpBBSq6YnMw2J6xoR8LfzjkvQDAO+HRJuG8cO3jYMaQzNJGlh5And7fwB17wT+MVHxFES2eE8cF2zKZB4bZ6xDjG5DQ800qDYBGF0wxoh7rIhvxGtOmgayXiowUr/rDiDtScCyTwaPX95s0HGyhqU/9n33XlEAV7y6fZE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2019 10:30:25.7954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9073d643-5466-4781-0832-08d74d6cdd32
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4346
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HW doesn't allow flushing inactive pipes and raises an MERR interrupt
if you try to do so. Stop triggering the MERR interrupt in the
middle of a commit by calling drm_atomic_helper_commit_planes
with the ACTIVE_ONLY flag.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 8820ce15ce37..ae274902ff92 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -82,7 +82,8 @@ static void komeda_kms_commit_tail(struct drm_atomic_stat=
e *old_state)
=20
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
=20
-	drm_atomic_helper_commit_planes(dev, old_state, 0);
+	drm_atomic_helper_commit_planes(dev, old_state,
+					DRM_PLANE_COMMIT_ACTIVE_ONLY);
=20
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
=20
--=20
2.23.0

