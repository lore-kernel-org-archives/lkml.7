Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97082C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535CC207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SSVxy7Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfI0J1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:27:47 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:10419
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfI0J1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:27:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJE4X238/k6xSETN6OySj08CPBr7bq2eERxApAplEKgueqRv0IL0/RE0CvN4LahgcUVrC5zEiY9De3qo4jUQ8B3gYBD+r/eEy0PhJwItEDCen83JbQt9/XusSI8uxntU00nt/P1PsdWbZt/9dhFhV/51SbUWh9wpek9V/bxCB8vITc2N5HkPWMVlfpv/grCdHmtFi4lGYIlVp2PklDs3MpQytvNLIqsKBbvPudZSaefNy1faIyy/DuaQr4H00ySWtAnX9tuj7xTCS+cDmztjDThtDSBZTdgkEDB4hEF1lQVt+udSMC3MvQYO1bw6GvoIadd7gkcPtOtryn0RIZUu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzjXXP5fNfhxdwQJR454GPRrg3qmYBOoBArY/dHaitI=;
 b=ChvSQufEvAabGnKGHkZrZpFEswYIPSY24uyMgVV2XnL6jzPQTuKXLGG5Q0ObQ+GuRtDL69WToOHZD+0W+rOZH/YzfKdu1EgxCY+7Bh6eq9JSqq9X7TP6HIUZJgU+s7lmYVheIwk1afylH8Z3K9unjOt0mV3AFfRGxnvXgMmCEUtRPl0e8DnWSMYCztFFJvB4URL3paGpeg95UpJHbYO714w2c34OHd7G0EeqpdJn0X8e4/RXcxzJvPn8rMuTXjKm0n+9VEZ4bmxDCemYXUZL0Qh8KAyKA1un8VK1I05DPRMepGzmjOJhLzM5r+qrMkq3uf0fOvvNoqjCoOBuJIg0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzjXXP5fNfhxdwQJR454GPRrg3qmYBOoBArY/dHaitI=;
 b=SSVxy7Z4gMjgDcZm9J9btoDemnNT0v9qcEbll7Gm6ShNEen5k2bu6JuknAkoRC4GSeUZc7qKCNxkTbd6ZON2lG7vBG1knBd8Pp/FzGvcSsuPitf9ioDKFR2BpUmYS2exQp7GZUdEHTeE4oKdgS35QKxfaJXRzzAqWkmwWRxCqI0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Fri, 27 Sep 2019 09:27:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 09:27:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHVc4lT/ErvPybCJUCbZ2x7mLGjsqc+tdHggACItoCAAATDMA==
Date:   Fri, 27 Sep 2019 09:27:43 +0000
Message-ID: <DB3PR0402MB3916C99B60D4F7843CAB9C43F5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
 <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190927090609.fyxdekkzrco7memt@pengutronix.de>
