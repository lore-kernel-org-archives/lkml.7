Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A406CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC6E2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vXQeeRw3";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vXQeeRw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfJUHX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:23:27 -0400
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:51700
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfJUHX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=020OchYj8JijBAHrdWnnn2VDtH8VH1V9dp9hCVh+FOI=;
 b=vXQeeRw3ZyCbhNI+z9WrEIS42R0jBbrH08+W3L5Eo8k0BbnJHkzV9ZSqOmuCys7FLPlrpnePBEWY3FoCclgC/jwPa33Xfgf7eoicRRGkrdYoCIoP6MiSvAqr6/FGqA1qQf9eKeKBql6n20763K/gfMyc1XVDvrbhZvNfxnY8zEU=
Received: from VI1PR0802CA0009.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::19) by AM6PR08MB4280.eurprd08.prod.outlook.com
 (2603:10a6:20b:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Mon, 21 Oct
 2019 07:23:19 +0000
Received: from DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR0802CA0009.outlook.office365.com
 (2603:10a6:800:aa::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 07:23:18 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT004.mail.protection.outlook.com (10.152.20.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 07:23:17 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Mon, 21 Oct 2019 07:23:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 28a8ee9281b6052d
X-CR-MTA-TID: 64aa7808
Received: from 456afc599ee0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4A6EA28C-A1ED-4DEE-97E0-03A795C9CCA7.1;
        Mon, 21 Oct 2019 07:23:08 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 456afc599ee0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 07:23:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzvYfTKOHjppEG3iQ19HC+AeCS1cewHJDDGbglKOoAGAEPKHIloXsSi4kCuA4CimlxMN8pfna0WZuKZ67mDWHlqM1y2TM10V8QFz0vlx8o5zAVI38OqRBKHoyf7C+CUGXHQQjNyBrq51cu9L0CwcqvBla4oJJMmjcbp1QGPOHue00vX8OJ8SjT8XLRpreFyjG7xiiP0QI7aTUJmM177Z1PSsLryIk9unhUqhR3Z6RS7woeDluQbDUr8mTA6rb2fwhS3jFtKMWnxLdc3BwNqrl4jE188QBNujio/h23kkoNelM+LtdsTF+W89pwF3vPM2nhg1f4/bHI+kPryqv2OrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=020OchYj8JijBAHrdWnnn2VDtH8VH1V9dp9hCVh+FOI=;
 b=FDtaLFi032/u6iVX8q6BqWqvoUfngqcRK9HSeMwyYndfj6PQi20MDLcO6Xc6uW9NBcH79CtR2+mCsNwQI0fgze3sit7LsEb+47tCRmwCT8hBp3AO0U9DuoZlP7c6gU7NuDC/Tnu+UsvVcCV76iDLs2ZhLRK1bklhCR+7tYOsmKAZbWHo7tI41bpffX9xQ4djV47gTOhcNgeAX/OZCmD7elU/uO11/3Fy/dg2X/UaihZ+r+lpz08f2b5x2Vmnv99ICaqeEfFmNcP2+ddmZ14Q7ZrPi5yqZ9ceSqFxoFN0scrnNkGfXvq1J9HkUIVcZdKEJ6ZlHQNGGNYb3gtkqDVSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=020OchYj8JijBAHrdWnnn2VDtH8VH1V9dp9hCVh+FOI=;
 b=vXQeeRw3ZyCbhNI+z9WrEIS42R0jBbrH08+W3L5Eo8k0BbnJHkzV9ZSqOmuCys7FLPlrpnePBEWY3FoCclgC/jwPa33Xfgf7eoicRRGkrdYoCIoP6MiSvAqr6/FGqA1qQf9eKeKBql6n20763K/gfMyc1XVDvrbhZvNfxnY8zEU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4831.eurprd08.prod.outlook.com (10.255.115.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 21 Oct 2019 07:23:04 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 07:23:04 +0000
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
Subject: [PATCH v6 1/4] drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v6 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVh+Bgb3FMRWa44UmY+hx9enDm4A==
Date:   Mon, 21 Oct 2019 07:23:04 +0000
Message-ID: <20191021072215.3993-2-james.qian.wang@arm.com>
References: <20191021072215.3993-1-james.qian.wang@arm.com>
In-Reply-To: <20191021072215.3993-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ed52ac93-56d9-4555-8aa5-08d755f78aff
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4831:|VE1PR08MB4831:|AM6PR08MB4280:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB42802FADC5C5A30CFD1029D9B3690@AM6PR08MB4280.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39850400004)(396003)(136003)(376002)(199004)(189003)(110136005)(6506007)(6486002)(386003)(66066001)(4326008)(8676002)(66946007)(54906003)(99286004)(103116003)(36756003)(6512007)(6436002)(66446008)(64756008)(66556008)(66476007)(55236004)(2171002)(102836004)(2501003)(26005)(14454004)(186003)(81156014)(81166006)(2201001)(478600001)(11346002)(446003)(316002)(2906002)(7736002)(86362001)(71190400001)(71200400001)(256004)(6116002)(25786009)(305945005)(486006)(3846002)(76176011)(52116002)(5660300002)(8936002)(2616005)(476003)(1076003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4831;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3WWo5SJgScHodatl5YBdY/DvIHZmhF0p+ouACCv/LDiv4iH1s7JHtK0maMaCHYqMbuM36Jp9A+UDIAqCF3MUuOl8BfZxIdoj8hgu654K5ks8+NImXoI9mln6eTIXTz4vqB+ZdLjSOH/0QCxguboPWL29zeMh+781jopwcoyVW3zY4xnnlHmhPHLeCsAS2aPcnumb2JWait4FaUgWEl49MDAwSAxhorePxiCsYgNHjVYnKef7hoi+6WoKpRbRd6Im8Wl0gy1fPdHK46iGM8BhDObpLYOCHPupJTiI2aycsJ0tig3zYZOKxDwwQam+LpepeYZ18pn8RixVNAYblnsK5xTDsOkDgefRaQb2BOfRywckvR36QHQ2yI403Tgg72s8Ojbtahax6Mxt1Vjmr9VOi4567LWVNnq1ZFtNauK7Gw4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6BD622705678F4E94EC730A809E4BCD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4831
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(346002)(136003)(376002)(396003)(199004)(189003)(356004)(76130400001)(25786009)(103116003)(70586007)(70206006)(36756003)(50466002)(2501003)(14454004)(5660300002)(54906003)(110136005)(1076003)(478600001)(316002)(26826003)(22756006)(102836004)(186003)(126002)(6486002)(63350400001)(436003)(2906002)(66066001)(2201001)(26005)(336012)(50226002)(81156014)(7736002)(305945005)(81166006)(2171002)(8936002)(107886003)(86362001)(76176011)(386003)(6506007)(6512007)(99286004)(8676002)(2616005)(2486003)(47776003)(446003)(23676004)(4326008)(486006)(11346002)(476003)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4280;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 736cf389-191b-4bc0-96dd-08d755f782d9
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vA5V1dXLQd8n9hZxKKGbE4qBglNcxf/uOyDzg3EscusJoorBOGhsVtdcE70DAKHPVXHv5u0NeIMzdBAF8THH/NXYleo3VQIC6a5L6pVixItRJPziRtAIWgx2w05BeOqZIPA68hTQkoCFbjo7QbvvOLKltZsq2Cx+/N/DMgu6byJHdJNz7D+4hSaAxwiKRt/Vvgd+IwwCXQvCcc/mP2TZHHoSn5DzrDpqCY/SXNylPZnIpoSGAB4XcFvwyOQjTExiQXGeMWAKg9ejxqk4JAlqX71tXZqf/pSFfT7zJlOYhV+ST0PATfRgwwQzxjjJOfHgWZK2q9LItond5r0nTVmCEw9mBuQzZazBV4umc4wy6z2H48+Vp0SY7F2lqcOcaDRfsZgIm9lVqJGqjDkFARzsM74zAv6UqQgkfl1juJR9ewkP0dxFFxTJWZBK5uQ4h7Kw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 07:23:17.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed52ac93-56d9-4555-8aa5-08d755f78aff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgbmV3IGhlbHBlciBmdW5jdGlvbiBkcm1fY29sb3JfY3RtX3MzMV8zMl90b19xbV9uKCkg
Zm9yIGRyaXZlciB0bw0KY29udmVydCBTMzEuMzIgc2lnbi1tYWduaXR1ZGUgdG8gUW0ubiAyJ3Mg
Y29tcGxlbWVudCB0aGF0IHN1cHBvcnRlZCBieQ0KaGFyZHdhcmUuDQoNClY0OiBBZGRyZXNzIE1p
aGFpLCBEYW5pZWwgYW5kIElsaWEncyByZXZpZXcgY29tbWVudHMuDQpWNTogSW5jbHVkZXMgdGhl
IHNpZ24gYml0IGluIHRoZSB2YWx1ZSBvZiBtIChRbS5uKS4NClY2OiBBbGxvd3MgbSA9PSAwIGFj
Y29yZGluZyB0byBNaWhhaWwncyBjb21tZW50cy4NCg0KU2lnbmVkLW9mZi1ieTogamFtZXMgcWlh
biB3YW5nIChBcm0gVGVjaG5vbG9neSBDaGluYSkgPGphbWVzLnFpYW4ud2FuZ0Bhcm0uY29tPg0K
UmV2aWV3ZWQtYnk6IE1paGFpbCBBdGFuYXNzb3YgPG1paGFpbC5hdGFuYXNzb3ZAYXJtLmNvbT4N
ClJldmlld2VkLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGZmd2xsLmNoPg0KLS0t
DQogZHJpdmVycy9ncHUvZHJtL2RybV9jb2xvcl9tZ210LmMgfCAzNiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvZHJtL2RybV9jb2xvcl9tZ210LmggICAgIHwgIDIg
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9jb2xv
cl9tZ210LmMNCmluZGV4IDRjZTVjNmQ4ZGU5OS4uMGY4MzM0NzBkMDQ5IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9jb2xvcl9tZ210LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9k
cm1fY29sb3JfbWdtdC5jDQpAQCAtMTMyLDYgKzEzMiw0MiBAQCB1aW50MzJfdCBkcm1fY29sb3Jf
bHV0X2V4dHJhY3QodWludDMyX3QgdXNlcl9pbnB1dCwgdWludDMyX3QgYml0X3ByZWNpc2lvbikN
CiB9DQogRVhQT1JUX1NZTUJPTChkcm1fY29sb3JfbHV0X2V4dHJhY3QpOw0KDQorLyoqDQorICog
ZHJtX2NvbG9yX2N0bV9zMzFfMzJfdG9fcW1fbg0KKyAqDQorICogQHVzZXJfaW5wdXQ6IGlucHV0
IHZhbHVlDQorICogQG06IG51bWJlciBvZiBpbnRlZ2VyIGJpdHMsIG9ubHkgc3VwcG9ydCBtIDw9
IDMyLCBpbmNsdWRlIHRoZSBzaWduLWJpdA0KKyAqIEBuOiBudW1iZXIgb2YgZnJhY3Rpb25hbCBi
aXRzLCBvbmx5IHN1cHBvcnQgbiA8PSAzMg0KKyAqDQorICogQ29udmVydCBhbmQgY2xhbXAgUzMx
LjMyIHNpZ24tbWFnbml0dWRlIHRvIFFtLm4gKHNpZ25lZCAyJ3MgY29tcGxlbWVudCkuIFRoZQ0K
KyAqIGhpZ2hlciBiaXRzIHRoYXQgYWJvdmUgbSArIG4gYXJlIGNsZWFyZWQgb3IgZXF1YWwgdG8g
c2lnbi1iaXQgQklUKG0rbikuDQorICogdGhlIHJhbmdlIG9mIHZhbHVlIGlzIFstMl4obS0xKSwg
Ml4obS0xKSAtIDJeLW5dDQorICoNCisgKiBGb3IgZXhhbXBsZQ0KKyAqIEEgUTMuMTIgZm9ybWF0
IG51bWJlcjoNCisgKiAtIHJlcXVpcmVkIGJpdDogMyArIDEyID0gMTViaXRzDQorICogLSByYW5n
ZTogWy0yXjIsIDJeMiAtIDJe4oiSMTVdDQorICoNCisgKiBOT1RFOiB0aGUgbSBjYW4gYmUgemVy
byBpZiBhbGwgYml0X3ByZWNpc2lvbiBhcmUgdXNlZCB0byBwcmVzZW50IGZyYWN0aW9uYWwNCisg
KiAgICAgICBiaXRzIGxpa2UgUTAuMzINCisgKi8NCit1aW50NjRfdCBkcm1fY29sb3JfY3RtX3Mz
MV8zMl90b19xbV9uKHVpbnQ2NF90IHVzZXJfaW5wdXQsDQorCQkJCSAgICAgIHVpbnQzMl90IG0s
IHVpbnQzMl90IG4pDQorew0KKwl1NjQgbWFnID0gKHVzZXJfaW5wdXQgJiB+QklUX1VMTCg2Mykp
ID4+ICgzMiAtIG4pOw0KKwlib29sIG5lZ2F0aXZlID0gISEodXNlcl9pbnB1dCAmIEJJVF9VTEwo
NjMpKTsNCisJczY0IHZhbDsNCisNCisJV0FSTl9PTihtID4gMzIgfHwgbiA+IDMyKTsNCisNCisN
CisJdmFsID0gY2xhbXBfdmFsKG1hZywgMCwgbmVnYXRpdmUgPw0KKwkJCQlCSVRfVUxMKG4gKyBt
IC0gMSkgOiBCSVRfVUxMKG4gKyBtIC0gMSkgLSAxKTsNCisNCisJcmV0dXJuIG5lZ2F0aXZlID8g
LXZhbCA6IHZhbDsNCit9DQorRVhQT1JUX1NZTUJPTChkcm1fY29sb3JfY3RtX3MzMV8zMl90b19x
bV9uKTsNCisNCiAvKioNCiAgKiBkcm1fY3J0Y19lbmFibGVfY29sb3JfbWdtdCAtIGVuYWJsZSBj
b2xvciBtYW5hZ2VtZW50IHByb3BlcnRpZXMNCiAgKiBAY3J0YzogRFJNIENSVEMNCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2RybS9kcm1fY29sb3JfbWdtdC5oIGIvaW5jbHVkZS9kcm0vZHJtX2NvbG9y
X21nbXQuaA0KaW5kZXggZDFjNjYyZDkyYWI3Li42MGZlYTU1MDE4ODYgMTAwNjQ0DQotLS0gYS9p
bmNsdWRlL2RybS9kcm1fY29sb3JfbWdtdC5oDQorKysgYi9pbmNsdWRlL2RybS9kcm1fY29sb3Jf
bWdtdC5oDQpAQCAtMzAsNiArMzAsOCBAQCBzdHJ1Y3QgZHJtX2NydGM7DQogc3RydWN0IGRybV9w
bGFuZTsNCg0KIHVpbnQzMl90IGRybV9jb2xvcl9sdXRfZXh0cmFjdCh1aW50MzJfdCB1c2VyX2lu
cHV0LCB1aW50MzJfdCBiaXRfcHJlY2lzaW9uKTsNCit1aW50NjRfdCBkcm1fY29sb3JfY3RtX3Mz
MV8zMl90b19xbV9uKHVpbnQ2NF90IHVzZXJfaW5wdXQsDQorCQkJCSAgICAgIHVpbnQzMl90IG0s
IHVpbnQzMl90IG4pOw0KDQogdm9pZCBkcm1fY3J0Y19lbmFibGVfY29sb3JfbWdtdChzdHJ1Y3Qg
ZHJtX2NydGMgKmNydGMsDQogCQkJCXVpbnQgZGVnYW1tYV9sdXRfc2l6ZSwNCi0tDQoyLjIwLjEN
Cg==
