Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E623ACA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A1021734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hFAoCQzc";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hFAoCQzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfKAGyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:54:13 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:20611
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKAGyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKQW6Eb95un6S0A37aPXjNKy9DHe+ZMM0AYifmcrwpU=;
 b=hFAoCQzckQZhnxmJJfzJPLVJ7MUtUORTu+BbaZg65fa7SeD4X4TcJyKeOEe/6bgtkBNlEcEzwQLJEkZr3LpOz86dIwai7sdXY/EdWtr2R2+i97zSofLfP/WBS8V9PeLHFSvcf11MgaBOHn+be9DdO2s6+ZN5oolx8EyVezcQHkk=
Received: from VI1PR0802CA0034.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::20) by HE1PR0801MB1802.eurprd08.prod.outlook.com
 (2603:10a6:3:88::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Fri, 1 Nov
 2019 06:54:01 +0000
Received: from DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR0802CA0034.outlook.office365.com
 (2603:10a6:800:a9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 06:54:00 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT058.mail.protection.outlook.com (10.152.20.255) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 06:54:00 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Fri, 01 Nov 2019 06:53:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 92d12cd53eaa3310
X-CR-MTA-TID: 64aa7808
Received: from abe47f65ad90.2 (cr-mta-lb-1.cr-mta-net [104.47.12.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B3EBD2C7-9F12-4CC4-9113-C9F60B07E2B5.1;
        Fri, 01 Nov 2019 06:53:50 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id abe47f65ad90.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 01 Nov 2019 06:53:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODPFK7WWenQsSKWZMXall798vNEwCaxsWbMh5Y7o06vGsIBBJOu3OGCONAbXi+5EGJZkNvsNjO+eSMnFgIWJcPt3A/CCMgsrd1NvU6Y2ShKnyn/OnBkLJn5/SluhhRi/xpuc0IKobTzeHvIv+edG40EvsX0XwHTxHEydTORgNWh5tX48biYNpPpPisY7fuopv04Gzpk6O/jh+r/NXOQHpZki3fT3/3visjNhkUUhMG8iYmcHJHi5YzFCl7TPsjLaRVEvDjM6Zr6hsz+V2gnzC3DxHTC//siPFptiQtsKY9YqHbohAEv9YgNp71dlqp0SKwKi/n0cHL25FHMBMHNHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKQW6Eb95un6S0A37aPXjNKy9DHe+ZMM0AYifmcrwpU=;
 b=ed+pIRp1S+r6iXEMw3vJQofBCUQqk3rncq5Xw9DNQ1YeVs7jGzZqQqdcXAz0R2OTHzFc9AtY0PzhhFOoW39DCyhS3iN7Ub4G3M+wRwd9eakTF35goHJ4bkhrVCGaGhlukLi3oO4qe7cW9f5vR5DzCJx9LPKuz6V2Z+ifihGGt11JmbgkPPoN1OdO5eGVOqNxPAo70MjZd9w3crZZ/R2aeSxkP7Ko432ksjLJIqkNhrHydlP7r7gbSbwHmo9QZojxPCLFN4jU29K2P7Qc+z/NahY2YeRnA5EBoJkCpk1YwiA1VqRut2In6Dnn9mt5HzmH+t80guwrFOaziS6gG8Tfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKQW6Eb95un6S0A37aPXjNKy9DHe+ZMM0AYifmcrwpU=;
 b=hFAoCQzckQZhnxmJJfzJPLVJ7MUtUORTu+BbaZg65fa7SeD4X4TcJyKeOEe/6bgtkBNlEcEzwQLJEkZr3LpOz86dIwai7sdXY/EdWtr2R2+i97zSofLfP/WBS8V9PeLHFSvcf11MgaBOHn+be9DdO2s6+ZN5oolx8EyVezcQHkk=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1SPR01MB0002.eurprd08.prod.outlook.com (20.179.193.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 06:53:48 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 06:53:48 +0000
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
Subject: [PATCH v8 1/4] drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v8 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVkIEc5Q+Snrdv1U6+DG7E3z5ENg==
Date:   Fri, 1 Nov 2019 06:53:48 +0000
Message-ID: <20191101065319.29251-2-james.qian.wang@arm.com>
References: <20191101065319.29251-1-james.qian.wang@arm.com>
In-Reply-To: <20191101065319.29251-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 233a9180-83d0-4e99-ac49-08d75e98467e
X-MS-TrafficTypeDiagnostic: VE1SPR01MB0002:|VE1SPR01MB0002:|HE1PR0801MB1802:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1802D1BA1CF651FAF89B2891B3620@HE1PR0801MB1802.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 020877E0CB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(66066001)(446003)(11346002)(2616005)(486006)(36756003)(8676002)(14454004)(5660300002)(476003)(103116003)(2501003)(2171002)(86362001)(3846002)(6116002)(305945005)(2201001)(25786009)(1076003)(6512007)(66476007)(52116002)(71200400001)(71190400001)(386003)(55236004)(6506007)(6436002)(102836004)(6486002)(7736002)(186003)(99286004)(8936002)(110136005)(4326008)(54906003)(50226002)(478600001)(64756008)(2906002)(66446008)(81156014)(66556008)(316002)(66946007)(81166006)(76176011)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1SPR01MB0002;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LA3SPFQ2Lsfv6b+GKsc2dUYuNvOgCTzXZ2Zdqdx4sOW3m2dXcV6FdA5NJBbCIwhnJXNBVp3btJzOTFwVhpP/6qe8G21BLbkBCBjJ2lfrePHsDMZsuhI0Cgwj3thQxcKe5AzZu/zerThJ31NwfLrT3oe/NsCVZOrZYmPiZxlX17j43bGfSF0l0b85Ly3vD0VaHFEe5uXoxjXdk90utCz14WRZ+ugdwKvDte7WubaO65YphbhX0/L+syY2QCsQ2GCq0+LpYLo15vzPR2x4H+/YPWtEp/XO/LDTuqL+B7PinBA8W/icZNrxnUvpWJ5tim285ANzeMGt2lWuW1TcgfZBZkz/NLXld1GE7AnB3bIFH5tjibsnwCRGh3kI5BNF57FOEGfmlbYceEG40/iUQMGE03M8OlUwV1ZH1v4KFQgpLYqxAjzmudyZRGywzhnqwyih
Content-Type: text/plain; charset="utf-8"
Content-ID: <50920539A9C20C47A86B9DC6F52106ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1SPR01MB0002
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(1110001)(339900001)(189003)(199004)(6486002)(50466002)(186003)(1076003)(11346002)(336012)(26826003)(2616005)(36756003)(47776003)(14454004)(26005)(102836004)(478600001)(436003)(386003)(6506007)(446003)(7736002)(86362001)(305945005)(2201001)(5660300002)(486006)(126002)(476003)(66066001)(25786009)(2501003)(316002)(2171002)(4326008)(81166006)(81156014)(22756006)(6512007)(105606002)(2486003)(76176011)(50226002)(8936002)(3846002)(6116002)(2906002)(76130400001)(99286004)(107886003)(103116003)(70206006)(70586007)(356004)(110136005)(23676004)(8676002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1802;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 51cf4374-da76-413b-1999-08d75e983ed1
NoDisclaimer: True
X-Forefront-PRVS: 020877E0CB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmGi2LvKvpUihWA8JyFEpbS4oxgzZr3x2cfApfe7SQXRn3quZw3jqBy7Bv9M94VDz0iObJcaaGPryE2hqyxHBiRjHyFWVA6hskYPqAI/5PEIbAoRoBVjLjNHCQXWsaoEKhrkVYUUDgGUCemm39X4Pv5MAugLXUbv0T28n/eHxmvTM6zPn6Db4rwJexcdHx5nuHUV/ZAOeuNMjPDUnshNJS/aztnYIdRZihWhLpEEIdbfOyNLmWNC85ykN1aWlw5JkpESRK0obq3n1GzCnTgMdnGmsOXvhmi8y8ChQSeb+og/FKXWAWqu3XlhPK2p/dqHNOlBlbGoOyDkFYFGjaQmyYPMruVHCX6sCl80TjpYOML9/Dktyzq5YU7Tq/Oms2NFUg5dqggJBQbHivD3bxrmcghRP2/YbR4pI5WkIIeSQefnvoLggpRZFV9vOAc5XdWc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:54:00.6410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 233a9180-83d0-4e99-ac49-08d75e98467e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1802
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
dHMuDQpWODogVXNlIHR5cGUgJ3UzMicgdG8gcmVwbGFjZSAndWludDMyX3QnDQoNClNpZ25lZC1v
ZmYtYnk6IGphbWVzIHFpYW4gd2FuZyAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxqYW1lcy5xaWFu
LndhbmdAYXJtLmNvbT4NClJldmlld2VkLWJ5OiBNaWhhaWwgQXRhbmFzc292IDxtaWhhaWwuYXRh
bmFzc292QGFybS5jb20+DQpSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRl
ckBmZndsbC5jaD4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5jIHwgMzQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2RybS9kcm1fY29sb3Jf
bWdtdC5oICAgICB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5jIGIvZHJpdmVycy9n
cHUvZHJtL2RybV9jb2xvcl9tZ210LmMNCmluZGV4IDRjZTVjNmQ4ZGU5OS4uYmE3MWUzYjgyN2Yx
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9jb2xvcl9tZ210LmMNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5jDQpAQCAtMTMyLDYgKzEzMiw0MCBAQCB1aW50
MzJfdCBkcm1fY29sb3JfbHV0X2V4dHJhY3QodWludDMyX3QgdXNlcl9pbnB1dCwgdWludDMyX3Qg
Yml0X3ByZWNpc2lvbikNCiB9DQogRVhQT1JUX1NZTUJPTChkcm1fY29sb3JfbHV0X2V4dHJhY3Qp
Ow0KIA0KKy8qKg0KKyAqIGRybV9jb2xvcl9jdG1fczMxXzMyX3RvX3FtX24NCisgKg0KKyAqIEB1
c2VyX2lucHV0OiBpbnB1dCB2YWx1ZQ0KKyAqIEBtOiBudW1iZXIgb2YgaW50ZWdlciBiaXRzLCBv
bmx5IHN1cHBvcnQgbSA8PSAzMiwgaW5jbHVkZSB0aGUgc2lnbi1iaXQNCisgKiBAbjogbnVtYmVy
IG9mIGZyYWN0aW9uYWwgYml0cywgb25seSBzdXBwb3J0IG4gPD0gMzINCisgKg0KKyAqIENvbnZl
cnQgYW5kIGNsYW1wIFMzMS4zMiBzaWduLW1hZ25pdHVkZSB0byBRbS5uIChzaWduZWQgMidzIGNv
bXBsZW1lbnQpLg0KKyAqIFRoZSBzaWduLWJpdCBCSVQobStuLTEpIGFuZCBhYm92ZSBhcmUgMCBm
b3IgcG9zaXRpdmUgdmFsdWUgYW5kIDEgZm9yIG5lZ2F0aXZlDQorICogdGhlIHJhbmdlIG9mIHZh
bHVlIGlzIFstMl4obS0xKSwgMl4obS0xKSAtIDJeLW5dDQorICoNCisgKiBGb3IgZXhhbXBsZQ0K
KyAqIEEgUTMuMTIgZm9ybWF0IG51bWJlcjoNCisgKiAtIHJlcXVpcmVkIGJpdDogMyArIDEyID0g
MTViaXRzDQorICogLSByYW5nZTogWy0yXjIsIDJeMiAtIDJe4oiSMTVdDQorICoNCisgKiBOT1RF
OiB0aGUgbSBjYW4gYmUgemVybyBpZiBhbGwgYml0X3ByZWNpc2lvbiBhcmUgdXNlZCB0byBwcmVz
ZW50IGZyYWN0aW9uYWwNCisgKiAgICAgICBiaXRzIGxpa2UgUTAuMzINCisgKi8NCit1NjQgZHJt
X2NvbG9yX2N0bV9zMzFfMzJfdG9fcW1fbih1NjQgdXNlcl9pbnB1dCwgdTMyIG0sIHUzMiBuKQ0K
K3sNCisJdTY0IG1hZyA9ICh1c2VyX2lucHV0ICYgfkJJVF9VTEwoNjMpKSA+PiAoMzIgLSBuKTsN
CisJYm9vbCBuZWdhdGl2ZSA9ICEhKHVzZXJfaW5wdXQgJiBCSVRfVUxMKDYzKSk7DQorCXM2NCB2
YWw7DQorDQorCVdBUk5fT04obSA+IDMyIHx8IG4gPiAzMik7DQorDQorCXZhbCA9IGNsYW1wX3Zh
bChtYWcsIDAsIG5lZ2F0aXZlID8NCisJCQkJQklUX1VMTChuICsgbSAtIDEpIDogQklUX1VMTChu
ICsgbSAtIDEpIC0gMSk7DQorDQorCXJldHVybiBuZWdhdGl2ZSA/IC12YWwgOiB2YWw7DQorfQ0K
K0VYUE9SVF9TWU1CT0woZHJtX2NvbG9yX2N0bV9zMzFfMzJfdG9fcW1fbik7DQorDQogLyoqDQog
ICogZHJtX2NydGNfZW5hYmxlX2NvbG9yX21nbXQgLSBlbmFibGUgY29sb3IgbWFuYWdlbWVudCBw
cm9wZXJ0aWVzDQogICogQGNydGM6IERSTSBDUlRDDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0v
ZHJtX2NvbG9yX21nbXQuaCBiL2luY2x1ZGUvZHJtL2RybV9jb2xvcl9tZ210LmgNCmluZGV4IGQx
YzY2MmQ5MmFiNy4uOTk3YTQyYWIyOWY1IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9kcm0vZHJtX2Nv
bG9yX21nbXQuaA0KKysrIGIvaW5jbHVkZS9kcm0vZHJtX2NvbG9yX21nbXQuaA0KQEAgLTMwLDYg
KzMwLDcgQEAgc3RydWN0IGRybV9jcnRjOw0KIHN0cnVjdCBkcm1fcGxhbmU7DQogDQogdWludDMy
X3QgZHJtX2NvbG9yX2x1dF9leHRyYWN0KHVpbnQzMl90IHVzZXJfaW5wdXQsIHVpbnQzMl90IGJp
dF9wcmVjaXNpb24pOw0KK3U2NCBkcm1fY29sb3JfY3RtX3MzMV8zMl90b19xbV9uKHU2NCB1c2Vy
X2lucHV0LCB1MzIgbSwgdTMyIG4pOw0KIA0KIHZvaWQgZHJtX2NydGNfZW5hYmxlX2NvbG9yX21n
bXQoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KIAkJCQl1aW50IGRlZ2FtbWFfbHV0X3NpemUsDQot
LSANCjIuMjAuMQ0KDQo=
