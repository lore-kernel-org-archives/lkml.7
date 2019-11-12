Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A439C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C572084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="a7S8FA0Z";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="a7S8FA0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfKLLKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:10:20 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:64264
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfKLLKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cVA01VPTm34igIPoloOoMRrAW1GGU6jFUdYSaPiuuk=;
 b=a7S8FA0ZNG+RFrvG7J9emCFOZWaTb+z/L/Kd4PePaCk4iMbgxgBCYJQSw0/fMEqd0wBBgQpKJqvMnC7nj6Ur2rniob/EDV+4JE1JR/02dCn3IUJ7BNIDxzY0HoejZQxltuDSCvD/QdXRqPeL4HO/WGavxF9c539tr2GP4lld6wQ=
Received: from VI1PR08CA0124.eurprd08.prod.outlook.com (2603:10a6:800:d4::26)
 by VI1PR0801MB1773.eurprd08.prod.outlook.com (2603:10a6:800:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Tue, 12 Nov
 2019 11:10:10 +0000
Received: from DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR08CA0124.outlook.office365.com
 (2603:10a6:800:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Tue, 12 Nov 2019 11:10:10 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT003.mail.protection.outlook.com (10.152.20.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 11:10:10 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Tue, 12 Nov 2019 11:10:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8c1b62e43d8bdea4
X-CR-MTA-TID: 64aa7808
Received: from 4b70c4a1f660.1 (cr-mta-lb-1.cr-mta-net [104.47.6.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 71930C17-C8E2-4B5B-8258-16B6696CBCBB.1;
        Tue, 12 Nov 2019 11:10:01 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2054.outbound.protection.outlook.com [104.47.6.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4b70c4a1f660.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 12 Nov 2019 11:10:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzosQRvGR0ujEQlIIoyKrrUK5Gz96sfNZttRoq6xfKGSSNaMaCVtBlDaVkSMbCmwYkDGetkMDnyPORsUVQhbQpnzfaU+9Kg8KSr2jYd+25ng0yNGHXWgfaAJgaZX7S6CIf7MahxxPSr+xOcEIWbmN3u5Q91qUwqRC+xO23v5AusjeIIV3ktR8KeJUfvxr/f82iL1C/IvLfD5+bM8lNNiQuaUEJqGIIqHj1dLepVBZmjC8EsIaH7ihJUhCaomE8Y27AlaRAGQjy17oqNWFvpMkQd4DWACAKPphJxnBhISrP417BpuvgJdIpO38ibtBgnQtbZKYBCl1sY0g06oBDnUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cVA01VPTm34igIPoloOoMRrAW1GGU6jFUdYSaPiuuk=;
 b=hY3CzOq7RXygXd7jfDlrzAeu/Jg+eko4WDS3oAWkC2MzrdDVnESnudIK4Gnl+DTMMePw72Yvbs0vY0FjNju0WRYUo5lVXsjN6wrXLWicHHJlf1X/ovoR02XEc3F831psD6OjfbaLpl5VM1Hcyms7F7iMt8NwiJQ0o/K/HwCVcYoKo8oEiqQOXVebv83p3Ga74rSVWE1INvDvYuliredYVFHr9kAjtoSCFfMGOgrLJLFyZcPCQ/MLrInhlc/w08iCvkskA0M0CcBpf8LJIcuA7yvPvNMv0INnzMnNLz50rvG2bQUuwpGn6JNWAErabAoowVs20LzRD2igNHhsiQjoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cVA01VPTm34igIPoloOoMRrAW1GGU6jFUdYSaPiuuk=;
 b=a7S8FA0ZNG+RFrvG7J9emCFOZWaTb+z/L/Kd4PePaCk4iMbgxgBCYJQSw0/fMEqd0wBBgQpKJqvMnC7nj6Ur2rniob/EDV+4JE1JR/02dCn3IUJ7BNIDxzY0HoejZQxltuDSCvD/QdXRqPeL4HO/WGavxF9c539tr2GP4lld6wQ=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB3636.eurprd08.prod.outlook.com (20.177.43.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 11:10:00 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:10:00 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v10 1/4] drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v10 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVmUm5GoYUWOqrlUaBroU+1xdxlw==
Date:   Tue, 12 Nov 2019 11:09:59 +0000
Message-ID: <20191112110927.20931-2-james.qian.wang@arm.com>
References: <20191112110927.20931-1-james.qian.wang@arm.com>
In-Reply-To: <20191112110927.20931-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To AM0PR08MB4995.eurprd08.prod.outlook.com
 (2603:10a6:208:162::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15240894-5b0b-4203-bd75-08d76760e20a
X-MS-TrafficTypeDiagnostic: AM0PR08MB3636:|AM0PR08MB3636:|VI1PR0801MB1773:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1773FF98BBD0FF2BD208C162B3770@VI1PR0801MB1773.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(2906002)(99286004)(446003)(2616005)(476003)(7736002)(66066001)(6512007)(6436002)(6486002)(11346002)(54906003)(256004)(305945005)(103116003)(110136005)(316002)(2201001)(14454004)(6116002)(2501003)(86362001)(3846002)(486006)(71200400001)(71190400001)(186003)(386003)(36756003)(1076003)(6506007)(5660300002)(81166006)(8676002)(4326008)(50226002)(26005)(76176011)(66946007)(2171002)(52116002)(81156014)(66446008)(102836004)(66476007)(64756008)(8936002)(66556008)(25786009)(55236004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3636;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tYu4chbxV2kejrJxKtWJI4gl3py26hLDymUJOBXoo92pdmVZqcIauhquIHPT20GYGAbJXLnzbfaM3yTz0M7sef/eNwhCmnRD0fJXkY+QopME+N5Rd75PMcDKvgxTILyLRpOaYUVEMe9kiewbVSg4IRzN8to8vzQxvmasF1Z3xrhyCPTSzn+Bw5FvxylDuKRdS4bReT6W4KYOzWRmjjwI3uby2sTdGvHhdMvccySZjMyrSApFDhJh90Z38jsvwCJmA9/Bei5rhSJmijcfrPXZXow+6ht0mAXUEzsPm+k2LEqVPlCGBzpQKgnWAhexuyDhoyKj5JqBnpQKI1JVLHe7jXq6Mj7YAG2+TgAhWgozkXi5QIGFT8G7hydscisBXFt74lWOBKRn/w0DaUd/gzeoh+exYIertVHHBtDTdna2nlDj7cwKkdP7FMIePvGqeQ2G
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A2532144974164FB0D33DCB16C5AE24@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3636
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(1110001)(339900001)(189003)(199004)(76130400001)(76176011)(107886003)(6116002)(3846002)(110136005)(54906003)(316002)(2171002)(2501003)(6512007)(22756006)(305945005)(26826003)(5660300002)(47776003)(66066001)(103116003)(478600001)(2906002)(14454004)(7736002)(50466002)(1076003)(86362001)(81156014)(6486002)(336012)(26005)(486006)(446003)(11346002)(186003)(2201001)(2616005)(476003)(126002)(436003)(386003)(50226002)(102836004)(25786009)(6506007)(356004)(99286004)(2486003)(70206006)(36756003)(23676004)(8676002)(81166006)(8936002)(70586007)(4326008)(105606002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1773;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ff22d156-645f-4d84-f095-08d76760dbb1
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Pf6kSXnPO3txBHqJ8ynuwGFdcChWqF95JvbgEZSOkBmFbUedOjsK/DDkzX7WsyeN5vEKSZ+hYjV0EO6jBiRYkzYEzV1k9r1F50L/Ei6mZEMRD76nsvh56z7qFqrQjqvaq2jG10kv1rUgBYpBH6zr5p8oFTmDgPZ/oxS6gZMImnK2noAwd6BhSAMl5dmrn4POHzHtv2m5OdgQAmBx7e6ZhYRvFf5GOMFQvbyMpvDGa/YuGfbBvXQyWhr09zHQLRQxm5yDK/HARpCpoAQt7XMyCzwQUi0GJXrcc6ZnE7pMe8C3oWxZinYi0zBJaYokJFJO/I3N6LD7abAYiyrlmpXEHvgH1vwMJ9BND+4IOYays51X8W5vsiruvy4ORkivL+8W+MsYSSRhFMhHSaiUx8Xs/hPTHKcv/dE/37CrAhBtu9uDPuYGy7gGoH9BdOJNjfn
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 11:10:10.2500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15240894-5b0b-4203-bd75-08d76760e20a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgbmV3IGhlbHBlciBmdW5jdGlvbiBkcm1fY29sb3JfY3RtX3MzMV8zMl90b19xbV9uKCkg
Zm9yIGRyaXZlciB0bw0KY29udmVydCBTMzEuMzIgc2lnbi1tYWduaXR1ZGUgdG8gUW0ubiAyJ3Mg
Y29tcGxlbWVudCB0aGF0IHN1cHBvcnRlZCBieQ0KaGFyZHdhcmUuDQoNClY0OiBBZGRyZXNzIE1p
aGFpLCBEYW5pZWwgYW5kIElsaWEncyByZXZpZXcgY29tbWVudHMuDQpWNTogSW5jbHVkZXMgdGhl
IHNpZ24gYml0IGluIHRoZSB2YWx1ZSBvZiBtIChRbS5uKS4NClY2OiBBbGxvd3MgbSA9IDAgYWNj
b3JkaW5nIHRvIE1paGFpbCdzIGNvbW1lbnRzLg0KVjc6IEFkZHJlc3MgTWloYWlsJ3MgY29tbWVu
dHMuDQpWODogVXNlIHR5cGUgJ3UzMicgdG8gcmVwbGFjZSAndWludDMyX3QnDQpWOTogUmViYXNl
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBqYW1lcyBxaWFuIHdhbmcgKEFybSBUZWNobm9sb2d5IENoaW5h
KSA8amFtZXMucWlhbi53YW5nQGFybS5jb20+DQpSZXZpZXdlZC1ieTogTWloYWlsIEF0YW5hc3Nv
diA8bWloYWlsLmF0YW5hc3NvdkBhcm0uY29tPg0KUmV2aWV3ZWQtYnk6IERhbmllbCBWZXR0ZXIg
PGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vZHJtX2NvbG9y
X21nbXQuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9k
cm0vZHJtX2NvbG9yX21nbXQuaCAgICAgfCAgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2NvbG9yX21nbXQu
YyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5jDQppbmRleCA0Y2U1YzZkOGRlOTku
LmJhNzFlM2I4MjdmMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdt
dC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2NvbG9yX21nbXQuYw0KQEAgLTEzMiw2ICsx
MzIsNDAgQEAgdWludDMyX3QgZHJtX2NvbG9yX2x1dF9leHRyYWN0KHVpbnQzMl90IHVzZXJfaW5w
dXQsIHVpbnQzMl90IGJpdF9wcmVjaXNpb24pDQogfQ0KIEVYUE9SVF9TWU1CT0woZHJtX2NvbG9y
X2x1dF9leHRyYWN0KTsNCiANCisvKioNCisgKiBkcm1fY29sb3JfY3RtX3MzMV8zMl90b19xbV9u
DQorICoNCisgKiBAdXNlcl9pbnB1dDogaW5wdXQgdmFsdWUNCisgKiBAbTogbnVtYmVyIG9mIGlu
dGVnZXIgYml0cywgb25seSBzdXBwb3J0IG0gPD0gMzIsIGluY2x1ZGUgdGhlIHNpZ24tYml0DQor
ICogQG46IG51bWJlciBvZiBmcmFjdGlvbmFsIGJpdHMsIG9ubHkgc3VwcG9ydCBuIDw9IDMyDQor
ICoNCisgKiBDb252ZXJ0IGFuZCBjbGFtcCBTMzEuMzIgc2lnbi1tYWduaXR1ZGUgdG8gUW0ubiAo
c2lnbmVkIDIncyBjb21wbGVtZW50KS4NCisgKiBUaGUgc2lnbi1iaXQgQklUKG0rbi0xKSBhbmQg
YWJvdmUgYXJlIDAgZm9yIHBvc2l0aXZlIHZhbHVlIGFuZCAxIGZvciBuZWdhdGl2ZQ0KKyAqIHRo
ZSByYW5nZSBvZiB2YWx1ZSBpcyBbLTJeKG0tMSksIDJeKG0tMSkgLSAyXi1uXQ0KKyAqDQorICog
Rm9yIGV4YW1wbGUNCisgKiBBIFEzLjEyIGZvcm1hdCBudW1iZXI6DQorICogLSByZXF1aXJlZCBi
aXQ6IDMgKyAxMiA9IDE1Yml0cw0KKyAqIC0gcmFuZ2U6IFstMl4yLCAyXjIgLSAyXuKIkjE1XQ0K
KyAqDQorICogTk9URTogdGhlIG0gY2FuIGJlIHplcm8gaWYgYWxsIGJpdF9wcmVjaXNpb24gYXJl
IHVzZWQgdG8gcHJlc2VudCBmcmFjdGlvbmFsDQorICogICAgICAgYml0cyBsaWtlIFEwLjMyDQor
ICovDQordTY0IGRybV9jb2xvcl9jdG1fczMxXzMyX3RvX3FtX24odTY0IHVzZXJfaW5wdXQsIHUz
MiBtLCB1MzIgbikNCit7DQorCXU2NCBtYWcgPSAodXNlcl9pbnB1dCAmIH5CSVRfVUxMKDYzKSkg
Pj4gKDMyIC0gbik7DQorCWJvb2wgbmVnYXRpdmUgPSAhISh1c2VyX2lucHV0ICYgQklUX1VMTCg2
MykpOw0KKwlzNjQgdmFsOw0KKw0KKwlXQVJOX09OKG0gPiAzMiB8fCBuID4gMzIpOw0KKw0KKwl2
YWwgPSBjbGFtcF92YWwobWFnLCAwLCBuZWdhdGl2ZSA/DQorCQkJCUJJVF9VTEwobiArIG0gLSAx
KSA6IEJJVF9VTEwobiArIG0gLSAxKSAtIDEpOw0KKw0KKwlyZXR1cm4gbmVnYXRpdmUgPyAtdmFs
IDogdmFsOw0KK30NCitFWFBPUlRfU1lNQk9MKGRybV9jb2xvcl9jdG1fczMxXzMyX3RvX3FtX24p
Ow0KKw0KIC8qKg0KICAqIGRybV9jcnRjX2VuYWJsZV9jb2xvcl9tZ210IC0gZW5hYmxlIGNvbG9y
IG1hbmFnZW1lbnQgcHJvcGVydGllcw0KICAqIEBjcnRjOiBEUk0gQ1JUQw0KZGlmZiAtLWdpdCBh
L2luY2x1ZGUvZHJtL2RybV9jb2xvcl9tZ210LmggYi9pbmNsdWRlL2RybS9kcm1fY29sb3JfbWdt
dC5oDQppbmRleCBkMWM2NjJkOTJhYjcuLjk5N2E0MmFiMjlmNSAxMDA2NDQNCi0tLSBhL2luY2x1
ZGUvZHJtL2RybV9jb2xvcl9tZ210LmgNCisrKyBiL2luY2x1ZGUvZHJtL2RybV9jb2xvcl9tZ210
LmgNCkBAIC0zMCw2ICszMCw3IEBAIHN0cnVjdCBkcm1fY3J0YzsNCiBzdHJ1Y3QgZHJtX3BsYW5l
Ow0KIA0KIHVpbnQzMl90IGRybV9jb2xvcl9sdXRfZXh0cmFjdCh1aW50MzJfdCB1c2VyX2lucHV0
LCB1aW50MzJfdCBiaXRfcHJlY2lzaW9uKTsNCit1NjQgZHJtX2NvbG9yX2N0bV9zMzFfMzJfdG9f
cW1fbih1NjQgdXNlcl9pbnB1dCwgdTMyIG0sIHUzMiBuKTsNCiANCiB2b2lkIGRybV9jcnRjX2Vu
YWJsZV9jb2xvcl9tZ210KHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCiAJCQkJdWludCBkZWdhbW1h
X2x1dF9zaXplLA0KLS0gDQoyLjIwLjENCg0K
