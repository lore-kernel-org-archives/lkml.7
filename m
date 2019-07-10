Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6827C73C65
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886E120693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GD9MiTsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfGJBaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:30:46 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:51468
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfGJBaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:30:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2IBnVTAEyvdR1MQ49f13eVt6MXjGwfzTKdRSGrhXVxR7HXn0v3JW5eAheHdbGiAfifdGSu84uIKUBHm9E+zwNHQvqa5L7wmwhMlekmlCEm9wBJS0liOvWzqz/TajThiX40Sh0PUPgmm250cRd1m/x2HNUFQbAKc7xE0g/RqK/xZkWj14tc3+gOCHEpbvjjaHJUNHJFvyyiHjc7nWBzjDoeDM7LqWQhFsoIjJF7FlKa+VFp2RnhVAtfKVDmjqUMiUT7DT0sTTAUa8Yv4SDJd2oSqG/gT7Am2qNGSyy4eqzMjVftjOCQW3esprAK5FkCDfbogmWy3LOqG98Drnvim4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/+GyMmVS/scMWnNx7/qPdLuUu8JgFpGswysIyL0Ulc=;
 b=Qeukn5ecOjzSmkrTHMP0VE02MzC2+mD4apnhDB73V4x6udfNNID/5RoSScc0ZLKId/biBB9B734QENFQ/7waTCSWeTK57yfn0yRuEI/DtUziTpUlVNdsSFjTuo2SRfS6BpVCp0jqDc/CZQmryzMZweQk6EMCzuv5aLKLZWdK98rggTdo8wNLjYhLpx/mtEWQKdJduB9g+3xdE0z2YUUttxS3gNI81Vi7V1allaftxNt7WO9L6KPDNGgwKvra9owf1aQXcvR7CuF1viNu7STXW2DHwfER/Mn2n3NbFm4Ttzpm2/0TlJAtzqJLvHYotTH9mUrWALmJOOmnuTzYFF0NVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/+GyMmVS/scMWnNx7/qPdLuUu8JgFpGswysIyL0Ulc=;
 b=GD9MiTsxSUJGAu/uIfMDp2Q9UgqsyivjLofcwb4dIlPi7xHUsrZROZuaSniXn2ERtj2MeLBa0fxsdGWBf+Gdw7fA94/pt7+h6AxHcPFPh4s6NvECjsur4XMetPag8zkwHTV8WwnXXUWpahKUJAS9/odVvBOTpJZ5NLpPx7//n+A=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3657.eurprd04.prod.outlook.com (52.134.69.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 01:30:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8875:8e81:7be1:b0a0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8875:8e81:7be1:b0a0%5]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 01:30:40 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/5] clocksource/drivers/sysctr: Add clock-frequency
 property
Thread-Topic: [PATCH V4 2/5] clocksource/drivers/sysctr: Add clock-frequency
 property
Thread-Index: AQHVL/II1Ibi8cGYOUSIKmrgeiNcLabCyoSAgABPmdA=
Date:   Wed, 10 Jul 2019 01:30:40 +0000
Message-ID: <DB3PR0402MB39167FC68991F071E9E58D81F5F00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190701093826.5472-1-Anson.Huang@nxp.com>
 <20190701093826.5472-2-Anson.Huang@nxp.com>
 <CAL_JsqKeu-b8mbMJBtnNn1vL=RSvUXbo+g40haZnjXTW11CJ6w@mail.gmail.com>
