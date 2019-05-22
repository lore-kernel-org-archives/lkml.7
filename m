Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA98C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815BC21479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sZEadPnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfEVKyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:54:06 -0400
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:61924
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728438AbfEVKyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X92+RpA5YfuPOXHavfDojHiu+IApqRwC0X4Hps7abpE=;
 b=sZEadPnZD7Tp55BSJYblfZLegRoyZWjqCNBfk9OV0EI2n1yIltx60C+mBF4bNHM8BqDenreFxyk1YtikzJVYVSGndU6NA0kvJe7jEmR7t+3HMt7IKe16x1qPdiMUpry0DJ5BNXEqQ8QVT4wXAFyoNAdXYasayqy2Q8+o6DS0KE0=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4319.eurprd04.prod.outlook.com (52.134.122.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Wed, 22 May 2019 10:54:02 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:54:02 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v5 2/5] USB: use genalloc for USB HCs with local memory
Thread-Topic: [PATCH v5 2/5] USB: use genalloc for USB HCs with local memory
Thread-Index: AQHVD96XE7hyjPzMhU2tA8mX94cqtKZ1s7qAgAFF3IA=
Date:   Wed, 22 May 2019 10:54:02 +0000
Message-ID: <afa2dd70-fdb6-cbcd-2100-210476f891bf@nxp.com>
References: <20190521140748.20012-1-laurentiu.tudor@nxp.com>
 <20190521140748.20012-3-laurentiu.tudor@nxp.com> <20190521152743.GA4693@sx9>
In-Reply-To: <20190521152743.GA4693@sx9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15ce8d6e-207c-469d-97bb-08d6dea3cd45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4319;
x-ms-traffictypediagnostic: VI1PR04MB4319:
x-microsoft-antispam-prvs: <VI1PR04MB4319562A265E9F66F9060370EC000@VI1PR04MB4319.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(51444003)(199004)(68736007)(36756003)(64756008)(2906002)(66476007)(66556008)(5660300002)(71200400001)(66446008)(66946007)(4744005)(81166006)(81156014)(498600001)(31686004)(8676002)(8936002)(73956011)(71190400001)(6246003)(305945005)(7736002)(14454004)(53936002)(256004)(14444005)(25786009)(66066001)(4326008)(6486002)(6512007)(99286004)(6436002)(186003)(6916009)(54906003)(31696002)(26005)(86362001)(2616005)(11346002)(229853002)(3846002)(76116006)(91956017)(6116002)(6506007)(53546011)(476003)(446003)(486006)(102836004)(76176011)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4319;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8XqPZpo5os8m87QgLBKOrhtgVKgbnFOPwX2jEagkmpqbJtawKahg2APybmaO9Z/bF7Aic7Rzk0VvicwbjaNeDfkgnTz6wfu6jc6qkyxZJ2hpOKzcViGwF9mCIWkqUMkNnaL9BBp7X+u/0U+sQTM/vbOrnRlgBe0n3FsVnEvr5IRQ2I/+o6ds13sMfM/yDOqdRruLH0eyDtHVhaH73LikTExWKHlWlMX6/PIeMk3t/8q5auXTknFluuypQG5IT4k/AkEMD3P3ccYNSM50jMRu8ak4Qqqar9oz50JNm33u3WzhzgAIhyug72Z5vVQcMXyzR8gHr7xXQV57q556rlPvrf1jVRMG4iLRShMXFLyNRMVIIM8JJcbDUJ3gxOytSankEeFaE/84hI1qXCGC6eI7iMSu0jg7OATK6mQJNZqIa9w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA26C74C5953B346992E50485A75C9F4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ce8d6e-207c-469d-97bb-08d6dea3cd45
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:54:02.3030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMS4wNS4yMDE5IDE4OjI3LCBGcmVkcmlrIE5vcmluZyB3cm90ZToNCj4gVGhhbmtzIExh
dXJlbnRpdSENCj4gDQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3VzYi9oY2QuaA0KPj4gKysrIGIv
aW5jbHVkZS9saW51eC91c2IvaGNkLmgNCj4+IEBAIC0yMTYsNiArMjE2LDkgQEAgc3RydWN0IHVz
Yl9oY2Qgew0KPj4gICAjZGVmaW5lCUhDX0lTX1JVTk5JTkcoc3RhdGUpICgoc3RhdGUpICYgX19B
Q1RJVkUpDQo+PiAgICNkZWZpbmUJSENfSVNfU1VTUEVOREVEKHN0YXRlKSAoKHN0YXRlKSAmIF9f
U1VTUEVORCkNCj4+ICAgDQo+PiArCS8qIGFsbG9jYXRvciBmb3IgSENzIGhhdmluZyBsb2NhbCBt
ZW1vcnkgKi8NCj4+ICsJc3RydWN0IGdlbl9wb29sICAgICAgICAgKmxvY2FsbWVtX3Bvb2w7DQo+
PiArDQo+IA0KPiBJIGhhdmUgdGVzdGVkIHBhdGNoZXMgMSwgMiBhbmQgNSwgYW5kIHRoZXkgc2Vl
bSB0byB3b3JrLiBOaWNlISANCg0KR3JlYXQhIFRoYW5rcyBmb3IgdGVzdGluZy4gSSdsbCBhZGQg
eW91ciBUZXN0ZWQtQnkgdGFncyBvbiB0aGUgcGF0Y2hlcyANCnlvdSBtZW50aW9uZWQuDQoNCj4g
TWF5IEkgc3VnZ2VzdCBjbGFyaWZ5aW5nIHRoZSBOVUxMIHBvaW50ZXJzPyBJIHRoaW5rIHRoYXQg
bWF5IGhlbHAgc29tZW9uZQ0KPiBkZWJ1Z2dpbmcgb3IgbWFpbnRhaW5pbmcgdGhpcyBpbiB0aGUg
ZnV0dXJlLiBTb21ldGhpbmcgbGlrZSB0aGlzOg0KDQpTdXJlLCB3aWxsIGluY2x1ZGUgaW4gdjYu
DQoNCi0tLQ0KQmVzdCBSZWdhcmRzLCBMYXVyZW50aXU=
