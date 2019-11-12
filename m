Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105BEC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB4820674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ryJcvghU";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ryJcvghU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfKLKkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:40:39 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:35399
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfKLKki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xvTegslMD5L2ZURhngFfxlrPcslIxpmCTDULZVxcYM=;
 b=ryJcvghUMnexM7ge7eE8VundpyqFzbWEbOk9bopnKiSpStzppcSqhMFC82RU5tTWDJkNeXTndiYw59OOvpAEnarwQ3dqoqET/EatuoTlLfyFwIm8bS1vJ06i68MfhFL6uc3w64x3wtlrClnrZKINUhQ7ynir1Bk+tar+9Jnv0pY=
Received: from VI1PR0802CA0011.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::21) by AM0PR08MB5155.eurprd08.prod.outlook.com
 (2603:10a6:208:15f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Tue, 12 Nov
 2019 10:40:33 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by VI1PR0802CA0011.outlook.office365.com
 (2603:10a6:800:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.24 via Frontend
 Transport; Tue, 12 Nov 2019 10:40:33 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 10:40:32 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Tue, 12 Nov 2019 10:40:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0223c4c3e8757ecc
X-CR-MTA-TID: 64aa7808
Received: from de65cc25b090.2 (cr-mta-lb-1.cr-mta-net [104.47.10.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F759FE6A-C118-4ADD-B299-F8CF3F1BE2B2.1;
        Tue, 12 Nov 2019 10:40:26 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2051.outbound.protection.outlook.com [104.47.10.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id de65cc25b090.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 12 Nov 2019 10:40:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLzOZrLe+GNCkmAUFv7kFffBcSZ9epXDbttamNCXgD7oDrmVKsTzsfWgD6pxAdoT4gScY311G0o5oAgJHPrNnMxQXRQeE74lRkRPOuuRe/u1lF1agKeFRpSb/SVNX5ECj0hJbiqDSGVFz+zc7ZQnBDt9WLJEu6xF9fqzZlRfkgtsOfB3aJU7fmiE7QflcES+IZ1RSx3EVtolR7F9V1cdOjrcf4BuFtbybn9jCYBsUsSixhSN3sFwAR+PmTQF6THmge3vHYbHSZFdApqw6YYlWWPww1+Kmik1dJ74g3BKlilMePr1HxMxJZ4autZC0F1B7N57cJ7p1VezH9Ht8BwiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xvTegslMD5L2ZURhngFfxlrPcslIxpmCTDULZVxcYM=;
 b=KqFg0vtulZoKcY3rAUtPXwRLL8t6VsRXhphh1OFG+6PyhUMWmc7LmgHMGyeItCiMs80/EvbUoQiOYBQe0f4GOEQBthhU/23X1jqrRujJ6gxM3+Uj7SoCAQJc26bA6SK8IXeADu/QMQVyQ6TUjDZbaHXaKW2aHELcEYgg1n8zDcLA1SVF/wqbLtsUvs4NoNi9YFPeWdnoeEf58/hRdD9CUINtJVWEhdn18P/ZJq0vA+Q0zYNdt1rZKixUReuwse2c0U9y6hX88Oxi99W/WBK7vpFQKiLkGY7C2r0i4avBVlXoXFE0OVgAeQiKEEmzykp1Oo6/mTi1uq+9D3fFdJmhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xvTegslMD5L2ZURhngFfxlrPcslIxpmCTDULZVxcYM=;
 b=ryJcvghUMnexM7ge7eE8VundpyqFzbWEbOk9bopnKiSpStzppcSqhMFC82RU5tTWDJkNeXTndiYw59OOvpAEnarwQ3dqoqET/EatuoTlLfyFwIm8bS1vJ06i68MfhFL6uc3w64x3wtlrClnrZKINUhQ7ynir1Bk+tar+9Jnv0pY=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB4082.eurprd08.prod.outlook.com (20.178.119.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 10:40:24 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 10:40:24 +0000
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
Subject: [PATCH v9 1/4] drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v9 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVmUWWuw5SiCc2fkWBYrtItjbs1w==
Date:   Tue, 12 Nov 2019 10:40:24 +0000
Message-ID: <20191112103956.19074-2-james.qian.wang@arm.com>
References: <20191112103956.19074-1-james.qian.wang@arm.com>
In-Reply-To: <20191112103956.19074-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:203:72::27) To AM0PR08MB4995.eurprd08.prod.outlook.com
 (2603:10a6:208:162::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d407a45-32b9-44b6-1992-08d7675cbeb1
X-MS-TrafficTypeDiagnostic: AM0PR08MB4082:|AM0PR08MB4082:|AM0PR08MB5155:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5155A15287EA05C2423282B5B3770@AM0PR08MB5155.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(86362001)(6512007)(478600001)(66066001)(54906003)(110136005)(316002)(5660300002)(6486002)(14454004)(2171002)(11346002)(446003)(2616005)(6436002)(25786009)(476003)(2201001)(5024004)(1076003)(6506007)(8936002)(386003)(99286004)(2906002)(4326008)(55236004)(102836004)(103116003)(256004)(66946007)(66556008)(66476007)(64756008)(66446008)(6116002)(3846002)(52116002)(26005)(81166006)(81156014)(8676002)(186003)(7736002)(486006)(71190400001)(71200400001)(36756003)(305945005)(76176011)(50226002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4082;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ReJv4jvD7YQLbC0YnVJnn44xbYNi/jreBYFSKCUPDERxW6BYEVnTbfKfzuvIuwcOlQwa3WBAFr3tx/1jbCPU36cuQmE4qbQq4RYeGWlhC99Wd6ZH8w5rozz1xaBWsttThognlCVnN8fBlehCtj7ELL9JI+vkwvK+DNbVqUuuFlWnxd4/66HRw9aL16ahl9R6/oExbhJtP2oN8Ey6MEGBz5B/+CUDLPwnziKrhSb7CofYSxt+NLZVKH/ULXbtDqvgBsxKZx+WmdDTtDOWRyamxR9Y+Zy8ohEn1Jctrn7Smk8YXH+yBCUx4U2zNa+jnOd8vAKhVBkvi1G4n3SIsfnqOxPMNHJY4Kg8Ldyf6t2ZC7DarguxahpShWkhZQTZNWWxxAtC4tzWuUEHzs7UZubtbfR3MU9ePBdGeQJssqWq0cESobbWavLbE+JauN/IuOK5
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDC123B376106B4E906BEB65FED792E5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4082
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(1110001)(339900001)(199004)(189003)(103116003)(478600001)(2201001)(26826003)(3846002)(6116002)(186003)(316002)(14454004)(76176011)(23676004)(6506007)(386003)(25786009)(70586007)(36906005)(1076003)(70206006)(2486003)(336012)(486006)(2616005)(436003)(476003)(126002)(446003)(11346002)(26005)(102836004)(6486002)(47776003)(7736002)(86362001)(50226002)(5024004)(2906002)(66066001)(8676002)(105606002)(81166006)(81156014)(36756003)(8936002)(5660300002)(50466002)(305945005)(110136005)(54906003)(22756006)(6512007)(99286004)(76130400001)(107886003)(2171002)(4326008)(356004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5155;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8aa1d5c2-c8ce-41c6-da6a-08d7675cb94f
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZ8YyYQz4gz9XMaMleAZaOIE/T6iyDehe87TBqK7vvhHCSQVGT5YSJVZMtnnW8moBzogHBGnqBRUTOPL3NX8uMysS3LNvIJRSRkonZOJxlN0L6Agh45U8VAReiftx85fn0o6GNb3LxvSPD1PbC1WCDVHuM5iy0s2fqQ1ntnKq71yjH3shaHjIguSwSZ8YbdtkDMuueQP5MjGUFHFWStfBnkYvSC3ydDyG70rvxEGFVIf/7Q6p9bhP8RRg6runRSK2+LlhqkObhDbE9yNCP/gELua3QWmjskDUeyydM+/kNFNJTiKr6YjyOyxFSZqZUv/X0ZE2JmiJt2Xh099ByVSsenBzXvOhcdXNNIl8CxsxcCve2N5EAlO3FHMIOWzYk8U3gNYUlD6CZQqaB3Z6l3NrKaK9wWCS72rOgQ056FVsa3tVer8oFo/yNNgQfFfycTV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:40:32.9003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d407a45-32b9-44b6-1992-08d7675cbeb1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5155
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
dHMuDQpWODogVXNlIHR5cGUgJ3UzMicgdG8gcmVwbGFjZSAndWludDMyX3QnDQp2OTogUmViYXNl
DQoNClNpZ25lZC1vZmYtYnk6IGphbWVzIHFpYW4gd2FuZyAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEp
IDxqYW1lcy5xaWFuLndhbmdAYXJtLmNvbT4NClJldmlld2VkLWJ5OiBNaWhhaWwgQXRhbmFzc292
IDxtaWhhaWwuYXRhbmFzc292QGFybS5jb20+DQpSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRlciA8
ZGFuaWVsLnZldHRlckBmZndsbC5jaD4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3Jf
bWdtdC5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2Ry
bS9kcm1fY29sb3JfbWdtdC5oICAgICB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDM2IGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5j
IGIvZHJpdmVycy9ncHUvZHJtL2RybV9jb2xvcl9tZ210LmMNCmluZGV4IDRjZTVjNmQ4ZGU5OS4u
OWRlMTBhYmM3YTk2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9jb2xvcl9tZ210
LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5jDQpAQCAtMTMyLDkgKzEz
Miw0NCBAQCB1aW50MzJfdCBkcm1fY29sb3JfbHV0X2V4dHJhY3QodWludDMyX3QgdXNlcl9pbnB1
dCwgdWludDMyX3QgYml0X3ByZWNpc2lvbikNCiB9DQogRVhQT1JUX1NZTUJPTChkcm1fY29sb3Jf
bHV0X2V4dHJhY3QpOw0KDQorLyoqDQorICogZHJtX2NvbG9yX2N0bV9zMzFfMzJfdG9fcW1fbg0K
KyAqDQorICogQHVzZXJfaW5wdXQ6IGlucHV0IHZhbHVlDQorICogQG06IG51bWJlciBvZiBpbnRl
Z2VyIGJpdHMsIG9ubHkgc3VwcG9ydCBtIDw9IDMyLCBpbmNsdWRlIHRoZSBzaWduLWJpdA0KKyAq
IEBuOiBudW1iZXIgb2YgZnJhY3Rpb25hbCBiaXRzLCBvbmx5IHN1cHBvcnQgbiA8PSAzMg0KKyAq
DQorICogQ29udmVydCBhbmQgY2xhbXAgUzMxLjMyIHNpZ24tbWFnbml0dWRlIHRvIFFtLm4gKHNp
Z25lZCAyJ3MgY29tcGxlbWVudCkuDQorICogVGhlIHNpZ24tYml0IEJJVChtK24tMSkgYW5kIGFi
b3ZlIGFyZSAwIGZvciBwb3NpdGl2ZSB2YWx1ZSBhbmQgMSBmb3IgbmVnYXRpdmUNCisgKiB0aGUg
cmFuZ2Ugb2YgdmFsdWUgaXMgWy0yXihtLTEpLCAyXihtLTEpIC0gMl4tbl0NCisgKg0KKyAqIEZv
ciBleGFtcGxlDQorICogQSBRMy4xMiBmb3JtYXQgbnVtYmVyOg0KKyAqIC0gcmVxdWlyZWQgYml0
OiAzICsgMTIgPSAxNWJpdHMNCisgKiAtIHJhbmdlOiBbLTJeMiwgMl4yIC0gMl7iiJIxNV0NCisg
Kg0KKyAqIE5PVEU6IHRoZSBtIGNhbiBiZSB6ZXJvIGlmIGFsbCBiaXRfcHJlY2lzaW9uIGFyZSB1
c2VkIHRvIHByZXNlbnQgZnJhY3Rpb25hbA0KKyAqICAgICAgIGJpdHMgbGlrZSBRMC4zMg0KKyAq
Lw0KK3U2NCBkcm1fY29sb3JfY3RtX3MzMV8zMl90b19xbV9uKHU2NCB1c2VyX2lucHV0LCB1MzIg
bSwgdTMyIG4pDQorew0KKwl1NjQgbWFnID0gKHVzZXJfaW5wdXQgJiB+QklUX1VMTCg2MykpID4+
ICgzMiAtIG4pOw0KKwlib29sIG5lZ2F0aXZlID0gISEodXNlcl9pbnB1dCAmIEJJVF9VTEwoNjMp
KTsNCisJczY0IHZhbDsNCisNCisJV0FSTl9PTihtID4gMzIgfHwgbiA+IDMyKTsNCisNCisJdmFs
ID0gY2xhbXBfdmFsKG1hZywgMCwgbmVnYXRpdmUgPw0KKwkJCQlCSVRfVUxMKG4gKyBtIC0gMSkg
OiBCSVRfVUxMKG4gKyBtIC0gMSkgLSAxKTsNCisNCisJcmV0dXJuIG5lZ2F0aXZlID8gLXZhbCA6
IHZhbDsNCit9DQorRVhQT1JUX1NZTUJPTChkcm1fY29sb3JfY3RtX3MzMV8zMl90b19xbV9uKTsN
CisNCiAvKioNCiAgKiBkcm1fY3J0Y19lbmFibGVfY29sb3JfbWdtdCAtIGVuYWJsZSBjb2xvciBt
YW5hZ2VtZW50IHByb3BlcnRpZXMNCiAgKiBAY3J0YzogRFJNIENSVEMNCisgKg0KICAqIEBkZWdh
bW1hX2x1dF9zaXplOiB0aGUgc2l6ZSBvZiB0aGUgZGVnYW1tYSBsdXQgKGJlZm9yZSBDU0MpDQog
ICogQGhhc19jdG06IHdoZXRoZXIgdG8gYXR0YWNoIGN0bV9wcm9wZXJ0eSBmb3IgQ1NDIG1hdHJp
eA0KICAqIEBnYW1tYV9sdXRfc2l6ZTogdGhlIHNpemUgb2YgdGhlIGdhbW1hIGx1dCAoYWZ0ZXIg
Q1NDKQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9jb2xvcl9tZ210LmggYi9pbmNsdWRl
L2RybS9kcm1fY29sb3JfbWdtdC5oDQppbmRleCBkMWM2NjJkOTJhYjcuLjk5N2E0MmFiMjlmNSAx
MDA2NDQNCi0tLSBhL2luY2x1ZGUvZHJtL2RybV9jb2xvcl9tZ210LmgNCisrKyBiL2luY2x1ZGUv
ZHJtL2RybV9jb2xvcl9tZ210LmgNCkBAIC0zMCw2ICszMCw3IEBAIHN0cnVjdCBkcm1fY3J0YzsN
CiBzdHJ1Y3QgZHJtX3BsYW5lOw0KDQogdWludDMyX3QgZHJtX2NvbG9yX2x1dF9leHRyYWN0KHVp
bnQzMl90IHVzZXJfaW5wdXQsIHVpbnQzMl90IGJpdF9wcmVjaXNpb24pOw0KK3U2NCBkcm1fY29s
b3JfY3RtX3MzMV8zMl90b19xbV9uKHU2NCB1c2VyX2lucHV0LCB1MzIgbSwgdTMyIG4pOw0KDQog
dm9pZCBkcm1fY3J0Y19lbmFibGVfY29sb3JfbWdtdChzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQog
CQkJCXVpbnQgZGVnYW1tYV9sdXRfc2l6ZSwNCi0tDQoyLjIwLjENCg==
