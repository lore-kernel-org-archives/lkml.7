Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74BDC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A902F22CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WFan8fc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfHTCYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:24:33 -0400
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:5442
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHTCYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:24:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flaK/6ZYlGRVo21xMiSVcbL/6A7tp1BLD/TVuUqMz9gFSyOj9tApEUyCyEYSs8uWdtsXAK/x8hq9h9yWdrNoLszFq/M8gTAcU5owEO/J1nmBvMyoGyDh0PPrFAt1jgVPEA8w+o2xgcWpjSK8rXNdhCxEWPlK4xkGXaZh8Jz6aOYbK7T6qWM+xdaBGDDd7LgFvctG5lcPc8Dxxa3gV8MhAiIXhPRQKfqwvJxhkX+fCNwEtIoVwOgIvECbHlhT/G39PUIdo6jyrS7ppkZ9SJl4FWQrcdaeyRXieRRlAclNNFPjdBittNgU2vMO5/NiV6QJTGmq6wyNo6rC8+yqd3IGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFDFF6r718NaTFLxZ6eZueWm4eb9QpoOvgThER+fflo=;
 b=TuiZPKaaO/YAN5OYWm2ognU1udin3fmByEz3JSFDxV++1ce9rYWXNmj3q0rR9jBijy4e47v1Ir7uF0LLEDqV+a61KargYnbcUnbGF4y3Ef82eEgurHlD4P91KlxC1jYcs1Ovyfrrz39NsQX2UnH4B28Va4Gl5TD/WJZyH2enm2BS98A7CdEN9JNPNxScoxlEFmFEQK1eZL7ivFR1TBgmopXOG0zyQFznh8GlcyvQe2JZYWILizfgjZqXrmzI31YDi/aNfRfhReACvIsjWo0YkdqZ2MRaTHzA285rE67uKzl3X4f4ge4zMjF7kIsFREunISc9m/VLm2Qhs59AfWIsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFDFF6r718NaTFLxZ6eZueWm4eb9QpoOvgThER+fflo=;
 b=WFan8fc/UZDUvyUE0IvlgL1jWeONt6bdl7yAAKlu6poHuxgSjoUBlX+z6kV2JeKWLAVfpHbmWYSKvDDEYLm90SZhmOPRXKruisOJiMRv8OcCvVDgPohQNAo6VeIlZ1p8CvD5SaFkBefMWxH723IUeqTGbSROfWg7fITdGBlo2KQ=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4139.eurprd04.prod.outlook.com (52.135.130.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 02:24:25 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4%5]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 02:24:25 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Subject: RE: [EXT] Re: [v2 2/3] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Topic: [EXT] Re: [v2 2/3] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Index: AQHVU1PbObDpg5VHhkiHRWFbV1fnLab+DmGAgAO1CpCAAQ4QgIAAfdKQ
Date:   Tue, 20 Aug 2019 02:24:25 +0000
Message-ID: <DB7PR04MB519563FED2146F6D1327668AE2AB0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190815101613.22872-1-wen.he_1@nxp.com>
 <20190815101613.22872-2-wen.he_1@nxp.com>
 <20190816174624.115FC205F4@mail.kernel.org>
 <DB7PR04MB51952DF4E1EE7FF10A947347E2A80@DB7PR04MB5195.eurprd04.prod.outlook.com>
 <20190819182944.4AEAB22CF5@mail.kernel.org>