In-Reply-To: <20190927090609.fyxdekkzrco7memt@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2a61edb-6d7e-4e9b-7a4c-08d7432cf35b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3947;
x-ms-traffictypediagnostic: DB3PR0402MB3947:|DB3PR0402MB3947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB394738FE266A1DF6D47C3674F5810@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(33656002)(7736002)(99286004)(4326008)(55016002)(66946007)(52536014)(25786009)(305945005)(66476007)(66556008)(66446008)(64756008)(6246003)(446003)(7696005)(81156014)(2906002)(86362001)(14454004)(81166006)(9686003)(76176011)(6506007)(26005)(53546011)(11346002)(102836004)(8936002)(3846002)(76116006)(186003)(6116002)(8676002)(74316002)(486006)(478600001)(44832011)(71200400001)(71190400001)(54906003)(256004)(316002)(6436002)(476003)(6916009)(5660300002)(229853002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s7q7E9naMGg/h66KWEfFIMDFuOC9epwrl609VmNwH/qDEOGaJyQafOfymj6ULl3ll2JdCG9ujJJF6THK+RslWgJQJmlcmwYBlxcS9C/zvW/Hq1+SDPDcaLGaCj1XlR51qi4pY3qTMICgEcKQpyJZiCBwSZOVDy9/p/yHm5J1bt2iUyhnym9ZIxskqDXM11BQHRcuv2u50jrTQRm9Tr1QqlNy31RIWObkppNzF1erhXFiBJIwLMDwW/Se4mLHss0wMKXH1b50pIveJjF2utQDDu2OUjf45uldYENxlmN7Xe9zHnjlkDyv1yJHHabg3e11VHBzMWuUr4NJZZ17bxSSnYbzawrd0cPfmRTVQWIqv3GjsopMAvqTudRguN/8YxU4meWk9R9M2TZRQae0TGr3fdq/qodc3Yo2XfchWyBALLY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a61edb-6d7e-4e9b-7a4c-08d7432cf35b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 09:27:43.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opUbC4mH2LkJGohKcp1d9ZiS+T4pZivXE1XaxaYNzPqMIsaXcEav0X6hZ2fswKjvW0rmC8B944FAzty3iY/y8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoNCj4gT24gMTktMDktMjcgMDE6MjAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
IEhpLCBMZW9uYXJkDQo+ID4NCj4gPiA+IE9uIDIwMTktMDktMjYgMTowNiBQTSwgTWFyY28gRmVs
c2NoIHdyb3RlOg0KPiA+ID4gPiBPbiAxOS0wOS0yNiAwODowMywgQW5zb24gSHVhbmcgd3JvdGU6
DQo+ID4gPiA+Pj4gT24gMTktMDktMjUgMTg6MDcsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+ID4g
Pj4+PiBUaGUgU0NVIGZpcm13YXJlIGRvZXMgTk9UIGFsd2F5cyBoYXZlIHJldHVybiB2YWx1ZSBz
dG9yZWQgaW4NCj4gPiA+ID4+Pj4gbWVzc2FnZSBoZWFkZXIncyBmdW5jdGlvbiBlbGVtZW50IGV2
ZW4gdGhlIEFQSSBoYXMgcmVzcG9uc2UNCj4gPiA+ID4+Pj4gZGF0YSwgdGhvc2Ugc3BlY2lhbCBB
UElzIGFyZSBkZWZpbmVkIGFzIHZvaWQgZnVuY3Rpb24gaW4gU0NVDQo+ID4gPiA+Pj4+IGZpcm13
YXJlLCBzbyB0aGV5IHNob3VsZCBiZSB0cmVhdGVkIGFzIHJldHVybiBzdWNjZXNzIGFsd2F5cy4N
Cj4gPiA+ID4+Pj4NCj4gPiA+ID4+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3NjX3JwY19t
c2cgd2hpdGVsaXN0W10gPSB7DQo+ID4gPiA+Pj4+ICsJeyAuc3ZjID0gSU1YX1NDX1JQQ19TVkNf
TUlTQywgLmZ1bmMgPQ0KPiA+ID4gPj4+IElNWF9TQ19NSVNDX0ZVTkNfVU5JUVVFX0lEIH0sDQo+
ID4gPiA+Pj4+ICsJeyAuc3ZjID0gSU1YX1NDX1JQQ19TVkNfTUlTQywgLmZ1bmMgPQ0KPiA+ID4g
Pj4+PiArSU1YX1NDX01JU0NfRlVOQ19HRVRfQlVUVE9OX1NUQVRVUyB9LCB9Ow0KPiA+ID4gPj4+
DQo+ID4gPiA+Pj4gSXMgdGhpcyBnb2luZyB0byBiZSBleHRlbmRlZCBpbiB0aGUgbmVhciBmdXR1
cmU/IEkgc2VlIHNvbWUNCj4gPiA+ID4+PiB1cGNvbWluZyBwcm9ibGVtcyBoZXJlIGlmIHNvbWVv
bmUgdXNlcyBhIGRpZmZlcmVudA0KPiA+ID4gPj4+IHNjdS1mdzwtPmtlcm5lbCBjb21iaW5hdGlv
biBhcyBueHAgd291bGQgc3VnZ2VzdC4NCj4gPiA+ID4+DQo+ID4gPiA+PiBDb3VsZCBiZSwgYnV0
IEkgY2hlY2tlZCB0aGUgY3VycmVudCBBUElzLCBPTkxZIHRoZXNlIDIgd2lsbCBiZQ0KPiA+ID4g
Pj4gdXNlZCBpbiBMaW51eCBrZXJuZWwsIHNvIEkgT05MWSBhZGQgdGhlc2UgMiBBUElzIGZvciBu
b3cuDQo+ID4gPiA+DQo+ID4gPiA+IE9rYXkuDQo+ID4gPiA+DQo+ID4gPiA+PiBIb3dldmVyLCBh
ZnRlciByZXRoaW5rLCBtYXliZSB3ZSBzaG91bGQgYWRkIGFub3RoZXIgaW14X3NjX3JwYw0KPiA+
ID4gPj4gQVBJIGZvciB0aG9zZSBzcGVjaWFsIEFQSXM/IFRvIGF2b2lkIGNoZWNraW5nIGl0IGZv
ciBhbGwgdGhlIEFQSXMNCj4gPiA+ID4+IGNhbGxlZCB3aGljaA0KPiA+ID4gbWF5IGltcGFjdCBz
b21lIHBlcmZvcm1hbmNlLg0KPiA+ID4gPj4gU3RpbGwgdW5kZXIgZGlzY3Vzc2lvbiwgaWYgeW91
IGhhdmUgYmV0dGVyIGlkZWEsIHBsZWFzZSBhZHZpc2UsIHRoYW5rcyENCj4gPiA+DQo+ID4gPiBN
eSBzdWdnZXN0aW9uIGlzIHRvIHJlZmFjdG9yIHRoZSBjb2RlIGFuZCBhZGQgYSBuZXcgQVBJIGZv
ciB0aGUgdGhpcw0KPiA+ID4gIm5vIGVycm9yIHZhbHVlIiBjb252ZW50aW9uLiBJbnRlcm5hbGx5
IHRoZXkgY2FuIGNhbGwgYSBjb21tb24NCj4gPiA+IGZ1bmN0aW9uIHdpdGggZmxhZ3MuDQo+ID4N
Cj4gPiBJZiBJIHVuZGVyc3RhbmQgeW91ciBwb2ludCBjb3JyZWN0bHksIHRoYXQgbWVhbnMgdGhl
IGxvb3AgY2hlY2sgb2YNCj4gPiB3aGV0aGVyIHRoZSBBUEkgaXMgd2l0aCAibm8gZXJyb3IgdmFs
dWUiIGZvciBldmVyeSBBUEkgc3RpbGwgTk9UIGJlDQo+ID4gc2tpcHBlZCwgaXQgaXMganVzdCBy
ZWZhY3RvcmluZyB0aGUgY29kZSwgcmlnaHQ/DQo+IA0KPiBIb3cgbWFrZXMgdGhpcyB0aGluZ3Mg
ZWFzaWVyPw0KDQpJIHRoaW5rIGl0IGlzIGp1c3QgZm9yIG1ha2luZyBhIGJldHRlciBTVyBsYXll
ci4NCg0KPiANCj4gPiA+ID4gQWRkaW5nIGEgc3BlY2lhbCBhcGkgc2hvdWxkbid0IGJlIHRoZSBy
aWdodCBmaXguIEltYWdpbmUgaWYNCj4gPiA+ID4gc29tZW9uZSAobm90IGEgbnhwLWRldmVsb3Bl
cikgd2FudHMgdG8gYWRkIGEgbmV3IGRyaXZlci4gSG93IGNvdWxkDQo+ID4gPiA+IGhlIGJlIGV4
cGVjdGVkIHRvIGtub3cgd2hpY2ggYXBpIGhlIHNob3VsZCB1c2UuIFRoZSBiZXR0ZXINCj4gPiA+
ID4gYWJicm9hY2ggd291bGQgYmUgdG8gZml4IHRoZSBzY3UtZncgaW5zdGVhZCBvZiBhZGRpbmcg
cXVpcmtzLi4NCj4gPg0KPiA+IFllcywgZml4aW5nIFNDVSBGVyBpcyB0aGUgYmVzdCBzb2x1dGlv
biwgYnV0IHdlIGhhdmUgdGFsa2VkIHRvIFNDVSBGVw0KPiA+IG93bmVyLCB0aGUgU0NVIEZXIHJl
bGVhc2VkIGhhcyBiZWVuIGZpbmFsaXplZCwgc28gdGhlIEFQSQ0KPiA+IGltcGxlbWVudGF0aW9u
IGNhbiBOT1QgYmUgY2hhbmdlZCwgYnV0IHRoZXkgd2lsbCBwYXkgYXR0ZW50aW9uIHRvIHRoaXMN
Cj4gPiBpc3N1ZSBmb3IgbmV3IGFkZGVkIEFQSXMgbGF0ZXIuIFRoYXQgbWVhbnMgdGhlIG51bWJl
ciBvZiBBUElzIGhhdmluZyB0aGlzDQo+IGlzc3VlIGEgdmVyeSBsaW1pdGVkLg0KPiANCj4gVGhp
cyBtZWFucyB0aG9zZSBBUElzIHdoaWNoIGFscmVhZHkgaGF2ZSB0aGlzIGJ1ZyB3aWxsIG5vdCBi
ZSBmaXhlZD8NCj4gSU1ITyB0aGlzIHNvdW5kcyBhIGJpdCB3ZWlyZCBzaW5jZSB0aGlzIGlzIGEg
Y2hhbmdlYWJsZSBwZWFjZSBvZiBjb2RlIDspDQoNCldlIGNhbid0IHNheSBpdCBpcyBhIGJ1Zywg
dGhlIFNDVSBGVyBvd25lciBkZXNpZ24gaXQgaW4gdGhpcyB3YXksIHRoZXJlIGFyZQ0Kc29tZSB2
b2lkIGZ1bmN0aW9uIGluIFNDVSBGVyBBUEksIGFuZCBvbmNlIHRoZXJlIGlzIHJlc3BvbnNlIGRh
dGEgZnJvbSBTQ1UsDQp0aGF0IG1lYW5zIHRoZSBBUEkgY2FsbCBpcyBzdWNjZXNzZnVsLCBhbmQg
dm9pZCBmdW5jdGlvbiBkb2VzIE5PVCBoYXZlIGEgcmV0dXJuDQp2YWx1ZSBmb3IgY2FsbGVyLg0K
U28gaXQgaXMganVzdCBjdXJyZW50IFNDVSBJUEMgZHJpdmVyIGluIGtlcm5lbCBOT1QgMTAwJSBt
YXRjaGluZyBTQ1UgRlcsIHRob3NlDQp2b2lkIGZ1bmN0aW9uIGhhcyBzdWNoIHJldHVybiB2YWx1
ZSBpc3N1ZS4NCg0KQW5zb24uDQo=
