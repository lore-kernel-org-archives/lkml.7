Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2318ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729F420B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CR1kULCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJIG6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:58:30 -0400
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:49078
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfJIG63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:58:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQJpYpem8g8XIKNBHTw+5k7ZMdrWUBcU+zrN/Bf7ccxqGdW+PanCeiZxc0lZX9gqYhhzEYevOJCPIqSPXg2mPCIfFWfgjmnRWrzZjO7Tr+P885W3LP4x3Arg+qyM76GdVpXHjdDMtCgcjgl1Vy9/q+lT/vvJ1cjhx4jQtSK6VvQ72AiIN46nP+1f+cHjQPP84bV+vxVetsSEBHJw4s1WpLGrJGhnYJInzW5+MV0r3s+fWA6RdsaBQCYsH+8FargrB5JOtllYnjhFu0tlFtp4haz/SQes0qz3syq2CXlqxZtowmz6WuErTHK3LMMiPPWqE2GdY3Uh0KeKWfTWLs1bKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XyknKhTwJnDdinRy8p9HJUi3Lp4jXFIt0IQhfRQTvo=;
 b=isXde4ZsF52wSfIoZzgwVAhsicNQt+Kvd0jkPv8LpsGXc21ydMMe3Y8eiKxBknITGETijTJjd+NnCTi+MJHwFg7VeOEleVq5n8mL+PKhBunfgCNnmT8Q6N3CrH+THpyNwUVM/LxfreXDc1Md6EOgtH+JjObFW7MHcpQvUhGMMxCJS35udBHFrvlPSP5cz4N3HMQ9V2uyQ+KAZ/Btyn4ANOowBDrVLbkRqvv1B+aQ6N5K5nGwGOa8tH1SCemgLdnJr3vC9w49YxEY/I5USjLv3ugVsZ4t0t1Ca7KiW4qtTuNPTtXBLX6WJZKKPRnNQQLD5EoVWvLih+4teOAj8ufO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XyknKhTwJnDdinRy8p9HJUi3Lp4jXFIt0IQhfRQTvo=;
 b=CR1kULCQ03dGM2lAZj5RawqcO+zFgPKQenqNb7saYsZq3G9Vy5TD9E+vQcU6jtqpFFCJzX+/ormgxNdoIEFo6PuMVVPqk46WlVSUK7/2mPWa3WNH9o6H5RYQoApGJ+Pa6qJS6xdCBkVsmyiWT8F66+QonlAS9x17phP7yA0I+gQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3948.eurprd04.prod.outlook.com (52.134.70.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Wed, 9 Oct 2019 06:58:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 06:58:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH] tty: serial: imx: Only get second/third IRQ when there is
 more than one IRQ
Thread-Topic: [PATCH] tty: serial: imx: Only get second/third IRQ when there
 is more than one IRQ
Thread-Index: AQHVfmm1cibywjMA5UifVvn4HL9DWadR35+AgAAA6hA=
Date:   Wed, 9 Oct 2019 06:58:24 +0000
Message-ID: <DB3PR0402MB39165F9CE876772F8F94F187F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
 <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
