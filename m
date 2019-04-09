Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF6C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD9E21841
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UJydvyLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDILHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:07:30 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:34760 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDILH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:07:29 -0400
X-IronPort-AV: E=Sophos;i="5.60,329,1549954800"; 
   d="scan'208";a="27942122"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Apr 2019 04:07:29 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 9 Apr 2019 04:07:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDbyTSULTVGuEVk3Qay3yEmSQg12kfumbfzu7o6OPdc=;
 b=UJydvyLzpNRnCoYygernwSRqcPvqQgpLDv5sJrPX5VFhzkt9OqjSeVHe8JJOReMT7kRvVpaTvySBtAew4626vvsUlV3fHPGq66u5/dPEZG10AD8qlZTbQH5ZQaM4u122VqWSkdAafbmLxdGLysEmCgD2PyXFHT5ogbNkFkwSiI8=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0011.namprd11.prod.outlook.com (10.164.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 11:07:19 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 11:07:19 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>
CC:     <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 0/7] media: atmel: atmel-isc: new features
Thread-Topic: [PATCH 0/7] media: atmel: atmel-isc: new features
Thread-Index: AQHU7sRlZzbs8eRI40urL/liPTuqoQ==
Date:   Tue, 9 Apr 2019 11:07:19 +0000
Message-ID: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:28::22) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be63b732-11ac-4c70-e0e1-08d6bcdb8820
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB0011;
x-ms-traffictypediagnostic: DM5PR11MB0011:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR11MB0011D9527964C403BF8169FEE82D0@DM5PR11MB0011.namprd11.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39850400004)(199004)(189003)(256004)(81166006)(66066001)(486006)(8676002)(36756003)(476003)(5660300002)(81156014)(50226002)(8936002)(71200400001)(71190400001)(14444005)(2616005)(6512007)(106356001)(105586002)(6306002)(7736002)(305945005)(478600001)(4326008)(2201001)(186003)(99286004)(6486002)(107886003)(68736007)(97736004)(72206003)(110136005)(14454004)(316002)(53936002)(52116002)(26005)(54906003)(6436002)(6506007)(6116002)(2501003)(2906002)(3846002)(386003)(25786009)(102836004)(966005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0011;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2uDXgAjxvmp3F6pLQ8kKMjRc5mhpTvkFKjtBZqCxhO8qnacvt6ynEjpwwwn/jmGwu0IH4NUyZQYLxh0YBS/sNuRRu1O9ndjGdGlU7hOrtf9YrbZO/EYaaHO9/PxsRnmGqhVwIvjMRxkx++6yKwq0B0eYe/Dyf6GvPJfW3vkQyxSiIBhof7FGMzpINb5JFyWtvI3hA2kN6pxnFkhpgobLm8XB2IXQcAk4InQTFA1Bm5AoFvmUBcDCNcF7QyQr3doEbvuJnf4YlG+4U4heWgYAMTCIU3QtvguttWPTtjfJl0aE3CKrMXVizTW/4M3ZMnulxEJiX2iCOZfefQbQoQ95U1hfjBPUVikHKcpZmg9iSI7AGAXVsLM7KcQXNlIviwlEXHDSQ90grWVDpVzzKlEI7339I0q0EttUuExY0HBGrSw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be63b732-11ac-4c70-e0e1-08d6bcdb8820
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:07:19.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0011
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpUaGlz
IHNlcmllcyBpbmNsdWRlcyBmZWF0dXJlIHJld29yaywgZmVhdHVyZSBhZGRpdGlvbnMgYW5kIGJ1
ZyBmaXhlcyBmb3IgdGhlDQphdG1lbC1pc2MgZHJpdmVyLg0KSXQgYXBwbGllcyBvbmx5IG9uIHRv
cCBvZiBteSBwcmV2aW91cyBwYXRjaHNldDoNCm1lZGlhOiBhdG1lbDogYXRtZWwtaXNjOiByZW1v
dmVkIEFSR0IzMiBhZGRlZCBBQkdSMzIgYW5kIFhCR1IzMg0KbWVkaWE6IGF0bWVsOiBhdG1lbC1p
c2M6IHJld29ya2VkIGRyaXZlciBhbmQgZm9ybWF0cw0KYXZhaWxhYmxlIGF0Og0KaHR0cHM6Ly9n
aXQubGludXh0di5vcmcvaHZlcmt1aWwvbWVkaWFfdHJlZS5naXQvY29tbWl0Lz9oPWZvci12NS4y
YiZpZD0wM2VmMWI1NmNiYTZhZDE3ZjZlYWQxM2M4NWE4MWUwZTgwZmJjOWQxDQoNCk9uZSBvcGVu
IHF1ZXN0aW9uIGlzIHJlZ2FyZGluZyB0aGUgV0hJVEVfQkFMQU5DRSBlcnJvciByZXR1cm5zOiBp
dCB3b3VsZCBzZWVtDQpsb2dpY2FsIHRvIHJldHVybiBFQUdBSU4gb3IgRUJVU1ksIGJ1dCB0aGlz
IGlzIG5vdCBjb21wbGlhbnQgd2l0aA0KdjRsMi1jb21wbGlhbmNlLg0KRG9lcyBpdCBtYWtlIHNl
bnNlIHRvIHJldHVybiBzdWNjZXNzIG9uIGV2ZXJ5IG9jY2FzaW9uPyBldmVuIGlmIHRoZQ0KRE9f
V0hJVEVfQkFMQU5DRSBkb2VzIG5vdGhpbmc/DQpJbiB0aGlzIHNlcmllcyBJIHVzZWQgdGhlIHJl
dHVybiBFQUdBSU4gb3IgRUJVU1kgZnJvbSB0aGUgdjRsMi1jdHJscywgYnV0IEkNCmNhbiBjaGFu
Z2UgaWYgYWx3YXlzIHN1Y2Nlc3MgaXMgYSBiZXR0ZXIgd2F5IG9mIHJldHVybmluZyAoZXZlbiBp
ZiBub3JtYWxseQ0KYSByZXR1cm4gdmFsdWUgc2VydmVzIHRoaXMgZXhhY3QgcHVycG9zZSAtIHJl
dHVybiBzb21lIGNvZGUgKQ0KDQpFdWdlbiBIcmlzdGV2ICg3KToNCiAgbWVkaWE6IGF0bWVsOiBh
dG1lbC1pc2M6IGFkZCBzYWZlIGNoZWNrcyBhbmQgZml4ZWQgd3JvbmcgSVNDIHN0YXRlIGluDQog
ICAgZXJyb3IgY2FzZQ0KICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogcmV3b3JrZWQgd2hpdGUg
YmFsYW5jZSBmZWF0dXJlDQogIG1lZGlhOiB2NGwyLWN0cmw6IGZpeCBmbGFncyBmb3IgRE9fV0hJ
VEVfQkFMQU5DRQ0KICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogYWRkIHN1cHBvcnQgZm9yIERP
X1dISVRFX0JBTEFOQ0UNCiAgbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IGxpbWl0IGluY29taW5n
IHBpeGVscyBwZXIgZnJhbWUNCiAgbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IGZpeCBJTklUX1dP
UksgbWlzcGxhY2VtZW50DQogIG1lZGlhOiBhdG1lbDogYXRtZWwtaXNjOiBmaXggYXNkIG1lbW9y
eSBhbGxvY2F0aW9uDQoNCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1y
ZWdzLmggfCAgMjUgKy0NCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5j
ICAgICAgfCAzNDYgKysrKysrKysrKysrKysrKysrKysrKystLS0NCiBkcml2ZXJzL21lZGlhL3Y0
bDItY29yZS92NGwyLWN0cmxzLmMgICAgICAgICAgfCAgIDEgKw0KIDMgZmlsZXMgY2hhbmdlZCwg
MzM2IGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuNy40DQoNCg==
