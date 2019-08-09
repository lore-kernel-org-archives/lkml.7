Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC14C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CAA208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="KCew+Ed8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436765AbfHIPjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:39:42 -0400
Received: from mail-eopbgr10102.outbound.protection.outlook.com ([40.107.1.102]:30944
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbfHIPjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP4vlNYOgj2Z+7q6cH8f66cPcqp3xp6rP7jReXY9pS+ggUhbcmJJpXAfZOJ9IpndS1AehzLY4LQFSMmBJmkl+my6F1hInTa1HgJ9x95Apeo4mBq7fEd6D9tei8wO98Z6vzsPnJaROYFFYfVoatVb0iJ0T0RXlrp1SWRKjwT7W1az3HgO41iGqeKUu/+XxWOIdJENUU53j+kMldrSbg4QKszf0FufPlWzOB8zdqzfIUl7zdHAlM/ii9yjHPbTTl+ghVpuqNW5cYirBOLCJ4T3m4D/8nRjpmBmya6RbNU5E7DXdURs/RkXCLylZw/7GVzEjUa9xFyb6u4UVL4bgUJxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as1RaMgZa8Nni1Tfq3bI4P9rTd7B1XaSX+Y7gmNzI7s=;
 b=kO2hnVLznyd+zeJIVTlx7fD3wYpLmL+gx5BaPv6MGhst0TbiLSAsIed4TUhotkgTA1qnP6QO3IKvpZ0v89LmZbicjBwNP7n6CvN5TpLA8gR+4ECm9ZDjNBsOBeBgmt7AkmBsFX/syfEG4d5BS+ypobfGeJcJInlHUcIP2xJt1xXLbM9jOF38dSWwiIq8yFO7k3f/RxLTx218FNCCzMFiJxDzA3xTTtd7O4jJwqjbEDxl3HLDmLL7/R/vNO//8Ms3XHuXXKUVUVwXYWm6BvQVg3eDNRnrWtylgGsg4TC7KQcaCQFd2WVYRkxWIiTmu6gOOq9YLJOgMEtTN7zBRptONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as1RaMgZa8Nni1Tfq3bI4P9rTd7B1XaSX+Y7gmNzI7s=;
 b=KCew+Ed8r/VG8mNDbHWcrTmqXIDmHMcmxxcnphcVSrqWIqTE86HUcXtDQVmf3R2ieIik4D6/JZTY49eXqMh1tWOf42NLew85T9c5s1dx7xIoognRQP0KLQZcKKNQECcnnjICAzMRIjtAL2P6gwNjc8guoRPVvSR63vkMZ0b49vE=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB4909.eurprd05.prod.outlook.com (20.177.51.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 9 Aug 2019 15:38:58 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:38:58 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 14/21] ARM: dts: imx6ull-colibri: Add sleep mode to fec
Thread-Topic: [PATCH v3 14/21] ARM: dts: imx6ull-colibri: Add sleep mode to
 fec
Thread-Index: AQHVTPnTvAF3yo3qqkOkBzEMOHzWcKby9ymA
Date:   Fri, 9 Aug 2019 15:38:58 +0000
Message-ID: <a2350a640f613bc7e41fa56f3909d462941125b6.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-15-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-15-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6b0f3b6-183c-4f46-8398-08d71cdfb231
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB4909;
x-ms-traffictypediagnostic: VI1PR05MB4909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB49090B2D7F0DC595AEFEC3F9FBD60@VI1PR05MB4909.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(199004)(189003)(186003)(14444005)(256004)(6506007)(446003)(11346002)(102836004)(6116002)(46003)(76176011)(2616005)(118296001)(478600001)(476003)(44832011)(71200400001)(71190400001)(66446008)(8936002)(66476007)(66556008)(486006)(66946007)(64756008)(2906002)(91956017)(76116006)(2501003)(25786009)(4326008)(53936002)(6512007)(86362001)(2201001)(305945005)(99286004)(7736002)(14454004)(7416002)(6436002)(36756003)(6486002)(5660300002)(110136005)(316002)(6246003)(54906003)(229853002)(8676002)(81166006)(81156014)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4909;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ju+X5w9dBFirHWzKwMudSac9t97qsWIF/QO95oi3qovaO4e9DWOmzczDJmOcmyMUPkf44znsZYnGxi/wlUcO2kHYvDXeh1TrJi/aquFHiGiGBSx+dC+oDT7tBrTDwNiOEILSfF445jzjWR7yuk6KwfyJNWvl42yVZPE+46nd1EmGI/b8LX9YdvZ0Srzu0AHpHpCsWnqAFrzYh4ucrqJdN3sfYC0iqG6XYfFGEf6MSa2af09KMc5lfKNtZUnI1nQoJrFTfsSBRCCLxpbbq0aDezCBUYXKL/V15mnzN2AMDU0ImcxwAFKWchniVauN2sRheH5FUKBM7WduLeSw97EsSzJwa23e1Fe7FRiXYhnpQNung/QWPLmaHrMjDuqsUTaX+z6FDGD/rPb3r9f+V5v3/Z3t/6/rjFAIAIuIYC0KwPs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8771B20DCCFC64687326A1AB7862887@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b0f3b6-183c-4f46-8398-08d71cdfb231
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:38:58.7769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKvel299bd5igBrMq263J0aUTXlXi81P6Hele7uD9af1HHXOrhvKnGuwaTpCU9v9G4vqEAkJ9bePacWEbz1GFfdivliQMaf2ORmDUtlpPyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRG8gbm90IGNoYW5nZSB0aGUgY2xvY2sgYXMgdGhlIHBvd2VyIGZvciB0aGlzIHBoeSBp
cyBzd2l0Y2hlZA0KPiB3aXRoIHRoYXQgY2xvY2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGls
aXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoNCkFja2VkLWJ5
OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0N
Cj4gDQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0KPiANCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpIHwgMTggKysrKysrKysrKysr
KysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5k
dHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gaW5kZXgg
ZDU2NzI4ZjAzYzM1Li4xMDE5Y2U2OWEyNDIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1
bGwtY29saWJyaS5kdHNpDQo+IEBAIC02Miw4ICs2Miw5IEBADQo+ICB9Ow0KPiAgDQo+ICAmZmVj
MiB7DQo+IC0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiLCAic2xlZXAiOw0KPiAgCXBpbmN0cmwtMCA9IDwmcGluY3RybF9lbmV0Mj47DQo+
ICsJcGluY3RybC0xID0gPCZwaW5jdHJsX2VuZXQyX3NsZWVwPjsNCj4gIAlwaHktbW9kZSA9ICJy
bWlpIjsNCj4gIAlwaHktaGFuZGxlID0gPCZldGhwaHkxPjsNCj4gIAlzdGF0dXMgPSAib2theSI7
DQo+IEBAIC0yMjAsNiArMjIxLDIxIEBADQo+ICAJCT47DQo+ICAJfTsNCj4gIA0KPiArCXBpbmN0
cmxfZW5ldDJfc2xlZXA6IGVuZXQyc2xlZXBncnAgew0KPiArCQlmc2wscGlucyA9IDwNCj4gKwkJ
CU1YNlVMX1BBRF9HUElPMV9JTzA2X19HUElPMV9JTzA2CTB4MA0KPiArCQkJTVg2VUxfUEFEX0dQ
SU8xX0lPMDdfX0dQSU8xX0lPMDcJMHgwDQo+ICsJCQlNWDZVTF9QQURfRU5FVDJfUlhfREFUQTBf
X0dQSU8yX0lPMDgJMHgwDQo+ICsJCQlNWDZVTF9QQURfRU5FVDJfUlhfREFUQTFfX0dQSU8yX0lP
MDkJMHgwDQo+ICsJCQlNWDZVTF9QQURfRU5FVDJfUlhfRU5fX0dQSU8yX0lPMTAJMHgwDQo+ICsJ
CQlNWDZVTF9QQURfRU5FVDJfUlhfRVJfX0dQSU8yX0lPMTUJMHgwDQo+ICsJCQlNWDZVTF9QQURf
RU5FVDJfVFhfQ0xLX19FTkVUMl9SRUZfQ0xLMgkweDQwMA0KPiAxYjAzMQ0KPiArCQkJTVg2VUxf
UEFEX0VORVQyX1RYX0RBVEEwX19HUElPMl9JTzExCTB4MA0KPiArCQkJTVg2VUxfUEFEX0VORVQy
X1RYX0RBVEExX19HUElPMl9JTzEyCTB4MA0KPiArCQkJTVg2VUxfUEFEX0VORVQyX1RYX0VOX19H
UElPMl9JTzEzCTB4MA0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4gIAlwaW5jdHJsX2Vjc3BpMV9j
czogZWNzcGkxLWNzLWdycCB7DQo+ICAJCWZzbCxwaW5zID0gPA0KPiAgCQkJTVg2VUxfUEFEX0xD
RF9EQVRBMjFfX0dQSU8zX0lPMjYJMHgwMDBhMA0K
