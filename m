Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0D5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 03:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99100206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 03:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sURocGKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfHLDKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 23:10:10 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:37088
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbfHLDKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 23:10:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFPeNM8iPXIEiRW+IW3i/W49tiOGQpEJUON6oM4jUn7A4wCA1+39Higc3ZlI6rMy/jNgAXbGxlUp3uElirtps9vYRMc9VMyZ3crnBfth9Wvs5Hwow3ddMKGUpDNH57ZptD2Xk5EPjS/5c5z4bOgPf7/PavgefgFfjHvTJilHZIw9b1PmASv2Bc+qHWrOe1b5a06Zblgc6Jb5qgu5+AEiFgKefhMb5Fyw5shMDxTG7ltsTaQQO9Bo+QiPAgXHEKoYQEHkz3kiiF1w+ALjh6JG9xUwJb3dgTfLXSsm5LBjA6CgXb/WM4jzRH7YcWgyM5kNf4p83XCxrNwhWXpg66L0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po5GMAb5mhQFpVDkLziheN9J1G7hGt/SgZ2jIDr6TrA=;
 b=lUnS3oBRaLd+0cgwzvjJV+TUKIwaCHWWap+bFp2hy9V9ebtb1c/yLgnZ0yyVoRrakLyuBbNPrESlSlPeS+t3a47ZcKgXxWANiSZZcdZDS+0C7+r/e1FGNiXWmeI8lr6psSD8yFxFyLmg2SseKRUofi4VCNdmTnoIAkzoVUFbi6OypMmmvSzhWk5sG35rAQ1KdrWrv5PKpfFUglHP3FAbaM6T75nzYGsNN4LQvl5NTZVsWHgwprSMO5XX/wgYccjSlEFP1ONKrpC4KH5TOvE3k0nBTaTx8kZWj0CIilcZqm/nLirhGPoIaDJhdXNaP9L+VmiNkg38zhHVpBzrwPZANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po5GMAb5mhQFpVDkLziheN9J1G7hGt/SgZ2jIDr6TrA=;
 b=sURocGKrMDLINTANZxjap+oHyjZsIO0SEQx7yE7s3Sh05rXFBcU1nf/K9gblwh1THaPSD1aZodoJpZLfOfT+VYp5Gd6cKdhtEi1AGsDFA1vTW/lOu2l8gexV8bDRG96GpfIE6ofNk8faBSU5vR+ueof9GFOy9T6d8nN/BkneUcY=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5168.eurprd04.prod.outlook.com (20.177.50.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 03:10:05 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::5c03:e10a:3a8d:d229]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::5c03:e10a:3a8d:d229%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 03:10:05 +0000
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
Thread-Index: AQHVRdjlx4xav9SpcE6dT51LBbLuJ6bwwpYAgAYkuaA=
Date:   Mon, 12 Aug 2019 03:10:05 +0000
Message-ID: <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190729064607.8131-1-yinbo.zhu@nxp.com>
 <875zn8nt31.fsf@gmail.com>
