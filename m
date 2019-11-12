Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A627FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9452246F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="06fTtVFp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wSzeEr91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfKLLVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:21:37 -0500
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:62634
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLLVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x0zRDUbtPs4da7ITik+U04UrZ6qv7CMSk1eqzqaYE4=;
 b=06fTtVFpN1x6PfaPS6SFyPu0eDvJ8zThv/uwMM2d/1QXYJ1aEdm68i2S2t+C49tuXgKzKc/nFB13KqRqNwMwUA1buf4KfyOfSMtImcaPwh1AvHb/Bp88mg3/REaZKIJmBP2bvCS7Go2zIIB0x2Sp4OnudhmA2Uryh1/tWTtcC5I=
Received: from VI1PR08CA0167.eurprd08.prod.outlook.com (2603:10a6:800:d1::21)
 by AM4PR0802MB2338.eurprd08.prod.outlook.com (2603:10a6:200:63::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.23; Tue, 12 Nov
 2019 11:21:26 +0000
Received: from VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by VI1PR08CA0167.outlook.office365.com
 (2603:10a6:800:d1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Tue, 12 Nov 2019 11:21:25 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT016.mail.protection.outlook.com (10.152.18.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 11:21:25 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Tue, 12 Nov 2019 11:21:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b19032987133da1b
X-CR-MTA-TID: 64aa7808
Received: from b71d13966898.2 (cr-mta-lb-1.cr-mta-net [104.47.13.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7A71CA8A-B891-43D3-96D6-C4C5A950BCAB.1;
        Tue, 12 Nov 2019 11:21:19 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b71d13966898.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 12 Nov 2019 11:21:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwkXyZzPDlGqJXSnS8f1T5rgiOBXmbEjbfOFDWx3zogtyX+XOgeiXQ6stg1U1ErfB6lKUHyl6CmCflpn3czBSGq6SddHx1fMhomRYyi0Jwx0UDy7AGR4fThUZriWzzck4mvPAKiSdlIVBuCQk+5x11BtycbeHeUQ+fTAuPFu7vPUqkRTbzWweYI93vLIOlmzbjcAFpLs9+ADlI3vP1++bp6vvk32e/42j641AsdjkXRA7j0CccVHrSiyFuL/gQZwxGTM3F0r1TjUiQ0BRLCjhLodmciQRZkrDqsd851TIONBqTo3Ng0iF5ncCyDOpV66DMaNn2KcPmFCjz2R5PC2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e325fy4VQ4Ggo/DAwZCPwzanUudRC2O4X7Ik0Eo1u+I=;
 b=V4xpUHfQp9QSmxggcbsDup0ZhtXynjYdoOdBxBwHT240yXJAjDk5tQZD5B0pS4a41qBO4tv0zxLlxRZyI4ab6Zt67wK0DrKBj9a55izTvfmFz/qwVqtF1O6uINBFRhucwrbsNSrJn5i1SsOqgSLPmqUnUYxVaEpQ+J2U/lsiUQN8sTb9HpsSchaOMECVwlIImPBGcoDt2SyrW5FiG2igirLeYYbfM9VgByE2ER391z1uBBloNaDibC06pTlSMvEQowPxe0sPdm+KKBkGVB9oYKkaTle5t0O3KJyIrNKnHKE9OAwwwUIPKG395WVuV353SF5g7BgKgb+y3s2gICVbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e325fy4VQ4Ggo/DAwZCPwzanUudRC2O4X7Ik0Eo1u+I=;
 b=wSzeEr91rhazrQWcO7HicKbLCv2oLTc3g2nRLPa009kO+xFKnzhXpJ9eiSKBqYO3/WVsx4D6wLksmYvq2JTu3tyc44d0GG+nb5Zx/F0ZR7ZAxnaNwT9Iz3KbVvEjqciXS8aqaDv5XiKjMmMxubMqmtqceZi6etsq48NfkobUn6A=
Received: from VE1PR08MB4800.eurprd08.prod.outlook.com (10.255.114.10) by
 VE1PR08MB4688.eurprd08.prod.outlook.com (10.255.112.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Tue, 12 Nov 2019 11:21:17 +0000
Received: from VE1PR08MB4800.eurprd08.prod.outlook.com
 ([fe80::2d7d:f046:7dc3:d9de]) by VE1PR08MB4800.eurprd08.prod.outlook.com
 ([fe80::2d7d:f046:7dc3:d9de%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:21:17 +0000
From:   Lukasz Luba <Lukasz.Luba@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "qperret@google.com" <qperret@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amit.kachhap@gmail.com" <amit.kachhap@gmail.com>,
        "javi.merino@kernel.org" <javi.merino@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [Patch v5 0/6] Introduce Thermal Pressure
Thread-Topic: [Patch v5 0/6] Introduce Thermal Pressure
Thread-Index: AQHVmUtL4/UV0iSxD0W1GNBDCHNdbQ==
Date:   Tue, 12 Nov 2019 11:21:17 +0000
Message-ID: <cb27d440-1421-b95e-19c3-4278dd37efda@arm.com>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::28) To VE1PR08MB4800.eurprd08.prod.outlook.com
 (2603:10a6:802:a9::10)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lukasz.Luba@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.96.140]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ddd1f5a-832f-4c94-e0a8-08d7676274bb
X-MS-TrafficTypeDiagnostic: VE1PR08MB4688:|VE1PR08MB4688:|AM4PR0802MB2338:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB233802EA1830C4E075E204A5E5770@AM4PR0802MB2338.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(54906003)(64756008)(81166006)(6116002)(14454004)(316002)(2906002)(31686004)(3846002)(66476007)(66556008)(66946007)(99286004)(25786009)(8936002)(81156014)(8676002)(478600001)(66446008)(6436002)(6916009)(446003)(229853002)(26005)(11346002)(476003)(186003)(44832011)(2616005)(4326008)(256004)(102836004)(14444005)(6486002)(386003)(6506007)(53546011)(76176011)(36756003)(71190400001)(71200400001)(31696002)(305945005)(7736002)(7416002)(86362001)(5660300002)(66066001)(486006)(6512007)(52116002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4688;H:VE1PR08MB4800.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: f3tk//DrbJDmylLg5fz4DDn4pIVw0C3CiK4RNIg4uxLsBX71rej/BaWSLtScjPmt1TliqFrZNwE3O9CIAxBett4iepLOlD7Hr2QXCmeSY2TWVTkbJ6d3xZCKu041mUGDZF3aDL/4mUhR5VZItv1QNavz9xpuwne00jZMMrRIsMRFEHwdqnWwOv0mdJeIWZ3hPvHC+V8kU/wftVDQx7QpTwt8V6P1AR+JY5wDKtWOxdbsIoK/lXjEad/TF3b5dhh78QqNjFsL+gWn/wIT52E3Zc6KkoEKmkPB3nN57obNUXRp2gwpBtcEkjoFPCmWOzBUhBY078qKHWWkT606cYBhi0UDcaH5CrF602Axpkbhi8VYxqbfwfY+Ufexl+02WpJ5wAY/sHvh6Qcy3uBl1RsusS0bo12ct9uO0DCPwoRVAUCdoP7COAvlI9LZUki08Amg
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F8F0A6B7C6661448EE6565E0892A378@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4688
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lukasz.Luba@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(1110001)(339900001)(40434004)(189003)(199004)(6486002)(386003)(2616005)(476003)(6512007)(336012)(436003)(11346002)(446003)(47776003)(105606002)(66066001)(6506007)(53546011)(2486003)(23676004)(50466002)(76176011)(70206006)(70586007)(5660300002)(186003)(126002)(22756006)(229853002)(102836004)(316002)(3846002)(99286004)(14444005)(5024004)(25786009)(31686004)(26005)(107886003)(6862004)(26826003)(478600001)(8936002)(14454004)(76130400001)(36756003)(31696002)(54906003)(6246003)(2906002)(8676002)(7736002)(305945005)(4326008)(356004)(486006)(6116002)(81156014)(81166006)(86362001)(36906005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2338;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e40e176-5082-4412-08c8-08d767626f57
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhlkTiesqcLLKHRyX5lDS0RgfLi4mAiz5Io4iKr//81HgbknPhuaCgHSm1F3v1RNsaF6bNIf3eZ69z57aHU7udgGY9oIDlS3qH0fiz6ZfGZwUlHfTW1ap8pwGpnaom4BrBhXMweZZ9bMdiiDcOD73qkoepYT+jBuQYUxRyw0OF1bxtA8x0Zq6U0939t7nMNBaTmAg4DpuzthJq178XbX57I2pVKbSU4ZTE61/XfEjP0PRlSn0dXijZ8N7fZ4P5fTl5dTR+kAZ59NGgDlzDq++r2G8nvOIn8sgf4dMp7YEUVbCEYzbKhFdSP4PPe8xmtfOf4X8Jy4NqcrmiccWkwetx3WrUpTL2FvdwUcFohJNB3PD0rqCAOo79jWdzEdSRoTcB8KFC0MKKO12PeBr2UuVBsQncF+8Gnuy0bLvNNJTUvOq7np/7rFzd0tkbksHAWp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 11:21:25.8039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddd1f5a-832f-4c94-e0a8-08d7676274bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhhcmEsDQoNCkkgYW0gZ29pbmcgdG8gdHJ5IHlvdXIgcGF0Y2ggc2V0IG9uIHNvbWUgZGlm
ZmVyZW50IGJvYXJkLg0KVG8gZG8gdGhhdCBJIG5lZWQgbW9yZSBpbmZvcm1hdGlvbiByZWdhcmRp
bmcgeW91ciBzZXR1cC4NClBsZWFzZSBmaW5kIG15IGNvbW1lbnRzIGJlbG93LiBJIG5lZWQgcHJv
YmFibHkgb25lIGhhY2sNCndoaWNoIGRvIG5vdCBmdWxseSB1bmRlcnN0YW5kLg0KDQpPbiAxMS81
LzE5IDY6NDkgUE0sIFRoYXJhIEdvcGluYXRoIHdyb3RlOg0KPiBUaGVybWFsIGdvdmVybm9ycyBj
YW4gcmVzcG9uZCB0byBhbiBvdmVyaGVhdCBldmVudCBvZiBhIGNwdSBieQ0KPiBjYXBwaW5nIHRo
ZSBjcHUncyBtYXhpbXVtIHBvc3NpYmxlIGZyZXF1ZW5jeS4gVGhpcyBpbiB0dXJuDQo+IG1lYW5z
IHRoYXQgdGhlIG1heGltdW0gYXZhaWxhYmxlIGNvbXB1dGUgY2FwYWNpdHkgb2YgdGhlDQo+IGNw
dSBpcyByZXN0cmljdGVkLiBCdXQgdG9kYXkgaW4gdGhlIGtlcm5lbCwgdGFzayBzY2hlZHVsZXIg
aXMNCj4gbm90IG5vdGlmaWVkIG9mIGNhcHBpbmcgb2YgbWF4aW11bSBmcmVxdWVuY3kgb2YgYSBj
cHUuDQo+IEluIG90aGVyIHdvcmRzLCBzY2hlZHVsZXIgaXMgdW5hd2FyZSBvZiBtYXhpbXVtIGNh
cGFjaXR5DQo+IHJlc3RyaWN0aW9ucyBwbGFjZWQgb24gYSBjcHUgZHVlIHRvIHRoZXJtYWwgYWN0
aXZpdHkuDQo+IFRoaXMgcGF0Y2ggc2VyaWVzIGF0dGVtcHRzIHRvIGFkZHJlc3MgdGhpcyBpc3N1
ZS4NCj4gVGhlIGJlbmVmaXRzIGlkZW50aWZpZWQgYXJlIGJldHRlciB0YXNrIHBsYWNlbWVudCBh
bW9uZyBhdmFpbGFibGUNCj4gY3B1cyBpbiBldmVudCBvZiBvdmVyaGVhdGluZyB3aGljaCBpbiB0
dXJuIGxlYWRzIHRvIGJldHRlcg0KPiBwZXJmb3JtYW5jZSBudW1iZXJzLg0KPg0KPiBUaGUgcmVk
dWN0aW9uIGluIHRoZSBtYXhpbXVtIHBvc3NpYmxlIGNhcGFjaXR5IG9mIGEgY3B1IGR1ZSB0byBh
DQo+IHRoZXJtYWwgZXZlbnQgY2FuIGJlIGNvbnNpZGVyZWQgYXMgdGhlcm1hbCBwcmVzc3VyZS4g
SW5zdGFudGFuZW91cw0KPiB0aGVybWFsIHByZXNzdXJlIGlzIGhhcmQgdG8gcmVjb3JkIGFuZCBj
YW4gc29tZXRpbWUgYmUgZXJyb25lb3VzDQo+IGFzIHRoZXJlIGNhbiBiZSBtaXNtYXRjaCBiZXR3
ZWVuIHRoZSBhY3R1YWwgY2FwcGluZyBvZiBjYXBhY2l0eQ0KPiBhbmQgc2NoZWR1bGVyIHJlY29y
ZGluZyBpdC4gVGh1cyBzb2x1dGlvbiBpcyB0byBoYXZlIGEgd2VpZ2h0ZWQNCj4gYXZlcmFnZSBw
ZXIgY3B1IHZhbHVlIGZvciB0aGVybWFsIHByZXNzdXJlIG92ZXIgdGltZS4NCj4gVGhlIHdlaWdo
dCByZWZsZWN0cyB0aGUgYW1vdW50IG9mIHRpbWUgdGhlIGNwdSBoYXMgc3BlbnQgYXQgYQ0KPiBj
YXBwZWQgbWF4aW11bSBmcmVxdWVuY3kuIFNpbmNlIHRoZXJtYWwgcHJlc3N1cmUgaXMgcmVjb3Jk
ZWQgYXMNCj4gYW4gYXZlcmFnZSwgaXQgbXVzdCBiZSBkZWNheWVkIHBlcmlvZGljYWxseS4gRXhp
c2l0aW5nIGFsZ29yaXRobQ0KPiBpbiB0aGUga2VybmVsIHNjaGVkdWxlciBwZWx0IGZyYW1ld29y
ayBpcyByZS11c2VkIHRvIGNhbGN1bGF0ZQ0KPiB0aGUgd2VpZ2h0ZWQgYXZlcmFnZS4gVGhpcyBw
YXRjaCBzZXJpZXMgYWxzbyBkZWZpbmVzIGEgc3lzY3RsDQo+IGluZXJmYWNlIHRvIGFsbG93IGZv
ciBhIGNvbmZpZ3VyYWJsZSBkZWNheSBwZXJpb2QuDQo+DQo+IFJlZ2FyZGluZyB0ZXN0aW5nLCBi
YXNpYyBidWlsZCwgYm9vdCBhbmQgc2FuaXR5IHRlc3RpbmcgaGF2ZSBiZWVuDQo+IHBlcmZvcm1l
ZCBvbiBkYjg0NWMgcGxhdGZvcm0gd2l0aCBkZWJpYW4gZmlsZSBzeXN0ZW0uDQo+IEZ1cnRoZXIs
IGRocnlzdG9uZSBhbmQgaGFja2JlbmNoIHRlc3RzIGhhdmUgYmVlbg0KPiBydW4gd2l0aCB0aGUg
dGhlcm1hbCBwcmVzc3VyZSBhbGdvcml0aG0uIER1cmluZyB0ZXN0aW5nLCBkdWUgdG8NCj4gY29u
c3RyYWludHMgb2Ygc3RlcCB3aXNlIGdvdmVybm9yIGluIGRlYWxpbmcgd2l0aCBiaWcgbGl0dGxl
IHN5c3RlbXMsDQpJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBtb2RpZmljYXRpb24uIENvdWxkIHlv
dSBleHBsYWluIHdoYXQgd2FzIHRoZQ0KaXNzdWUgYW5kIGlmIHRoaXMgbW9kaWZpY2F0aW9uIGRp
ZCBub3QgYnJlYWsgdGhlIG9yaWdpbmFsDQp0aGVybWFsIHNvbHV0aW9uIHVwZnJvbnQ/IFlvdSBh
cmUgdGhlbiBjb21wYXJpbmcgdGhpcyBtb2RpZmllZA0KdmVyc2lvbiBhbmQgdHJlYXQgaXQgYXMg
YW4gJ29yaWdpbicsIGFtIEkgcmlnaHQ/DQoNCj4gdHJpcCBwb2ludCAwIHRlbXBlcmF0dXJlIHdh
cyBtYWRlIGFzc3ltZXRyaWMgYmV0d2VlbiBjcHVzIGluIGxpdHRsZQ0KPiBjbHVzdGVyIGFuZCBi
aWcgY2x1c3RlcjsgdGhlIGlkZWEgYmVpbmcgdGhhdA0KPiBiaWcgY29yZSB3aWxsIGhlYXQgdXAg
YW5kIGNwdSBjb29saW5nIGRldmljZSB3aWxsIHRocm90dGxlIHRoZQ0KPiBmcmVxdWVuY3kgb2Yg
dGhlIGJpZyBjb3JlcyBmYXN0ZXIsIHRoZXJlIGJ5IGxpbWl0aW5nIHRoZSBtYXhpbXVtIGF2YWls
YWJsZQ0KPiBjYXBhY2l0eSBhbmQgdGhlIHNjaGVkdWxlciB3aWxsIHNwcmVhZCBvdXQgdGFza3Mg
dG8gbGl0dGxlIGNvcmVzIGFzIHdlbGwuDQo+DQo+IFRlc3QgUmVzdWx0cw0KPg0KPiBIYWNrYmVu
Y2g6IDEgZ3JvdXAgLCAzMDAwMCBsb29wcywgMTAgcnVucw0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXN1bHQgICAgICAgICBTRA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoU2VjcykgICAgICglIG9m
IG1lYW4pDQo+ICAgTm8gVGhlcm1hbCBQcmVzc3VyZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAxNC4wMyAgICAgICAyLjY5JQ0KPiAgIFRoZXJtYWwgUHJlc3N1cmUgUEVMVCBBbGdvLiBEZWNh
eSA6IDMyIG1zICAgICAgMTMuMjkgICAgICAgMC41NiUNCj4gICBUaGVybWFsIFByZXNzdXJlIFBF
TFQgQWxnby4gRGVjYXkgOiA2NCBtcyAgICAgIDEyLjU3ICAgICAgIDEuNTYlDQo+ICAgVGhlcm1h
bCBQcmVzc3VyZSBQRUxUIEFsZ28uIERlY2F5IDogMTI4IG1zICAgICAxMi43MSAgICAgICAxLjA0
JQ0KPiAgIFRoZXJtYWwgUHJlc3N1cmUgUEVMVCBBbGdvLiBEZWNheSA6IDI1NiBtcyAgICAgMTIu
MjkgICAgICAgMS40MiUNCj4gICBUaGVybWFsIFByZXNzdXJlIFBFTFQgQWxnby4gRGVjYXkgOiA1
MTIgbXMgICAgIDEyLjQyICAgICAgIDEuMTUlDQo+DQo+IERocnlzdG9uZSBSdW4gVGltZSAgOiAy
MCB0aHJlYWRzLCAzMDAwIE1MT09QUw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFJlc3VsdCAgICAgIFNEDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKFNlY3MpICAgICglIG9mIG1lYW4pDQo+ICAg
Tm8gVGhlcm1hbCBQcmVzc3VyZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDkuNDUyICAg
ICAgNC40OSUNCj4gICBUaGVybWFsIFByZXNzdXJlIFBFTFQgQWxnby4gRGVjYXkgOiAzMiBtcyAg
ICAgICAgOC43OTMgICAgICA1LjMwJQ0KPiAgIFRoZXJtYWwgUHJlc3N1cmUgUEVMVCBBbGdvLiBE
ZWNheSA6IDY0IG1zICAgICAgICA4Ljk4MSAgICAgIDUuMjklDQo+ICAgVGhlcm1hbCBQcmVzc3Vy
ZSBQRUxUIEFsZ28uIERlY2F5IDogMTI4IG1zICAgICAgIDguNjQ3ICAgICAgNi42MiUNCj4gICBU
aGVybWFsIFByZXNzdXJlIFBFTFQgQWxnby4gRGVjYXkgOiAyNTYgbXMgICAgICAgOC43NzQgICAg
ICA2LjQ1JQ0KPiAgIFRoZXJtYWwgUHJlc3N1cmUgUEVMVCBBbGdvLiBEZWNheSA6IDUxMiBtcyAg
ICAgICA4LjYwMyAgICAgIDUuNDElDQo+DQpXaGF0IEkgd291bGQgbGlrZSB0byBzZWUgYWxzbyBm
b3IgdGhpcyBwZXJmb3JtYW5jZSByZXN1bHRzIGlzDQphdmcgdGVtcGVyYXR1cmUgb2YgdGhlIGNo
aXAuIElzIGl0IGhpZ2hlciB0aGFuIGluIHRoZSAnb3JpZ2luJz8NCg0KUmVnYXJkcywNCkx1a2Fz
eiBMdWJhDQoNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFu
ZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmls
ZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlm
eSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRz
IHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9y
IGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
