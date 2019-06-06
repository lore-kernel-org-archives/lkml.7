Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50E4C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6796C207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f00ZiltP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfFFGfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:35:21 -0400
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:8903
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfFFGfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOjKJbZ9uzZFZopQndsV3284mzJQ9yzn0gRqm8OSuNE=;
 b=f00ZiltPmRCJzJHmAimm924eZqe6xo98h5j0BPn28U9MifeOI6Ut1zb36tNfszBJ8/MVAafW0fPyK8Y7vqVAdSfGZCC3XKXSPyS7b3yNYizpXLnwmAmEMH12iczUSqE9EkSCbNV9Fh0trpz4OzPVw/6/dFaZrWU5IteEcOfiUWQ=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5517.eurprd04.prod.outlook.com (20.178.122.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 06:35:15 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::adce:72e8:d327:a10]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::adce:72e8:d327:a10%7]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 06:35:15 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 4/5] usb: host: Stops USB controller init if
 PLL fails to lock
Thread-Topic: [EXT] Re: [PATCH v6 4/5] usb: host: Stops USB controller init if
 PLL fails to lock
Thread-Index: AQHVG2JFHPrNwRzzI0qVTHZVwmHoiqaNHVEAgAELuXA=
Date:   Thu, 6 Jun 2019 06:35:14 +0000
Message-ID: <VI1PR04MB4158822B3E935275A488FDA7E9170@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190605054952.34687-4-yinbo.zhu@nxp.com>
 <Pine.LNX.4.44L0.1906051020540.1788-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1906051020540.1788-100000@iolanthe.rowland.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5856730c-23bc-4636-9049-08d6ea49227f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5517;
