Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB67C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284CF2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SbWHQNX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDLKTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:19:41 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:42998 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:19:41 -0400
X-IronPort-AV: E=Sophos;i="5.60,340,1549954800"; 
   d="scan'208";a="31374106"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Apr 2019 03:19:40 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 12 Apr 2019 03:19:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6tqL5zrMozhh96Ecd1j+j5yAl+rxiVNj1xHZakVAdU=;
 b=SbWHQNX2Kh1a5rNCslvt0eFl9mgUi2nIULk4PtzahR1wr1vnfrD8TlCMm68BpzwDM39/EtLZBWNZqbdZSTH0077OtnX9mQ+uMSVtkckeuPKPoMCUB3W79QwzzSBFK6zmO84zFqaKzEufw+rQ6gH9QGKq2gEjNxcqTEKu7qXdkds=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1947.namprd11.prod.outlook.com (10.175.88.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16; Fri, 12 Apr 2019 10:19:37 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 10:19:37 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <mchehab@kernel.org>,
        <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 0/3] media: atmel: atmel-isc: some fixes
Thread-Topic: [PATCH 0/3] media: atmel: atmel-isc: some fixes
Thread-Index: AQHU8Rk7t7BW4v2Y6kWMbiWeR3e4gA==
Date:   Fri, 12 Apr 2019 10:19:36 +0000
Message-ID: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0111.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::40) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9eea157-89d6-4e73-b1b5-08d6bf305d40
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB1947;
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-microsoft-antispam-prvs: <DM5PR11MB1947CE2844AEFECC911F38E7E8280@DM5PR11MB1947.namprd11.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(105586002)(54906003)(102836004)(36756003)(50226002)(26005)(14454004)(2906002)(97736004)(66066001)(6486002)(6436002)(6506007)(386003)(305945005)(7736002)(2501003)(81166006)(5660300002)(8676002)(8936002)(81156014)(107886003)(14444005)(256004)(486006)(4326008)(478600001)(110136005)(106356001)(68736007)(316002)(86362001)(3846002)(4744005)(71200400001)(52116002)(72206003)(2616005)(476003)(25786009)(6116002)(186003)(6512007)(71190400001)(99286004)(2201001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1947;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CEH+1whyU/yN6pZ4vm+MJxJ8SAm3GA8/Vk86AcpzWch1XwVkQvVyEzgOcFfwbffO+tmEGu4bsD63sj0lVb0YluPjvyG6TqnhL69ZGcDGTU3yaAqzUh/q6YGHvOr2IX70u8U9b7HMK8Den22Yx6oBVMEn2rdNdxwuwI+58zx4DYO7rZsY3LC1g/T2JOF3J3vm30OB6x4vM/4eUjzP6UUSaDfrsIX6eVIqra6bWKDzmEPjCQzKUDjkzJ95EcU3ti3wapaHBDmwl50XByCn1sYUHxaJvVACW7Dgm60JOAU6kN2OHs/tPMEy8L/1UPtuc8cTVpKxzcRYur/S7lUAAAqf7h0hElIEPAAHfbYdlpHXAOdecPpRn+XV9Dfoj2jr/Lc2IVNyHeR/jUAF1yvsWFyT6AeVvK5a79ztlZcFZYh2Zas=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d9eea157-89d6-4e73-b1b5-08d6bf305d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 10:19:37.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1947
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpIZWxs
bywNCg0KVGhpcyBzZXJpZXMgaW5jbHVkZXMgc29tZSBmaXhlcyBmb3IgdGhlIGF0bWVsLWlzYyBt
ZWRpYSBkcml2ZXIuDQoNCkFzIHJlcXVlc3RlZCBieSBIYW5zICwgY3JlYXRlZCBhIGZpcnN0IHNl
cmllcyBvZiBvbmx5IGZpeGVzLA0KdGhlIHBhdGNoZXMgYXJlIHRoZSBzYW1lIGFzIGluIHRoZSBw
cmV2aW91cyBwYXRjaCBzZXJpZXMsIGJ1dCByZW1vdmVkDQp0aGUgb25lIHdpdGggc2FmZSBjaGVj
a3M6IEhhbnMgc2FpZCBpdCdzIG92ZXJraWxsLg0KDQpBbm90aGVyIHNlcmllcyBiYXNlZCBvbiB0
aGlzIG9uZSBJIHdpbGwgc2VuZCBzb29uIHdpdGggdGhlIG5ldyBmZWF0dXJlIHNldCwNCnJld29y
a2VkIGJhc2VkIG9uIEhhbnMnIHJldmlldy4NCg0KVGhhbmtzICENCg0KRXVnZW4gSHJpc3RldiAo
Myk6DQogIG1lZGlhOiBhdG1lbDogYXRtZWwtaXNjOiBsaW1pdCBpbmNvbWluZyBwaXhlbHMgcGVy
IGZyYW1lDQogIG1lZGlhOiBhdG1lbDogYXRtZWwtaXNjOiBmaXggSU5JVF9XT1JLIG1pc3BsYWNl
bWVudA0KICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogZml4IGFzZCBtZW1vcnkgYWxsb2NhdGlv
bg0KDQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtcmVncy5oIHwgMTkg
KysrKysrKysrKysNCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jICAg
ICAgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKystLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDYx
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi43LjQNCg0K
