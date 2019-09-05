Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3700C3A5A9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A695920828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cnhq127W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfIECTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 22:19:30 -0400
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:58883
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730571AbfIECTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:19:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQFqcNjCj+jzKnKCFbL6PBP+riPPQZo01JL8LnVkBP3Bd9wGHz4CNtyc4FZJIRvH21BdY9EBpbHXy3iXqNpfN71xEndlWGL8L4TF4oaDUyOiYftfkmn1xSrMz5RzHytNL/mq4+p7d4fkRDHerQfBHrXFpGdYskNDs9hIEtWZxkdObwYbg/qXoeNe51jRwb8jA7QO4g5fBaR2F1iufPrnqTxqwNdZ+VtpeZAj2pO3US7MqAS8MySB1i6waXIVWTk4r78vx59ag30A+Kb7Qhu+RjHyJsVqv5Mb9QIAxUNUKZUwG9tBm9IaMq5BIKEvFlvDTr7UbHzESfLsPNPao6RyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTgv8BbokCsHUsum+UCAdsLIvAi1+MuAOLNEcrsFCEg=;
 b=QDx1f8GHxKPbvQB+enijIKRmNbxAq35gSlzU5w7k9rkZ6hpshJmqkzvL16Q/3ZF0uvJ6hmQZ35My5CGZewVjwNBFdb9ilwQ6dKmIKwVpIa6m0dljY12+D0Bv/mddBLGfo5wgodDB7jwblvaJzdD33k5JXIr+M+tLQjaXzHdXQYNu9dS43cPoKsulzp4in6JtzIGH5TtSrMwe5Pj39IVpd6klEZouOPT3hWMi0qaxMQ95sUSQy0v32roUUs7ABs85/m/s2JndI1ahVkcsJa+Avm0+JvIWWn+OIz8GIbGgvzaA/vtjJ8M/4K6jS0ovpY8hKRZW8hn1Abogpz4CXKI9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTgv8BbokCsHUsum+UCAdsLIvAi1+MuAOLNEcrsFCEg=;
 b=Cnhq127WloyVK/I7TzFMJ7o/Ja5qBmuNNZd+LYZB5HEeLyss/QK4ijaiMKlKWAjDRV/xQoY190vjB4pSLM1qmtOdflT5pUmDIVm+JG2GMHOTnL7/Pe8HVGzHiIPTHzG0kJVr9GYb1RGb+3wqyl2e71kMJCXrzzCl3ktV0pMiygc=
