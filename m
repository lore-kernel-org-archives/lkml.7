Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E8C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEE82086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="M+UGRmxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437133AbfFLIw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:52:58 -0400
Received: from mail-eopbgr40091.outbound.protection.outlook.com ([40.107.4.91]:47108
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436777AbfFLIw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RslixCXNajP7TwiIgQD7UGEhvXFx8WBLIfQGXT83P4Y=;
 b=M+UGRmxxdFjSzuWlQBKgmjPUBZOTZ1A/+/Q0enYi/Oc8juf1IOs+hIzpC5Dd7OXyUINpgxy41n2ljglJMKJKj00uDZlMGg5z0LpTobYF692u2cPknHmzrSZC9vMgywfWUlGMAVUv4nBqkLsF9uoJhMbOnwDb69lTppxV6caMIac=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3275.eurprd02.prod.outlook.com (52.134.66.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Wed, 12 Jun 2019 08:52:51 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1987.010; Wed, 12 Jun 2019
 08:52:51 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [RESEND PATCH 0/2] mux: a couple of patches for 5.3-rc1
Thread-Topic: [RESEND PATCH 0/2] mux: a couple of patches for 5.3-rc1
Thread-Index: AQHVIPw3zI6fNL+/mke3L2Fv6k7D4A==
Date:   Wed, 12 Jun 2019 08:52:51 +0000
Message-ID: <20190612085238.1763-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::30) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c60ab886-a8b3-4473-449e-08d6ef135a27
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3275;
x-ms-traffictypediagnostic: DB3PR0202MB3275:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB3PR0202MB3275DE4F9106E47046557792BCEC0@DB3PR0202MB3275.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39830400003)(396003)(346002)(136003)(189003)(199004)(25786009)(508600001)(8936002)(4326008)(66476007)(74482002)(256004)(64756008)(66446008)(66556008)(66946007)(50226002)(73956011)(486006)(2906002)(14454004)(476003)(81166006)(966005)(86362001)(110136005)(186003)(71200400001)(2501003)(3846002)(66066001)(8676002)(53936002)(6486002)(81156014)(2616005)(26005)(6512007)(6436002)(14444005)(316002)(5660300002)(6116002)(99286004)(7736002)(36756003)(52116002)(68736007)(305945005)(1076003)(6506007)(54906003)(102836004)(71190400001)(386003)(6306002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3275;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4L6bn58fIHPvwymmYZ1FLDwAjH0S1SQwXEOasXUT01dDu/3GLGj3JlOyfZCer/ETvg6Dw5Y9V71OfKxdV9AcspHyy+d+Mi9YiZIpKHWZcdqj9NAkcGqE+COVqjNzTIZ29vYoJdijegXduKJtEj/P4tgM/xmw+AO8a+eOklRWvOi0CAebSKtQe2ZXhEaU/o9vUYzvNaJy5h5TQ78WgQKp6HPynFNohCeDg6bt9muip5tw/INZI0G5Wq2V82xKflvO+7WGI3ZXA+5sQXqdZy7HI11xf6s/HExc/M3ujN5LJ22vJTEhL9V0XUHOFMqW5+HLzzM5ep/L4AOsx6e+ssGJfqgYnDEhGLmL0XBA+SLhuFbdSM3kj1Hc8+XapXNI0Po+ZOGiVx8NwsvNk1U7pGlajsW2lLj9yPBasdEQcikTCNA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c60ab886-a8b3-4473-449e-08d6ef135a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 08:52:51.8202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KKEZvciBHcmVnLCB0aGlzIGlzIG5vdCBhIHJlc2VuZCwgc2luY2UgSSBhcHBh
cmVudGx5IGZvcmdvdCB0bw0KIGluY2x1ZGUgaGltIGxhc3QgdGltZSBbMV0uIE15IG1pc3Rha2Us
IHNvcnJ5IGFib3V0IHRoYXQpDQoNCkEgc21hbGwgYWRkaXRpb24gdG8gdGhlIG1taW8gbXV4IHNv
IHRoYXQgaXQgY2FuIGhhbmRsZSBub24tc3lzY29uDQpyZWdtYXBzLiBUaGUgYmluZGluZ3MgcGF0
Y2ggc2hvdWxkIHByb2JhYmx5IGhhdmUgaGFkIFJvYnMgdGFnLA0KYnV0IGFmdGVyIGEgYml0IG9m
IGJhY2sgYW5kIGZvcnRoIEkgZ290IHRoZSBpbXByZXNzaW9uIHRoYXQgaXQNCndhc24ndCByZWFs
bHkgbmVlZGVkLCBzaW5jZSBpdCdzIGJhc2ljYWxseSBqdXN0IGEgZmlsZSByZW5hbWUNCnBsdXMg
YWRkaXRpb24gb2YgYSBjb21wYXRpYmxlIFsyXS4gVGhlIHBhdGNoZXMgaGF2ZSBiZWVuIGluIC1u
ZXh0DQpmb3IgYSB3ZWVrIG9yIHNvLg0KDQpCdXQsIGlmIEkgbWlzdW5kZXJzdG9vZCBvciBpZiB5
b3UgaGF2ZSBhIHRhZyB0byBzcGFyZSBSb2IsIG5vdw0KaXMgdGhlIHRpbWUuIDotKQ0KDQpDaGVl
cnMsDQpQZXRlcg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDQzMDE5
NTIyNi44OTY1LTEtcGVkYUBheGVudGlhLnNlLw0KWzJdIGh0dHBzOi8vbWFyYy5pbmZvLz9sPWRl
dmljZXRyZWUmbT0xNTUxMjE4NDM1MDM1OTANCiAgICAiVGhhdCB3b3VsZCBoYXZlIHNhdmVkIG1l
IHJldmlld2luZyB0aGUgd2hvbGUgdGhpbmcgYWdhaW4uLi4iDQoNClBhbmthaiBCYW5zYWwgKDIp
Og0KICBkdC1iaW5kaW5nczogYWRkIHJlZ2lzdGVyIGJhc2VkIGRldmljZXMnIG11eCBjb250cm9s
bGVyIERUIGJpbmRpbmdzDQogIG11eDogbW1pbzogYWRkIGdlbmVyaWMgcmVnbWFwIGJpdGZpZWxk
LWJhc2VkIG11bHRpcGxleGVyDQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bXV4L21taW8tbXV4LnR4dCB8ICA2MCAtLS0tLS0tLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL211eC9yZWctbXV4LnR4dCAgfCAxMjkgKysrKysrKysrKysrKysrKysrKysr
DQogZHJpdmVycy9tdXgvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MTIgKy0NCiBkcml2ZXJzL211eC9tbWlvLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNiArLQ0KIDQgZmlsZXMgY2hhbmdlZCwgMTQwIGluc2VydGlvbnMoKyksIDY3IGRlbGV0
aW9ucygtKQ0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbXV4L21taW8tbXV4LnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbXV4L3JlZy1tdXgudHh0DQoNCi0tIA0KMi4xMS4wDQoNCg==
