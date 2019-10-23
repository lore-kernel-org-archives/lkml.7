Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A38CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EA621872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YMqWKiuC";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YMqWKiuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbfJWGnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:43:12 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:47751
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWGnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR0RtOODGwJKPGPv6sNfKERHsmalyGvuC8CCokH63Tw=;
 b=YMqWKiuCELDGBTmwKU4eaufSfYSAEt0jyTGK03oTp3IqCQtaouR4aisJhXiXrOH8et0nA0Zqvm+TvRbV6pdH2kBUXjPTtHD48OXiEw+p0jF6jvBCV152lPFB6eJASf0P+rFOVFLP0uDykDVUgSZ+Q9iR+nmu9i1JmE2mZrcEVwU=
Received: from AM6PR08CA0028.eurprd08.prod.outlook.com (2603:10a6:20b:c0::16)
 by AM6PR08MB5190.eurprd08.prod.outlook.com (2603:10a6:20b:e8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Wed, 23 Oct
 2019 06:43:05 +0000
Received: from VE1EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by AM6PR08CA0028.outlook.office365.com
 (2603:10a6:20b:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Wed, 23 Oct 2019 06:43:05 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT058.mail.protection.outlook.com (10.152.19.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Wed, 23 Oct 2019 06:43:05 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Wed, 23 Oct 2019 06:43:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1af05dff4a19bcd4
X-CR-MTA-TID: 64aa7808
Received: from 68dd3a3811af.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FF873FE2-02A2-4B73-B53D-6B93DD935D4A.1;
        Wed, 23 Oct 2019 06:42:57 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 68dd3a3811af.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Oct 2019 06:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUSu0OWQQHeveEFbKcYDJL3Xx3iDycHrkay6owVnOMykMv+ZFZiBYb1fcnXyA+vTswvHZ1UPRnWku9aQdvQxp5MjBMgUn/Kx5QuPh2O3yQnPeiwr5WIJsfO2z4C92KY6fC4jcK2OZ06KvaL8aFq2bRnTHttJGw28D+TMxWYFL1SQ//Ozqcftpuu9+RSom4klaiur1Bd0nf6zoLIz0//Eupaj0iudO08T2I9Hv10atYhCEFqRZZK3Fis5gPQ0kZEfMHQdKX25YMeGGyxIgec0lIxPvREQbCwAmP2g1qWVb7DblP4BKp/L5yzxbpgCj72F5EjJbCCSzQOLN/40/a2M9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR0RtOODGwJKPGPv6sNfKERHsmalyGvuC8CCokH63Tw=;
 b=jRHBC4EfqFHvJPfJQlJDH/gcPUD+T8B2nO4yj1iG2zEa+ab5ZeoTrbcX7Hg7guaeBXOTdTRgM6+796+f70mWa3/pI+WNOInzdmzuhtbChvnQ39YzROabWnRRPKEMW+YObnKS8d5xwZ2dxQLutyWbaLBguwCTPGX6NKD6t7s+n9Ps7zKOB49c/t03WJn9wwar5G61z4R6SEG+pUwaKv3qsN0REP4bnySSrKdqv/4KlsmQCB8qOrI/xG7Dcg/kaCrZ4jr5bWDEyGLyDldJqmzAnv8fezspVkf741r3j/ySJk2G4J0LSZPM6UZwG+GXm3HZbxFX8Ng2xBDgoZ5klpL4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR0RtOODGwJKPGPv6sNfKERHsmalyGvuC8CCokH63Tw=;
 b=YMqWKiuCELDGBTmwKU4eaufSfYSAEt0jyTGK03oTp3IqCQtaouR4aisJhXiXrOH8et0nA0Zqvm+TvRbV6pdH2kBUXjPTtHD48OXiEw+p0jF6jvBCV152lPFB6eJASf0P+rFOVFLP0uDykDVUgSZ+Q9iR+nmu9i1JmE2mZrcEVwU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4672.eurprd08.prod.outlook.com (10.255.112.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Wed, 23 Oct 2019 06:42:56 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 06:42:56 +0000
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
Subject: [PATCH v7 1/4] drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v7 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHViW0axzrBedn3A0yRNgX73SioEQ==
Date:   Wed, 23 Oct 2019 06:42:55 +0000
Message-ID: <20191023064226.10969-2-james.qian.wang@arm.com>
References: <20191023064226.10969-1-james.qian.wang@arm.com>
In-Reply-To: <20191023064226.10969-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47ccc216-e229-46ef-fcba-08d75784420a
X-MS-TrafficTypeDiagnostic: VE1PR08MB4672:|VE1PR08MB4672:|AM6PR08MB5190:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5190B5F39405EF6D6D5AFFE4B36B0@AM6PR08MB5190.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 019919A9E4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(7736002)(25786009)(2906002)(386003)(71200400001)(4326008)(36756003)(305945005)(6506007)(66066001)(2201001)(71190400001)(102836004)(5660300002)(26005)(478600001)(52116002)(55236004)(316002)(86362001)(186003)(6116002)(76176011)(3846002)(256004)(2171002)(66446008)(66946007)(103116003)(64756008)(6512007)(1076003)(66556008)(50226002)(66476007)(476003)(6436002)(8936002)(446003)(2501003)(11346002)(2616005)(6486002)(14454004)(486006)(54906003)(99286004)(81166006)(8676002)(81156014)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4672;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jc9qNN95z2LggFhMQUr/etJwrvoKW1S/byLD6AwTxBR+ydkc8Xjpn+WLnZn05hFXwQrdKXAUk51lVqCE942ff8DpyrY3lpOrVpFR9RnQxsPTLSTX4pbePMqx1hfhLgeJyJbv7SZBLmLs8lDCDD1PbxybUYWShuO7JoR8SxW533pINf2Iv5iHGM6XpbpgfDm7byTkmq65z7R26ioRPKqBv96whmzlH3BRXHjHEMeKvq4C0nPIQ/8AiurL7pwf0HMJKGR+YgsgX920LHuXHLvf3r1LHjYz3jaUXZ2IBRLQa4hVUcLpzMy0OSfEwVLXmo/jeMy0EAG7hSOFVq0lQ38/I0VdfhaFcq3ZZYqFIc4bdd1P4Wquo8UwWIT/you8VHNHEAmczGWFneb96wkAeiG4NBw33WxKfk0gZwifjCBz3XE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A029D6F7679FC14D841BE2583C3820C9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(1110001)(339900001)(199004)(189003)(54906003)(110136005)(76130400001)(50466002)(316002)(2201001)(86362001)(70586007)(36756003)(70206006)(36906005)(66066001)(107886003)(25786009)(22756006)(305945005)(3846002)(6116002)(7736002)(4326008)(2906002)(436003)(336012)(11346002)(446003)(47776003)(26826003)(76176011)(478600001)(6486002)(14454004)(105606002)(2171002)(1076003)(99286004)(102836004)(26005)(6506007)(386003)(2501003)(126002)(476003)(2616005)(81166006)(81156014)(8936002)(8676002)(103116003)(486006)(6512007)(23676004)(2486003)(356004)(186003)(5660300002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5190;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 506f0e41-01e0-40d1-85a2-08d757843c58
NoDisclaimer: True
X-Forefront-PRVS: 019919A9E4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xE+EOvFnmkrPJd0KOP1lRjFKVNhu3rB6WILvXkRy/7FGaRuzu6xPiiMSg8e/YQYqTCQ7/loKcv/sqg3Mur7t/J29ouxe7S+7RXZbGb+j44fJYCztv10s1BD1zkCd83FTrNxcpgyUaf9EFcQpHeku6801s9ldH5gTyGd7oOTgbNCK3vnsO0bQW7irbqD6tB9yPJ3oNPFQQjSA5hw4nE36wQ1TdOYb7YImrNpIaTrzEmbVEzN0pqePWS/bmDEjo52JQFPjY+yLJ9P2TFDwnxRwQKqsLVbhtB2WDz0TX11r5FWXTsFEKoC4zZNEze2g8BhPc5X3C3t7Z3eYSjMMOGIXguxHZUEIAmtNes3IATP5U4dStwi9T+z0U61epm8ar0J/uIw4EkuJQmijRbu3W8D3fqOW774LnWO/QyUl3jZVyIMleFfd0kDGgovcU71EePy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 06:43:05.0389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ccc216-e229-46ef-fcba-08d75784420a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgbmV3IGhlbHBlciBmdW5jdGlvbiBkcm1fY29sb3JfY3RtX3MzMV8zMl90b19xbV9uKCkg
Zm9yIGRyaXZlciB0bw0KY29udmVydCBTMzEuMzIgc2lnbi1tYWduaXR1ZGUgdG8gUW0ubiAyJ3Mg
Y29tcGxlbWVudCB0aGF0IHN1cHBvcnRlZCBieQ0KaGFyZHdhcmUuDQoNClY0OiBBZGRyZXNzIE1p
aGFpLCBEYW5pZWwgYW5kIElsaWEncyByZXZpZXcgY29tbWVudHMuDQpWNTogSW5jbHVkZXMgdGhl
IHNpZ24gYml0IGluIHRoZSB2YWx1ZSBvZiBtIChRbS5uKS4NClY2OiBBbGxvd3MgbSA9IDAgYWNj
b3JkaW5nIHRvIE1paGFpbCdzIGNvbW1lbnRzLg0KVjY6IEFkZHJlc3MgTWloYWlsJ3MgY29tbWVu
dHMuDQoNClNpZ25lZC1vZmYtYnk6IGphbWVzIHFpYW4gd2FuZyAoQXJtIFRlY2hub2xvZ3kgQ2hp
bmEpIDxqYW1lcy5xaWFuLndhbmdAYXJtLmNvbT4NClJldmlld2VkLWJ5OiBNaWhhaWwgQXRhbmFz
c292IDxtaWhhaWwuYXRhbmFzc292QGFybS5jb20+DQpSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRl
ciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fY29s
b3JfbWdtdC5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRl
L2RybS9kcm1fY29sb3JfbWdtdC5oICAgICB8ICAyICsrDQogMiBmaWxlcyBjaGFuZ2VkLCAzOCBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2NvbG9yX21n
bXQuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5jDQppbmRleCA0Y2U1YzZkOGRl
OTkuLmY1ZmJhNTgwMmEwNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3Jf
bWdtdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2NvbG9yX21nbXQuYw0KQEAgLTEzMiw2
ICsxMzIsNDIgQEAgdWludDMyX3QgZHJtX2NvbG9yX2x1dF9leHRyYWN0KHVpbnQzMl90IHVzZXJf
aW5wdXQsIHVpbnQzMl90IGJpdF9wcmVjaXNpb24pDQogfQ0KIEVYUE9SVF9TWU1CT0woZHJtX2Nv
bG9yX2x1dF9leHRyYWN0KTsNCiANCisvKioNCisgKiBkcm1fY29sb3JfY3RtX3MzMV8zMl90b19x
bV9uDQorICoNCisgKiBAdXNlcl9pbnB1dDogaW5wdXQgdmFsdWUNCisgKiBAbTogbnVtYmVyIG9m
IGludGVnZXIgYml0cywgb25seSBzdXBwb3J0IG0gPD0gMzIsIGluY2x1ZGUgdGhlIHNpZ24tYml0
DQorICogQG46IG51bWJlciBvZiBmcmFjdGlvbmFsIGJpdHMsIG9ubHkgc3VwcG9ydCBuIDw9IDMy
DQorICoNCisgKiBDb252ZXJ0IGFuZCBjbGFtcCBTMzEuMzIgc2lnbi1tYWduaXR1ZGUgdG8gUW0u
biAoc2lnbmVkIDIncyBjb21wbGVtZW50KS4NCisgKiBUaGUgc2lnbi1iaXQgQklUKG0rbikgYW5k
IGFib3ZlIGFyZSAwIGZvciBwb3NpdGl2ZSB2YWx1ZSBhbmQgMSBmb3IgbmVnYXRpdmUuDQorICog
dGhlIHJhbmdlIG9mIHZhbHVlIGlzIFstMl4obS0xKSwgMl4obS0xKSAtIDJeLW5dDQorICoNCisg
KiBGb3IgZXhhbXBsZQ0KKyAqIEEgUTMuMTIgZm9ybWF0IG51bWJlcjoNCisgKiAtIHJlcXVpcmVk
IGJpdDogMyArIDEyID0gMTViaXRzDQorICogLSByYW5nZTogWy0yXjIsIDJeMiAtIDJe4oiSMTVd
DQorICoNCisgKiBOT1RFOiB0aGUgbSBjYW4gYmUgemVybyBpZiBhbGwgYml0X3ByZWNpc2lvbiBh
cmUgdXNlZCB0byBwcmVzZW50IGZyYWN0aW9uYWwNCisgKiAgICAgICBiaXRzIGxpa2UgUTAuMzIN
CisgKi8NCit1aW50NjRfdCBkcm1fY29sb3JfY3RtX3MzMV8zMl90b19xbV9uKHVpbnQ2NF90IHVz
ZXJfaW5wdXQsDQorCQkJCSAgICAgIHVpbnQzMl90IG0sIHVpbnQzMl90IG4pDQorew0KKwl1NjQg
bWFnID0gKHVzZXJfaW5wdXQgJiB+QklUX1VMTCg2MykpID4+ICgzMiAtIG4pOw0KKwlib29sIG5l
Z2F0aXZlID0gISEodXNlcl9pbnB1dCAmIEJJVF9VTEwoNjMpKTsNCisJczY0IHZhbDsNCisNCisJ
V0FSTl9PTihtID4gMzIgfHwgbiA+IDMyKTsNCisNCisNCisJdmFsID0gY2xhbXBfdmFsKG1hZywg
MCwgbmVnYXRpdmUgPw0KKwkJCQlCSVRfVUxMKG4gKyBtIC0gMSkgOiBCSVRfVUxMKG4gKyBtIC0g
MSkgLSAxKTsNCisNCisJcmV0dXJuIG5lZ2F0aXZlID8gLXZhbCA6IHZhbDsNCit9DQorRVhQT1JU
X1NZTUJPTChkcm1fY29sb3JfY3RtX3MzMV8zMl90b19xbV9uKTsNCisNCiAvKioNCiAgKiBkcm1f
Y3J0Y19lbmFibGVfY29sb3JfbWdtdCAtIGVuYWJsZSBjb2xvciBtYW5hZ2VtZW50IHByb3BlcnRp
ZXMNCiAgKiBAY3J0YzogRFJNIENSVEMNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fY29s
b3JfbWdtdC5oIGIvaW5jbHVkZS9kcm0vZHJtX2NvbG9yX21nbXQuaA0KaW5kZXggZDFjNjYyZDky
YWI3Li42MGZlYTU1MDE4ODYgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2RybS9kcm1fY29sb3JfbWdt
dC5oDQorKysgYi9pbmNsdWRlL2RybS9kcm1fY29sb3JfbWdtdC5oDQpAQCAtMzAsNiArMzAsOCBA
QCBzdHJ1Y3QgZHJtX2NydGM7DQogc3RydWN0IGRybV9wbGFuZTsNCiANCiB1aW50MzJfdCBkcm1f
Y29sb3JfbHV0X2V4dHJhY3QodWludDMyX3QgdXNlcl9pbnB1dCwgdWludDMyX3QgYml0X3ByZWNp
c2lvbik7DQordWludDY0X3QgZHJtX2NvbG9yX2N0bV9zMzFfMzJfdG9fcW1fbih1aW50NjRfdCB1
c2VyX2lucHV0LA0KKwkJCQkgICAgICB1aW50MzJfdCBtLCB1aW50MzJfdCBuKTsNCiANCiB2b2lk
IGRybV9jcnRjX2VuYWJsZV9jb2xvcl9tZ210KHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCiAJCQkJ
dWludCBkZWdhbW1hX2x1dF9zaXplLA0KLS0gDQoyLjIwLjENCg0K
