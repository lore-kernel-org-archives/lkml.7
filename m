Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F60C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F722208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qEsmGjju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfHOESI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:18:08 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:2937
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfHOESH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:18:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvOSHnxxIqWEm72RvCdQiyFh4a0E45g/notc8PdYJB3I674gkq3srpP/Ow0k4BQGtCPGJMxZVq3BtwjHUbcq9lDnHZ7xNywYwQ1Xsg1oTejrc/xX5DmjRw52RXY31TKJA2qpqB1raH99/ACf2BtMiGpYvd1MpzHEXQ+380e/k5RYL7/ltYnQWtVFrwVjNl7BRNGuh9CXXXOGcdSvV2lN1Fbw+JZE+cq/MXagimSpjUmUhwsCUkBhs28R0oKRzJAGZJsqL1tbeVxOtosHqtA5FOSktEKMWq+DEmW9XJr+bYLyCbABpKbj5abdWvnZFr37vwt50WU9iAjmwkssn2JCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8xMkouRGDV9FIiPSOfrPMKNiHXqf50kmEwVlbvd5DI=;
 b=m2r9WF2rcty7eyc9CoWs96Zc/KdAGSdVhs4BtnFjx3vPfyKhTUjpQHFS9M49ZGkkP48SjM3x6yycpZ3ilhYH+jGTOLa2a2FzJOMu9PBloW+VI0S1mh47QMZ7S5UytqLHUAPoRWhrpoVDY83BKe7kYhM+HGAum8+NqrXMMxHo3JiV5G8tKthuOU83HFTr6LxXUfEvsBogPjQUsSYL05ecdjjFybEayfYeZd8CvSwHzs0zSPHELEj+lkKy3O51bt2NFxeA9aqPoTU/XS6YGuFGGzMLJEkHp+yMLn2oUS6QlisCXS17Swq6ByLiiQLWr98LoptuprhXJxmmkvFlT/5a3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8xMkouRGDV9FIiPSOfrPMKNiHXqf50kmEwVlbvd5DI=;
 b=qEsmGjjuprafTgsiXWtVq7eG2m2echcFjjmUSWjpYL+hmy+MdyJpk+RBYt8qF25qJKEKDkXqiR/RuvsrJBx/KmyUmxKJFzIyaQr48/Aob0N89Nx9FGBIjzFxz2JTpCeyP5u0lpoL/u8EfzlHm16Dyl631YAYNB+BH7DyW6RtCuM=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4624.eurprd04.prod.outlook.com (20.177.56.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Thu, 15 Aug 2019 04:18:01 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::5c03:e10a:3a8d:d229]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::5c03:e10a:3a8d:d229%3]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 04:18:01 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of
 USBx_GFLADJ
Thread-Topic: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of
 USBx_GFLADJ
Thread-Index: AQHVRdjlx4xav9SpcE6dT51LBbLuJ6bwwpYAgAYkuaCAACotgIAEhrMA
Date:   Thu, 15 Aug 2019 04:18:01 +0000
Message-ID: <VI1PR04MB4158B49129BE9E3C00997555E9AC0@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190729064607.8131-1-yinbo.zhu@nxp.com>
 <875zn8nt31.fsf@gmail.com>
 <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com>
 <87h86nvtqo.fsf@gmail.com>