In-Reply-To: <CAL_JsqKeu-b8mbMJBtnNn1vL=RSvUXbo+g40haZnjXTW11CJ6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74c29fd7-3894-48a8-0674-08d704d63829
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3657;
x-ms-traffictypediagnostic: DB3PR0402MB3657:
x-microsoft-antispam-prvs: <DB3PR0402MB3657D04A9CF4510DC5D5063AF5F00@DB3PR0402MB3657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(76176011)(478600001)(7736002)(4326008)(2906002)(99286004)(6436002)(5660300002)(53546011)(66066001)(52536014)(7416002)(74316002)(229853002)(54906003)(8936002)(186003)(6506007)(256004)(316002)(102836004)(305945005)(9686003)(6246003)(81166006)(486006)(81156014)(33656002)(25786009)(26005)(86362001)(3846002)(6116002)(8676002)(53936002)(68736007)(446003)(476003)(44832011)(7696005)(66446008)(55016002)(66476007)(66556008)(64756008)(11346002)(71190400001)(71200400001)(14454004)(66946007)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3657;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GFnAN5i/pyUaxAd/0zEIrolL/AngVN5xzIM0ps0QFeuqdb2MoJ+EgGEKnEubQTP2GJ8x1lsnvIHVKWtXVBT8NWiKRjkceCX/Q0SlgAFL7sDcT5WR+42Kjoy/igh9c1FKO2+tojLd6a5TkogDop0zTmoLQMIQaGx3iiuDfTyDLPBM/PDwJYJjHhUhOixdLVeHjewaimRdaUqmWSVrxiwzeusjdM8LVbt7KGrQVxtjx4utVJi7AT8u23bjgJcNe/pcxKgtRXA8xI3l6g1iPqkO9RGPfgDFqynnU/sY+mvFV+kHNye3TV+d00ummC+WOsaxZq8ee5H7BeUPY39pDqvANUA6FqYrksZMBt2Wz4MZ1yuddm/HPZkW+T4lXqFWb3TIofnX8kvA1y1oA5LDa0adHzD0dVibeSMnYvkQ9t3hPl8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c29fd7-3894-48a8-0674-08d704d63829
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 01:30:40.5760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQo+IE9uIE1vbiwgSnVsIDEsIDIwMTkgYXQgMzo0NyBBTSA8QW5zb24uSHVhbmdA
bnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gDQo+ICdkdC1iaW5kaW5nczogdGltZXI6IC4uLicgZm9yIHRoZSBzdWJqZWN0
Lg0KDQpPSywgSSBtYWRlIGEgbWlzdGFrZS4NCg0KPiANCj4gPg0KPiA+IFN5c3RlbXMgd2hpY2gg
dXNlIHBsYXRmb3JtIGRyaXZlciBtb2RlbCBmb3IgY2xvY2sgZHJpdmVyIHJlcXVpcmUgdGhlDQo+
ID4gY2xvY2sgZnJlcXVlbmN5IHRvIGJlIHN1cHBsaWVkIHZpYSBkZXZpY2UgdHJlZSB3aGVuIHN5
c3RlbSBjb3VudGVyDQo+ID4gZHJpdmVyIGlzIGVuYWJsZWQuDQo+IA0KPiBUaGlzIGlzIGEgRFQg
YmluZGluZy4gV2hhdCdzIGEgcGxhdGZvcm0gZHJpdmVyPw0KDQpJdCBpcyBqdXN0IHRyeWluZyB0
byBleHBsYWluIHdoeSB3ZSBuZWVkIHRvIGludHJvZHVjZSB0aGlzICJjbG9jay1mcmVxdWVuY3ki
DQpwcm9wZXJ0eSwgbm90aGluZyBhYm91dCB0aGUgYmluZGluZyBhbmQgcGxhdGZvcm0gZHJpdmVy
Lg0KDQo+IA0KPiA+DQo+ID4gVGhpcyBpcyBuZWNlc3NhcnkgYXMgaW4gdGhlIHBsYXRmb3JtIGRy
aXZlciBtb2RlbCB0aGUgb2ZfY2xrDQo+ID4gb3BlcmF0aW9ucyBkbyBub3Qgd29yayBjb3JyZWN0
bHkgYmVjYXVzZSBzeXN0ZW0gY291bnRlciBkcml2ZXIgaXMNCj4gPiBpbml0aWFsaXplZCBpbiBl
YXJseSBwaGFzZSBvZiBzeXN0ZW0gYm9vdCB1cCwgYW5kIGNsb2NrIGRyaXZlciB1c2luZw0KPiA+
IHBsYXRmb3JtIGRyaXZlciBtb2RlbCBpcyBOT1QgcmVhZHkgYXQgdGhhdCB0aW1lLCBpdCB3aWxs
IGNhdXNlIHN5c3RlbQ0KPiA+IGNvdW50ZXIgZHJpdmVyIGluaXRpYWxpemF0aW9uIGZhaWxlZC4N
Cj4gPg0KPiA+IEFkZCBjbG9jay1mcmVxdWVuY3kgcHJvcGVydHkgdG8gdGhlIGRldmljZSB0cmVl
IGJpbmRpbmdzIG9mIHRoZSBOWFANCj4gPiBzeXN0ZW0gY291bnRlciwgc28gdGhlIGRyaXZlciBj
YW4gdGVsbCB0aW1lci1vZiBkcml2ZXIgdG8gZ2V0IGNsb2NrDQo+ID4gZnJlcXVlbmN5IGZyb20g
RFQgZGlyZWN0bHkgaW5zdGVhZCBvZiBkb2luZyBvZl9jbGsgb3BlcmF0aW9ucyB2aWEgY2xrDQo+
ID4gQVBJcy4NCj4gDQo+IFdoaWxlIHlvdSd2ZSBub3cgZ2l2ZW4gYSBnb29kIGV4cGxhbmF0aW9u
IHdoeSB5b3UgbmVlZCB0aGlzLCBpdCBhbGwgc291bmRzDQo+IGxpa2UgbGludXggc3BlY2lmaWMg
aXNzdWVzIGFuZCBhIERUIGNoYW5nZSBzaG91bGQgbm90IGJlIG5lY2Vzc2FyeS4NCj4gDQo+IFBy
ZXN1bWFibHksICdjbG9ja3MnIHBvaW50cyB0byBhIGZpeGVkLWNsb2NrIG5vZGUsIHJpZ2h0PyBK
dXN0IHBhcnNlIHRoZSAnY2xvY2tzJw0KPiBwaGFuZGxlIGFuZCBmZXRjaCB0aGUgZnJlcXVlbmN5
IGZyb20gdGhhdCBub2RlIGlmIHlvdSBuZWVkIHRvIGdldCB0aGUNCj4gZnJlcXVlbmN5ICdlYXJs
eScuDQoNClNvdW5kIGxpa2UgYSBiZXR0ZXIgc29sdXRpb24sIEkgd2lsbCB0cnkgdGhhdCwgc2lu
Y2UgdGhlIHN5c3RlbSBjb3VudGVyJ3MgY2xvY2sgaXMNCmZyb20gb3NjXzI0bSBhbmQgZGl2aWRl
ZCBieSAzLCBzaW5jZSBkaWZmZXJlbnQgcGxhdGZvcm1zIG1heSBoYXZlIGRpZmZlcmVudCBkaXZp
ZGVyLA0Kc28gbWF5YmUgSSBjYW4gY3JlYXRlIGEgZml4ZWQtY2xvY2sgbm9kZSBpbiBEVCwgdGhl
biBzeXN0ZW0gY291bnRlciBkcml2ZXIgY2FuIHBhcnNlDQp0aGUgY2xvY2sgYW5kIGZldGNoIHRo
ZSBmcmVxdWVuY3kgZnJvbSB0aGF0IG5vZGUsIHdpbGwgcmVkbyBhIFY1IHBhdGNoLg0KDQo+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+
IC0tLQ0KPiA+IE5vIGNoYW5nZS4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvdGltZXIvbnhwLHN5c2N0ci10aW1lci50eHQgICAgICAgIHwgMTUgKysrKysrKysrLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdGltZXIvbnhwLHN5c2N0ci10aW1lci50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy90aW1lci9ueHAsc3lzY3RyLXRpbWVyLnR4dA0KPiA+IGluZGV4IGQ1NzY1
OTkuLjcwODhhMGUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RpbWVyL254cCxzeXNjdHItdGltZXIudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL254cCxzeXNjdHItdGltZXIudHh0DQo+ID4gQEAg
LTExLDE1ICsxMSwxOCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAtIHJlZyA6ICAgICAg
ICAgICAgIFNwZWNpZmllcyB0aGUgYmFzZSBwaHlzaWNhbCBhZGRyZXNzIGFuZCBzaXplIG9mIHRo
ZSBjb21hcHJlDQo+ID4gICAgICAgICAgICAgICAgICAgICAgZnJhbWUgYW5kIHRoZSBjb3VudGVy
IGNvbnRyb2wsIHJlYWQgJiBjb21wYXJlLg0KPiA+ICAtIGludGVycnVwdHMgOiAgICAgIHNob3Vs
ZCBiZSB0aGUgZmlyc3QgY29tcGFyZSBmcmFtZXMnIGludGVycnVwdA0KPiA+IC0tIGNsb2NrcyA6
ICAgICAgICAgU3BlY2lmaWVzIHRoZSBjb3VudGVyIGNsb2NrLg0KPiA+IC0tIGNsb2NrLW5hbWVz
OiAgICAgICAgICAgICBTcGVjaWZpZXMgdGhlIGNsb2NrJ3MgbmFtZSBvZiB0aGlzIG1vZHVsZQ0K
PiA+ICstIGNsb2NrcyA6ICAgICAgICAgIFNwZWNpZmllcyB0aGUgY291bnRlciBjbG9jaywgbXV0
dWFsbHkgZXhjbHVzaXZlIHdpdGggY2xvY2stDQo+IGZyZXF1ZW5jeS4NCj4gPiArLSBjbG9jay1u
YW1lcyA6ICAgICBTcGVjaWZpZXMgdGhlIGNsb2NrJ3MgbmFtZSBvZiB0aGlzIG1vZHVsZSwgbXV0
dWFsbHkNCj4gZXhjbHVzaXZlIHdpdGgNCj4gPiArICAgICAgICAgICAgICAgICAgIGNsb2NrLWZy
ZXF1ZW5jeS4NCj4gPiArLSBjbG9jay1mcmVxdWVuY3kgOiBTcGVjaWZpZXMgc3lzdGVtIGNvdW50
ZXIgY2xvY2sgZnJlcXVlbmN5LCBtdXR1YWxseQ0KPiBleGNsdXNpdmUgd2l0aA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgY2xvY2tzL2Nsb2NrLW5hbWVzLg0KPiANCj4gSXQgZG9lc24ndCByZWFs
bHkgd29yayB0byBzYXkgb25lIG9yIHRoZSBvdGhlciBpcyBuZWVkZWQgdW5sZXNzIHlvdSBtYWtl
IHRoZQ0KPiBPUyBzdXBwb3J0IGJvdGggY2FzZXMuDQoNClRoZSBPUyBhbHJlYWR5IHN1cHBvcnQg
Ym90aCBjYXNlcyBub3cgd2l0aCB0aGlzIHBhdGNoIHNlcmllcy4NCg0KVGhhbmtzLA0KQW5zb24N
Cg==