In-Reply-To: <875zn8nt31.fsf@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c05f08d-9a3f-47b2-fe8b-08d71ed292e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5168;
x-ms-traffictypediagnostic: VI1PR04MB5168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5168BE30D9BC54D2BCC13FFAE9D30@VI1PR04MB5168.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(13464003)(76176011)(8676002)(33656002)(6116002)(3846002)(446003)(66066001)(4326008)(186003)(99286004)(476003)(53546011)(14454004)(74316002)(6506007)(316002)(26005)(102836004)(86362001)(305945005)(11346002)(25786009)(7696005)(54906003)(110136005)(7736002)(256004)(44832011)(66556008)(478600001)(2501003)(66476007)(64756008)(66446008)(66946007)(14444005)(229853002)(81156014)(81166006)(2906002)(52536014)(6246003)(5660300002)(71200400001)(486006)(8936002)(53936002)(71190400001)(6436002)(9686003)(55016002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5168;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EsYohC0OoEEfMaHoFsSMBErLsvrohsj+sRVWi3FIZ3prQ33v/yL430Ra0/Ih8OzxYlPljIplJ6EILdJhjpxW9JOC2tWy5OWZDIhoVzB24iFlEGpQcrendZVZvGYmP03lZ+EBjPWHmeB2d8stcbTYWeu2ffcw3kz1PNAQ4kzrtfDrxvV109MQlYYxU6z/xaTOCLQOBSaEdCUPzESEThliLbCjnR2dW5QKQgdfDt0R5/q3lrsnu/VZ3opAE3XINhjUdrmg0XgdcOoqAgZLoW0KLcw9pOMX7dWSWaglVeI2r5IGEohv3X1yEaJhSPFTV3rqG7qP5XCXsu9rP9IKL0oOaY5qk1fFpGsPz/cdi3aRz7l6WyZfp310kxJdwWoPIpibVjvDqc9vxNkRUnOV3YufwBn8k0gMIbu60gR6Pi1sax8=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c05f08d-9a3f-47b2-fe8b-08d71ed292e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 03:10:05.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQ8UMHScbeZGmXBbvL4pv/ji6N+l9xIjGdDEgHt9iNb3bfP2fGOmQqXHWy69YR5DJYww600diYlyQDkA/RFSjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmVsaXBlIEJhbGJpIFtt
YWlsdG86YmFsYmlAa2VybmVsLm9yZ10NCj4gU2VudDogMjAxOcTqONTCOMjVIDEzOjA3DQo+IFRv
OiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IG9w
ZW4gbGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IFlpbmJvIFpo
dSA8eWluYm8uemh1QG54cC5jb20+OyBYaWFvYm8gWGllIDx4aWFvYm8ueGllQG54cC5jb20+OyBK
aWFmZWkNCj4gUGFuIDxqaWFmZWkucGFuQG54cC5jb20+OyBSYW4gV2FuZyA8cmFuLndhbmdfMUBu
eHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYxXSB1c2I6IGR3YzM6IHJlbW92
ZSB0aGUgY2FsbCB0cmFjZSBvZiBVU0J4X0dGTEFESg0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWls
DQo+IA0KPiBIaSwNCj4gDQo+IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+IHdyaXRlczoN
Cj4gDQo+ID4gbGF5ZXJzY2FwZSBib2FyZCBzb21ldGltZXMgcmVwb3J0ZWQgc29tZSB1c2IgY2Fs
bCB0cmFjZSwgdGhhdCBpcyBkdWUNCj4gPiB0byBrZXJuZWwgc2VudCBMUE0gdG9rZXJucyBhdXRv
bWF0aWNhbGx5IHdoZW4gaXQgaGFzIG5vIHBlbmRpbmcNCj4gPiB0cmFuc2ZlcnMgYW5kIHRoaW5r
IHRoYXQgdGhlIGxpbmsgaXMgaWRsZSBlbm91Z2ggdG8gZW50ZXIgTDEsIHdoaWNoDQo+ID4gcHJv
Y2VkdXJlIHdpbGwgYXNrIHVzYiByZWdpc3RlciBoYXMgYSByZWNvdmVyeSx0aGVuIGtlcm5lbCB3
aWxsDQo+ID4gY29tcGFyZSBVU0J4X0dGTEFESiBhbmQgc2V0IEdGTEFESl8zME1IWiwgR0ZMQURK
XzMwTUhaX1JFRyB1bnRpbA0KPiA+IEdGTEFESl8zME1IWiBpcyBlcXVhbCAweDIwLCBpZiB0aGUg
Y29uZGl0aW9ucyB3ZXJlIG1ldCB0aGVuIGlzc3VlDQo+ID4gb2NjdXIsIGJ1dCB3aGF0ZXZlciB0
aGUgY29uZGl0aW9ucyB3aGV0aGVyIHdlcmUgbWV0IHRoYXQgdXNiIGlzIGFsbA0KPiA+IG5lZWQg
a2VlcCBHRkxBREpfMzBNSFogb2YgdmFsdWUgaXMgMHgyMCAoeGhjaSBzcGVjIGFzayB1c2UNCj4g
PiBHRkxBREpfMzBNSFogdG8gYWRqdXN0IGFueSBvZmZzZXQgZnJvbSBjbG9jayBzb3VyY2UgdGhh
dCBnZW5lcmF0ZXMgdGhlDQo+ID4gY2xvY2sgdGhhdCBkcml2ZXMgdGhlIFNPRiBjb3VudGVyLCAw
eDIwIGlzIGRlZmF1bHQgdmFsdWUgb2YgaXQpVGhhdCBpcyBub3JtYWwgbG9naWMsDQo+IHNvIG5l
ZWQgcmVtb3ZlIHRoZSBjYWxsIHRyYWNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWluYm8g
Wmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMgfCAzICstLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBpbmRleA0KPiA+IDk4YmNlODVjMjlkMC4uYTEzM2Q4
NDkwMzIyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiBAQCAtMzAwLDggKzMwMCw3IEBAIHN0YXRp
YyB2b2lkIGR3YzNfZnJhbWVfbGVuZ3RoX2FkanVzdG1lbnQoc3RydWN0DQo+ID4gZHdjMyAqZHdj
KQ0KPiA+DQo+ID4gICAgICAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR0ZMQURK
KTsNCj4gPiAgICAgICBkZnQgPSByZWcgJiBEV0MzX0dGTEFESl8zME1IWl9NQVNLOw0KPiA+IC0g
ICAgIGlmICghZGV2X1dBUk5fT05DRShkd2MtPmRldiwgZGZ0ID09IGR3Yy0+ZmxhZGosDQo+ID4g
LSAgICAgICAgICJyZXF1ZXN0IHZhbHVlIHNhbWUgYXMgZGVmYXVsdCwgaWdub3JpbmdcbiIpKSB7
DQo+ID4gKyAgICAgaWYgKGRmdCAhPSBkd2MtPmZsYWRqKSB7DQo+IA0KPiBpZiB0aGUgdmFsdWUg
aXNuJ3QgZGlmZmVyZW50LCB3aHkgZG8geW91IHdhbnQgdG8gY2hhbmdlIGl0Pw0KPiANCj4gLS0N
Cj4gQmFsYmkNCkhpIEJhbGJpLA0KDQpJIGRvbid0IGNoYW5nZSBhbnkgdmFsdWUuIEkgd2FzIHJl
bW92ZSB0aGF0IGNhbGwgdHJhY2UuDQpJbiBhZGRpdGlvbiB0aGF0IEdGTEFESl8zME1IWiB2YWx1
ZSBpbnRpYWwgdmFsdWUgaXMgMCwgYW5kIGl0J3MgdmFsdWUgbXVzdCBiZSAweDIwLCBpZiBub3Qs
IHVzYiB3aWxsIG5vdCB3b3JrLg0KDQpSZWdhcmRzLA0KWWluYm8NCg0KICANCg==
