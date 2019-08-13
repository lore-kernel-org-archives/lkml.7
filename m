Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FCBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C5D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yFbUh3ZB";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yFbUh3ZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfHMLIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 07:08:42 -0400
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:35662
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfHMLIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsDNXr0KNxCcnIZ9PF1U792HvsS/tGBmMN/oZ0GYiz4=;
 b=yFbUh3ZBF8yOxD7dBYPYrfaIQ0uoMkYUuSAxsDj+5UypmfxMWvm6jvN/kGC/+oPxYxFo0+i/ikNIyNh5gsSOtHhSB9AdSb35bRchnfRSB1REDC7czIcvTiG2k9QZbfuHRLm0BnfjDQ7bfAGENVgNl8yvSj3x932e7hox8Jz0ssk=
Received: from HE1PR08CA0055.eurprd08.prod.outlook.com (2603:10a6:7:2a::26) by
 HE1PR0801MB1852.eurprd08.prod.outlook.com (2603:10a6:3:7c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Tue, 13 Aug 2019 11:08:34 +0000
Received: from DB5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by HE1PR08CA0055.outlook.office365.com
 (2603:10a6:7:2a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.18 via Frontend
 Transport; Tue, 13 Aug 2019 11:08:33 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT047.mail.protection.outlook.com (10.152.21.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 13 Aug 2019 11:08:32 +0000
Received: ("Tessian outbound a1fd2c3cfdb0:v26"); Tue, 13 Aug 2019 11:08:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 260a94ef076d9744
X-CR-MTA-TID: 64aa7808
Received: from 631ab1ffda15.1 (cr-mta-lb-1.cr-mta-net [104.47.6.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CF60CC6A-489F-44FC-AFF4-C8BAC4697BC4.1;
        Tue, 13 Aug 2019 11:08:22 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 631ab1ffda15.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 13 Aug 2019 11:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9iu9+2vJyJUJ1jMiSE7DhsnsbpnqzMWY97MPUs+nAJ83O0grSI+/P2vAuJ6neM43bk8Gixe5k4+QXXQznVCJ+Fa1/UzlObFnNHGutqnICa7653D0OM8HswA6kMwRWZJNVx64VQtyfBUmn9YRbF11S6tM39XK2CWSt7gUJIQoVQzHSAhaCSmVhWiEyFePUoOsO8kEDfn9McTEidPcp+ZUPbTHnMtoylbUWbrt6yK289KvI2sjKbXP/brC8CNcoATkUn/Wa+SFfrHlQVooJRjOHEN48uueh7o/AgHyA3sSw0C5JK7gxuLV6X9wQWbwsOYzt2ltJp6YiyWCgb9C3I4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsDNXr0KNxCcnIZ9PF1U792HvsS/tGBmMN/oZ0GYiz4=;
 b=WKZZbrzGytf/PPnlpbKjH5gNa/IrfdFrgOWNPPW2OY/fma2LQQ0boKaCZkNGcVeTYtiD4C2AoR6cLmZN1NxFGz5RhmA7Wvpghj10ImsXrSfFnPNbQYT0pWQcYgggMM3db9wkX3SjUCSll8/cisNrxZK7qTdGc/yhgodTgvfNV810Y+W8sG6m5E9s/5CvROF6AKxVg8TLYuvp8O7zj8GEpKE9NbzQFVjVtWJjPd077jLx7DVQpyGzXfPvzb3qIgh4N5D76UZ5pT2sXnBsANAZrWyHo9+i0wQwc/LHvGCJlBDHPRhnNEtaNA7Xd/Yq4NlxPLQ/4+U1epeOntr8d0JL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsDNXr0KNxCcnIZ9PF1U792HvsS/tGBmMN/oZ0GYiz4=;
 b=yFbUh3ZBF8yOxD7dBYPYrfaIQ0uoMkYUuSAxsDj+5UypmfxMWvm6jvN/kGC/+oPxYxFo0+i/ikNIyNh5gsSOtHhSB9AdSb35bRchnfRSB1REDC7czIcvTiG2k9QZbfuHRLm0BnfjDQ7bfAGENVgNl8yvSj3x932e7hox8Jz0ssk=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4894.eurprd08.prod.outlook.com (10.255.113.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Tue, 13 Aug 2019 11:08:20 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 11:08:20 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
Subject: [PATCH] drm/komeda: Clean warning 'komeda_component_add' might be a
 candidate for 'gnu_printf'
Thread-Topic: [PATCH] drm/komeda: Clean warning 'komeda_component_add' might
 be a candidate for 'gnu_printf'
Thread-Index: AQHVUcdq4wh1p5uTvkWo2JsLoFstlQ==
Date:   Tue, 13 Aug 2019 11:08:20 +0000
Message-ID: <20190813110759.10425-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 0e41fb41-3f0f-409d-e6f1-08d71fde945b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4894;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4894:|HE1PR0801MB1852:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB18529B6E1B37BC01E764224BB3D20@HE1PR0801MB1852.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1303;OLM:1303;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(66476007)(66556008)(6436002)(3846002)(6116002)(53936002)(2201001)(66946007)(66446008)(64756008)(36756003)(478600001)(486006)(102836004)(55236004)(316002)(8936002)(66066001)(6512007)(386003)(6506007)(26005)(476003)(103116003)(186003)(81156014)(25786009)(81166006)(2616005)(99286004)(50226002)(8676002)(4744005)(52116002)(2501003)(6486002)(14454004)(256004)(1076003)(14444005)(71190400001)(71200400001)(110136005)(2906002)(54906003)(86362001)(5660300002)(305945005)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4894;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: Wt35t6ZGCWITMQjsqOrCkOjM/B0/2LZl+kmH47OKq0mNwCBOyAENi+O7mzUHCu1AWmH35zxYcTuEiL069fMjmVDN/1XO75hiRxTycj6UUJVcIFYVogfpT9CH5nC96cwAcXBNlFAI/SB4Sxe9CSvhmGC21WiDFE1yn9kAUb47fbQbWYAQgrt+QOF+7gKRRIgTLd0/EWH/izH8mjDaqWwiXGKfmDhU03K+lrxSEcFPxFzEdHflceMlX5faa2Lr9mFXmNQYoNvcaTsF9E1b95M/tMbsRf6ffbzeKl7Pk+bUlELtbvWt5c499dObSoJwgu8dDp8h0ynVi6MQSMWRVAYQoZJbzpseeZNU8n2cc21IWO7kPA1hAMfKhz7TIhprVybDDKwPn7hxcSmacEmXMM8GkZfM1hEhnWCvjIsdvE30j8w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4894
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(189003)(199004)(50226002)(126002)(66066001)(99286004)(81166006)(26005)(7736002)(47776003)(102836004)(8746002)(8936002)(2616005)(81156014)(6486002)(6506007)(386003)(2906002)(63370400001)(63350400001)(336012)(476003)(6512007)(36756003)(486006)(2201001)(4326008)(25786009)(14444005)(2501003)(86362001)(356004)(103116003)(70206006)(23756003)(1076003)(26826003)(70586007)(305945005)(478600001)(14454004)(50466002)(316002)(3846002)(6116002)(8676002)(186003)(110136005)(54906003)(22756006)(5660300002)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1852;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 633fa617-309c-4d26-9c24-08d71fde8c93
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HE1PR0801MB1852;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: RT8ynRgNFlG/4rRIvney5RBJmFF/7pAkJCITz0SaMKVBIvPD3XbIWxi3iz86S1TYvipFADdvygC6gBQUICfrnowJAgpVB82ftaRpWCVX2iX05Ezgc/7QKskCIz6AAv/Ikf0mXvLCeaUEyxEzXa7BBThviVNYKPeO9znacLqgUvnkbYTyBSyNKLFglI0VpRCWsnKZLT9OjNOSR61YcMWeKX/RNYhV05xKln67hPJNa+ElFUxgKk3QoOWv5XaA9IO4ZkLmhLazEAIHrgEYuLsIzoyeRJq1lJ4fEolJZVnsTIqxKo2ycB/5XzPiLKS4BDaINO2PXahyhdWdGovt1RIZqW8WTnt5iQLVQY5Fp3ZIAHW6iJMfYREU3JOJs8M2zUL16zJ7TVQ/T1YDuH56ItgUi23riioJFqT9PlK+NdHCgbU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 11:08:32.7935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e41fb41-3f0f-409d-e6f1-08d71fde945b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1852
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

komeda/komeda_pipeline.c: In function 'komeda_component_add':
komeda/komeda_pipeline.c:212:3: warning: function 'komeda_component_add' mi=
ght be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=
=3Dformat]
   vsnprintf(c->name, sizeof(c->name), name_fmt, args);
   ^~~~~~~~~

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index a90bcbb3cb23..14b683164544 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -480,6 +480,7 @@ void komeda_pipeline_dump_register(struct komeda_pipeli=
ne *pipe,
 				   struct seq_file *sf);
=20
 /* component APIs */
+extern __printf(10, 11)
 struct komeda_component *
 komeda_component_add(struct komeda_pipeline *pipe,
 		     size_t comp_sz, u32 id, u32 hw_id,
--=20
2.20.1

