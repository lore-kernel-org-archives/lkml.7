Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEF5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6934B218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="IfAM7I85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDLW7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:59:46 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com ([40.107.3.96]:21214
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726757AbfDLW7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 18:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuZhlqpIar/6P71EmLZE6b39zZX+ExXpOPeTl3uP3wo=;
 b=IfAM7I85w+4MkD9xdpMTPIW5f/A2o+txLBMsTygKvS7k32PgYFyD6/M3T0lEAh7L1WEsw1nsvGpNf6bfAJTHekFX+/X2R8Rc+QUHQEleZcUKEWc5HXR3ZpkaWN+niwPSeb04sPZxk6ceuoxcktty7YeuBphPxCjp0SNKMLAGAz4=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4303.eurprd02.prod.outlook.com (20.177.60.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Fri, 12 Apr 2019 22:59:40 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1771.019; Fri, 12 Apr 2019
 22:59:40 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Ray Jui <ray.jui@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Thread-Topic: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Thread-Index: AQHU6mEE3VBQWFg3OEO4UFCMK2X3RqY5MgwA
Date:   Fri, 12 Apr 2019 22:59:40 +0000
Message-ID: <f28f604a-55a4-7542-0e13-a92a83ab2144@axentia.se>
References: <20190403210535.32236-1-ray.jui@broadcom.com>
In-Reply-To: <20190403210535.32236-1-ray.jui@broadcom.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 169db324-4b04-4702-3216-08d6bf9a8b6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB4303;
x-ms-traffictypediagnostic: VI1PR02MB4303:
x-microsoft-antispam-prvs: <VI1PR02MB4303D948F71F450C6FAAA2F0BC280@VI1PR02MB4303.eurprd02.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(366004)(346002)(396003)(376002)(52314003)(189003)(199004)(99286004)(8676002)(305945005)(6436002)(5660300002)(106356001)(71200400001)(71190400001)(105586002)(7736002)(14454004)(316002)(6486002)(74482002)(65826007)(229853002)(110136005)(508600001)(54906003)(58126008)(31696002)(4326008)(11346002)(186003)(97736004)(66066001)(446003)(476003)(2616005)(6512007)(486006)(26005)(64126003)(65956001)(65806001)(31686004)(6246003)(2906002)(53936002)(36756003)(86362001)(3846002)(6116002)(81166006)(8936002)(81156014)(52116002)(68736007)(25786009)(14444005)(256004)(53546011)(6506007)(102836004)(386003)(76176011)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4303;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /nMDHvy6EENG+992CvATL6HxjmXq+ckdtu0GFfc4GTSHIjsH5q3iJi6kwOIXzqaed2jZhvCWRNxiVBfVtYg2ZnbGZ7qW8luGG4OEDnpF5Ul4eJzvJQS/vUWq33EpmDkUKvRoIbhd5VyPdJWY1FdhevGwPRw5u4HpHs1hmX2d2S9rUUTnsetBF80JWNnA5NZLh5RJVooKSr0LGkCRq8ckQtCKhYwt6NUY82T6ZZWDETIk3cXCI0HI/+MyFhuY2HPY660G/9xOtWDKTSkkZPzEwsQ0gMYSWx+UXtfmIUNr8ZDmuaSCcQt72WifBBEMeAWxCX/zG6vFOBNcnj9X44nWLvwEomXnZtjiSrikH8IG7+zPcMOpmNtpZv5Q6ovFjwU6FxGZiUmcEfCusSarcpFvUBQn4rFIMrHyVCAZM43W6MQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B974AB5B066A13448F3E73798D855946@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 169db324-4b04-4702-3216-08d6bf9a8b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 22:59:40.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0wMyAyMzowNSwgUmF5IEp1aSB3cm90ZToNCj4gQ2hhbmdlIHRoZSBpUHJvYyBJ
MkMgZHJpdmVyIHRvIHVzZSB0aGUgJ0JJVCcgbWFjcm8gZnJvbSBhbGwgJzEgPDwgWFhYJw0KPiBi
aXQgb3BlcmF0aW9ucyB0byBnZXQgcmlkIG9mIGNvbXBpbGVyIHdhcm5pbmcgYW5kIGltcHJvdmUg
cmVhZGFiaWxpdHkgb2YNCj4gdGhlIGNvZGUNCg0KQWxsPyBJIHNlZSBsb3RzIG1vcmUgJzEgPDwg
WFhYX1NISUZUJyBtYXRjaGVzLiBJIG1pZ2h0IGJlIGJlaGluZCB0aG91Z2g/DQpBbnl3YXksIGlm
IHlvdSBhcmUgY2xlYW5pbmcgdXAsIEknbSBqdXN0IGZsYWdnaW5nIHRoYXQgQklUKFhYWF9TSElG
VCkgbG9va3MNCmEgYml0IGNsdW5reSB0byBtZS4gWW91IG1pZ2h0IGNvbnNpZGVyIHJlbmFtaW5n
IGFsbCB0aG9zZSBzaW5nbGUtYml0DQpYWFhfU0hJRlQgbWFjcm9zIHRvIHNpbXBsZSBiZQ0KDQoj
ZGVmaW5lIFhYWCBCSVQoPHh4eD4pDQoNCmluc3RlYWQgb2YNCg0KI2RlZmluZSBYWFhfU0hJRlQg
PHh4eD4NCg0KYnV0IHRoYXQgdHJpZ2dlcnMgbW9yZSBjaHVybiwgc28gaXMgb2J2aW91c2x5IG1v
cmUgZXJyb3IgcHJvbmUuIFlvdSBtaWdodA0Kbm90IGRhcmUgaXQ/DQoNCkNoZWVycywNClBldGVy
DQoNCj4gU2lnbmVkLW9mZi1ieTogUmF5IEp1aSA8cmF5Lmp1aUBicm9hZGNvbS5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1iY20taXByb2MuYyB8IDYgKysrLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtLWlwcm9jLmMgYi9kcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLWJjbS1pcHJvYy5jDQo+IGluZGV4IDU2Mjk0MmQwYzA1Yy4uYTg0NWI4ZGVj
YWM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWJjbS1pcHJvYy5jDQo+
ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtLWlwcm9jLmMNCj4gQEAgLTcxNyw3ICs3
MTcsNyBAQCBzdGF0aWMgaW50IGJjbV9pcHJvY19pMmNfeGZlcl9zaW5nbGVfbXNnKHN0cnVjdCBi
Y21faXByb2NfaTJjX2RldiAqaXByb2NfaTJjLA0KPiAgDQo+ICAJCQkvKiBtYXJrIHRoZSBsYXN0
IGJ5dGUgKi8NCj4gIAkJCWlmIChpID09IG1zZy0+bGVuIC0gMSkNCj4gLQkJCQl2YWwgfD0gMSA8
PCBNX1RYX1dSX1NUQVRVU19TSElGVDsNCj4gKwkJCQl2YWwgfD0gQklUKE1fVFhfV1JfU1RBVFVT
X1NISUZUKTsNCj4gIA0KPiAgCQkJaXByb2NfaTJjX3dyX3JlZyhpcHJvY19pMmMsIE1fVFhfT0ZG
U0VULCB2YWwpOw0KPiAgCQl9DQo+IEBAIC04NDQsNyArODQ0LDcgQEAgc3RhdGljIGludCBiY21f
aXByb2NfaTJjX2NmZ19zcGVlZChzdHJ1Y3QgYmNtX2lwcm9jX2kyY19kZXYgKmlwcm9jX2kyYykN
Cj4gIA0KPiAgCWlwcm9jX2kyYy0+YnVzX3NwZWVkID0gYnVzX3NwZWVkOw0KPiAgCXZhbCA9IGlw
cm9jX2kyY19yZF9yZWcoaXByb2NfaTJjLCBUSU1fQ0ZHX09GRlNFVCk7DQo+IC0JdmFsICY9IH4o
MSA8PCBUSU1fQ0ZHX01PREVfNDAwX1NISUZUKTsNCj4gKwl2YWwgJj0gfkJJVChUSU1fQ0ZHX01P
REVfNDAwX1NISUZUKTsNCj4gIAl2YWwgfD0gKGJ1c19zcGVlZCA9PSA0MDAwMDApIDw8IFRJTV9D
RkdfTU9ERV80MDBfU0hJRlQ7DQo+ICAJaXByb2NfaTJjX3dyX3JlZyhpcHJvY19pMmMsIFRJTV9D
RkdfT0ZGU0VULCB2YWwpOw0KPiAgDQo+IEBAIC05OTUsNyArOTk1LDcgQEAgc3RhdGljIGludCBi
Y21faXByb2NfaTJjX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICANCj4gIAkvKiBjb25m
aWd1cmUgdG8gdGhlIGRlc2lyZWQgYnVzIHNwZWVkICovDQo+ICAJdmFsID0gaXByb2NfaTJjX3Jk
X3JlZyhpcHJvY19pMmMsIFRJTV9DRkdfT0ZGU0VUKTsNCj4gLQl2YWwgJj0gfigxIDw8IFRJTV9D
RkdfTU9ERV80MDBfU0hJRlQpOw0KPiArCXZhbCAmPSB+QklUKFRJTV9DRkdfTU9ERV80MDBfU0hJ
RlQpOw0KPiAgCXZhbCB8PSAoaXByb2NfaTJjLT5idXNfc3BlZWQgPT0gNDAwMDAwKSA8PCBUSU1f
Q0ZHX01PREVfNDAwX1NISUZUOw0KPiAgCWlwcm9jX2kyY193cl9yZWcoaXByb2NfaTJjLCBUSU1f
Q0ZHX09GRlNFVCwgdmFsKTsNCj4gIA0KPiANCg0K
