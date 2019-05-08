Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F95C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA69F21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UEg8SCqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEHD0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 23:26:16 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:49703
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfEHD0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 23:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ46+YbKuyImdjA6OJGg1R2jIPfD2Ydqbs7TbZszJCk=;
 b=UEg8SCqtoywk8UmiwYWBEzdCj1CmSZolxVJxV3RtEMdXJfshGeEa6CWSViGBRfHnaefOMEILasgRsdEAL7Ws7KE15R82mwxnR/z5I7T7TvBX+sFNlJsay8BAxuAbuy1+9VnmaC44JJ/5YqGPyvrpOBnhoXSndSAPgg6gAlOTyXE=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB3040.eurprd04.prod.outlook.com (10.170.228.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 03:26:09 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 03:26:09 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suresh Gupta <B42813@freescale.com>
Subject: RE: [PATCH v4 2/5] usb: phy: Workaround for USB erratum-A005728
Thread-Topic: [PATCH v4 2/5] usb: phy: Workaround for USB erratum-A005728
Thread-Index: AQHUtHOesohGAmkVu06RgZ2b3quwfKXE1aeAgJxbksA=
Date:   Wed, 8 May 2019 03:26:09 +0000
Message-ID: <VI1PR04MB4158EB9135C9536D612F0967E9320@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190125060356.14294-2-yinbo.zhu@nxp.com>
 <Pine.LNX.4.44L0.1901281034080.1450-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1901281034080.1450-100000@iolanthe.rowland.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1569cd0-94d4-4192-e510-08d6d364e9d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3040;
x-ms-traffictypediagnostic: VI1PR04MB3040:
x-microsoft-antispam-prvs: <VI1PR04MB3040616CBB79E3B8C8E7C401E9320@VI1PR04MB3040.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(366004)(346002)(13464003)(199004)(189003)(5660300002)(2906002)(68736007)(76176011)(33656002)(3846002)(6116002)(4326008)(7736002)(229853002)(55016002)(44832011)(7696005)(2171002)(446003)(476003)(486006)(11346002)(26005)(6916009)(71200400001)(71190400001)(478600001)(186003)(52536014)(102836004)(53546011)(6506007)(8676002)(305945005)(25786009)(99286004)(14454004)(6436002)(9686003)(53936002)(54906003)(74316002)(66066001)(256004)(316002)(8936002)(81166006)(6246003)(107886003)(64756008)(66556008)(66476007)(66946007)(66446008)(86362001)(73956011)(76116006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3040;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X7tW4a0XMuoYE5B+7tAI44ihrmTSlArKYfOp15nwcs3fqqOgGW9L70h6ISW3iFEEhiR+u8ENaUKZZAtTpptfPRjHrEasZPwr9w3yOEw7PZT1syheH9e3NmbiPkGa2jk3S7f8dMWCJGe+xnurmlQgOkVLoFQFkgZf0IvX0yaozWj5uS333fKCEAdEgRzhgMmimf14VfG2sEzq1tsb8vo6oSgJ88akY0nuGbU+DJ4jxSypHVTrICMoRlkkMACAPiDJstJPCtfmMeUtweSqLf5/kqxHoiaECNt2ZHQ/MRxmJ90kzaRxDUn/MtCLwDlLocWW00MgSITSNx7zgqn0Kw+GFB8hwnzzW5S/bvbrjSYLMbKCRgtgnplyjnBPF+6EV22/bnkKH2523teNPzpppse+6EwaejSTC71cdMJ5Apqg3AM=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1569cd0-94d4-4192-e510-08d6d364e9d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 03:26:09.1164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxhbiBTdGVybiBbbWFp
bHRvOnN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHVdDQo+IFNlbnQ6IDIwMTnE6jHUwjI4yNUgMjM6
MzcNCj4gVG86IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQo+IENjOiBYaWFvYm8gWGll
IDx4aWFvYm8ueGllQG54cC5jb20+OyBKZXJyeSBIdWFuZyA8amVycnkuaHVhbmdAbnhwLmNvbT47
DQo+IFJhbiBXYW5nIDxyYW4ud2FuZ18xQG54cC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgUmFtbmVlayBNZWhyZXNoDQo+IDxyYW1uZWVr
Lm1laHJlc2hAZnJlZXNjYWxlLmNvbT47IE5pa2hpbCBCYWRvbGENCj4gPG5pa2hpbC5iYWRvbGFA
ZnJlZXNjYWxlLmNvbT47IFN1cmVzaCBHdXB0YSA8c3VyZXNoLmd1cHRhQGZyZWVzY2FsZS5jb20+
Ow0KPiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBTdXJlc2ggR3VwdGENCj4gPEI0MjgxM0BmcmVlc2NhbGUuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY0IDIvNV0gdXNiOiBwaHk6IFdvcmthcm91bmQgZm9yIFVTQiBlcnJhdHVtLUEw
MDU3MjgNCj4gDQo+IE9uIEZyaSwgMjUgSmFuIDIwMTksIFlpbmJvIFpodSB3cm90ZToNCj4gDQo+
ID4gRnJvbTogU3VyZXNoIEd1cHRhIDxCNDI4MTNAZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+IFBI
WV9DTEtfVkFMSUQgYml0IGZvciBVVE1JIFBIWSBpbiBVU0JEUiBkb2VzIG5vdCBzZXQgZXZlbiBp
ZiBQSFkgaXMNCj4gPiBwcm92aWRpbmcgdmFsaWQgY2xvY2suIFdvcmthcm91bmQgZm9yIHRoaXMg
aW52b2x2ZXMgcmVzZXR0aW5nIG9mIFBIWQ0KPiA+IGFuZCBjaGVjayBQSFlfQ0xLX1ZBTElEIGJp
dCBtdWx0aXBsZSB0aW1lcy4gSWYgUEhZX0NMS19WQUxJRCBiaXQgaXMNCj4gPiBzdGlsbCBub3Qg
c2V0IGV2ZW4gYWZ0ZXIgNSByZXRyaWVzLCBpdCB3b3VsZCBiZSBzYWZlIHRvIGRlYWNsYXJlIHRo
YXQNCj4gPiBQSFkgY2xvY2sgaXMgbm90IGF2YWlsYWJsZS4NCj4gPiBUaGlzIGVycmF0dW0gaXMg
YXBwbGljYWJsZSBmb3IgVVNCRFIgbGVzcyB0aGVuIHZlciAyLjQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTdXJlc2ggR3VwdGEgPEI0MjgxM0BmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdl
IGluIHY0Og0KPiA+IAkJSW5jb3JyZWN0IGluZGVudGF0aW9uIG9mIHRoZSBjb250aW51YXRpb24g
bGluZS4NCj4gPiAJCXJlcGxhY2UgcHJfZXJyIHdpdGggZGV2X2Vyci4NCj4gPg0KPiA+ICBkcml2
ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMgfCAgIDM4DQo+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuaCB8ICAgIDMg
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jIGIv
ZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jDQo+ID4gaW5kZXggMzg2NzRiNy4uMzczYTgxNiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMNCj4gPiArKysgYi9k
cml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMNCj4gPiBAQCAtMTgzLDYgKzE4MywxNyBAQCBzdGF0
aWMgaW50IGZzbF9laGNpX2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2
KQ0KPiA+ICAJcmV0dXJuIHJldHZhbDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBib29sIHVz
Yl9waHlfY2xrX3ZhbGlkKHN0cnVjdCB1c2JfaGNkICpoY2QpIHsNCj4gPiArCXZvaWQgX19pb21l
bSAqbm9uX2VoY2kgPSBoY2QtPnJlZ3M7DQo+ID4gKwlib29sIHJldCA9IHRydWU7DQo+ID4gKw0K
PiA+ICsJaWYgKCEoaW9yZWFkMzJiZShub25fZWhjaSArIEZTTF9TT0NfVVNCX0NUUkwpICYgUEhZ
X0NMS19WQUxJRCkpDQo+ID4gKwkJcmV0ID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJl
dDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBlaGNpX2ZzbF9zZXR1cF9waHkoc3Ry
dWN0IHVzYl9oY2QgKmhjZCwNCj4gPiAgCQkJICAgICAgIGVudW0gZnNsX3VzYjJfcGh5X21vZGVz
IHBoeV9tb2RlLA0KPiA+ICAJCQkgICAgICAgdW5zaWduZWQgaW50IHBvcnRfb2Zmc2V0KQ0KPiA+
IEBAIC0yMjYsNiArMjM3LDE3IEBAIHN0YXRpYyBpbnQgZWhjaV9mc2xfc2V0dXBfcGh5KHN0cnVj
dCB1c2JfaGNkICpoY2QsDQo+ID4gIAkJLyogZmFsbCB0aHJvdWdoICovDQo+ID4gIAljYXNlIEZT
TF9VU0IyX1BIWV9VVE1JOg0KPiA+ICAJY2FzZSBGU0xfVVNCMl9QSFlfVVRNSV9EVUFMOg0KPiA+
ICsJCS8qIFBIWV9DTEtfVkFMSUQgYml0IGlzIGRlLWZlYXR1cmVkIGZyb20gYWxsIGNvbnRyb2xs
ZXINCj4gPiArCQkgKiB2ZXJzaW9ucyBiZWxvdyAyLjQgYW5kIGlzIHRvIGJlIGNoZWNrZWQgb25s
eSBmb3INCj4gPiArCQkgKiBpbnRlcm5hbCBVVE1JIHBoeQ0KPiA+ICsJCSAqLw0KPiA+ICsJCWlm
IChwZGF0YS0+Y29udHJvbGxlcl92ZXIgPiBGU0xfVVNCX1ZFUl8yXzQgJiYNCj4gPiArCQkgICAg
cGRhdGEtPmhhdmVfc3lzaWZfcmVncyAmJiAhdXNiX3BoeV9jbGtfdmFsaWQoaGNkKSkgew0KPiA+
ICsJCQlkZXZfZXJyKGRldiwNCj4gPiArCQkJCSIlczogVVNCIFBIWSBjbG9jayBpbnZhbGlkXG4i
LCBkZXZfbmFtZShkZXYpKTsNCj4gDQo+IFRoaXMgbG9va3Mgc2lsbHk7IGl0IHByaW50cyB0aGUg
ZGV2aWNlIG5hbWUgdHdpY2UgKG9uY2UgYmVjYXVzZSB0aGF0J3Mgd2hhdA0KPiBkZXZfZXJyKCkg
ZG9lcywgYW5kIHRoZW4gYWdhaW4gYmVjYXVzZSB5b3UgZXhwbGljaXRseSB0b2xkIGl0IHRvIHBy
aW50IHRoZSBkZXZpY2UNCj4gbmFtZSkuDQo+IA0KPiBMb29rIGF0IGhvdyBkZXZfZXJyKCkgaXMg
dXNlZCBpbiBvdGhlciBwYXJ0cyBvZiB0aGUgZHJpdmVyIGFuZCBkbyB0aGUgc2FtZSB0aGluZy4N
Cj4gDQo+ID4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gIAkJaWYg
KHBkYXRhLT5oYXZlX3N5c2lmX3JlZ3MgJiYgcGRhdGEtPmNvbnRyb2xsZXJfdmVyKSB7DQo+ID4g
IAkJCS8qIGNvbnRyb2xsZXIgdmVyc2lvbiAxLjYgb3IgYWJvdmUgKi8NCj4gPiAgCQkJdG1wID0g
aW9yZWFkMzJiZShub25fZWhjaSArIEZTTF9TT0NfVVNCX0NUUkwpOyBAQCAtMjQ5LDE3DQo+ICsy
NzEsMTENCj4gPiBAQCBzdGF0aWMgaW50IGVoY2lfZnNsX3NldHVwX3BoeShzdHJ1Y3QgdXNiX2hj
ZCAqaGNkLA0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQkvKg0KPiA+IC0JICog
Y2hlY2sgUEhZX0NMS19WQUxJRCB0byBkZXRlcm1pbmUgcGh5IGNsb2NrIHByZXNlbmNlIGJlZm9y
ZSB3cml0aW5nDQo+ID4gLQkgKiB0byBwb3J0c2MNCj4gPiAtCSAqLw0KPiA+IC0JaWYgKHBkYXRh
LT5jaGVja19waHlfY2xrX3ZhbGlkKSB7DQo+ID4gLQkJaWYgKCEoaW9yZWFkMzJiZShub25fZWhj
aSArIEZTTF9TT0NfVVNCX0NUUkwpICYNCj4gPiAtCQkgICAgUEhZX0NMS19WQUxJRCkpIHsNCj4g
PiAtCQkJZGV2X3dhcm4oaGNkLT5zZWxmLmNvbnRyb2xsZXIsDQo+ID4gLQkJCQkgIlVTQiBQSFkg
Y2xvY2sgaW52YWxpZFxuIik7DQo+ID4gLQkJCXJldHVybiAtRUlOVkFMOw0KPiA+IC0JCX0NCj4g
PiArCWlmIChwZGF0YS0+aGF2ZV9zeXNpZl9yZWdzICYmDQo+ID4gKwkgICAgcGRhdGEtPmNvbnRy
b2xsZXJfdmVyID4gRlNMX1VTQl9WRVJfMV82ICYmDQo+ID4gKwkJIXVzYl9waHlfY2xrX3ZhbGlk
KGhjZCkpIHsNCj4gPiArCQlkZXZfd2FybihoY2QtPnNlbGYuY29udHJvbGxlciwgIlVTQiBQSFkg
Y2xvY2sgaW52YWxpZFxuIik7DQo+IA0KPiBPbmNlIGFnYWluLCB5b3UgaGF2ZSBhIGNvbnRpbnVh
dGlvbiBsaW5lIHRoYXQgaXMgaW5kZW50ZWQgYnkgdGhlIHNhbWUgYW1vdW50IGFzDQo+IHRoZSBj
b2RlIGluIHRoZSBpbm5lciBibG9jay4gIFBsZWFzZSBmaXggdGhpcyBwcm9wZXJseS4NCkhpIEFs
YW4gc3Rlcm4sDQoNCkFib3ZlIGNvZGUgaW5kZW50ZWQgaXMgaW4gb2RlciB0byBlbnN1cmUgdGhh
dCBldmVyeSBsaW5lIGxlc3MgdGhhbiA4MCBjaGFyYWN0ZXJzLA0KT3RoZXJ3aXNlLCBjaGVjay1w
YXRjaCB0b29sIHRvIGNoZWNrIHBhdGNoIHRoYXQgd2lsbCBoYXMgZXJyb3IuDQoNClJlZ2FyZHMs
DQpZaW5ibw0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICAJfQ0KPiA+DQo+ID4gIAllaGNp
X3dyaXRlbChlaGNpLCBwb3J0c2MsICZlaGNpLT5yZWdzLT5wb3J0X3N0YXR1c1twb3J0X29mZnNl
dF0pOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmggYi9kcml2
ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmgNCj4gPiBpbmRleCBjYmM0MjIwLi45ZDE4YzZlIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuaA0KPiA+ICsrKyBiL2RyaXZl
cnMvdXNiL2hvc3QvZWhjaS1mc2wuaA0KPiA+IEBAIC01MCw0ICs1MCw3IEBADQo+ID4gICNkZWZp
bmUgVVRNSV9QSFlfRU4gICAgICAgICAgICAgKDE8PDkpDQo+ID4gICNkZWZpbmUgVUxQSV9QSFlf
Q0xLX1NFTCAgICAgICAgKDE8PDEwKQ0KPiA+ICAjZGVmaW5lIFBIWV9DTEtfVkFMSUQJCSgxPDwx
NykNCj4gPiArDQo+ID4gKy8qIFJldHJ5IGNvdW50IGZvciBjaGVja2luZyBVVE1JIFBIWSBDTEsg
dmFsaWRpdHkgKi8gI2RlZmluZQ0KPiA+ICtVVE1JX1BIWV9DTEtfVkFMSURfQ0hLX1JFVFJZIDUN
Cj4gPiAgI2VuZGlmCQkJCS8qIF9FSENJX0ZTTF9IICovDQo+IA0KPiBBbGFuIFN0ZXJuDQoNCg==
