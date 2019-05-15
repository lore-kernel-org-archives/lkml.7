Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8C82084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="isrOFz0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEOKhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:37:09 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:35229
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfEOKhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgEZWhMTW3/nSQoTLLLG9IA6TYU3ODHNRVGE7B1JvHk=;
 b=isrOFz0w5pPxPN0u529j79tbTqXqSN6gSIHiF+vhd7BHrrvdCnCJj5cl31i6YZ6LLFg4q+35Ail3v4cIgr+3HUMfIysgmyZGe05iveo3dxVNhSaOah41pkqtpHnD/ubXuop86xKc0FMYGFYls8DfaU7ZbbvCNjSdUiojYECfinQ=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4432.eurprd04.prod.outlook.com (20.177.55.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Wed, 15 May 2019 10:37:04 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8942:6d16:631:413]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8942:6d16:631:413%4]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 10:37:04 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Fredrik Noring <noring@nocrew.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Thread-Topic: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Thread-Index: AQHVCmKoDp6AVawLEEugEGZuSLgHU6Zqu4uAgAA1oICAAQ5TAA==
Date:   Wed, 15 May 2019 10:37:03 +0000
Message-ID: <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com> <20190514182931.GA2559@sx9>
In-Reply-To: <20190514182931.GA2559@sx9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bd2ba5d-f397-483d-1f8e-08d6d921456e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4432;
x-ms-traffictypediagnostic: VI1PR04MB4432:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <VI1PR04MB4432A8177BD4C198B60DD258EC090@VI1PR04MB4432.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(51444003)(189003)(199004)(5660300002)(36756003)(53936002)(4326008)(6246003)(478600001)(71190400001)(14454004)(966005)(86362001)(14444005)(256004)(31696002)(31686004)(71200400001)(305945005)(7736002)(316002)(486006)(8936002)(6116002)(3846002)(99286004)(26005)(66556008)(66946007)(66476007)(66446008)(64756008)(2616005)(6436002)(476003)(446003)(11346002)(68736007)(76116006)(91956017)(73956011)(6512007)(6306002)(44832011)(2906002)(110136005)(54906003)(53546011)(186003)(25786009)(6506007)(102836004)(66066001)(76176011)(81166006)(81156014)(8676002)(6486002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4432;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1lYAzg1OgQhwXRd83xL8J5clfNFl1ZmNjrnC+7QNITDAKYUKVl/nJGmA/Fk99Dft5uG+K3bnnISxJ29mkl4NGCbMcvbwl1kNTnxS/gPDGg3MMki1BICxWvp/RvJ45Qrpf3/5nnHMZZ0E0Hj1LNbKiArnT8G8FXijgS28x9Sm3H9O1ri5c+jeIc8kg6DqO2pbuIQba6/l7xg/yZHNUGNLYVmUUt9Ph2OfM33pJlqT+455Sc0UvOJ9WNNFPQfyYYb7FNhdwm30qmeuNkR/H6tvPZL3uxOVPkGUQQGc0MBma2Tpp52fJkW1vTCjZ+nvOVTWPAU+98Fdg/B94hPkwUhKFIZal0FWuK1wG9g2dB8S+Pfze296q2cyxva0uEcrwdEkhv6ocXqQgOAijxudVUt8lt7re8EKE6Miu3l9P7Gwaq4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <810E4835CD66544F8E9EFAAC25DE090A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd2ba5d-f397-483d-1f8e-08d6d921456e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 10:37:03.9745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk9uIDE0LjA1LjIwMTkgMjE6MjksIEZyZWRyaWsgTm9yaW5nIHdyb3RlOg0KPiBU
aGFua3MgUm9iaW4hDQo+IA0KPj4+IEZvciBIQ3MgdGhhdCBoYXZlIGxvY2FsIG1lbW9yeSwgcmVw
bGFjZSB0aGUgY3VycmVudCBETUEgQVBJIHVzYWdlDQo+Pj4gd2l0aCBhIGdlbmFsbG9jIGdlbmVy
aWMgYWxsb2NhdG9yIHRvIG1hbmFnZSB0aGUgbWFwcGluZ3MgZm9yIHRoZXNlDQo+Pj4gZGV2aWNl
cy4NCj4+PiBUaGlzIGlzIGluIHByZXBhcmF0aW9uIGZvciBkcm9wcGluZyB0aGUgZXhpc3Rpbmcg
ImNvaGVyZW50IiBkbWENCj4+PiBtZW0gZGVjbGFyYXRpb24gQVBJcy4gQ3VycmVudCBpbXBsZW1l
bnRhdGlvbiB3YXMgcmVseWluZyBvbiBhIHNob3J0DQo+Pj4gY2lyY3VpdCBpbiB0aGUgRE1BIEFQ
SSB0aGF0IGluIHRoZSBlbmQsIHdhcyBhY3RpbmcgYXMgYW4gYWxsb2NhdG9yDQo+Pj4gZm9yIHRo
ZXNlIHR5cGUgb2YgZGV2aWNlcy4NCj4+Pg0KPj4+IE9ubHkgY29tcGlsZWQgdGVzdGVkLCBzbyBh
bnkgdm9sdW50ZWVycyB3aWxsaW5nIHRvIHRlc3QgYXJlIG1vc3Qgd2VsY29tZS4NCj4+DQo+PiBJ
IHJlY2FsbCBhbiBvdXQtb2YtdHJlZSBQbGF5U3RhdGlvbiAyIE9IQ0kgZHJpdmVyIGJlaW5nIGFu
b3RoZXINCj4+IEhDRF9MT0NBTF9NRU0gdXNlciAtIGlmIEZyZWRyaWsgYW5kIEp1ZXJnZW4gYXJl
IHN0aWxsIGFjdGl2ZSBvbiB0aGF0LA0KPj4gaG9wZWZ1bGx5IHRoZXkgbWlnaHQgYmUgYWJsZSB0
byBjb21tZW50IG9uIHdoZXRoZXIgdGhpcyBhcHByb2FjaCBjYW4NCj4+IHdvcmsgZm9yIHRoZW0g
dG9vLiBQYXRjaHdvcmsgbGluayBqdXN0IGluIGNhc2U6DQo+PiBodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3Byb2plY3QvbGludXgtdXNiL2xpc3QvP3Nlcmllcz0xMTc0MzMNCj4gDQo+IFRy
dWUuIEluIGZhY3QgSSdtIHByZXBhcmluZyBhIHBhdGNoIHN1Ym1pc3Npb24gZm9yIHRoaXMgUFMy
IE9IQ0kgZHJpdmVyLA0KPiBhbG9uZyB3aXRoIGFib3V0IGEgaHVuZHJlZCBvdGhlciBwYXRjaGVz
ICh1bnJlbGF0ZWQgdG8gdGhlIFVTQiBzdWJzeXN0ZW0pLg0KPiBIb3BlZnVsbHkgaW4gYSBmZXcg
d2Vla3MuIE15IHBhdGNoZXMgYXJlIGN1cnJlbnRseSBvbiB0b3Agb2YgdjUuMC4gV2hhdA0KPiBi
cmFuY2gvdmVyc2lvbiBpcyByZWNvbW1lbmRlZCB0byB0cnkgdGhpcyBETUEgdXBkYXRlPw0KDQpJ
IHRoaW5rIHRoYXQgYW55IHJlY2VudCBrZXJuZWwgd2lsbCBkbywgc28gSSdkIHNheSB5b3VyIGN1
cnJlbnQgYnJhbmNoIA0Kc2hvdWxkIGJlIGZpbmUuDQoNCj4gSGVyZSBpcyB0aGUgdjUuMC4xMSBQ
UzIgT0hDSSBkcml2ZXIsIGZvciByZWZlcmVuY2U6DQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20v
ZnJubzcvbGludXgvYmxvYi9wczItdjUuMC4xMS9kcml2ZXJzL3VzYi9ob3N0L29oY2ktcHMyLmMN
ClBsZWFzZSBub3RlIHRoYXQgdGhlIGRyaXZlciB3aWxsIG5lZWQgdG8gYmUgdXBkYXRlZCwgc2Vl
IGhlcmUgZm9yIGFuIA0KZXhhbXBsZToNCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
YXRjaC8xMDk0MzEwNS8NCg0KLS0tDQpCZXN0IFJlZ2FyZHMsIExhdXJldG5pdQ==
