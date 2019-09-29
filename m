Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1FBC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5905B214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4dqtpH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfI2BNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 21:13:04 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:3054
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728601AbfI2BNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 21:13:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQhHYk4aRNBdq/YfP+7vQdttwm3ZcEPlS7fks6moIL2n1B1Q3PW36vKmwG02wmoJOzc204O+cauD/M5n0sPHTMkUhXycj1InIUHsbNhD1TpwjlNG06N/H72JcEzlsaBHIP3gEQihApYO7ZvKhxLCNK8QefnJXjxB1ctsywiGQjbmR3WMkcb9r7/tXlC+MZ6oLAy7agNgw3RR4Z9vTCWUBtXzNERFFP2Vk1Q3+hWmOYr4XfmzP7XNxUm8lZL/532b2e892K86ojus+dBkAci/ZY/f6d0Hyqnd7Xjg4ZimMR0zWuUUMkpjCyt+z/FcqJybZz2l1vOJrNXTzfDjBaEe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0rfWE9NhDLQGy/IThYSNVrqtPYuozVqMZgghShHS0E=;
 b=YLOOqASOAtO055LetssByThdcxwtbnOvqNi+VjmnrZwxxjkqMXbe12rWn8IucfCjzc7GkpHB4NouPCBj9Wgn9XMwta3qaIWnhyEkbD5DnkcWQwV0VugvUgeNnfYWu2z5pxn8IDveOUO4AekKK/pPuclfIPSBDPL/j9hwNcuaTCYlDdcMAp830JCLIeujICRL6P81pNmdMMvbNg8jFhD+w/2sqnckjdh+lnGSEufuYunB5AU1gOpINzNB3n3Px8fPmmDeb9deWPL34mtUn77fzC3me6wcCVLP33cFOQB/6sGz40suKYAM4lEUHoBx2ccuZG7fBOJTnlrC78f8/VXOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0rfWE9NhDLQGy/IThYSNVrqtPYuozVqMZgghShHS0E=;
 b=E4dqtpH7rypy7K+1D4dT8zGwcsfeTMYzB7F+o/XwH2P0ZDWXwiZm8O34zC19U4iry0hmGD5vF/ca+NsfcBcdFlnFyTt/Pyt3m6mdHu7aOBNSv+IVhkpG7QWUrk0wcie5gOsYJMqRiN9txCJkjEp6+8WATf6vKXCDs+UPqCe12BA=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3639.eurprd04.prod.outlook.com (52.133.28.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Sun, 29 Sep 2019 01:12:57 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::b0c2:4fbb:fae7:991]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::b0c2:4fbb:fae7:991%5]) with mapi id 15.20.2305.017; Sun, 29 Sep 2019
 01:12:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Topic: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Index: AQHVc4lT/ErvPybCJUCbZ2x7mLGjsqdB1xcg