x-ms-traffictypediagnostic: VI1PR04MB5517:
x-microsoft-antispam-prvs: <VI1PR04MB551707968EDD98E6AFAA9A43E9170@VI1PR04MB5517.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(366004)(189003)(199004)(13464003)(81156014)(8676002)(2906002)(4326008)(229853002)(68736007)(73956011)(66476007)(3846002)(74316002)(8936002)(44832011)(81166006)(6246003)(6916009)(2171002)(6436002)(64756008)(66556008)(66446008)(76116006)(7736002)(33656002)(305945005)(6116002)(53936002)(25786009)(14444005)(66946007)(71190400001)(71200400001)(256004)(5660300002)(52536014)(14454004)(55016002)(66066001)(9686003)(186003)(446003)(26005)(476003)(11346002)(486006)(76176011)(53546011)(6506007)(102836004)(99286004)(316002)(7696005)(54906003)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5517;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Or7U349XZSMbDzfbJiKD6QrlFCDOP9w03Vv+LLaoEPd739IsIOXrxipHvgpfdRB3KO1Mcvj+ekZoA5WgDiYM/ifc/W6iWVA7kTeNJkBnETJ2UXgXHyyUxpKSmKWTLN1kkKPqpKN6zIRlQsMQKx7htJu8B3q3PVNGgKGJbnD08P50r4Gc+aR92BwvGXysVpb5x5R5IZh1tOjC1Ft4zY1n3ChdJxsJnUPK4CB/lVFk86zLXaAFu3oS1KQ6d/aGEsRPwmgtTagLAR/lKa1OXGChKJyipHhdBF7P52J64hv/ZNl14tFr8quajcC21LFGHV3n/iY+SCEp9TP5rMNnr9tQgZeUqLNqz55y0o+5raaoKkeDVkfcTB9grs0Ka1NPGZBeBaqBTrFYz8HD9DjRllWCsR6sNJ9CubQ2Re7ZaI0kicY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5856730c-23bc-4636-9049-08d6ea49227f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 06:35:14.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yinbo.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5517
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxhbiBTdGVybiBbbWFp
bHRvOnN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHVdDQo+IFNlbnQ6IDIwMTnE6jbUwjXI1SAyMjoy
Mg0KPiBUbzogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCj4gQ2M6IFhpYW9ibyBYaWUg
PHhpYW9iby54aWVAbnhwLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBSYW1uZWVrIE1laHJlc2gNCj4gPHJhbW5lZWsubWVocmVzaEBmcmVl
c2NhbGUuY29tPjsgTmlraGlsIEJhZG9sYQ0KPiA8bmlraGlsLmJhZG9sYUBmcmVlc2NhbGUuY29t
PjsgUmFuIFdhbmcgPHJhbi53YW5nXzFAbnhwLmNvbT47DQo+IGxpbnV4LXVzYkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppYWZlaSBQYW4NCj4gPGppYWZl
aS5wYW5AbnhwLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2NiA0LzVdIHVzYjog
aG9zdDogU3RvcHMgVVNCIGNvbnRyb2xsZXIgaW5pdCBpZiBQTEwgZmFpbHMgdG8NCj4gbG9jaw0K
PiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBXZWQsIDUgSnVuIDIwMTksIFlpbmJv
IFpodSB3cm90ZToNCj4gDQo+ID4gRnJvbTogUmFtbmVlayBNZWhyZXNoIDxyYW1uZWVrLm1laHJl
c2hAZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+IFVTQiBlcnJhdHVtLUEwMDY5MTggd29ya2Fyb3Vu
ZCB0cmllcyB0byBzdGFydCBpbnRlcm5hbCBQSFkgaW5zaWRlDQo+ID4gdWJvb3QgKHdoZW4gUExM
IGZhaWxzIHRvIGxvY2spLiBIb3dldmVyLCBpZiB0aGUgd29ya2Fyb3VuZCBhbHNvIGZhaWxzLA0K
PiA+IHRoZW4gVVNCIGluaXRpYWxpemF0aW9uIGlzIGFsc28gc3RvcHBlZCBpbnNpZGUgTGludXgu
DQo+ID4gRXJyYXR1bS1BMDA2OTE4IHdvcmthcm91bmQgZmFpbHVyZSBjcmVhdGVzICJmc2wsZXJy
YXR1bV9hMDA2OTE4Ig0KPiA+IG5vZGUgaW4gZGV2aWNlLXRyZWUuIFByZXNlbmNlIG9mIHRoaXMg
bm9kZSBpbiBkZXZpY2UtdHJlZSBpcyB1c2VkIHRvDQo+ID4gc3RvcCBVU0IgY29udHJvbGxlciBp
bml0aWFsaXphdGlvbiBpbiBMaW51eA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFtbmVlayBN
ZWhyZXNoIDxyYW1uZWVrLm1laHJlc2hAZnJlZXNjYWxlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTdXJlc2ggR3VwdGEgPHN1cmVzaC5ndXB0YUBmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdl
IGluIHY2Og0KPiA+ICAgICAgICAgICAgICAgYWRkIGEgIkZhbGwgdGhyb3VnaCIgY29tbWVudA0K
PiA+DQo+ID4gIGRyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuYyAgICAgIHwgMTAgKysrKysrKysr
LQ0KPiA+ICBkcml2ZXJzL3VzYi9ob3N0L2ZzbC1tcGgtZHItb2YuYyB8ICAzICsrLQ0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jIGIvZHJpdmVycy91c2Iv
aG9zdC9laGNpLWZzbC5jDQo+ID4gaW5kZXggOGYzYmYzZWZiMDM4Li44NmFlMzcwODZhNzQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jDQo+ID4gKysrIGIvZHJp
dmVycy91c2IvaG9zdC9laGNpLWZzbC5jDQo+ID4gQEAgLTIzNCw4ICsyMzQsMTYgQEAgc3RhdGlj
IGludCBlaGNpX2ZzbF9zZXR1cF9waHkoc3RydWN0IHVzYl9oY2QgKmhjZCwNCj4gPiAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIGNhc2UgRlNMX1VTQjJfUEhZX1VUTUlfV0lERToNCj4g
PiAgICAgICAgICAgICAgIHBvcnRzYyB8PSBQT1JUX1BUU19QVFc7DQo+ID4gLSAgICAgICAgICAg
ICAvKiBmYWxsIHRocm91Z2ggKi8NCj4gPiAgICAgICBjYXNlIEZTTF9VU0IyX1BIWV9VVE1JOg0K
PiA+ICsgICAgICAgICAgICAgLyogUHJlc2VuY2Ugb2YgdGhpcyBub2RlICJoYXNfZnNsX2VycmF0
dW1fYTAwNjkxOCINCj4gPiArICAgICAgICAgICAgICAqIGluIGRldmljZS10cmVlIGlzIHVzZWQg
dG8gc3RvcCBVU0IgY29udHJvbGxlcg0KPiA+ICsgICAgICAgICAgICAgICogaW5pdGlhbGl6YXRp
b24gaW4gTGludXgNCj4gPiArICAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgaWYg
KHBkYXRhLT5oYXNfZnNsX2VycmF0dW1fYTAwNjkxOCkgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBkZXZfd2FybihkZXYsICJVU0IgUEhZIGNsb2NrIGludmFsaWRcbiIpOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAgIH0NCj4g
PiArDQo+ID4gICAgICAgY2FzZSBGU0xfVVNCMl9QSFlfVVRNSV9EVUFMOg0KPiANCj4gDQo+IFlv
dSBuZWVkIHRvIGFkZCBhICJGYWxsIHRocm91Z2giIGNvbW1lbnQgYmV0d2VlbiB0aGVzZSB0d28g
Y2FzZXMuDQo+ID4gICAgICAgY2FzZSBGU0xfVVNCMl9QSFlfVVRNSV9EVUFMOg0KPiA+ICAgICAg
ICAgICAgICAgLyogUEhZX0NMS19WQUxJRCBiaXQgaXMgZGUtZmVhdHVyZWQgZnJvbSBhbGwgY29u
dHJvbGxlcg0KPiA+ICAgICAgICAgICAgICAgICogdmVyc2lvbnMgYmVsb3cgMi40IGFuZCBpcyB0
byBiZSBjaGVja2VkIG9ubHkgZm9yDQo+IA0KPiBBbGFuIFN0ZXJuDQo+IEhpIEFsYW4gU3Rlcm4s
DQo+DQo+IFlvdXIgbWVhbmluZyBpcyB0byByZW1vdmUgIi8qIGZhbGwgdGhyb3VnaCovIiBvciBh
ZGQgdGhlIGVycmF0dW0gY29tbW9udCByZXBsYWNlICIvKiBmYWxsIHRocm91Z2gqLyINCj4NCj4g
UmVnYXJkcywNCj4gWWluYm8NCj4gVGhpcyBpcyBiYWQuICBZb3UgZ290IHJpZCBvZiBhICJmYWxs
IHRocm91Z2giIGNvbW1lbnQgdGhhdCB3YXMgbmVlZGVkLCBhbmQgeW91DQo+IGZhaWxlZCB0byBh
ZGQgYW5vdGhlciBvbmUgd2hlcmUgaXQgd2FzIG5lZWRlZC4NCj4gDQo+IEFsYW4gU3Rlcm4NCkkg
ZG9uJ3QgZ2V0IHlvdXIgbWVhbmluZy4NCllpbmJvDQo+IA0KPiA+ICAgICAgICAgICAgICAgLyog
UEhZX0NMS19WQUxJRCBiaXQgaXMgZGUtZmVhdHVyZWQgZnJvbSBhbGwgY29udHJvbGxlcg0KPiA+
ICAgICAgICAgICAgICAgICogdmVyc2lvbnMgYmVsb3cgMi40IGFuZCBpcyB0byBiZSBjaGVja2Vk
IG9ubHkgZm9yIGRpZmYNCj4gPiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QvZnNsLW1waC1kci1v
Zi5jDQo+ID4gYi9kcml2ZXJzL3VzYi9ob3N0L2ZzbC1tcGgtZHItb2YuYw0KPiA+IGluZGV4IDRm
OGI4YTA4YzkxNC4uNzYyYjk3NjAwYWIwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hv
c3QvZnNsLW1waC1kci1vZi5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC9mc2wtbXBoLWRy
LW9mLmMNCj4gPiBAQCAtMjI0LDEzICsyMjQsMTQgQEAgc3RhdGljIGludCBmc2xfdXNiMl9tcGhf
ZHJfb2ZfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqb2ZkZXYpDQo+ID4gICAgICAg
ICAgICAgICBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJmc2wsdXNiLWVycmF0dW0tYTAwNTI3
NSIpOw0KPiA+ICAgICAgIHBkYXRhLT5oYXNfZnNsX2VycmF0dW1fYTAwNTY5NyA9DQo+ID4gICAg
ICAgICAgICAgICBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJmc2wsdXNiX2VycmF0dW0tYTAw
NTY5NyIpOw0KPiA+ICsgICAgIHBkYXRhLT5oYXNfZnNsX2VycmF0dW1fYTAwNjkxOCA9DQo+ID4g
KyAgICAgICAgICAgICBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJmc2wsdXNiX2VycmF0dW0t
YTAwNjkxOCIpOw0KPiA+DQo+ID4gICAgICAgaWYgKG9mX2dldF9wcm9wZXJ0eShucCwgImZzbCx1
c2JfZXJyYXR1bV8xNCIsIE5VTEwpKQ0KPiA+ICAgICAgICAgICAgICAgcGRhdGEtPmhhc19mc2xf
ZXJyYXR1bV8xNCA9IDE7DQo+ID4gICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgcGRhdGEt
Pmhhc19mc2xfZXJyYXR1bV8xNCA9IDA7DQo+ID4NCj4gPiAtDQo+ID4gICAgICAgLyoNCj4gPiAg
ICAgICAgKiBEZXRlcm1pbmUgd2hldGhlciBwaHlfY2xrX3ZhbGlkIG5lZWRzIHRvIGJlIGNoZWNr
ZWQNCj4gPiAgICAgICAgKiBieSByZWFkaW5nIHByb3BlcnR5IGluIGRldmljZSB0cmVlDQo+ID4N
Cg0K
