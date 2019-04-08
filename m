Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58481C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7DD20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PVe30n9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfDHKSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:18:40 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:4081
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfDHKSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHk4h27hysX67WVtOEnviF2ZLgL30jH9LPYNYTQoLl8=;
 b=PVe30n9/uR8wtSTi83NEnuOLE3fAvb2GvNtB746L42XPd+mPUl4BrIhDtxcinebemzGMxnyr+fQExb6VDXna6QP5O26Jiez3UY2mo94bmP3jwVJ+pgGxL91hizrWBVK2ITzfO6aWpO78xH2SjX2SqzK22mAQa8c3EjvQFzEPCTQ=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5007.eurprd04.prod.outlook.com (20.177.49.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Mon, 8 Apr 2019 10:18:33 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1771.019; Mon, 8 Apr 2019
 10:18:33 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Igor Plyatov <plyatov@gmail.com>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: Issues with i.MX SPI DMA transfers
Thread-Topic: Issues with i.MX SPI DMA transfers
Thread-Index: AQHU5MQedyysM/Gs0UKoyWKgyiIok6YgnCuAgAADPICAACYCkIAAHYGAgAEpjtCABnMWgIAAEhKQgABAWQCAAT6NAIAAkCIAgAds3bA=
Date:   Mon, 8 Apr 2019 10:18:33 +0000
Message-ID: <VI1PR04MB4543694861C3452433C9D956892C0@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
 <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <197990d4-b1e2-8db9-0cb7-87b860f23bd7@gmail.com>
 <VI1PR04MB4543DEA3C0CED159C472E85F89570@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <fbb4850d-f63f-d384-1a85-1f4c5c077af6@gmail.com>
In-Reply-To: <fbb4850d-f63f-d384-1a85-1f4c5c077af6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e33f127e-ac90-423a-f806-08d6bc0b8e0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5007;
x-ms-traffictypediagnostic: VI1PR04MB5007:
x-microsoft-antispam-prvs: <VI1PR04MB50079CA5D0775234E8327B5E892C0@VI1PR04MB5007.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(376002)(39860400002)(189003)(199004)(31014005)(13464003)(25786009)(9686003)(14444005)(5024004)(71200400001)(7736002)(71190400001)(8936002)(2906002)(8676002)(74316002)(81156014)(81166006)(305945005)(55016002)(256004)(7416002)(5660300002)(1411001)(6436002)(33656002)(6246003)(52536014)(3846002)(68736007)(6116002)(229853002)(53936002)(4326008)(106356001)(6916009)(11346002)(105586002)(486006)(6506007)(86362001)(446003)(76176011)(53546011)(476003)(99286004)(14454004)(7696005)(93886005)(66066001)(186003)(66574012)(102836004)(26005)(97736004)(478600001)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5007;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q6Jj8DRdSaFEZYvhOvxEmPmhn28FJO/nx8OC6d0xv/l1Yt+B4knOMNI52g7fkwhh86QR5+fYF0PymA8cZRZY3NF+mTwgxTRLbrNgfJMakeZ4eJ7X2xTiDEw6jOLODBuo3QHOzaYkAoadAXuCwcRFuQzqRtFCIHtnkW2+j/DCxZygTzJa3kbPjy+U7WdvMtx6N5aRMa95hA0N7mSYVQ5ahc4n39MIh3++TsozlZMQ66Nf9K+CA9vx++SgiTkaipwPwmbhVKMBdjgtSTxbFSG7sDx0ejY/2Nzg9x+vDtres22MpM034GUG7UnOus7JUF+qAPNJD9/SiNSm2X9mZSIArFodYOVdIWHnzn26SA6TtwCE9s6bxK8e0+mP2H36o3w8QM5BMK3Oj+kWg1HgFt7dJuIUVLflRr/Iye4rMVPFJKA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33f127e-ac90-423a-f806-08d6bc0b8e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 10:18:33.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJZ29yIFBseWF0b3YgPHBseWF0
b3ZAZ21haWwuY29tPg0KPiBTZW50OiAyMDE55bm0NOaciDPml6UgMjM6NTENCj4gVG86IFJvYmlu
IEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gQ2M6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LXNwaUB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBGYWJpbyBF
c3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJv
bml4LmRlPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgTWFyayBCcm93biA8
YnJvb25pZUBrZXJuZWwub3JnPjsNCj4gZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgVmlub2Qg
S291bCA8dmtvdWxAa2VybmVsLm9yZz47IERhbiBXaWxsaWFtcw0KPiA8ZGFuLmoud2lsbGlhbXNA
aW50ZWwuY29tPjsgQW5keSBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPjsgSGFuIFh1DQo+IDxo
YW4ueHVAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IElzc3VlcyB3aXRoIGkuTVggU1BJIERNQSB0cmFuc2ZlcnMNCj4gDQo+IERlYXIg
Um9iaW4sDQo+IA0KPiANCj4gPiBQbGVhc2UgYXBwbHkgdGhlIGF0dGFjaGVkIHBhdGNoIHdoaWNo
IGlzIGJhc2VkIG9uIGxpbnV4LW5leHQgY29tbWl0DQo+ID4gMDVkMDhlMjk5NWNiZTZlZmRiOTkz
NDgyZWUwZDM4YTc3MDQwODYxYS4NCj4gPiBQbGVhc2Ugbm90aWNlIGl0IGhhcyBhbHJlYWR5IGNv
bnRhaW5lZCB0d28gc2RtYSBwYXRjaGVzIHJldmVydCAtDQo+ICJhZDBkOTJkN2JhNmEiIGFuZCAi
MjVhYWE3NWRmMWU2Ig0KPiANCj4gMSkgWW91cnMgc291cmNlIGNvZGUgaXMgc2FtZSBhcyBtaW5l
IHdpdGggZXhjZXB0aW9uIG9mIFNETUEgZGVzY3JpcHRpb24gZm9yDQo+IGVDU1BJIGluIERldmlj
ZSBUcmVlLg0KPiANCj4gSSBoYXZlIGNoYW5nZWQgRGV2aWNlIFRyZWUgZm9yIGkuTVg2US9ETCBh
cyBpbiBhdHRhY2hlZCBwYXRjaCBhbmQgZmluYWxseSBTUEkNCj4gaW50ZXJmYWNlcyBvcGVyYXRl
IG1vcmUgb3IgbGVzcy4NCj4gDQo+IE15IHBhdGNoIHJldmVydCBiYWNrIHBhdGNoZXMgZGYwNzEw
MWUxYzRhMjllODIwZGYwMmY5OTg5YTA2Njk4OGIxNjBlNg0KPiBhbmQgZGQ0YjQ4N2IzMmEzNTcx
ZmRjYzY2MDYyZTY2MWUzYTNlMzYwZTM1Yi4gSXQgaXMgc3RyYW5nZSwgYmVjYXVzZQ0KPiB0aGV5
IGFyZSBtZXJnZWQgaW50byBtYWlubGluZSB3aGlsZSBhZ28uIE1heWJlIHRoZXkgYXJlIHZhbGlk
IGZvciBzb21lDQo+IHNwZWNpZmljIHZhcmlhbnQgb2YgaS5NWCBTT0M/DQpPa2F5LCBub3cgSSBj
YW4gdW5kZXJzdGFuZCB3aHkgaXQgZGlkbid0IG5vdCB3b3JrIGluIHlvdXIgc2lkZSB3aXRoIHNk
bWENCmZyb20gbGludXgtZmlybXdhcmUsIGJlY2F1c2UgdGhlIHdvcmthcm91bmQgb2YgRVJSMDA5
MTY1IGlzIG9ubHkgZml4ZWQgaW4gDQpBSVBTIHJhbSBzY3JpcHQgd2l0aCBzaW11bGF0aW5nIFBJ
TyBpbiBYQ0ggbW9kZSBpbnN0ZWFkIG9mIFNNQyBtb2RlLCBidXQgbm90IGZpeGVkDQpJbiBTSFAg
c2NyaXB0IHdoaWNoIHVzZWQgYnkgU2FzY2hhJ3Mgcm9tIHBhdGNoIGRkNGI0ODdiMzJhMy4gDQpT
b3JyeSwgSSdtIG5vdCB2ZXJ5IGNsZWFyIGFib3V0IFNhc2NoYSdzIHBhdGNoIHdoaWNoIHNlZW1z
IHRoZSBzYW1lIGFzIEVSUjAwOTE2NS4gQnV0DQphdCBsZWFzdCwgZWNzcGkgY291bGQgd29yayB3
aXRoIGFwcF8yX21jdS9tY3VfMl9hcHAgc2NyaXB0LCBub3QgJ211c3QnIGJlIHVzZWQgd2l0aA0K
c2hwXzJfbWN1L21jdV8yX3NocCwgYmVjYXVzZSBTUEJBIGlzIGFsc28gbG9jYXRlZCBpbiBBSVBT
IGJ1cywgcGxlYXNlIHJlZmVyIHRvIHRoZQ0KYmVsb3cgaW5mb3JtYXRpb24gZnJvbSBSTS4gU28g
SSBhbSBhZnJhaWQgU2FzY2hhJ3MgcGF0Y2ggbWF5IG5vdCBzb2xpZC4NCiJBLjMuMS42IGFwcF8y
X21jdQ0KVGhpcyBnZW5lcmljIHNjcmlwdCBpcyB1c2VkIHRvIHRyYW5zZmVyIGRhdGEgZnJvbSBh
IDgsIDE2LCAyNCBvciAzMi1iaXQgcGVyaXBoZXJhbCBjb25uZWN0ZWQNCnRvIHRoZSBBSVBTIGFj
Y2Vzc2VkIHRocm91Z2ggdGhlIFBlcmlwaGVyYSBETUEgb2YgU0RNQSwgdG8gbWVtb3JpZXMgYWNj
ZXNzZWQgYnkNCnRoZSBCdXJzdERNQSAoRXh0ZXJuYWwgbWVtb3JpZXMpLiINCg0KDQo+IA0KPiAi
TW9yZSBvciBsZXNzIiBtZWFucyBJIGhhdmUgY29tZSB0byBzdGF0ZSBkZXNjcmliZWQgaW4gZmly
c3QgZS1tYWlsIG9mIHRoaXMNCj4gZS1tYWlsIHRocmVhZC4gQnl0ZSBkdXBsaWNhdGlvbiAoRVJS
MDA5MTY1KSBoYXBwZW5zIHZlcnkgb2Z0ZW4gZm9yDQo+IGVDU1BJNSBpbnRlcmZhY2Ugb3BlcmF0
aW5nIHRocm91Z2ggRE1BLg0KSSBjb3VsZCByZXByb2R1Y2UgeW91ciBpc3N1ZSBhcyBiZWxvdyB3
aGF0ZXZlciB3aXRoIG15IHBhdGNoZXMgZm9yIEVSUjAwOTE2NSBvciBub3QsIHNvDQp0aGF0J3Mg
YSBuZXcgaXNzdWUgc2luY2UgaXQncyBvbmx5IGV4aXN0IG9uIGVjc3BpNS4gU29mdHdhcmUgaXMg
dGhlIHNhbWUgb24gYWxsIGVjc3BpDQpwb3J0LCBzbyBpdCdzIHNlZW1zIGEgaGFyZHdhcmUgaXNz
dWUsIEkgd2lsbCBpbnZvbHZlIGRlc2lnbiB0ZWFtIHRvIGxvb2sgaW50byBpdC4gRm9yIG5vdywN
CnN1Z2dlc3QgeW91IHVzaW5nIG90aGVyIGVjc3BpIHBvcnQgaWYgeW91IGNhbi4NCg0KLi9zcGlk
ZXZfdGVzdCAtRCAvZGV2L3NwaWRldjQuMCAtcyAyMDAwMDAwMCAtYiA4IC1TIDY0IC1JIDEwMA0K
c3BpIG1vZGU6IDB4MjANCmJpdHMgcGVyIHdvcmQ6IDgNCm1heCBzcGVlZDogMjAwMDAwMDAgSHog
KDIwMDAwIEtIeikNCg0KDQp0cmFuc2ZlciBlcnJvciAhDQpUWCB8IEUxIDUxIDI0IEU5IEYzIERD
IDNDIDk5IDA3IDU3IDYyIDEwIDcwIDUzIEY1IDg2IERFIDFDIDlEIDhEIENEIDdBIDZBIDQ2IDVB
IDlBIDMwIDNFIDE1IEIwIDUzIEY2ICB8LlEkLi4uPC4uV2IucFMuLi4uLi4uempGWi4wPi4uUy58
DQpUWCB8IDAxIDc3IERGIEY0IDU0IDFCIDhFIDVCIDczIEYwIDZCIEUzIDQzIDYwIDY5IDIxIDdE
IDA2IEFFIDRBIDgwIDE4IDkwIERCIEIzIEMwIDE5IEM4IDcwIDZDIEJFIDcxICB8LncuLlQuLltz
LmsuQ2BpIX0uLkouLi4uLi4uLnBsLnF8DQpSWCB8IEUxIDUxIDI0IEU5IEYzIEYzIERDIDNDIDk5
IDA3IDU3IDYyIDEwIDcwIDUzIEY1IDg2IERFIDFDIDlEIDhEIENEIDdBIDZBIDQ2IDVBIDlBIDMw
IDNFIDE1IEIwIDUzICB8LlEkLi4uLjwuLldiLnBTLi4uLi4uLnpqRlouMD4uLlN8DQpSWCB8IEY2
IDAxIDc3IERGIEY0IDU0IDFCIDhFIDVCIDczIEYwIDZCIEUzIDQzIDYwIDY5IDIxIDdEIDA2IEFF
IDRBIDgwIDE4IDkwIERCIEIzIEMwIDE5IEM4IDcwIDZDIEJFICB8Li53Li5ULi5bcy5rLkNgaSF9
Li5KLi4uLi4uLi5wbC58DQo+IA0KPiAyKSBJIHdhbnQgdG8gaW1wcm92ZSBkZXNjcmlwdGlvbiBh
bmQgcmVwbGFjZSBtYWdpYyBudW1iZXJzIGJ5IGNvbnN0YW50cyBpbg0KPiBEZXZpY2UgVHJlZSBm
b3IgU0RNQS4gSSBtZWFuIHN0cmluZ3MgbGlrZSAiZG1hcyA9IDwmc2RtYSAxMSA3IDE+LCA8JnNk
bWENCj4gMTIgNyAyPjsiPw0KPiANCj4gU28sIGZpbmFsbHkgRGV2aWNlIFRyZWUgd2lsbCBoYXZl
IHN0cmluZ3MgbGlrZQ0KPiANCj4gZG1hcyA9IDwmc2RtYSBTT01FX0RFRl9BIElNWF9ETUFUWVBF
Xy4uIERNQV9QUklPXy4uPiwgPCZzZG1hDQo+IFNPTUVfREVGX0IgSU1YX0RNQVRZUEVfLi4gRE1B
X1BSSU9fLi4+Ow0KPiANCj4gSSB0aGluaywgdGhpcyB3aWxsIHN0b3AgYmxhY2sgbWFnaWMgbWFu
aXB1bGF0aW9ucyBmb3IgU0RNQSBpbiBEZXZpY2UgVHJlZSwgYnkNCj4gdmFyaW91cyBkZXZlbG9w
ZXJzLg0KPiANCj4gRG9lcyBmaXJzdCBkaWdpdCBtZWFucyAiRE1BIHJlcXVlc3QvZXZlbnQgSUQi
PyBXaGVyZSB0byBmaW5kIG1vcmUgaW5mbyBhYm91dA0KPiB0aGlzPw0KWWVzLCB0aGF0J3MgbWVh
biBkbWEgZXZlbnQgSUQsIHlvdSBjb3VsZCBmaW5kIGluICJUYWJsZSAzLTIuIFNETUEgZXZlbnQg
bWFwcGluZyINCmZyb20gUk0uDQo+IA0KPiBEb2VzIHNlY29uZCBkaWdpdCBtZWFucyAiZW51bSBz
ZG1hX3BlcmlwaGVyYWxfdHlwZSI/DQo+IA0KPiBEb2VzIHRoaXJkIGRpZ2l0IG1lYW5zICJlbnVt
IGlteF9kbWFfcHJpbyI/DQpZZXMuDQo+IA0KPiBXaGVyZSBjYW4gSSBmaW5kIGRlc2NyaXB0aW9u
IG9mIGRpZmZlcmVuY2UgYmV0d2VlbiBJTVhfRE1BVFlQRV9DU1BJIChNQ1UNCj4gZG9tYWluIENT
UEkpIGFuZCBJTVhfRE1BVFlQRV9DU1BJX1NQIChTaGFyZWQgQ1NQSSk/IEdvb2dsaW5nIGRvZXMg
bm90DQo+IGhlbHAgdG9vIG11Y2guDQpJTVhfRE1BVFlQRV9DU1BJIHVzZSBBSVBTIHNjcmlwdCwg
SU1YX0RNQVRZUEVfQ1NQSV9TUCB1c2UgU1BCQSBzY3JpcHQgd2hpY2ggDQpTRE1BIGNvdWxkIGFj
Y2VzcyBwZXJpcGhlcmFscyBvbiBTUEJBIGRpcmVjdGx5LCBBSVBTIHNjcmlwdCBjb3VsZCBiZSB1
c2VkIGJ5IGFsbCBwZXJpcGhlcmFscw0Kc2luY2Ugb25seSBmZXcgcGVyaXBoZXJhbHMgb24gU1BC
QSBidXQgU1BCQSBzY3JpcHQgaXMgbW9yZSBlZmZpY2llbmN5IGJlY2F1c2Ugb2Ygc2hvcnQgcGF0
aC4NCg0KPiANCj4gQmVzdCB3aXNoZXMuDQo+IC0tDQo+IElnb3IgUGx5YXRvdg0K
