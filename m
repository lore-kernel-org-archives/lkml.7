Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41946C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF1120838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KSHUDWNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfGJJYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:24:37 -0400
Received: from mail-eopbgr130118.outbound.protection.outlook.com ([40.107.13.118]:59182
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfGJJYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnnf9avYfA4mgOaRAFsI8FNm7Kg2Mf+GchbtmVnVX1U=;
 b=KSHUDWNctnlTZH7zvIQ/Vt9teAhRX+jmqatVe9C/oMPJncLc6O1oF/PiGdfUq7qYLVm2cj2gEWXf9dVo+iN2HXx/ePN1UdeX4NLP4nDn8ptMtmtIEFL0ayZrSTalzGO/y0fig6nHdZMspSh110b46K5SAuyNLzHfgjCaE+0syDM=
Received: from VI1PR08MB3166.eurprd08.prod.outlook.com (52.133.15.141) by
 VI1PR08MB3038.eurprd08.prod.outlook.com (52.133.14.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 09:24:32 +0000
Received: from VI1PR08MB3166.eurprd08.prod.outlook.com
 ([fe80::2c58:9237:97d5:485d]) by VI1PR08MB3166.eurprd08.prod.outlook.com
 ([fe80::2c58:9237:97d5:485d%7]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 09:24:32 +0000
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Finn Thain <fthain@telegraphics.com.au>,
        "Andrey Jr. Melnikov" <temnota.am@gmail.com>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] scsi: aacraid: resurrect correct arc ctrl checks for
 Series-6
Thread-Topic: [PATCH 1/1] scsi: aacraid: resurrect correct arc ctrl checks for
 Series-6
Thread-Index: AQHVLQNcsN6qYRwvAUm4pvYVhh3Yc6a/42KigAPFSAA=
Date:   Wed, 10 Jul 2019 09:24:32 +0000
Message-ID: <2a6f5cc2-40cb-647c-003d-aae594d05062@virtuozzo.com>
References: <20190627161408.10295-1-khorenko@virtuozzo.com>
 <20190627161408.10295-2-khorenko@virtuozzo.com>
 <10t8vf-fq.ln1@banana.localnet>
 <alpine.LNX.2.21.1907080936090.10@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1907080936090.10@nippy.intranet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0014.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::24) To VI1PR08MB3166.eurprd08.prod.outlook.com
 (2603:10a6:803:47::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 374d2625-4430-41f7-7fd3-08d705186aa8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR08MB3038;
x-ms-traffictypediagnostic: VI1PR08MB3038:
x-microsoft-antispam-prvs: <VI1PR08MB303895B4DCA45EBC3BD9A1A0C8F00@VI1PR08MB3038.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39850400004)(376002)(136003)(189003)(199004)(25786009)(386003)(6506007)(52116002)(2906002)(66446008)(66946007)(53546011)(66476007)(66556008)(64756008)(446003)(2616005)(66066001)(6246003)(186003)(316002)(36756003)(54906003)(110136005)(71190400001)(76176011)(8936002)(476003)(71200400001)(102836004)(5660300002)(11346002)(6512007)(81166006)(81156014)(53936002)(3846002)(6436002)(6116002)(14454004)(99286004)(6486002)(229853002)(26005)(8676002)(4326008)(256004)(7736002)(305945005)(68736007)(478600001)(31686004)(31696002)(86362001)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3038;H:VI1PR08MB3166.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xw09MF4SeHqzissX8yJdkYjr1AJiaWaX4NBpxMAAUAkuW1Qvv5FUeoUTkDdWtJ4HuozB9TMfT+jAKR77/b8QIo+K/fymJJUcljJvY2J7fx0GtSm/LRFVc6XGRgxdOFt0DbL5kCyzZAau4rRYzXjIbvPkY14MMaibFS/2j3SGwaHQyUW4SnrCay1skxCKe4tkhSC7kOm7nCqA6ZiDgHf2bJ2FbfQFovXEt8lxp17kb7k7I4DpQEKE+sxDj6hgYirak4ohDr6gMMhslWKbOeHxHvfZDAhKtmjxvn2n2/wNqPYY+SISE+/qoFfGd+PLZe3OGKuUPOdzgi2cBPX0ChLIAjsSYtuXF344383RD0iSYXFm7ai3ukVZabRWkdZgFQU7W2+xC+cNoEErVAaQT04UGFfodl0zlQEPF87oESm58iQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FFDF7C3A92AA54B9A0F794CBF1770D9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374d2625-4430-41f7-7fd3-08d705186aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 09:24:32.5874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khorenko@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDgvMjAxOSAwMjo0OSBBTSwgRmlubiBUaGFpbiB3cm90ZToNCj4gQW5kcmV5LA0KPg0K
PiBJdCBpcyBoZWxwZnVsIHRvIHNlbmQgeW91ciByZXZpZXcgdG8gdGhlIHBhdGNoIGF1dGhvci4g
SSd2ZSBhZGRlZA0KPiBLb25zdGFudGluIHRvIHRoZSBDYyBsaXN0LCBhcyB3ZWxsIGFzIFJhZ2hh
dmEgKHdobyBpbnRyb2R1Y2VkIHRoZQ0KPiByZWdyZXNzaW9uIGFkZHJlc3NlZCBieSBLb25zdGFu
dGluJ3MgcGF0Y2gpLg0KPg0KPiBJZiBJJ20gbm90IG1pc3Rha2VuLCB5b3VyIHJldmlldyBtaXN1
bmRlcnN0YW5kcyB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQo+DQo+IEZXSVcsIEtvbnN0YW50aW4n
cyBwYXRjaCBtaWdodCBoYXZlIGJlZW4gZWFzaWVyIHRvIGZvbGxvdyBpZiBpdCB3YXMgYQ0KPiBz
aW1wbGUgJ2dpdCByZXZlcnQnLg0KDQpIaSBGaW5uLCBBbmRyZXksDQoNCkZpbm4sDQp0aGFuayB5
b3UgZm9yIHB1dHRpbmcgbWUgYmFjayB0byB0aGUgdGhyZWFkLCBhcHByZWNpYXRlZC4NCkFuZCBp
IGFncmVlIHdpdGggeW91LCBtYXkgYmUgZ2l0IHJldmVydCBmb2xsb3dlZCBieSBpbmRlcGVuZGVu
dCBwYXRjaA0Kd2hpY2ggcmVtb3ZlcyBTZXJpZXMtOSBtZW50aW9ucyBpcyBlYXNpZXIgdG8gcmVh
ZCwgc28gc2VuZGluZyB0aGUgc2Vjb25kDQp2ZXJzaW9uIC0gaW4gdGhhdCB3YXkuDQoNCg0KQW5k
cmV5LA0KcGxlYXNlIHRha2UgYSBsb29rIGF0IHRoZSBuZXcgdmVyc2lvbiBwYXRjaGVzLCBob3Bl
IGl0J3MgZWFzaWVyIHRvIHVuZGVyc3RhbmQuDQoNCkFuZCB0YWxraW5nIGFib3V0IHRoZSBoZWxw
ZXI6IGkgdGhvdWdodCBhYm91dCBsZWF2aW5nIGl0LCBidXQgd2UgaGF2ZSBzZXZlcmFsIHBsYWNl
cyB3aGljaCBjaGVjayBmb3IgU2VyaWVzIDcgYW5kIDggb25seQ0KYW5kIHNldmVyYWwgcGxhY2Vz
IHdoaWNoIGNoZWNrIGZvciBTZXJpZXMgNiw3LDgsIHNvIGVpdGhlcg0KLSB3ZSBuZWVkIDIgaGVs
cGVycw0KLSB3ZSBoYXZlIGEgaGVscGVyIHRvIGNoZWNrIGZvciBTZXJpZXMgNyw4IG9ubHkgYW5k
IGluIHNvbWUgcGxhY2VzIHdpbGwgaGF2ZSBhIGNoZWNrIGZvciBTZXJpZXMgNiArIGhlbHBlcg0K
LSBpbnRyb2R1Y2UgdGhlIGhlbHBlciB3aXRoIHBhcmFtZXRlcg0KDQpIb25lc3RseSBpIGRvbid0
IGxpa2UgYW55IG9mIHZhcmlhbnRzIGFib3ZlLCBzbyBqdXN0IGxlZnQgdGhlIGNvZGUgd2l0aG91
dCBoZWxwZXIsDQpub3QgdGhhdCBtYW55IGNoZWNrcyBhbmQgZWFzaWVyIHRvIHJlYWQgdGhlIGNv
ZGUgSU1ITy4NCg0KVGhhbmsgeW91IQ0KDQotLQ0KQmVzdCByZWdhcmRzLA0KDQpLb25zdGFudGlu
IEtob3JlbmtvLA0KVmlydHVvenpvIExpbnV4IEtlcm5lbCBUZWFtDQo=
