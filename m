Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F545C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59727204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="To/jfKTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfE0FTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 01:19:49 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:4324
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfE0FTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 01:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56hDANp4suTB41J9pYnAJLDjA63ugdNhAfKjIV3Caho=;
 b=To/jfKTVsMsOoFb+4qf559yW546vS1Mmr3FgwdZb0BFtsHUkNCx48tGphWTsbvKSYyZ9YlQ30Bn2+TbtmJ4XTUhCEw1oXyLH9wGPSdP+XwEAUyPjmuZTzYS6Jhny2AmnnccjJWYs3H14aImnq7NkJdA48znR6qVP3lcl55P6xew=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Mon, 27 May 2019 05:19:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 05:19:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVESt7O8zUR8j7k0mzGFqyu7YBg6Z4+DAAgAVHW8A=
Date:   Mon, 27 May 2019 05:19:41 +0000
Message-ID: <AM0PR04MB4481C44F9B5EFCDD076EF728881D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190523060437.11059-1-peng.fan@nxp.com>
 <4ba2b243-5622-bb27-6fc3-cd9457430e54@gmail.com>
In-Reply-To: <4ba2b243-5622-bb27-6fc3-cd9457430e54@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1960822f-bb25-4312-5060-08d6e262ec34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4353;
x-ms-traffictypediagnostic: AM0PR04MB4353:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB4353A34B2D5504584CF10500881D0@AM0PR04MB4353.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(199004)(189003)(478600001)(966005)(74316002)(26005)(186003)(2906002)(110136005)(71190400001)(71200400001)(52536014)(73956011)(66556008)(64756008)(66446008)(76116006)(66946007)(66476007)(14454004)(102836004)(7416002)(53546011)(6506007)(229853002)(53936002)(6246003)(68736007)(6436002)(4326008)(15650500001)(5660300002)(76176011)(256004)(45080400002)(305945005)(7696005)(54906003)(6306002)(81166006)(81156014)(8676002)(8936002)(9686003)(55016002)(316002)(99286004)(446003)(3846002)(33656002)(86362001)(6116002)(11346002)(44832011)(486006)(2501003)(2201001)(14444005)(25786009)(476003)(66066001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4353;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vFaXc91ZFUFkeObqTRLlF73sNraOlJfE58AAtSTKNiltzHdgOxw2SDnAFq+MCwaFc58HrQaKk54GiCRkoHowJkocBULrRP4JzoUmVt2VpZ1SygHVRz4Blg0aFHBil0RUX/wVDJY2J5fd8XsReelYMpfE06Nleg97zr3TalI7y4R6hiTfuGu1rXfdMG3GXBmsMqf8ztCHaClBudkVGNm+V2BLuZiIe9VSRuKgunU+Y8BWTv3JhZF/+Al5+XSn4jDj4jUzhJxh5czj4DiK5yi2jZ4qQPzLt+HBZenhIjVnu5ieXh79Yd0hnxfykRY6h3rJpFbG4bteF5RLwMU9ci3OVPPffZMfWU98K+Z7jjZvUf4OQOqIsYb8xYoUaKjzJ4g5VcHSpRuNFMoGEPy7SiXkA84DlpWDWlklfzSOgXe6H5o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1960822f-bb25-4312-5060-08d6e262ec34
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 05:19:41.5808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmxvcmlhbiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gbWFpbGJveDogYXJtOiBp
bnRyb2R1Y2Ugc21jIHRyaWdnZXJlZCBtYWlsYm94DQo+IA0KPiBIaSwNCj4gDQo+IE9uIDUvMjIv
MTkgMTA6NTAgUE0sIFBlbmcgRmFuIHdyb3RlOg0KPiA+IFRoaXMgaXMgYSBtb2RpZmllZCB2ZXJz
aW9uIGZyb20gQW5kcmUgUHJ6eXdhcmEncyBwYXRjaCBzZXJpZXMNCj4gPg0KPiBodHRwczovL2V1
cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZs
b3JlLmtlDQo+IHJuZWwub3JnJTJGcGF0Y2h3b3JrJTJGY292ZXIlMkY4MTI5OTclMkYmYW1wO2Rh
dGE9MDIlN0MwMSU3Q3BlDQo+IG5nLmZhbiU0MG54cC5jb20lN0MwMTBjOWRkZDVkZjY0NWM5YzY2
YjA4ZDZkZmE0NmNiMiU3QzY4NmVhMWQzYg0KPiBjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAl
N0MwJTdDNjM2OTQyMjk0NjMxNDQyNjY1JmFtcDtzZGF0DQo+IGE9QmJTNVpRdHpNQU5Td2FLUkRK
NjJOS3JQckF5YUVEMSUyQnZ5bVFhVDZRcjhFJTNEJmFtcDtyZXNlDQo+IHJ2ZWQ9MC4NCj4gPiBb
MV0gaXMgYSBkcmFmdCBpbXBsZW1lbnRhdGlvbiBvZiBpLk1YOE1NIFNDTUkgQVRGIGltcGxlbWVu
dGF0aW9uIHRoYXQNCj4gPiB1c2Ugc21jIGFzIG1haWxib3gsIHBvd2VyL2NsayBpcyBpbmNsdWRl
ZCwgYnV0IG9ubHkgcGFydCBvZiBjbGsgaGFzDQo+ID4gYmVlbiBpbXBsZW1lbnRlZCB0byB3b3Jr
IHdpdGggaGFyZHdhcmUsIHBvd2VyIGRvbWFpbiBvbmx5IHN1cHBvcnRzIGdldA0KPiA+IG5hbWUg
Zm9yIG5vdy4NCj4gPg0KPiA+IFRoZSB0cmFkaXRpb25hbCBMaW51eCBtYWlsYm94IG1lY2hhbmlz
bSB1c2VzIHNvbWUga2luZCBvZiBkZWRpY2F0ZWQNCj4gPiBoYXJkd2FyZSBJUCB0byBzaWduYWwg
YSBjb25kaXRpb24gdG8gc29tZSBvdGhlciBwcm9jZXNzaW5nIHVuaXQsDQo+ID4gdHlwaWNhbGx5
IGEgZGVkaWNhdGVkIG1hbmFnZW1lbnQgcHJvY2Vzc29yLg0KPiA+IFRoaXMgbWFpbGJveCBmZWF0
dXJlIGlzIHVzZWQgZm9yIGluc3RhbmNlIGJ5IHRoZSBTQ01JIHByb3RvY29sIHRvDQo+ID4gc2ln
bmFsIGEgcmVxdWVzdCBmb3Igc29tZSBhY3Rpb24gdG8gYmUgdGFrZW4gYnkgdGhlIG1hbmFnZW1l
bnQgcHJvY2Vzc29yLg0KPiA+IEhvd2V2ZXIgc29tZSBTb0NzIGRvZXMgbm90IGhhdmUgYSBkZWRp
Y2F0ZWQgbWFuYWdlbWVudCBjb3JlIHRvDQo+IHByb3ZpZGUNCj4gPiB0aG9zZSBzZXJ2aWNlcy4g
SW4gb3JkZXIgdG8gc2VydmljZSBURUUgYW5kIHRvIGF2b2lkIGxpbnV4IHNodXRkb3duDQo+ID4g
cG93ZXIgYW5kIGNsb2NrIHRoYXQgdXNlZCBieSBURUUsIG5lZWQgbGV0IGZpcm13YXJlIHRvIGhh
bmRsZSBwb3dlcg0KPiA+IGFuZCBjbG9jaywgdGhlIGZpcm13YXJlIGhlcmUgaXMgQVJNIFRydXN0
ZWQgRmlybXdhcmUgdGhhdCBjb3VsZCBhbHNvDQo+ID4gcnVuIFNDTUkgc2VydmljZS4NCj4gPg0K
PiA+IFRoZSBleGlzdGluZyBTQ01JIGltcGxlbWVudGF0aW9uIHVzZXMgYSByYXRoZXIgZmxleGli
bGUgc2hhcmVkIG1lbW9yeQ0KPiA+IHJlZ2lvbiB0byBjb21tdW5pY2F0ZSBjb21tYW5kcyBhbmQg
dGhlaXIgcGFyYW1ldGVycywgaXQgc3RpbGwgcmVxdWlyZXMNCj4gPiBhIG1haWxib3ggdG8gYWN0
dWFsbHkgdHJpZ2dlciB0aGUgYWN0aW9uLg0KPiANCj4gV2UgaGF2ZSBoYWQgc29tZXRoaW5nIHNp
bWlsYXIgZG9uZSBpbnRlcm5hbGx5IHdpdGggYSBjb3VwbGUgb2YgbWlub3INCj4gZGlmZmVyZW5j
ZXM6DQo+IA0KPiAtIGEgU0dJIGlzIHVzZWQgdG8gc2VuZCBTQ01JIG5vdGlmaWNhdGlvbnMvZGVs
YXllZCByZXBsaWVzIHRvIHN1cHBvcnQNCj4gYXN5bmNocm9uaXNtIChwYXRjaGVzIGFyZSBpbiB0
aGUgd29ya3MgdG8gYWN0dWFsbHkgYWRkIHRoYXQgdG8gdGhlIExpbnV4IFNDTUkNCj4gZnJhbWV3
b3JrKS4gVGhlcmUgaXMgbm8gZ29vZCBzdXBwb3J0IGZvciBTR0kgaW4gdGhlIGtlcm5lbCByaWdo
dCBub3cgc28gd2UNCj4gaGFja2VkIHVwIHNvbWV0aGluZyBmcm9tIHRoZSBleGlzdGluZyBTTVAg
Y29kZSBhbmQgYWRkaW5nIHRoZSBhYmlsaXR5IHRvDQo+IHJlZ2lzdGVyIG91ciBvd24gSVBJIGhh
bmRsZXJzIChTSEFNRSEpLiBVc2luZyBhIFBQSSBzaG91bGQgd29yayBhbmQgc2hvdWxkDQo+IGFs
bG93IGZvciB1c2luZyByZXF1ZXN0X2lycSgpIEFGQUlDVC4NCg0KU28geW91IGFyZSBhbHNvIGlt
cGxlbWVudGluZyBhIGZpcm13YXJlIGluc2lkZSBBVEYgZm9yIFNDTUkgdXNlY2FzZSwgcmlnaHQ/
DQoNCkludHJvZHVjaW5nIFNHSSBpbiBBVEYgdG8gbm90aWZ5IExpbnV4IHdpbGwgaW50cm9kdWNl
IGNvbXBsZXhpdHksIHRoZXJlIGlzDQpubyBnb29kIGZyYW1ld29yayBpbnNpZGUgQVRGIGZvciBT
Q01JLCBhbmQgSSB1c2Ugc3luY2hyb25pemF0aW9uIGNhbGwgZm9yDQpzaW1wbGljaXR5IGZvciBu
b3cuDQoNCj4gDQo+IC0gdGhlIG1haWxib3ggaWRlbnRpZmllciBpcyBpbmRpY2F0ZWQgYXMgcGFy
dCBvZiB0aGUgU01DIGNhbGwgc3VjaCB0aGF0IHdlIGNhbg0KPiBoYXZlIG11bHRpcGxlIFNDTUkg
bWFpbGJveGVzIHNlcnZpbmcgYm90aCBzdGFuZGFyZCBwcm90b2NvbHMgYW5kDQo+IG5vbi1zdGFu
ZGFyZCAoaW4gdGhlIDB4ODAgYW5kIGFib3ZlKSByYW5nZSwgYWxzbyB0aGV5IG1heSBoYXZlIGRp
ZmZlcmVudA0KPiB0aHJvdWdocHV0IChpbiBoaW5kc2lnaHQsIHRoZXNlIGNvdWxkIHNpbXBseSBi
ZSBkaWZmZXJlbnQgY2hhbm5lbHMpDQo+IA0KPiBZb3VyIHBhdGNoIHNlcmllcyBsb29rcyBib3Ro
IGdvb2QgYW5kIHVzZWZ1bCB0byBtZSwgSSB3b3VsZCBqdXN0IHB1dCBhDQo+IHByb3Zpc2lvbiBp
biB0aGUgYmluZGluZyB0byBzdXBwb3J0IGFuIG9wdGlvbmFsIGludGVycnVwdCBzdWNoIHRoYXQN
Cj4gYXN5bmNocm9uaXNtIGdldHMgcmVhc29uYWJseSBlYXN5IHRvIHBsdWcgaW4gd2hlbiBpdCBp
cyBhdmFpbGFibGUgKGFuZA0KPiBkZXNpcmFibGUpLg0KDQpPay4gTGV0IG1lIHRoaW5rIGFib3V0
IGFuZCBhZGQgdGhhdCBpbiBuZXcgdmVyc2lvbiBwYXRjaC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0K
PiANCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGEgTGludXggbWFpbGJveCBj
b21wYXRpYmxlIHNlcnZpY2Ugd2hpY2gNCj4gPiB1c2VzIHNtYyBjYWxscyB0byBpbnZva2UgZmly
bXdhcmUgY29kZSwgZm9yIGluc3RhbmNlIHRha2luZyBjYXJlIG9mIFNDTUkNCj4gcmVxdWVzdHMu
DQo+ID4gVGhlIGFjdHVhbCByZXF1ZXN0cyBhcmUgc3RpbGwgY29tbXVuaWNhdGVkIHVzaW5nIHRo
ZSBzdGFuZGFyZCBTQ01JIHdheQ0KPiA+IG9mIHNoYXJlZCBtZW1vcnkgcmVnaW9ucywgYnV0IGEg
ZGVkaWNhdGVkIG1haWxib3ggaGFyZHdhcmUgSVAgY2FuIGJlDQo+ID4gcmVwbGFjZWQgdmlhIHRo
aXMgbmV3IGRyaXZlci4NCj4gPg0KPiA+IFRoaXMgc2ltcGxlIGRyaXZlciB1c2VzIHRoZSBhcmNo
aXRlY3RlZCBTTUMgY2FsbGluZyBjb252ZW50aW9uIHRvDQo+ID4gdHJpZ2dlciBmaXJtd2FyZSBz
ZXJ2aWNlcywgYWxzbyBhbGxvd3MgZm9yIHVzaW5nICJIVkMiIGNhbGxzIHRvIGNhbGwNCj4gPiBp
bnRvIGh5cGVydmlzb3JzIG9yIGZpcm13YXJlIGxheWVycyBydW5uaW5nIGluIHRoZSBFTDIgZXhj
ZXB0aW9uIGxldmVsLg0KPiA+DQo+ID4gUGF0Y2ggMSBjb250YWlucyB0aGUgZGV2aWNlIHRyZWUg
YmluZGluZyBkb2N1bWVudGF0aW9uLCBwYXRjaCAyDQo+ID4gaW50cm9kdWNlcyB0aGUgYWN0dWFs
IG1haWxib3ggZHJpdmVyLg0KPiA+DQo+ID4gUGxlYXNlIG5vdGUgdGhhdCB0aGlzIGRyaXZlciBq
dXN0IHByb3ZpZGVzIGEgZ2VuZXJpYyBtYWlsYm94DQo+ID4gbWVjaGFuaXNtLCB0aG91Z2ggdGhp
cyBpcyBzeW5jaHJvbm91cyBhbmQgb25lLXdheSBvbmx5ICh0cmlnZ2VyZWQgYnkNCj4gPiB0aGUg
T1Mgb25seSwgd2l0aG91dCBwcm92aWRpbmcgYW4gYXN5bmNocm9ub3VzIHdheSBvZiB0cmlnZ2Vy
aW5nDQo+ID4gcmVxdWVzdCBmcm9tIHRoZSBmaXJtd2FyZSkuDQo+ID4gQW5kIHdoaWxlIHByb3Zp
ZGluZyBTQ01JIHNlcnZpY2VzIHdhcyB0aGUgcmVhc29uIGZvciB0aGlzIGV4ZXJjaXNlLA0KPiA+
IHRoaXMgZHJpdmVyIGlzIGluIG5vIHdheSBib3VuZCB0byB0aGlzIHVzZSBjYXNlLCBidXQgY2Fu
IGJlIHVzZWQNCj4gPiBnZW5lcmljYWxseSB3aGVyZSB0aGUgT1Mgd2FudHMgdG8gc2lnbmFsIGEg
bWFpbGJveCBjb25kaXRpb24gdG8NCj4gPiBmaXJtd2FyZSBvciBhIGh5cGVydmlzb3IuDQo+ID4g
QWxzbyB0aGUgZHJpdmVyIGlzIGluIG5vIHdheSBtZWFudCB0byByZXBsYWNlIGFueSBleGlzdGlu
ZyBmaXJtd2FyZQ0KPiA+IGludGVyZmFjZSwgYnV0IGFjdHVhbGx5IHRvIGNvbXBsZW1lbnQgZXhp
c3RpbmcgaW50ZXJmYWNlcy4NCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGgNCj4gPg0K
PiB1Yi5jb20lMkZNclZhbiUyRmFybS10cnVzdGVkLWZpcm13YXJlJTJGdHJlZSUyRnNjbWkmYW1w
O2RhdGE9MDINCj4gJTdDMDElNw0KPiA+DQo+IENwZW5nLmZhbiU0MG54cC5jb20lN0MwMTBjOWRk
ZDVkZjY0NWM5YzY2YjA4ZDZkZmE0NmNiMiU3QzY4NmVhMQ0KPiBkM2JjMmI0DQo+ID4NCj4gYzZm
YTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2OTQyMjk0NjMxNDQyNjY1JmFtcDtzZGF0YT1r
Tg0KPiA5YkVGRmNzWkENCj4gPiAxZVBlTkxMZkhtT05wVmFHNk81YWpWUXZLTXVhQlh5ayUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KPiA+DQo+ID4gUGVuZyBGYW4gKDIpOg0KPiA+ICAgRFQ6IG1haWxib3g6
IGFkZCBiaW5kaW5nIGRvYyBmb3IgdGhlIEFSTSBTTUMgbWFpbGJveA0KPiA+ICAgbWFpbGJveDog
aW50cm9kdWNlIEFSTSBTTUMgYmFzZWQgbWFpbGJveA0KPiA+DQo+ID4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21haWxib3gvYXJtLXNtYy50eHQgICAgICAgIHwgIDk2DQo+ICsrKysrKysrKysr
KysNCj4gPiAgZHJpdmVycy9tYWlsYm94L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDcgKw0KPiA+ICBkcml2ZXJzL21haWxib3gvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMiArDQo+ID4gIGRyaXZlcnMvbWFpbGJveC9hcm0tc21jLW1haWxib3gu
YyAgICAgICAgICAgICAgICAgIHwgMTU0DQo+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBp
bmNsdWRlL2xpbnV4L21haWxib3gvYXJtLXNtYy1tYWlsYm94LmggICAgICAgICAgICB8ICAxMCAr
Kw0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDI2OSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94
L2FybS1zbWMudHh0DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21haWxib3gvYXJt
LXNtYy1tYWlsYm94LmMgIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IGluY2x1ZGUvbGludXgvbWFp
bGJveC9hcm0tc21jLW1haWxib3guaA0KPiA+DQo+IA0KPiANCj4gLS0NCj4gRmxvcmlhbg0K