In-Reply-To: <20190819182944.4AEAB22CF5@mail.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21707400-1c9a-4adf-7363-08d72515852f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4139;
x-ms-traffictypediagnostic: DB7PR04MB4139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB41395D9D7122B029220F9142E2AB0@DB7PR04MB4139.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(13464003)(199004)(189003)(256004)(52536014)(64756008)(66476007)(76116006)(81156014)(4326008)(6436002)(66946007)(76176011)(66066001)(6116002)(305945005)(53546011)(3846002)(25786009)(110136005)(2906002)(229853002)(66556008)(66446008)(81166006)(54906003)(316002)(55016002)(8936002)(9686003)(53936002)(8676002)(7736002)(186003)(446003)(476003)(11346002)(99286004)(7696005)(5660300002)(486006)(86362001)(33656002)(102836004)(71200400001)(6246003)(2501003)(26005)(6506007)(2201001)(71190400001)(478600001)(74316002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4139;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1c1nZmtlKpqE32BpPDsOMvZdbSlUa2vU5ZQXIxuiViWdlaXb4q8RPccPmTe6CoRqWoa+jgmAk/zTdROiXtrusQLMbnfVmODgNx8KD3x8BX+MWr1xWZueSIXzjB2O193Cit9xpe92dYgz3vZYCE5wqBKLyCX2RgDrBbU/wkEk6ysgX662LdxdUzIOOkfQlrP2HtY+5ounqnmXQawxvaLl3fQtE8BlFLdHM9T+ypq6SAY8zTdcdxjrKNV/5jrucVCJqHFNl9S7ZFtaT0/VUn1I537jGgd/eGpJFOEL1QzE1lkN1ICHnzNbcP0PGb49JIM+UyVq1bFCN58DGr4DeLit30eRumNG+XPt4mqmAEM1vKMgG1rVjnQG4VBeYNkjpre6u8TfpM5YiRtvsYrpK017kdLnc1OrIULg3w9B38j7ArA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21707400-1c9a-4adf-7363-08d72515852f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 02:24:25.4445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjkr20u/o4VJItPhrXEN8MXiVjyD0BPMuXFg9VqanFQF5BKY20Z8XUA5rHJPPNamXtPqrjI5AiMU6+1P7K5dHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0OOaciDIw5pelIDI6MzANCj4gVG86IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1kZXZlbEBsaW51eC5ueGRpLm54cC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IE1hcmsgUnV0bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBNaWNoYWVsIFR1cnF1
ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+Ow0KPiBSb2IgSGVycmluZyA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgV2VuDQo+IEhlIDx3
ZW4uaGVfMUBueHAuY29tPg0KPiBDYzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBsaXZp
dS5kdWRhdUBhcm0uY29tDQo+IFN1YmplY3Q6IFJFOiBbRVhUXSBSZTogW3YyIDIvM10gY2xrOiBs
czEwMjhhOiBBZGQgY2xvY2sgZHJpdmVyIGZvciBEaXNwbGF5IG91dHB1dA0KPiBpbnRlcmZhY2UN
Cj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gUXVvdGluZyBXZW4gSGUgKDIwMTktMDgt
MTkgMDA6MzA6NDkpDQo+ID4gPiBRdW90aW5nIFdlbiBIZSAoMjAxOS0wOC0xNSAwMzoxNjoxMikN
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL0tjb25maWcgYi9kcml2ZXJzL2Nsay9L
Y29uZmlnIGluZGV4DQo+ID4gPiA+IDgwMWZhMWNkMDMyMS4uM2M5NWQ4ZWMzMWQ0IDEwMDY0NA0K
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9LY29uZmlnDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
Y2xrL0tjb25maWcNCj4gPiA+ID4gQEAgLTIyMyw2ICsyMjMsMTYgQEAgY29uZmlnIENMS19RT1JJ
UQ0KPiA+ID4gPiAgICAgICAgICAgVGhpcyBhZGRzIHRoZSBjbG9jayBkcml2ZXIgc3VwcG9ydCBm
b3IgRnJlZXNjYWxlIFFvcklRDQo+IHBsYXRmb3Jtcw0KPiA+ID4gPiAgICAgICAgICAgdXNpbmcg
Y29tbW9uIGNsb2NrIGZyYW1ld29yay4NCj4gPiA+ID4NCj4gPiA+ID4gK2NvbmZpZyBDTEtfTFMx
MDI4QV9QTExESUcNCj4gPiA+ID4gKyAgICAgICAgYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBMUzEw
MjhBIERpc3BsYXkgb3V0cHV0Ig0KPiA+ID4gPiArICAgICAgIGRlcGVuZHMgb24gKEFSQ0hfTEFZ
RVJTQ0FQRSB8fCBDT01QSUxFX1RFU1QpICYmIE9GDQo+ID4gPg0KPiA+ID4gV2hlcmUgaXMgdGhl
IE9GIGRlcGVuZGVuY3kgdG8gYnVpbGQgYW55dGhpbmc/IERvZXNuJ3QgdGhpcyBzdGlsbA0KPiA+
ID4gY29tcGlsZSB3aXRob3V0IENPTkZJR19PRiBzZXQ/DQo+ID4NCj4gPiBZZXMsIGN1cnJlbnQg
aW5jbHVkZWQgc29tZSBBUElzIG9mIHRoZSBPRiwgbGlrZSBvZl9nZXRfcGFyZW50X25hbWUoKQ0K
PiANCj4gQW5kIHRoZXJlIGlzbid0IGEgc3R1YiBBUEkgZm9yIG9mX2dldF9wYXJlbnRfbmFtZSB3
aGVuIE9GIGlzbid0IGRlZmluZWQ/DQoNCllvdSBhcmUgcmlnaHQsIHNob3VsZCBiZSByZW1vdmUg
T0YgZGVwZW5kZW5jeS4NCg0KPiANCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIGludCBwbGxk
aWdfY2xrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiA+ID4gKyAg
ICAgICBzdHJ1Y3QgY2xrX3BsbGRpZyAqZGF0YTsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgcmVz
b3VyY2UgKm1lbTsNCj4gPiA+ID4gKyAgICAgICBjb25zdCBjaGFyICpwYXJlbnRfbmFtZTsNCj4g
PiA+ID4gKyAgICAgICBzdHJ1Y3QgY2xrX2luaXRfZGF0YSBpbml0ID0ge307DQo+ID4gPiA+ICsg
ICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiA+ID4gKyAgICAgICBp
bnQgcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgZGF0YSA9IGRldm1fa3phbGxvYyhk
ZXYsIHNpemVvZigqZGF0YSksIEdGUF9LRVJORUwpOw0KPiA+ID4gPiArICAgICAgIGlmICghZGF0
YSkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ID4gPiArDQo+
ID4gPiA+ICsgICAgICAgbWVtID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VS
Q0VfTUVNLCAwKTsNCj4gPiA+ID4gKyAgICAgICBkYXRhLT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jl
c291cmNlKGRldiwgbWVtKTsNCj4gPiA+ID4gKyAgICAgICBpZiAoSVNfRVJSKGRhdGEtPnJlZ3Mp
KQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoZGF0YS0+cmVncyk7DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBpbml0Lm5hbWUgPSBkZXYtPm9mX25vZGUtPm5hbWU7
DQo+ID4gPiA+ICsgICAgICAgaW5pdC5vcHMgPSAmcGxsZGlnX2Nsa19vcHM7DQo+ID4gPiA+ICsg
ICAgICAgcGFyZW50X25hbWUgPSBvZl9jbGtfZ2V0X3BhcmVudF9uYW1lKGRldi0+b2Zfbm9kZSwg
MCk7DQo+ID4gPiA+ICsgICAgICAgaW5pdC5wYXJlbnRfbmFtZXMgPSAmcGFyZW50X25hbWU7DQo+
ID4gPg0KPiA+ID4gQ2FuIHlvdSB1c2UgdGhlIG5ldyB3YXkgb2Ygc3BlY2lmeWluZyBjbGsgcGFy
ZW50cyB3aXRoIHRoZQ0KPiA+ID4gcGFyZW50X2RhdGEgbWVtYmVyIG9mIGNsa19pbml0Pw0KPiA+
DQo+ID4gT2YgY291cnNlLCBidXQgSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBuZWVkIHJlY29tbWVu
ZCB0byB1c2UgdGhpcyBtZW1iZXI/DQo+ID4gSXMgdGhhdCB0aGUgbWVtYmVyIHBhcmVudF9uYW1l
cyB3aWxsIGJlIGRpc2NhcmQgaW4gZnV0dXJlPw0KPiA+DQo+ID4gSGVyZSBhcmUgZGVmaW5pdGlv
biBvZiB0aGUgY2xrLXByb3ZpZGVyLmgNCj4gPiAvKiBPbmx5IG9uZSBvZiB0aGUgZm9sbG93aW5n
IHRocmVlIHNob3VsZCBiZSBhc3NpZ25lZCAqLw0KPiA+IGNvbnN0IGNoYXIgICAgICAgICAgICAg
ICogY29uc3QgKnBhcmVudF9uYW1lczsNCj4gPiBjb25zdCBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRh
ICAgICpwYXJlbnRfZGF0YTsNCj4gPiBjb25zdCBzdHJ1Y3QgY2xrX2h3ICAgICAgICAgICAgICoq
cGFyZW50X2h3czsNCj4gPg0KPiA+IEZvciBQTExESUcsIGl0IG9ubHkgaGFzIG9uZSBwYXJlbnQu
DQo+IA0KPiBZZXMuIENhbiB5b3UgdXNlIGNsa19wYXJlbnRfZGF0YSBhcnJheSBhbmQgc3BlY2lm
eSBhIERUIGluZGV4IG9mIDAgYW5kIHNvbWUNCj4gbmFtZSB0aGF0IHdvdWxkIGdvIGludG8gImNs
b2NrLW5hbWVzIiBpbiB0aGUgLmZ3X25hbWUgbWVtYmVyPw0KDQpPSywgYnV0IC5md19uYW1lIHVz
ZWQgZm9yIHRvIHJlZ2lzdGVyaW5nIGNsaywgY3VycmVudCBpdCByZWdpc3RlcmVkIHdpdGggZml4
ZWQgY2xrIGluIGR0cyAuDQpJIHRoaW5rIHNob3VsZCBiZSBzcGVjaWZ5IGEgRFQgaW5kZXggb2Yg
MCBhbmQgc3BlY2lmeSB0aGUgdW5pcXVlIG5hbWUgZm9yIC5uYW1lIG1lbWJlci4NCg0KSSBmb3Vu
ZCBoYXZlIHR3byB3YXlzIHRvIHNwZWNpZnk6DQoxLiBkZWNsYXJlIGNsa19wYXJlbnRfZGF0YSB2
YXJpYWJsZSBwYXJlbnRfZGF0YSwgYW5kIGluaXRpYWxpemF0aW9uIHdpdGggY2xrX2luaXRfZGF0
YSwgbGlrZSB0aGlzOg0KIA0KcGFyZW50X2RhdGEubmFtZSA9IG9mX2Nsa19nZXRfcGFyZW50X25h
bWUoZGV2LT5vZl9ub2RlLCAwKTsgDQpwYXJlbnRfZGF0YS5pbmRleCA9IDA7DQoNCmluaXQubmFt
ZSA9IGRldi0+b2Zfbm9kZS0+bmFtZTsNCmluaXQub3BzID0gJnBsbGRpZ19jbGtfb3BzOw0KaW5p
dC5wYXJlbnRfZGF0YSA9ICZwYXJlbnRfZGF0YTsNCmluaXQubnVtX3BhcmVudHMgPSAxOw0KDQoy
LiBPciB1c2UgYSBzdGF0aWMgY29uc3QgYXJyYXkgZm9yIGhlcmU/IEFuZCBwdXQgdGhlIHVuaXF1
ZSBuYW1lIGFuZCBpbmRleCBsaWtlIHRoaXMuDQpzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19wYXJl
bnRfZGF0YSBwYXJlbnRfZGF0YVtdID0gew0KICAgICAgICB7Lm5hbWUgPSAicGh5XzI3bSIsIC5p
bmRleCA9IDB9LA0KfTsNCg0KQWZ0ZXIgdGhlbiBpbml0aWFsaXphdGlvbiB3aXRoIG1hY3JvIENM
S19IV19JTklUX1BBUkVOVFNfREFUQT8NCg0KQmVzdCBSZWdhcmRzLA0KV2VuDQo=
