Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C41CC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376F32198D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="orW4pgtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfDYM20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:28:26 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:5676 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfDYM2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:28:25 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="28120780"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Apr 2019 05:28:24 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:28:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2x/rH9I3sFIUAxVYa+gEMdk4ynzviA4RtGxIuyrp0E=;
 b=orW4pgtH4hW8yZKjUZWbwNHf9xM7uY3fq+UnBVGW9ih+ml+wE/jSBCP8qu2m/iAW1AxpzEF2k81RK7NCsR1VLUihtMvuVGVK+Wsf/upUW6eyK875XmxAH4YicavZivlxCcubNSslmFP+o1n7Ga8X+6pLBSZWUw7vrkWty35rNG0=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1470.namprd11.prod.outlook.com (10.172.53.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 12:28:22 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:28:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 0/6] add LCD support for SAM9X60
Thread-Topic: [PATCH v3 0/6] add LCD support for SAM9X60
Thread-Index: AQHU+2JfKahpj0VP40yXHKSopzVA6A==
Date:   Thu, 25 Apr 2019 12:28:22 +0000
Message-ID: <1556195285-10687-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0254.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::21) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01f562dd-e57a-4ad9-a0bd-08d6c9798188
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1470;
x-ms-traffictypediagnostic: MWHPR11MB1470:
x-microsoft-antispam-prvs: <MWHPR11MB1470D8ED9FF71B80D55AA7BD873D0@MWHPR11MB1470.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(66476007)(7736002)(81156014)(305945005)(66556008)(64756008)(66446008)(8936002)(68736007)(8676002)(73956011)(66946007)(81166006)(5660300002)(6486002)(3846002)(6116002)(6506007)(2501003)(386003)(14444005)(2201001)(102836004)(50226002)(99286004)(86362001)(36756003)(52116002)(4326008)(110136005)(54906003)(107886003)(66066001)(186003)(256004)(26005)(71190400001)(71200400001)(53936002)(25786009)(486006)(478600001)(72206003)(476003)(2616005)(2906002)(97736004)(316002)(6436002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1470;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XwxHeueMwp5CtaAQnHdWSXuJmnUF6iCIiiDN31Dg/1kC6CbUmWfNc3WGJ3JQsVHywpckoYpJPBEispEv0sG+G0NW0Ppq1tFa8zmKY/orh+JvwA3R6eMgqwJ0aZv0PAjlZNwdze4MXRpYqzbrF4Y0WYNlqP/yKzbHDBL+kgCkQW/dy4GbXfKVjZSL0PUAoSW6OZZvNK0enrRA8JOJ1h86LwYXq+0jBiPYXGsUvNLAVIrF9daugg1kkiVYW44HC7RP3qXcJUg9EQkuN2numjrz7QNXsDhRh5yySrEebtL/M41T7wHFOsL5ecfMqztNBVhK79UcA+VT+hRCwxQy+iqBMohCzFpGYi4WlP0uY+oUlDbbCWIedYXWdszGafMR8mgskP29ug384STByDaNaVTFVOPsbUmcJx7N7ghlWrSf0io=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f562dd-e57a-4ad9-a0bd-08d6c9798188
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:28:22.5038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1470
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkhp
LA0KDQpUaGVzZSBwYXRjaGVzIGFkZHMgc3VwcG9ydCBmb3IgU0FNOVg2MCdzIExDRCBjb250cm9s
bGVyLg0KDQpGaXJzdCBwYXRjaGVzIGFkZCBvcHRpb24gdG8gc3BlY2lmeSBpZiBjb250cm9sbGVy
IGNsb2NrIHNvdXJjZSBpcyBmaXhlZC4NClNlY29uZCBwYXRjaCBhdm9pZCBhIHZhcmlhYmxlIGlu
aXRpYWxpemF0aW9uIGluIGF0bWVsX2hsY2RjX2NydGNfbW9kZV9zZXRfbm9mYigpLg0KVGhlIDNy
ZCBhZGQgY29tcGF0aWJsZXMgaW4gcHdtLWF0bWVsLWhsY2RjIGRyaXZlci4NClRoZSA0dGggcGF0
Y2ggZW5hYmxlcyBzeXNfY2xrIGluIHByb2JlIHNpbmNlIFNBTTlYNjAgbmVlZHMgdGhpcy4NClNw
ZWNpZmljIHN1cHBvcnQgd2FzIGFkZGVkIGFsc28gaW4gc3VzcGVuZC9yZXN1bWUgaG9va3MuDQpU
aGUgNXRoIHBhdGNoIGFkZHMgU0FNOVg2MCdzIExDRCBjb25maWd1cmF0aW9uIGFuZCBlbmFibGVk
IGl0Lg0KDQpJIHRvb2sgdGhlIGNoYW5nZXMgb2YgdGhpcyBzZXJpZXMgYW5kIGludHJvZHVjZWQg
YWxzbyBhIGZpeA0KKHRoaXMgaXMgdGhlIDZ0aCBwYXRjaCBpbiB0aGlzIHNlcmllcykgLSBpZiB5
b3Ugd2FudCB0byBzZW5kIGl0IHNlcGFyYXRlbHkNCkkgd291bGQgZ2xhZGx5IGRvIGl0Lg0KDQpU
aGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQpDaGFuZ2VzIGluIHYzOg0KLSBrZWVwIGNvbXBh
dGlibGUgc3RyaW5nIG9uIHBhdGNoIDMvNiBvbiBhIHNpbmdsZSBsaW5lIChJIGtlZXAgaGVyZSBh
IHRhYg0KICBpbiBmcm9udCBvZiAiLmNvbXBhdGlibGUiIHRvIGJlIGFsaWduZWQgd2l0aCB0aGUg
cmVzdCBvZiB0aGUgY29kZSBpbg0KICBhdG1lbF9obGNkY19kdF9pZHNbXSkNCi0gcGF0Y2hlcyA0
LzcgYW5kIDMvNyBmcm9tIHYyIHdlcmUgYXBwbGllZCBzbyByZW1vdmUgdGhlbSBmcm9tIHRoaXMg
dmVyc2lvbg0KLSBhZGQgYSBmaXggZm9yIGF0bWVsX2hsY2RjIChwYXRjaCA2LzYpDQoNCkNoYW5n
ZXMgaW4gdjI6DQotIHVzZSAifCIgb3BlcmF0b3IgaW4gcGF0Y2ggMS83IHRvIHNldCBBVE1FTF9I
TENEQ19DTEtTRUwgb24gY2ZnDQotIGNvbGxlY3QgQWNrZWQtYnksIFJldmlld2VkLWJ5IHRhZ3MN
Cg0KQ2xhdWRpdSBCZXpuZWEgKDQpOg0KICBkcm06IGF0bWVsLWhsY2RjOiBhZGQgY29uZmlnIG9w
dGlvbiBmb3IgY2xvY2sgc2VsZWN0aW9uDQogIGRybTogYXRtZWwtaGxjZGM6IGF2b2lkIGluaXRp
YWxpemluZyBjZmcgd2l0aCB6ZXJvDQogIHB3bTogYXRtZWwtaGxjZGM6IGFkZCBjb21wYXRpYmxl
IGZvciBTQU05WDYwIEhMQ0RDJ3MgUFdNDQogIGRybS9hdG1lbC1oY2xjZGM6IHJldmVydCBzaGlm
dCBieSA4DQoNClNhbmRlZXAgU2hlcmlrZXIgTWFsbGlrYXJqdW4gKDIpOg0KICBkcm06IGF0bWVs
LWhsY2RjOiBlbmFibGUgc3lzX2NsayBkdXJpbmcgaW5pdGFsaXphdGlvbi4NCiAgZHJtOiBhdG1l
bC1obGNkYzogYWRkIHNhbTl4NjAgTENEIGNvbnRyb2xsZXINCg0KIGRyaXZlcnMvZ3B1L2RybS9h
dG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMgIHwgIDE4ICsrLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuYyAgICB8IDEyMCArKysrKysrKysrKysrKysr
KysrKysrKy0NCiBkcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuaCAg
ICB8ICAgMiArDQogZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX3BsYW5l
LmMgfCAgIDIgKy0NCiBkcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYyAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQogNSBmaWxlcyBjaGFuZ2VkLCAxMzIgaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pDQoNCi0tIA0KMi43LjQNCg0K
