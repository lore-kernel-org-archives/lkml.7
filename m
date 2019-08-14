Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29B8C32757
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9E820843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H9qn7WjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfHNJtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:49:33 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:42150
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbfHNJtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQn3jyUnFvezQgC5EGFX4MXEUJHPryr/ZZuySrDlFcT9ynccvLYRgi7UUdjRsE7tqXgulEa0UhLW6L2fmTBxOhijuWs892hb40xejccOgGVQuqaYfzhqaEtlO0pEzDZyesIvpC0ZH/wQ2S/VsHcvjsPl1gnjAbmswVWZ4wL8OEDaj24mfN5HGGH3MvOaa3HAuGh7hGRcVC6+0Z02lAgXgPYnTlqe+p4XpTDSn+YFJ8hVS7k7tId5h3xAlO1gRovqm7JW0Lk0OQU+Kymo++pjPEsAryX8BJKs6a1dnu1arW6p87LnpbM1kRqnLpHxkn0909m4eaWp38py81RWoGZIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRd/psKjwplic+EWLadb0xRsxO4dZLXyZ+s3ZTAi2eg=;
 b=eRKAv1CYzYKAVmpjWskQjN7OTc2yvGUMt+sWArhtveRfUe4gEGMfafNPYe4JWwLjNSkfND3tstV3x+eC32AK/9fBtpI29aNRjTCkSOSVQP9ojPemU+T31RzWzqdpY4idCiT4Vwa4QZ0NcbYH6tbHfKtxcABwIdhYeDsZSy7zE2aOObyJqdVGP/P5EcKuokFn5OniZsCJsiuulqmSzYmjwualyjjxkRTDrBoeWOYYQdQd8rdw39x8PrR7fmXFyf3KRdr+b1IkxnKSgPVku3l/JeX7k1XIUwG1Li8OKXMjDxNIrZd/Uwk+shMpfgvzMJHmdWyeP49jpZU3YASm5JhBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRd/psKjwplic+EWLadb0xRsxO4dZLXyZ+s3ZTAi2eg=;
 b=H9qn7WjEcqw29PHsf4ldWQTbh2Dyoj2/Mf956qQst0cx7nId1g4O4XW9xRRd3r9FIOU3mEgwoufknzJf7/i8lFRYz5+Np73dCTYQehnvb7Hy66s0nJH59AUqZurOqmk9m//0dZQpD/raip9hWdJJxYZbPCjdb76fbDDuKI/lmDs=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4700.eurprd04.prod.outlook.com (20.176.233.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Wed, 14 Aug 2019 09:49:29 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4%5]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 09:49:29 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Subject: RE: [EXT] Re: [v1 2/3] dt/bindings: clk: Add DT bindings for LS1028A
 Display output interface
Thread-Topic: [EXT] Re: [v1 2/3] dt/bindings: clk: Add DT bindings for LS1028A
 Display output interface
Thread-Index: AQHVUPZmmHsvouKPJkueVWpL5KhirKb5aFSAgAD9yfA=
Date:   Wed, 14 Aug 2019 09:49:29 +0000
Message-ID: <DB7PR04MB51950A726D59F17EE269F2F3E2AD0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190812100216.34459-1-wen.he_1@nxp.com>
 <20190813183005.EC13020665@mail.kernel.org>
