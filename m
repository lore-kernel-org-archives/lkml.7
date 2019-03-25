Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00ED20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WHDDGpjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfCYNUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:20:11 -0400
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:38372
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730545AbfCYNUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJRW/2ldx0wZDDEe16hCEpGUN53UtmdSrmnHy3Gzptw=;
 b=WHDDGpjT2shV++hz4EYBthKuIgW0rNW4kCWCcP1DtMSm3MbffBIs+fuhz+wsdUZSGo3tgLlgi/YRimM+YtQ/OISU6X7s16Tc0aQBr62inMbnfDfLyES3mT7PFHl5i2TuO8PCJrSUKjxqThqcS4pvxj0ZmPwKDAMbAj6vVXFhHEo=
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com (10.172.217.137) by
 AM4PR0802MB2260.eurprd08.prod.outlook.com (10.172.217.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 13:20:07 +0000
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::b7:11d9:4d0e:995e]) by AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::b7:11d9:4d0e:995e%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 13:20:06 +0000
From:   Ben Gainey <Ben.Gainey@arm.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        Will Deacon <Will.Deacon@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: BUG in "perf: Suppress AUX/OVERWRITE records"?
Thread-Topic: BUG in "perf: Suppress AUX/OVERWRITE records"?
Thread-Index: AQHU4w12v5Mi06394Eazgqc3Su3itw==
Date:   Mon, 25 Mar 2019 13:20:06 +0000
Message-ID: <ca9bbbdfada4c02eacb5064fce5d187d0f13f4f0.camel@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.0 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Gainey@arm.com; 
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 543b2bb9-ac14-4fb9-ecc3-08d6b124995c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0802MB2260;
x-ms-traffictypediagnostic: AM4PR0802MB2260:
x-microsoft-antispam-prvs: <AM4PR0802MB2260AA9BC74D523F66D5761D915E0@AM4PR0802MB2260.eurprd08.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(366004)(189003)(53754006)(40434004)(199004)(6506007)(105586002)(106356001)(99286004)(26005)(102836004)(476003)(2616005)(186003)(66066001)(8676002)(71190400001)(71200400001)(25786009)(4326008)(6116002)(3846002)(478600001)(81156014)(81166006)(68736007)(2201001)(86362001)(14444005)(72206003)(5660300002)(256004)(14454004)(36756003)(7736002)(53936002)(110136005)(118296001)(305945005)(54906003)(316002)(8936002)(5024004)(2501003)(486006)(6486002)(6512007)(2906002)(58126008)(6636002)(6436002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2260;H:AM4PR0802MB2211.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3jFSttcNisL93D/mWsrR2G01SmeglhVP11oH8MW2NaCGwY4LNDscvKy/T/UEo1wPBW4hh4iPm+jNeFgDZzDWSmehc46OXAdAW7TBLBRwaDD08JJBocZm9r3lNunlhEf7ak1mXDkB9HglxJKtyfy5fZO5FknZFraF4IespneeuGIpr59y5FIGcfv242eYgIGlO3OnG+RX4AM5M8nFzTB5fb0Bmx6FTb80tt7I+9+vKtxoYBSoGWvbXFLpU5V6ilXCp+oAiv4b5nUEfmBCI4hlixDhVGnPCL/eZsfyl63c2Qq4+jdM0e/YzvTl2Zft1T7N0ZAT5A+YRTmJWWGDTPc/Mx8eyk/Yh9oxKopKtmagrn7w4re6Ck0ZgK1eKp2Gyh5Gm623l44TywffXPTIChjQblJx52AJ5flTGEJM4sDQot0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <701B7E3A144DDE4CA4619188B00BAF5F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543b2bb9-ac14-4fb9-ecc3-08d6b124995c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 13:20:06.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsDQoNClJlZ2FyZGluZyBjb21taXQgMTYyNzMxNGZiNTRhMzNlYmQyM2JkMDhmMmUyMTVl
YWVkMGY0NDcxMiAicGVyZjoNClN1cHByZXNzIEFVWC9PVkVSV1JJVEUgcmVjb3JkcyIsIEkgaGF2
ZSBmb3VuZCB0aGF0IEkgbm8gbG9uZ2VyIHJlY2VpdmUNClBFUkZfUkVDT1JEX0FVWCBvbiBjb250
ZXh0IHN3aXRjaCB3aGVuIGNvbGxlY3RpbmcgZGF0YSBmcm9tIHRoZSBhcm1fc3BlDQpQTVUgZHJp
dmVyLiBUaGlzIGlzIGJlY2F1c2UsIG9uIGNvbnRleHQgc3dpdGNoLCB0aGUgYXJtX3NwZSBkcml2
ZXINCmNhbGxzIHBlcmZfYXV4X291dHB1dF9lbmQgd2l0aCBgaGFuZGxlLT5hdXhfZmxhZ3MgPT0g
MGAsIGZhaWxpbmcgdGhlDQp0ZXN0IGFkZGVkIGluIHRoaXMgY29tbWl0Lg0KDQpUaGlzIGlzIGEg
cHJvYmxlbSBhcyBpdCBtZWFucyB3aGVuIGNhcHR1cmluZyBkYXRhIGZvciBtdWx0aXBsZSB0aHJl
YWRzDQoodXNpbmcgcGVyZl9ldmVudF9vcGVuKSB3aGVyZSBBVVggZGF0YSBpcyB3cml0dGVuIHRv
IGEgcGVyLWNwdSBidWZmZXIsDQpJIGNhbiBubyBsb25nZXIgYWNjdXJhdGVseSBhdHRyaWJ1dGUg
U1BFIEFVWCBkYXRhIHRvIGFuIGluZGl2aWR1YWwNCnRocmVhZC4NCg0KSWYgSSByZWFkIHRoZSBp
bnRlbnQgb2YgdGhlIGNvbW1pdCBhcyB0byByZW1vdmUgT1ZFUldSSVRFIEFVWCByZWNvcmRzLA0K
dGhlbiBpdCBzZWVtcyB0aGUgYWRkZWQgaWYgY29uZGl0aW9uIGlzIGluY29ycmVjdCBhbmQgc2hv
dWxkIHByb2JhYmx5DQpiZSBmb3JtdWxhdGVkIGFzOg0KDQogICAgaWYgKChoYW5kbGUtPmF1eF9m
bGFncyAmIH4odTY0KVBFUkZfQVVYX0ZMQUdfT1ZFUldSSVRFKSB8fCAhaGFuZGxlLQ0KPmF1eF9m
bGFncykNCg0KSXMgdGhpcyBjb3JyZWN0IChhbmQgd291bGQgeW91IGxpa2UgYSBwYXRjaD8pLCBv
ciBpcyBteSB1c2Ugb2YNClBFUkZfUkVDT1JEX0FVWCBpbmNvcnJlY3QgaW4gdGhpcyBjYXNlPw0K
DQpUaGFua3MNCg0KQmVuDQoNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRo
aXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxz
byBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0
aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwg
b3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91
Lg0K