Received: from DB7PR04MB4153.eurprd04.prod.outlook.com (52.134.111.144) by
 DB7PR04MB3996.eurprd04.prod.outlook.com (52.134.109.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 5 Sep 2019 02:19:24 +0000
Received: from DB7PR04MB4153.eurprd04.prod.outlook.com
 ([fe80::40cc:ea12:967f:ece7]) by DB7PR04MB4153.eurprd04.prod.outlook.com
 ([fe80::40cc:ea12:967f:ece7%3]) with mapi id 15.20.2220.021; Thu, 5 Sep 2019
 02:19:24 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     'Felipe Balbi' <balbi@kernel.org>, Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of
 USBx_GFLADJ
Thread-Topic: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of
 USBx_GFLADJ
Thread-Index: AQHVRdjlx4xav9SpcE6dT51LBbLuJ6bwwpYAgAYkuaCAACotgIAEhrMAgAA5UQCAEqOegIAAm7IAgA2DqFA=
Date:   Thu, 5 Sep 2019 02:19:23 +0000
Message-ID: <DB7PR04MB4153BCFB2380183EB5E5D2DCE9BB0@DB7PR04MB4153.eurprd04.prod.outlook.com>
References: <20190729064607.8131-1-yinbo.zhu@nxp.com>
 <875zn8nt31.fsf@gmail.com>
 <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com>
 <87h86nvtqo.fsf@gmail.com>
 <VI1PR04MB4158B49129BE9E3C00997555E9AC0@VI1PR04MB4158.eurprd04.prod.outlook.com>
 <87v9uzt1dr.fsf@gmail.com>
 <DB8PR04MB682695EEB3E358BDB3E2D5D0F1A00@DB8PR04MB6826.eurprd04.prod.outlook.com>
 <87sgpmx1pn.fsf@gmail.com>
In-Reply-To: <87sgpmx1pn.fsf@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a23356fa-3197-4219-8a44-08d731a7781f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB3996;
x-ms-traffictypediagnostic: DB7PR04MB3996:|DB7PR04MB3996:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB3996CD4AB0F48B254F04E1E0E9BB0@DB7PR04MB3996.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(199004)(189003)(13464003)(3846002)(5660300002)(2501003)(66556008)(66446008)(64756008)(76116006)(316002)(476003)(86362001)(8936002)(66946007)(66476007)(53936002)(25786009)(478600001)(6436002)(55016002)(52536014)(6116002)(99286004)(4326008)(6246003)(81156014)(54906003)(14454004)(76176011)(44832011)(486006)(110136005)(71190400001)(71200400001)(8676002)(53546011)(6506007)(256004)(14444005)(26005)(7736002)(229853002)(2906002)(74316002)(66066001)(102836004)(186003)(11346002)(9686003)(33656002)(446003)(81166006)(7696005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3996;H:DB7PR04MB4153.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dckEVJPhoE+T61hbBMhcsIE4nThNQYzW21GIcOpLxeAtogDXBIzX/r/HL1fWjq1E0ZyjTL4buvMaRKdJUkauoqGROlne0nsztwglP0jXd+2M+i3yjRXgh6SWqREZ7334oADYdpiAiEmDJnzQyOEfvz6AyHv0UyJ3cQ/DW9qSRSZMiFWXTO0m2VR0SrcIaHHwYJQoDk6vEY6bua7xxigOzRtwatJZt90x6VuRHYzR39/vLKFRACsEm4aQygNoq5Trlqkvr4zFHbrv6uoAMKKV5vlQgD6v0EgpMZ+TUwdnsbNvuHgiiEmThveM/KNMyFE+Y4uJ6nkAcBqmYiKX7AwrjuUeFOMcQCHrEbTiwboyfLdau1atzWbnO58baMNYOJRZsIA+G7OwWB31x2fCq/RMC2pY8b9aTACV3aucAfh3/Qo=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23356fa-3197-4219-8a44-08d731a7781f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 02:19:23.9597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQh5BgxwvDPfeZmsMc7OwLY8V4qIo5m9BxbAn4eef0xEEsnAg3+aK5dCAgNNAg4ih1kBCeSGgxi8PnPkwX8drA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3996
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFsYmksDQoNCklmIG5vIG90aGVyIGRvdWJ0cywgcGxlYXNlIGhlbHAgYXBwbHkgaXQuDQoN
ClRoYW5rcywNClJlZ2FyZHMsDQpZaW5ibyBaaHUuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+IA0KU2VudDogMjAxOcTq
ONTCMjfI1SAxOTo1NQ0KVG86IFJhbiBXYW5nIDxyYW4ud2FuZ18xQG54cC5jb20+OyBZaW5ibyBa
aHUgPHlpbmJvLnpodUBueHAuY29tPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz47IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IG9wZW4gbGlzdCA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCkNjOiBYaWFvYm8gWGllIDx4aWFvYm8ueGllQG54
cC5jb20+OyBKaWFmZWkgUGFuIDxqaWFmZWkucGFuQG54cC5jb20+DQpTdWJqZWN0OiBSRTogW0VY
VF0gUmU6IFtQQVRDSCB2MV0gdXNiOiBkd2MzOiByZW1vdmUgdGhlIGNhbGwgdHJhY2Ugb2YgVVNC
eF9HRkxBREoNCg0KDQpIaSwNCg0KUmFuIFdhbmcgPHJhbi53YW5nXzFAbnhwLmNvbT4gd3JpdGVz
Og0KPj4gWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4gd3JpdGVzOg0KPj4gPj4gWWluYm8g
Wmh1IDx5aW5iby56aHVAbnhwLmNvbT4gd3JpdGVzOg0KPj4gPj4gPj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgDQo+PiA+PiA+PiA+IGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMgaW5kZXgNCj4+ID4+ID4+ID4gOThiY2U4NWMyOWQwLi5hMTMzZDg0OTAzMjIgMTAwNjQ0
DQo+PiA+PiA+PiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+PiA+PiA+PiA+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+PiA+PiA+PiA+IEBAIC0zMDAsOCArMzAwLDcg
QEAgc3RhdGljIHZvaWQgDQo+PiA+PiA+PiA+IGR3YzNfZnJhbWVfbGVuZ3RoX2FkanVzdG1lbnQo
c3RydWN0DQo+PiA+PiA+PiA+IGR3YzMgKmR3YykNCj4+ID4+ID4+ID4NCj4+ID4+ID4+ID4gICAg
ICAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR0ZMQURKKTsNCj4+ID4+ID4+ID4g
ICAgICAgZGZ0ID0gcmVnICYgRFdDM19HRkxBREpfMzBNSFpfTUFTSzsNCj4+ID4+ID4+ID4gLSAg
ICAgaWYgKCFkZXZfV0FSTl9PTkNFKGR3Yy0+ZGV2LCBkZnQgPT0gZHdjLT5mbGFkaiwNCj4+ID4+
ID4+ID4gLSAgICAgICAgICJyZXF1ZXN0IHZhbHVlIHNhbWUgYXMgZGVmYXVsdCwgaWdub3Jpbmdc
biIpKSB7DQo+PiA+PiA+PiA+ICsgICAgIGlmIChkZnQgIT0gZHdjLT5mbGFkaikgew0KPj4gPj4g
Pj4NCj4+ID4+ID4+IGlmIHRoZSB2YWx1ZSBpc24ndCBkaWZmZXJlbnQsIHdoeSBkbyB5b3Ugd2Fu
dCB0byBjaGFuZ2UgaXQ/DQo+PiA+PiA+Pg0KPj4gPj4gPj4gLS0NCj4+ID4+ID4+IEJhbGJpDQo+
PiA+PiA+IEhpIEJhbGJpLA0KPj4gPj4gPg0KPj4gPj4gPiBJIGRvbid0IGNoYW5nZSBhbnkgdmFs
dWUuIEkgd2FzIHJlbW92ZSB0aGF0IGNhbGwgdHJhY2UuDQo+PiA+Pg0KPj4gPj4gU3VyZSB5b3Ug
ZG8uIFRoZSBzcGxhdCBvbmx5IHNob3dzIHdoZW4geW91IHJlcXVlc3QgYSBGTEFESiB2YWx1ZSAN
Cj4+ID4+IHRoYXQncyB0aGUgc2FtZSBhcyB0aGUgb25lIGFscmVhZHkgaW4gdGhlIHJlZ2lzdGVy
LiBUaGUgcmVhc29uIHlvdSANCj4+ID4+IHNlZSB0aGUgc3BsYXQgaXMgYmVjYXVzZSB5b3VyIHJl
cXVlc3RlZCB2YWx1ZSBpcyB3aGF0J3MgYWxyZWFkeSBpbiB0aGUgSFcuDQo+PiA+Pg0KPj4gPj4g
U28sIGFnYWluLCB3aHkgYXJlIHlvdSBhZGRpbmcgdGhpcyBkZXZpY2UgdHJlZSBwcm9wZXJ0eSBp
ZiB0aGUgDQo+PiA+PiB2YWx1ZSBpcyBhbHJlYWR5IHRoZSBjb3JyZWN0IG9uZT8NCj4+ID4+DQo+
PiA+PiA+IEluIGFkZGl0aW9uIHRoYXQgR0ZMQURKXzMwTUhaIHZhbHVlIGludGlhbCB2YWx1ZSBp
cyAwLCBhbmQgaXQncyANCj4+ID4+ID4gdmFsdWUgbXVzdCBiZSAweDIwLCBpZiBub3QsIHVzYiB3
aWxsIG5vdCB3b3JrLg0KPj4gPj4NCj4+ID4+IGl0J3Mgbm90IHplcm8sIG90aGVyd2lzZSB0aGUg
c3BsYXQgd291bGRuJ3QgdHJpZ2dlci4gWW91J3JlIA0KPj4gPj4gcmVxdWVzdGluZyB0aGUgdmFs
dWUgdGhhdCdzIGFscmVhZHkgaW4geW91ciByZWdpc3RlciBieSBkZWZhdWx0Lg0KPj4gPj4NCj4+
ID4+IC0tDQo+PiA+PiBCYWxiaQ0KPj4gPg0KPj4gPiBIaSBCYWxiaSwNCj4+ID4NCj4+ID4gQWNj
b3JkaW5nIHRoYXQgcm0gZG9jIHRoYXQgR0ZMQURKXzMwTUhaIGhhcyBhIGRlZmF1bHQgdmFsdWUg
aXMgDQo+PiA+IDB4MjAsIHdoZW4gR0ZMQURKXzMwTUhaX1JFR19TRUwgaXMgMCwgdGhpcyAweDIw
IGlzIGEgaGFyZC1jb2RlZCB2YWx1ZS4NCj4+ID4NCj4+ID4gQnV0IGluIGZhY3QsIHRoYXQgZGVm
YXVsdCB2YWx1ZSBpcyAwLCBwbGVhc2UgeW91IG5vdGUhDQo+PiA+DQo+PiA+IFRoZW4gYWNjb3Jk
aW5nIHRoYXQgeGhjaSBzcGVjIDUuMi40LCB0aGF0IHJlZ2lzdGVyIHRoZSBzaXh0aCBiaXQgaWYg
DQo+PiA+IGlzIDAsIHRoZW4gdGhhdCBjYW4gc3VwcG9ydCBGcmFtZSBMZW50aCBUaW1pbmcgdmFs
dWUuDQo+PiA+DQo+PiA+IFNvIHNldCBHRkxBREpfMzBNSFpfUkVHX1NFTCB0byAxIGZvciB1c2Ug
RkxBREosIHRoZW4gSSBmaW5kIHRoYXQgaXQgDQo+PiA+IG11c3QgdXNlIDB4MjAgdXNiIHdpbGwg
d29yayB3ZWxsLCBldmVuIHRob3VnIHhoY2kgY2FuIHBlcm1pdCANCj4+ID4gR0ZMQURKXzMwTUha
IHVzZSBvdGhlciB2YWx1ZQ0KPj4gDQo+PiBZb3Ugb25seSBnZXQgdGhlIHNwbGF0IGJlY2F1c2Ug
eW91IHRyeSB0byBzZW50IEdGTEFESiB0byAweDIwIGFuZCANCj4+IGl0J3MgQUxSRUFEWSAweDIw
LiBUaGlzIG1lYW5zIHRoYXQgeW91IGRvbid0IG5lZWQgdGhlIHByb3BlcnR5IGluIERUUy4NCj4+
IA0KPj4gPiBJbiBhZGRpdGlvbiBhYm91dCB3aGF0IHlvdSBzYWlkIGlzIGFib3V0IGR0cyBwYXRj
aCwgYW5kIHRoYXQgcGF0Y2ggDQo+PiA+IGhhZCBtZXJnZWQgYnkgdXBzdHJlYW0sIHBhdGNoIG93
bmVyIGlzbid0IG1lLA0KPj4gDQo+PiBXZWxsLCB0aGVuIHJlbW92ZSB0aGUgc2V0dGluZyBmcm9t
IERUUywgc2luY2UgY2xlYXJseSBpdCdzIG5vdCBuZWVkZWQuDQo+DQo+IFBsZWFzZSBjb25zaWRl
cmluZyBiZWxvdyBzY2VuYXJpb3Mgb24gdGhlIHNhbWUgYm9hcmQgd2hpY2ggbmVlZHMgR0ZMQURK
IHByb3BlcnR5IG9uIGtlcm5lbCBEVFM6DQo+DQo+IDEuIEJvYXJkIGJvb3QgdG8gVS1Cb290IGZp
cnN0LCB0aGVuIGxvYWQga2VybmVsLiBJbiB0aGlzIGNhc2UsIHdlIG5lZWQga2VybmVsIERUUw0K
PiAgICAgaGVscCB0byBnZXQgR0ZMQURKIHNldHRpbmcgcmlnaHQsIGV2ZXJ5dGhpbmcgaXMgYXMg
ZXhwZWN0ZWQuDQo+DQo+IDIuIEJvYXJkIGJvb3QgdG8gVS1Cb290IGNvbnNvbGUsIHRoZW4gZXhl
Y3V0ZSAndXNiIHN0YXJ0JyB1bmRlciBVLUJvb3QgY29uc29sZSB0byBpbml0DQo+ICAgICBEV0Mz
IGNvbnRyb2xsZXIsIHRoZW4gbG9hZCBrZXJuZWwuIEluIHRoaXMgY2FzZSwgYWN0dWFsbHkgR0ZM
QURKIGlzIGNvcnJlY3RseQ0KPiAgICAgY29uZmlndXJlZCBhbHJlYWR5LCBhbmQgdGhlIEdGTEFE
SiBjb25maWcgZG91YmxlLWNoZWNraW5nIGlzIGZpbmUgKGJlY2F1c2Uga2VybmVsDQo+ICAgICBj
YW5ub3Qga25vdyBpZiBVLUJvb3QgaGFzIGluaXRpYWxpemVkIGl0IG9yIG5vdCksIGJ1dCB3YXJu
aW5nIGxvb2tzIG5vdCBuZWNlc3NhcnkuDQo+DQo+IDMuIEJvYXJkIGJvb3QgdG8ga2VybmVsLCBH
RkxBREogZ2V0IHNldCBmcm9tIERUUywgdGhlbiBzeXN0ZW0gc3VzcGVuZCAmIHJlc3VtZS4gSW4g
dGhpcyBjYXNlDQo+ICAgICB3aGVuIHJlc3VtaW5nLCBHRkxBREogc2V0dGluZyBoYXMgYmVlbiBy
ZXN0b3JlZCBjb3JyZWN0bHksIHNvIGhlcmUgd2UgbWlnaHQgbm90IG5lZWQNCj4gICAgIHNlbmQg
b3V0IHRoZSB3YXJuaW5nIG1lc3NhZ2UgKGRvdWJsZS1jaGVja2luZyBtaWdodCBiZSBmaW5lKS4N
Cj4NCj4gU28sIHdoYXQncyB5b3VyIHN1Z2dlc3Rpb24gdG8gcmVtb3ZlIHRoaXMgbG9va3Mgbm9u
LW5lY2Vzc2FyeSB3YXJuaW5nIG1lc3NhZ2U/DQoNCm5vdyB0aGlzIGlzIHdlbGwgZXhwbGFpbmVk
ISBTbyB0aGUgdmFsdWUgaW4gdGhlIHJlZ2lzdGVyIGlzICpOT1QqIDB4MjAgYnkgZGVmYXVsdCwg
aG93ZXZlciwgdS1ib290IF9jYW5fIHVzZSBkd2MzIGlmIHdlJ3JlIGZsYXNoaW5nLCB0aGVuIGl0
J2xsIHJlc3VsdCBpbiB0aGUgc3BsYXQuDQoNCk9rYXksIHRoaXMgaXMgYSB2YWxpZCBzY2VuYXJp
byB0aGF0IHRoZSBrZXJuZWwgc2hvdWxkIGNvbnNpZGVyLiBJIGFncmVlIHRoYXQgd2Ugc2hvdWxk
IHJlbW92ZSB0aGUgV0FSTigpIGZyb20gdGhlcmUuDQoNClRoYW5rcw0KDQotLQ0KYmFsYmkNCg==