Date:   Sun, 29 Sep 2019 01:12:57 +0000
Message-ID: <AM6PR0402MB39115E54D8879FFBFF5CB798F5830@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
 <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190927090609.fyxdekkzrco7memt@pengutronix.de>
 <VI1PR04MB702397C54519DC27CFF05A78EE810@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB702397C54519DC27CFF05A78EE810@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba4101f0-bd5b-4d15-c2e8-08d7447a29e4
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM6PR0402MB3639:|AM6PR0402MB3639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3639CFEE384C0E2D80C98C8BF5830@AM6PR0402MB3639.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 017589626D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(8936002)(66476007)(110136005)(54906003)(66946007)(66556008)(71200400001)(71190400001)(486006)(74316002)(7696005)(99286004)(3846002)(6116002)(11346002)(5660300002)(76176011)(446003)(44832011)(186003)(476003)(256004)(66446008)(64756008)(76116006)(25786009)(9686003)(81166006)(81156014)(229853002)(6246003)(66066001)(102836004)(33656002)(26005)(53546011)(86362001)(6506007)(478600001)(316002)(4326008)(55016002)(52536014)(2906002)(6436002)(14454004)(7736002)(305945005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3639;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R9heKuEaNZwdhHRRa5pi42DGB+ji0IYjCMwJWUF0Zvi9H0NzW1xU/DJx6KxV/xBd3hqf80oWyHp+AiUipQQAhcMrhJ9lRa9Xy6c1fVmX9WxTpSoNX0c0fM6l+AH5nF8j4XWsDKofK+nYmkCRv3gOnxbRKplwT3A1nDd1gXnQNivx18F1bk/u53Lw+jTgb66v0IYSrcAXcRHHSegZOnPW9A8BaRqySFVvJON2NayvDKRIraF8a06hhij2Z9+T1ZZUqWdzlCCXih1cu2ZCHyuzIC0CqSa2bU8WjG25q/N6hYdK74G+q8cLY95pob+0Ha1FF2cEuU4x+GOhXgILEOz/Cnod3oKkiGoQIM8WbzSE/HsBEWsNwitnOAryW/UtYoT9DJFTmpqg4rr9LtJD9U1thB8lH490ccPSSvqj37HR/XY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4101f0-bd5b-4d15-c2e8-08d7447a29e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2019 01:12:57.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1X8mqCX2xXQaPcFKsc6gZTYbD+U2Rr6Jqx4VCK78EGc+NUUCO/pxIf28mLYzQPQzpVH1OUeB2hE0W/ImL3Ex9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3639
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQvTWFyY28NCglJIHRoaW5rIHdlIHNob3VsZCBnZXQgYWxpZ25lZCBmaXJzdCwg
bXkgb3JpZ2luYWwgdGhvdWdodCBpcyB0byBsZXQgU0NVIEFQSSBjYWxsZXIgTk9UIGF3YXJlIG9m
IHRob3NlIHNwZWNpYWwgQVBJcywgc28gaGF2ZSB0byBkbyB0aGUgc3BlY2lhbCBoYW5kbGluZyBp
biBpbXhfc2N1X2NhbGxfcnBjKCkuIEFuZCB0aGUgc2hvcnQgbG9vcCBjaGVjayBoYXMgdG8gYmUg
dXNlZCB3aGljaCB3b3VsZCBpbXBhY3QgdGhlIHBlcmZvcm1hbmNlIGEgbGl0dGxlIGJpdCBJIHRo
aW5rLiBCdXQgTGVvbmFyZCBzdGF0ZWQgdGhlIGNhbGxlciBzaG91bGQga25vdyB0aGUgU0NVIEZX
IEFQSSdzIHVzYWdlLCBpZiBzbywgdGhlbiBJIHRoaW5rIHRoZSBzcGVjaWFsIGNhbGxlcnMgY2Fu
IGp1c3Qgc2tpcCB0aGUgcmV0dXJuIHZhbHVlIGNoZWNrLCBhZGRpbmcgYSBjb21tZW50IHRvIGRl
c2NyaWJlIHRoZSByZWFzb24sIHdvdWxkIGl0IGJlIG11Y2ggbW9yZSBlYXNpZXIgdGhhbiBjaGFu
Z2luZyB0aGUgaW14X3NjdV9jYWxsX3JwYygpPyBPciBhbnkgb3RoZXIgc3VnZ2VzdGlvbj8NCg0K
QW5zb24NCg0KPiBPbiAyNy4wOS4yMDE5IDEyOjA2LCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+ID4g
SGkgQW5zb24sIExlb25hcmQsDQo+ID4NCj4gPiBPbiAxOS0wOS0yNyAwMToyMCwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4+IEhpLCBMZW9uYXJkDQo+ID4+DQo+ID4+PiBPbiAyMDE5LTA5LTI2IDE6
MDYgUE0sIE1hcmNvIEZlbHNjaCB3cm90ZToNCj4gPj4+PiBPbiAxOS0wOS0yNiAwODowMywgQW5z
b24gSHVhbmcgd3JvdGU6DQo+ID4+Pj4+PiBPbiAxOS0wOS0yNSAxODowNywgQW5zb24gSHVhbmcg
d3JvdGU6DQo+ID4+Pj4+Pj4gVGhlIFNDVSBmaXJtd2FyZSBkb2VzIE5PVCBhbHdheXMgaGF2ZSBy
ZXR1cm4gdmFsdWUgc3RvcmVkIGluDQo+ID4+Pj4+Pj4gbWVzc2FnZSBoZWFkZXIncyBmdW5jdGlv
biBlbGVtZW50IGV2ZW4gdGhlIEFQSSBoYXMgcmVzcG9uc2UNCj4gPj4+Pj4+PiBkYXRhLCB0aG9z
ZSBzcGVjaWFsIEFQSXMgYXJlIGRlZmluZWQgYXMgdm9pZCBmdW5jdGlvbiBpbiBTQ1UNCj4gPj4+
Pj4+PiBmaXJtd2FyZSwgc28gdGhleSBzaG91bGQgYmUgdHJlYXRlZCBhcyByZXR1cm4gc3VjY2Vz
cyBhbHdheXMuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhf
c2NfcnBjX21zZyB3aGl0ZWxpc3RbXSA9IHsNCj4gPj4+Pj4+PiArCXsgLnN2YyA9IElNWF9TQ19S
UENfU1ZDX01JU0MsIC5mdW5jID0NCj4gPj4+Pj4+IElNWF9TQ19NSVNDX0ZVTkNfVU5JUVVFX0lE
IH0sDQo+ID4+Pj4+Pj4gKwl7IC5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDLCAuZnVuYyA9DQo+
ID4+Pj4+Pj4gK0lNWF9TQ19NSVNDX0ZVTkNfR0VUX0JVVFRPTl9TVEFUVVMgfSwgfTsNCj4gPj4+
Pj4+DQo+ID4+Pj4+PiBJcyB0aGlzIGdvaW5nIHRvIGJlIGV4dGVuZGVkIGluIHRoZSBuZWFyIGZ1
dHVyZT8gSSBzZWUgc29tZQ0KPiA+Pj4+Pj4gdXBjb21pbmcgcHJvYmxlbXMgaGVyZSBpZiBzb21l
b25lIHVzZXMgYSBkaWZmZXJlbnQNCj4gPj4+Pj4+IHNjdS1mdzwtPmtlcm5lbCBjb21iaW5hdGlv
biBhcyBueHAgd291bGQgc3VnZ2VzdC4NCj4gPj4+Pj4NCj4gPj4+Pj4gQ291bGQgYmUsIGJ1dCBJ
IGNoZWNrZWQgdGhlIGN1cnJlbnQgQVBJcywgT05MWSB0aGVzZSAyIHdpbGwgYmUNCj4gPj4+Pj4g
dXNlZCBpbiBMaW51eCBrZXJuZWwsIHNvIEkgT05MWSBhZGQgdGhlc2UgMiBBUElzIGZvciBub3cu
DQo+ID4+Pj4NCj4gPj4+PiBPa2F5Lg0KPiA+Pj4+DQo+ID4+Pj4+IEhvd2V2ZXIsIGFmdGVyIHJl
dGhpbmssIG1heWJlIHdlIHNob3VsZCBhZGQgYW5vdGhlciBpbXhfc2NfcnBjIEFQSQ0KPiA+Pj4+
PiBmb3IgdGhvc2Ugc3BlY2lhbCBBUElzPyBUbyBhdm9pZCBjaGVja2luZyBpdCBmb3IgYWxsIHRo
ZSBBUElzDQo+ID4+Pj4+IGNhbGxlZCB3aGljaA0KPiA+Pj4gbWF5IGltcGFjdCBzb21lIHBlcmZv
cm1hbmNlLg0KPiA+Pj4+PiBTdGlsbCB1bmRlciBkaXNjdXNzaW9uLCBpZiB5b3UgaGF2ZSBiZXR0
ZXIgaWRlYSwgcGxlYXNlIGFkdmlzZSwgdGhhbmtzIQ0KPiA+Pj4NCj4gPj4+IE15IHN1Z2dlc3Rp
b24gaXMgdG8gcmVmYWN0b3IgdGhlIGNvZGUgYW5kIGFkZCBhIG5ldyBBUEkgZm9yIHRoZSB0aGlz
DQo+ID4+PiAibm8gZXJyb3IgdmFsdWUiIGNvbnZlbnRpb24uIEludGVybmFsbHkgdGhleSBjYW4g
Y2FsbCBhIGNvbW1vbg0KPiA+Pj4gZnVuY3Rpb24gd2l0aCBmbGFncy4NCj4gPj4NCj4gPj4+PiBB
ZGRpbmcgYSBzcGVjaWFsIGFwaSBzaG91bGRuJ3QgYmUgdGhlIHJpZ2h0IGZpeC4gSW1hZ2luZSBp
ZiBzb21lb25lDQo+ID4+Pj4gKG5vdCBhIG54cC1kZXZlbG9wZXIpIHdhbnRzIHRvIGFkZCBhIG5l
dyBkcml2ZXIuIEhvdyBjb3VsZCBoZSBiZQ0KPiA+Pj4+IGV4cGVjdGVkIHRvIGtub3cgd2hpY2gg
YXBpIGhlIHNob3VsZCB1c2UuIFRoZSBiZXR0ZXIgYWJicm9hY2ggd291bGQNCj4gPj4+PiBiZSB0
byBmaXggdGhlIHNjdS1mdyBpbnN0ZWFkIG9mIGFkZGluZyBxdWlya3MuLg0KPiA+Pg0KPiA+PiBZ
ZXMsIGZpeGluZyBTQ1UgRlcgaXMgdGhlIGJlc3Qgc29sdXRpb24sIGJ1dCB3ZSBoYXZlIHRhbGtl
ZCB0byBTQ1UgRlcNCj4gPj4gb3duZXIsIHRoZSBTQ1UgRlcgcmVsZWFzZWQgaGFzIGJlZW4gZmlu
YWxpemVkLCBzbyB0aGUgQVBJDQo+ID4+IGltcGxlbWVudGF0aW9uIGNhbiBOT1QgYmUgY2hhbmdl
ZCwgYnV0IHRoZXkgd2lsbCBwYXkgYXR0ZW50aW9uIHRvDQo+ID4+IHRoaXMgaXNzdWUgZm9yIG5l
dyBhZGRlZCBBUElzIGxhdGVyLiBUaGF0IG1lYW5zIHRoZSBudW1iZXIgb2YgQVBJcyBoYXZpbmcN
Cj4gdGhpcyBpc3N1ZSBhIHZlcnkgbGltaXRlZC4NCj4gPg0KPiA+IFRoaXMgbWVhbnMgdGhvc2Ug
QVBJcyB3aGljaCBhbHJlYWR5IGhhdmUgdGhpcyBidWcgd2lsbCBub3QgYmUgZml4ZWQ/DQo+ID4g
SU1ITyB0aGlzIHNvdW5kcyBhIGJpdCB3ZWlyZCBzaW5jZSB0aGlzIGlzIGEgY2hhbmdlYWJsZSBw
ZWFjZSBvZiBjb2RlDQo+ID4gOykNCj4gDQo+IEl0J3Mgbm90IGEgYnVnLCBpdCdzIGEgZG9jdW1l
bnRlZCBmZWF0dXJlIDspDQo+IA0KPiA+Pj4gUmlnaHQgbm93IGRldmVsb3BlcnMgd2hvIHdhbnQg
dG8gbWFrZSBTQ0ZXIGNhbGxzIGluIHVwc3RyZWFtIG5lZWQgdG8NCj4gPj4+IGRlZmluZSB0aGUg
bWVzc2FnZSBzdHJ1Y3QgaW4gdGhlaXIgZHJpdmVyIGJhc2VkIG9uIHByb3RvY29sDQo+IGRvY3Vt
ZW50YXRpb24uDQo+ID4+PiBUaGlzIGluY2x1ZGVzOg0KPiA+Pj4NCj4gPj4+ICogQmluYXJ5IGxh
eW91dCBvZiB0aGUgbWVzc2FnZSAoYSBwYWNrZWQgc3RydWN0KQ0KPiA+Pj4gKiBJZiB0aGUgbWVz
c2FnZSBoYXMgYSByZXNwb25zZSAoYWxyZWFkeSBhIGJvb2wgZmxhZykNCj4gPj4+ICogSWYgYW4g
ZXJyb3IgY29kZSBpcyByZXR1cm5lZCAodGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIGl0KQ0K
PiA+DQo+ID4gV2h5IHNob3VsZCBJIHNwZWNpZnkgaWYgYSBlcnJvciBjb2RlIGlzIHJldHVybmVk
Pw0KPiANCj4gQmVjYXVzZSB5b3UncmUgYWxyZWFkeSBkZWZpbmluZyB0aGUgbWVzc2FnZSBzdHJ1
Y3QgYW5kIHlvdSdyZSBhbHJlYWR5DQo+IHNwZWNpZnlpbmcgaWYgYSByZXNwb25zZSBpcyByZXF1
aXJlZC4NCj4gDQo+IFRoZSBhc3N1bXB0aW9uIGlzIHRoYXQgYW55b25lIGFkZGluZyBhIFNDRlcg
Y2FsbCB0byBhIGRyaXZlciBpcyBhbHJlYWR5DQo+IGxvb2tpbmcgYXQgU0NGVyBkb2N1bWVudGF0
aW9uIHdoaWNoIGRlc2NyaWJlcyB0aGUgYmluYXJ5IG1lc3NhZ2UgZm9ybWF0Lg0KPiANCj4gLS0N
Cj4gUmVnYXJkcywNCj4gTGVvbmFyZA0K