In-Reply-To: <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35c2c9b8-0abd-4f4a-b042-08d74c86145d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3948:|DB3PR0402MB3948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3948B74C3538E128C17E0E80F5950@DB3PR0402MB3948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(189003)(199004)(55016002)(33656002)(446003)(8936002)(74316002)(66476007)(66946007)(6246003)(6116002)(52536014)(9686003)(11346002)(4326008)(256004)(7416002)(25786009)(305945005)(5660300002)(476003)(99286004)(66556008)(486006)(3846002)(76116006)(64756008)(44832011)(66446008)(26005)(102836004)(6506007)(86362001)(66066001)(81166006)(186003)(76176011)(478600001)(81156014)(2906002)(7736002)(316002)(54906003)(110136005)(8676002)(71190400001)(71200400001)(229853002)(14454004)(7696005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3948;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEX+ujd31QMQNoG8UrgX01OK2mRC0WpJtsI5gxY2S0uxSwwWImE5nNKA5ON393xEwJyVKmhDY/b2KO8VCrH3Z8jGD+kGqdRexACw5P0KEp1oCI/xjccXRLL249vTYiKaarEaqq+3n2VAeQic4/S2jAH/Wj59f3o6AKe5/aDIxe5Q0dE13KeknRqwX9//xrHjsMN4Hw/YSul5g8fPKqYAnqzlBf2bbVmcs3qNttRudKSQdGzSKQMLrs1j2ccjqo5tYL1jdfYte5gchgOlRPmzjMcyri/Fa/egEzUjFI6/OE6x7V3YyarXVKy/+IH3fTsE2gedsDkH/1v5/82yP3sR8h6qUxia9ajTGosxo08cFKsWhP1Oo4HZYfU2U1etFPypQls994bitwXeWKesgiknmgsnCuU+/8omjMNyYI0IFU8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c2c9b8-0abd-4f4a-b042-08d74c86145d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 06:58:24.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmonbYR1dkHCXNz5KZXnVDgo6Wx9KMQdMI4d2GmiutR9SlZLxkVIVqEsook0DLk2jCXQy9lsVOcUssSAh6P7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFV3ZQ0KDQo+IE9uIFdlZCwgT2N0IDA5LCAyMDE5IGF0IDAyOjE4OjMxUE0gKzA4MDAsIEFu
c29uIEh1YW5nIHdyb3RlOg0KPiA+IEFsbCBpLk1YIFNvQ3MgZXhjZXB0IGkuTVgxIGhhdmUgT05M
WSAxIElSUSwgc28gaXQgaXMgYmV0dGVyIHRvIGNoZWNrDQo+ID4gdGhlIElSUSBjb3VudCBiZWZv
cmUgZ2V0dGluZyBzZWNvbmQvdGhpcmQgSVJRIHRvIGF2b2lkIGJlbG93IGVycm9yDQo+ID4gbWVz
c2FnZSBkdXJpbmcgcHJvYmU6DQo+ID4NCj4gPiBbICAgIDAuNzI2MjE5XSBpbXgtdWFydCAzMDg2
MDAwMC5zZXJpYWw6IElSUSBpbmRleCAxIG5vdCBmb3VuZA0KPiA+IFsgICAgMC43MzEzMjldIGlt
eC11YXJ0IDMwODYwMDAwLnNlcmlhbDogSVJRIGluZGV4IDIgbm90IGZvdW5kDQo+IA0KPiBUaGlz
IG1lc3NhZ2Ugd2FzIGludHJvZHVjZWQgaW4gY29tbWl0DQo+IDc3MjNmNGM1ZWNkYjhkODMyZjA0
OWY4NDgzYmViMGQxMDgxY2VkZjYgZm9yIDUuNC1yYzEuIEkgYWRkZWQgdGhlDQo+IGludm9sdmVk
IHBlb3BsZSB0byB0aGUgcmVjaXBlbnRzIG9mIHRoaXMgbWFpbC4NCg0KWWVzLCBJIG5vdGljZWQg
dGhpcywgdGhhbmtzLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMg
fCAxMyArKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBpbmRleA0KPiA+IDUwNGQ4MWMuLjA4
MWZhODIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQo+ID4gKysr
IGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQo+ID4gQEAgLTIxOTgsNiArMjE5OCw3IEBAIHN0
YXRpYyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikN
Cj4gPiAgCXUzMiB1Y3IxOw0KPiA+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gIAlpbnQg
dHhpcnEsIHJ4aXJxLCBydHNpcnE7DQo+ID4gKwlpbnQgaXJxX2NvdW50Ow0KPiA+DQo+ID4gIAlz
cG9ydCA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKnNwb3J0KSwgR0ZQX0tFUk5F
TCk7DQo+ID4gIAlpZiAoIXNwb3J0KQ0KPiA+IEBAIC0yMjIwLDkgKzIyMjEsMTcgQEAgc3RhdGlj
IGludCBpbXhfdWFydF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+
ICAJaWYgKElTX0VSUihiYXNlKSkNCj4gPiAgCQlyZXR1cm4gUFRSX0VSUihiYXNlKTsNCj4gPg0K
PiA+ICsJaXJxX2NvdW50ID0gcGxhdGZvcm1faXJxX2NvdW50KHBkZXYpOw0KPiA+ICsJaWYgKGly
cV9jb3VudCA8IDApDQo+ID4gKwkJcmV0dXJuIGlycV9jb3VudDsNCj4gPiArDQo+ID4gIAlyeGly
cSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+ID4gLQl0eGlycSA9IHBsYXRmb3JtX2dl
dF9pcnEocGRldiwgMSk7DQo+ID4gLQlydHNpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDIp
Ow0KPiA+ICsJaWYgKGlycV9jb3VudCA+IDEpIHsNCj4gPiArCQl0eGlycSA9IHBsYXRmb3JtX2dl
dF9pcnEocGRldiwgMSk7DQo+ID4gKwkJcnRzaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAy
KTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJdHhpcnEgPSBydHNpcnEgPSAtRU5YSU87DQo+ID4g
Kwl9DQo+IA0KPiBUaGUgcGF0Y2ggaXMgZmluZSBnaXZlbiB0aGUgY2hhbmdlZCBiZWhhdmlvdXIg
b2YgcGxhdGZvcm1fZ2V0X2lycS4gSSB3b25kZXINCj4gaWYgaXQgaXMgc2Vuc2libGUgdG8gaW50
cm9kdWNlIGEgdmFyaWFudCBvZiBwbGF0Zm9ybV9nZXRfaXJxIChzYXkNCj4gcGxhdGZvcm1fZ2V0
X2lycV9ub3dhcm4pIHRoYXQgYmVoYXZlcyBsaWtlIF9fcGxhdGZvcm1fZ2V0X2lycSBkb2VzIHQN
Cj4gVGhlbiB0aGUgaW14IGRyaXZlciB3b3VsZCBqdXN0IGNhbGwgcGxhdGZvcm1fZ2V0X2lycV9u
b3dhcm4gd2l0aG91dCBoYXZpbmcNCj4gdG8gY2hlY2sgdGhlIG51bWJlciBvZiBhdmFpbGFibGUg
aXJxcyBmaXJzdC4NCg0KQWdyZWVkLCBpdCB3b3VsZCBiZSBuaWNlIGlmIHdlIGNhbiBmaXggdGhp
cyBmcm9tIHRoZSBBUEkgbGV2ZWwsIHRoaXMgaXMgdG8gc2F2ZSBtYW55IHBhdGNoZXMNCmZyb20g
dmFyaW91cyBkcml2ZXJzIHNpZGUsIGxldCBtZSBrbm93IGlmIGFncmVlbWVudCBpcyByZWFjaGVk
IGFuZCBJIHdpbGwgZG8gdGhlIHBhdGNoLg0KDQpUaGFua3MsDQpBbnNvbi4NCg==
