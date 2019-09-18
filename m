Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D61C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E082054F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vdgsq5PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfIRNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:51:52 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:61086
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbfIRNvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB+qx4O6/fNxv6KDyObUnKLWyB+XB+j+dmTs/O4kF+U5SzYlLm/nazdffTq56mM7+6lhPVZADmNs45LYtWArXSw9VMMGE4QG3k+VpLkuoKYEkvCKgpJBuGvawCAdWgH6ZwksT/cFegrpUqYNmC/DungH7JPEOAPzKNZgLmucCgosMl3H/YS/s3LHweiUi4qGwuqJwyF9w/UE7zHxVqQ4kVr3AWFrnIF1EJP+nI4djLI3LCAc0O5LzVT9lJPE5cc9RKot82aaa7/A+zuUiLPNhKzUuYYYMJNL1//NdPNHU5bLHc4mq1k5998B6d92jHc2AWv09Km42w+y+wNXBf9IMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYJcJVDwhiUgGE4StWC4WUa+QVIzGdI6djdgc8jGVUg=;
 b=PcJoadqdwGXu2wHJ/LF9Vs4LAuHFV86YX4EmoXn1pbFuE48o4LJn50UQzDD/j+E/2lM1xslKKaB9ic9p1hP7PjMdbfCLlquDf4LQCrkwnEPUdLmSfWqyHc3bOLh8jjLUP8MCeIv2Qw3SWobRy/5JZTmEPY9MzA0K05M2M4Pus1h41ltLa/vg88htAdLbRnwK1jBHCbkwAUJofApqzLqaT8fnfubfm7jfNs7F/LyYf8iJVMNhI1RPRJUMWWnOLyOZAYiJz96iFOkpbr1gW+tY+iTVQE2sfgWoTQeg/HIzi1oGpC5+uEQ5BHRfHjq3sQqp8T8nAx7ObY2QYjESqgd3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYJcJVDwhiUgGE4StWC4WUa+QVIzGdI6djdgc8jGVUg=;
 b=Vdgsq5PIbo/Z/ijiNMe05rzE1BDE8drq95Ga+wQSSHoEPP8BPvlGyZ7V4guuRHU7bVbNxH57L8b/Ca8TBnKEJDRrEMMx23gbJXt+LgdJ61bN9MAdnPTWcHUEAy+T3GiZQ5CQlvJy88mCbV1aXqX6E9Gxgo5idN//J4btsSzZPI4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4354.eurprd04.prod.outlook.com (52.134.90.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 13:51:47 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 13:51:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Andre Przywara <andre.przywara@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVbHNaBQCH9BWPL0mqFSSgcphDeqcwIoOAgADH+gCAADitQIAAT5WAgAAEqNA=
Date:   Wed, 18 Sep 2019 13:51:47 +0000
Message-ID: <AM0PR04MB4481DB4590FF3DB941C88BBC888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
 <1568626884-5189-2-git-send-email-peng.fan@nxp.com>
 <20190917183115.3e40180f@donnerap.cambridge.arm.com>
 <CABb+yY2CP1i9fZMoPua=-mLCUpYrcO28xF5UXDeRD2XTYe7mEg@mail.gmail.com>
 <AM0PR04MB44811AE46803D10FD8A5B8B0888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY09pPqM-47zNFVGMNM9wrDF9iiVuqKTXrEd4-PdOxBPrQ@mail.gmail.com>