In-Reply-To: <20190813183005.EC13020665@mail.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c28a252-6c56-4cbc-e367-08d7209cb3a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4700;
x-ms-traffictypediagnostic: DB7PR04MB4700:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4700D0FFE0E582F9E56DBB80E2AD0@DB7PR04MB4700.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(13464003)(189003)(199004)(76116006)(186003)(66476007)(81156014)(99286004)(446003)(66946007)(102836004)(66556008)(256004)(6506007)(53546011)(7696005)(26005)(9686003)(8936002)(64756008)(2906002)(14444005)(3846002)(76176011)(33656002)(81166006)(66446008)(2501003)(6116002)(476003)(14454004)(11346002)(478600001)(486006)(55016002)(52536014)(110136005)(6436002)(66066001)(7736002)(54906003)(71190400001)(71200400001)(74316002)(53936002)(316002)(305945005)(5660300002)(2201001)(86362001)(6246003)(8676002)(4326008)(25786009)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4700;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K8IcF9Kz6ZcsOSRXi9JE2lWloEWXLQ4Tu3hZWCp9qsTyw61rza/hSn+HcHwaD430zJaUSLxwFrkP+Bw0IQ6Jh/E/H/z/wo28kMojGZyBEinlZNMmpp8TZ/Dkv1VhWKDZDuHGrrg3BB5KIe94j0ZEzRBVHT4B3RV5DRAA2uZd0ajtMZL8G9/l9ytwJUd7KQNK4QNK4tPrXACfLXqMPPtC5hc2AowgWMkfWq+0y4VSShoXAaBF8OFkqpAcTKAceR+I0uJYL0ABp4xIkD013qI79fLLF84DXjLtIwlMC6VcYnME4rcR168AZ6LFx/iUQqt2FoMicL469znNwekF6fi3CMh/ri+Prtt14lpEQmeaxvz2B1fgsBCqQ0gbBWb7XjcCXvpGGCzfry38NC0x+ErhZQwgBKdaH7KLefYTHNpsO7U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c28a252-6c56-4cbc-e367-08d7209cb3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 09:49:29.5878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wdMlI0NuOBpFMJfWwB4WcR+m7rD9o0OfFxtTnhvbCVWcla2/cjtBcBxzpWgW9Fc3AClDubhOH33WWgd4ZCRzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0OOaciDE05pelIDI6MzANCj4gVG86IE1h
cmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0ZQ0KPiA8
bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgV2VuIEhlIDx3ZW4uaGVfMUBu
eHAuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IExlbyBMaSA8
bGVveWFuZy5saUBueHAuY29tPjsgbGl2aXUuZHVkYXVAYXJtLmNvbTsgV2VuIEhlDQo+IDx3ZW4u
aGVfMUBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW3YxIDIvM10gZHQvYmluZGluZ3M6
IGNsazogQWRkIERUIGJpbmRpbmdzIGZvciBMUzEwMjhBDQo+IERpc3BsYXkgb3V0cHV0IGludGVy
ZmFjZQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBRdW90aW5nIFdlbiBIZSAoMjAx
OS0wOC0xMiAwMzowMjoxNikNCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Nsb2NrL2ZzbCxwbGxkaWcudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY2xvY2svZnNsLHBsbGRpZy50eHQNCj4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjljNWE2MTE3ODA5DQo+ID4gLS0tIC9k
ZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9j
ay9mc2wscGxsZGlnLnR4dA0KPiA+IEBAIC0wLDAgKzEsMjYgQEANCj4gPiArTlhQIFFvcklRIExh
eWVyc2NhcGUgTFMxMDI4QSBEaXNwbGF5IG91dHB1dCBpbnRlcmZhY2UgQ2xvY2sNCj4gPiArPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gDQo+IENhbiB5b3UgY29udmVydCB0aGlzIHRvIFlBTUw/DQoNClN1cmUsIG5vIHByb2JsZW0u
DQoNCj4gDQo+ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgLSBjb21w
YXRpYmxlOiBzaGFsbCBjb250YWluICJmc2wsbHMxMDI4YS1wbGxkaWciDQo+ID4gKyAgICAtIHJl
ZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBibG9jayByZWdpc3RlcnMN
Cj4gPiArICAgIC0gI2Nsb2NrLWNlbGxzOiBzaGFsbCBjb250YWluIDEuDQo+IA0KPiBBcyBJIHNh
aWQgaW4gdGhlIHByZXZpb3VzIHBhdGNoLCB0aGlzIHNob3VsZCBwcm9iYWJseSBiZSAwLiBBbHNv
LCBwbGVhc2Ugb3JkZXINCj4gdGhpcyBiZWZvcmUgdGhlIGRyaXZlciBpbiB0aGUgcGF0Y2ggc2Vy
aWVzIGFuZCB0aHJlYWQgeW91ciBtZXNzYWdlcyBwbGVhc2UuIElmDQo+IHlvdSB1c2UgZ2l0LXNl
bmQtZW1haWwgdGhpcyBpcyBkb25lIGZvciB5b3UgcHJldHR5IGVhc2lseS4NCg0KVW5kZXJzdGFu
ZCwgV2lsbCBwcmVwYXJlIGFuZCBzZW5kIG5leHQgdmVyc2lvbiBwYXRjaC4NCg0KQmVzdCBSZWdh
cmRzLA0KV2VuDQoNCj4gDQo+ID4gKyAgICAtIGNsb2NrczogYSBwaGFuZGxlICsgY2xvY2stc3Bl
Y2lmaWVyIHBhaXJzLCBoZXJlIHNob3VsZCBiZQ0KPiA+ICsgICAgc3BlY2lmeSB0aGUgcmVmZXJl
bmNlIGNsb2NrIG9mIHRoZSBzeXN0ZW0NCj4gPiArDQo+ID4gKw0K