In-Reply-To: <87h86nvtqo.fsf@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e15beb20-70cf-4ad6-64da-08d721378fde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4624;
x-ms-traffictypediagnostic: VI1PR04MB4624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4624388A19AE2AEF037D3FFFE9AC0@VI1PR04MB4624.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(199004)(189003)(13464003)(5660300002)(3846002)(7736002)(25786009)(6246003)(305945005)(229853002)(8676002)(6116002)(26005)(71200400001)(66066001)(71190400001)(99286004)(74316002)(186003)(316002)(9686003)(52536014)(4326008)(110136005)(76176011)(81166006)(6436002)(102836004)(54906003)(6506007)(55016002)(86362001)(8936002)(53936002)(53546011)(64756008)(66556008)(476003)(14454004)(44832011)(66476007)(446003)(11346002)(66446008)(14444005)(76116006)(478600001)(81156014)(66946007)(2501003)(486006)(33656002)(256004)(7696005)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4624;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5Ywm7oT+uTids40wpilLOB1gu/YW01aUztwFZmcuwiqjVrn6TGEHuLj+11z5XUFXnSvG9FR0zTDKIpC3f4RO25rML/F9QvfZizIdCZiWUwOagOg/mCCvPd+MqXAnwgS2i2S5rY0RHu/AfNcorHyk5fx0MjvELl8RvW/AMSHnzOe3/TuH6JA93Hr9Gszn/ugImetSUqbKp42dxmtTYVeevwutn7dSpSLzSQnvGi5OSJF4PUhx/midmIVPnFuASBrOYNEx46Ky+nrwSfiKxFv6Pn0b6QfuurPY0sFF+XcBnIf6ppdIzFiRYu0SXnsbGwKYhuid9AKG7GGNQoseNFkHzHDMcc9v7vnmY9b9xaqrbVsSpHU2iR7YO4kEK/Ywbc1wlQdSEX7FmjRu/18lPbMYGC7NxbjzVJnV0PsSNMWQXIc=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15beb20-70cf-4ad6-64da-08d721378fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 04:18:01.5150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lz0AWjQVps1uU0hOIeAjfYZzfuzssYMw5ICFWNTaCQP1Z+tUU+Po6HvOmSATxdVwOyq4eVzLtHmw4Y3h8g/1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmVsaXBlIEJhbGJpIFtt
YWlsdG86YmFsYmlAa2VybmVsLm9yZ10NCj4gU2VudDogMjAxOcTqONTCMTLI1SAxMzoyNw0KPiBU
bzogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBv
cGVuIGxpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBYaWFvYm8g
WGllIDx4aWFvYm8ueGllQG54cC5jb20+OyBKaWFmZWkgUGFuIDxqaWFmZWkucGFuQG54cC5jb20+
OyBSYW4NCj4gV2FuZyA8cmFuLndhbmdfMUBueHAuY29tPg0KPiBTdWJqZWN0OiBSRTogW0VYVF0g
UmU6IFtQQVRDSCB2MV0gdXNiOiBkd2MzOiByZW1vdmUgdGhlIGNhbGwgdHJhY2Ugb2YNCj4gVVNC
eF9HRkxBREoNCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gSGksDQo+IA0KPiBZaW5i
byBaaHUgPHlpbmJvLnpodUBueHAuY29tPiB3cml0ZXM6DQo+ID4+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPj4gPiBp
bmRleA0KPiA+PiA+IDk4YmNlODVjMjlkMC4uYTEzM2Q4NDkwMzIyIDEwMDY0NA0KPiA+PiA+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+ID4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gPj4gPiBAQCAtMzAwLDggKzMwMCw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZnJh
bWVfbGVuZ3RoX2FkanVzdG1lbnQoc3RydWN0DQo+ID4+ID4gZHdjMyAqZHdjKQ0KPiA+PiA+DQo+
ID4+ID4gICAgICAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR0ZMQURKKTsNCj4g
Pj4gPiAgICAgICBkZnQgPSByZWcgJiBEV0MzX0dGTEFESl8zME1IWl9NQVNLOw0KPiA+PiA+IC0g
ICAgIGlmICghZGV2X1dBUk5fT05DRShkd2MtPmRldiwgZGZ0ID09IGR3Yy0+ZmxhZGosDQo+ID4+
ID4gLSAgICAgICAgICJyZXF1ZXN0IHZhbHVlIHNhbWUgYXMgZGVmYXVsdCwgaWdub3JpbmdcbiIp
KSB7DQo+ID4+ID4gKyAgICAgaWYgKGRmdCAhPSBkd2MtPmZsYWRqKSB7DQo+ID4+DQo+ID4+IGlm
IHRoZSB2YWx1ZSBpc24ndCBkaWZmZXJlbnQsIHdoeSBkbyB5b3Ugd2FudCB0byBjaGFuZ2UgaXQ/
DQo+ID4+DQo+ID4+IC0tDQo+ID4+IEJhbGJpDQo+ID4gSGkgQmFsYmksDQo+ID4NCj4gPiBJIGRv
bid0IGNoYW5nZSBhbnkgdmFsdWUuIEkgd2FzIHJlbW92ZSB0aGF0IGNhbGwgdHJhY2UuDQo+IA0K
PiBTdXJlIHlvdSBkby4gVGhlIHNwbGF0IG9ubHkgc2hvd3Mgd2hlbiB5b3UgcmVxdWVzdCBhIEZM
QURKIHZhbHVlIHRoYXQncyB0aGUNCj4gc2FtZSBhcyB0aGUgb25lIGFscmVhZHkgaW4gdGhlIHJl
Z2lzdGVyLiBUaGUgcmVhc29uIHlvdSBzZWUgdGhlIHNwbGF0IGlzIGJlY2F1c2UNCj4geW91ciBy
ZXF1ZXN0ZWQgdmFsdWUgaXMgd2hhdCdzIGFscmVhZHkgaW4gdGhlIEhXLg0KPiANCj4gU28sIGFn
YWluLCB3aHkgYXJlIHlvdSBhZGRpbmcgdGhpcyBkZXZpY2UgdHJlZSBwcm9wZXJ0eSBpZiB0aGUg
dmFsdWUgaXMgYWxyZWFkeSB0aGUNCj4gY29ycmVjdCBvbmU/DQo+IA0KPiA+IEluIGFkZGl0aW9u
IHRoYXQgR0ZMQURKXzMwTUhaIHZhbHVlIGludGlhbCB2YWx1ZSBpcyAwLCBhbmQgaXQncyB2YWx1
ZQ0KPiA+IG11c3QgYmUgMHgyMCwgaWYgbm90LCB1c2Igd2lsbCBub3Qgd29yay4NCj4gDQo+IGl0
J3Mgbm90IHplcm8sIG90aGVyd2lzZSB0aGUgc3BsYXQgd291bGRuJ3QgdHJpZ2dlci4gWW91J3Jl
IHJlcXVlc3RpbmcgdGhlIHZhbHVlDQo+IHRoYXQncyBhbHJlYWR5IGluIHlvdXIgcmVnaXN0ZXIg
YnkgZGVmYXVsdC4NCj4gDQo+IC0tDQo+IEJhbGJpDQoNCkhpIEJhbGJpLA0KICAgDQpBY2NvcmRp
bmcgdGhhdCBybSBkb2MgdGhhdCBHRkxBREpfMzBNSFogaGFzIGEgZGVmYXVsdCB2YWx1ZSBpcyAw
eDIwLCB3aGVuIEdGTEFESl8zME1IWl9SRUdfU0VMIGlzIDAsIHRoaXMgMHgyMCBpcyBhIGhhcmQt
Y29kZWQgdmFsdWUuDQpCdXQgaW4gZmFjdCwgdGhhdCBkZWZhdWx0IHZhbHVlIGlzIDAsIHBsZWFz
ZSB5b3Ugbm90ZSEgICAgDQpUaGVuIGFjY29yZGluZyB0aGF0IHhoY2kgc3BlYyA1LjIuNCwgdGhh
dCByZWdpc3RlciB0aGUgc2l4dGggYml0IGlmIGlzIDAsIHRoZW4gdGhhdCBjYW4gc3VwcG9ydCBG
cmFtZSBMZW50aCBUaW1pbmcgdmFsdWUuDQpTbyBzZXQgR0ZMQURKXzMwTUhaX1JFR19TRUwgdG8g
MSBmb3IgdXNlIEZMQURKLCB0aGVuIEkgZmluZCB0aGF0IGl0IG11c3QgdXNlIDB4MjAgdXNiIHdp
bGwgd29yayB3ZWxsLCBldmVuIHRob3VnIHhoY2kgY2FuIHBlcm1pdCBHRkxBREpfMzBNSFogdXNl
IG90aGVyIHZhbHVlDQpJbiBhZGRpdGlvbiBhYm91dCB3aGF0IHlvdSBzYWlkIGlzIGFib3V0IGR0
cyBwYXRjaCwgYW5kIHRoYXQgcGF0Y2ggaGFkIG1lcmdlZCBieSB1cHN0cmVhbSwgcGF0Y2ggb3du
ZXIgaXNuJ3QgbWUsIA0KTXkgcGF0Y2ggaXMgb25seSBmb3IgcmVtb3ZlIHRoZSBjYWxsLXRyYWNl
LCBhYm91dCB3aHkgcmVtb3ZlIGl0IGNvbW1pdCBpbmZvcm1hdGlvbiBoYXMgZGV0YWlsIGludHJv
ZHVjZSBwbGVhc2UgY2hlY2shDQoNClRoYW5rcywNCllpbmJvLg0KDQoNCg0K