In-Reply-To: <CABb+yY09pPqM-47zNFVGMNM9wrDF9iiVuqKTXrEd4-PdOxBPrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e30e789b-3cff-40a9-29d9-08d73c3f5924
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4354;
x-ms-traffictypediagnostic: AM0PR04MB4354:|AM0PR04MB4354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB435450381D15F46EEBBA7A51888E0@AM0PR04MB4354.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(199004)(189003)(14454004)(9686003)(55016002)(478600001)(14444005)(4326008)(229853002)(256004)(25786009)(7736002)(6436002)(6916009)(74316002)(1411001)(71190400001)(71200400001)(6246003)(305945005)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(33656002)(476003)(11346002)(81156014)(81166006)(8676002)(8936002)(446003)(102836004)(6506007)(186003)(15650500001)(53546011)(66066001)(76176011)(7696005)(99286004)(6116002)(54906003)(316002)(4744005)(44832011)(486006)(52536014)(3846002)(2906002)(26005)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4354;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bFmedldT0DWIAkWJWAuuOSWrmbMYkN/jpd/6WEHWqYDcv1xP0H4B0A6R6MFU/QHi9tW0hEOZ5CeYY/GdJDRVwp3zMV908NHaBk54AiwOzhMbzxvjmGoyf1/GxFFlyIG7uwHODV2s6mN7O5aqhtZGEZn+aeeW1PIy4fubgvNuajpMf3Fd+SE47qCA/fdjd48qnvX+6Iu3Xt/E+4aqGUy2euMU6xjLYFeD1nZmKlFhR39FTJW+k7CyOQ2Vq8EvtOlL39Cqf4yjtwdIRUBd5stL0KRvi+8rBVqLeUEMI1YWLt4b4koUIJ2gUAwBjRe/kP1VI9L6qhgX06H46as9sV8gp44dHRJVuoM8wXbxI5reGk0Ktt9pzCe9lBdn+aE1eR51lgn9F//Aotk+5FI9adKoYq5Jbi5lZBJYCNMzruO1t4w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30e789b-3cff-40a9-29d9-08d73c3f5924
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 13:51:47.1063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MF4nMwPBAaSmtGJs8kFkolqo+L3PMKK5j+LTUWIQXXNmQpIsHU/RiT1RtDuJ/Xxq1i7w66CCEDVt71eZQfuPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY2IDEvMl0gZHQtYmluZGluZ3M6IG1haWxib3g6IGFkZCBi
aW5kaW5nIGRvYyBmb3IgdGhlDQo+IEFSTSBTTUMvSFZDIG1haWxib3gNCj4gDQo+IE9uIFdlZCwg
U2VwIDE4LCAyMDE5IGF0IDM6NTMgQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3Rl
Og0KPiANCj4gPiA+ID4NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgIiNtYm94LWNlbGxzIjoN
Cj4gPiA+ID4gPiArICAgIGNvbnN0OiAxDQo+ID4gPiA+DQo+ID4gPiA+IFdoeSBpcyB0aGlzICIx
Ij8gV2hhdCBpcyB0aGlzIG51bWJlciB1c2VkIGZvcj8gSXQgdXNlZCB0byBiZSB0aGUNCj4gPiA+
ID4gY2hhbm5lbCBJRCwNCj4gPiA+IGJ1dCBzaW5jZSB5b3UgYXJlIGRlc2NyaWJpbmcgYSBzaW5n
bGUgY2hhbm5lbCBjb250cm9sbGVyIG9ubHksIHRoaXMNCj4gPiA+IHNob3VsZCBiZSAwIG5vdy4N
Cj4gPiA+ID4NCj4gPiA+IFllcy4gSSBvdmVybG9va2VkIGl0IGFuZCBhY3R1YWxseSBxdWV1ZWQg
dGhlIHBhdGNoIGZvciBwdWxsIHJlcXVlc3QuDQo+ID4NCj4gPiBJbiBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tYWlsYm94LnR4dA0KPiA+ICNtYm94LWNlbGxzOiBN
dXN0IGJlIGF0IGxlYXN0IDEuDQo+ID4NCj4gPiBTbyBJIHVzZSAxIGhlcmUsIDAgbm90IHdvcmsu
IEJlY2F1c2Ugb2ZfbWJveF9pbmRleF94bGF0ZSBleHBlY3QgYXQgbGVhc3QgMQ0KPiBoZXJlLg0K
PiA+IFNvIEkgbmVlZCBtb2RpZnkgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21h
aWxib3gvbWFpbGJveC50eHQNCj4gPiBhbmQgYWRkIHhsYXRlIGZvciBzbWMgbWFpbGJveD8NCj4g
Pg0KPiBObywgeW91IGp1c3QgY2FuIG5vdCB1c2UgdGhlIGdlbmVyaWMgeGxhdGUoKSBwcm92aWRl
ZCBieSB0aGUgYXBpLg0KPiBQbGVhc2UgaW1wbGVtZW50IHlvdXIgb3duIHhsYXRlKCkgdGhhdCBy
ZXF1aXJlcyBubyBhcmd1bWVudC4NCg0Kb2suIFdpbGwgYWRkIHhsYXRlLg0KDQpUaGFua3MsDQpQ
ZW5nLg0KDQo+IA0KPiBDaGVlcnMhDQo=
