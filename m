Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169E8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE47C26B24
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="j0XbqT8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFCTxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:53:43 -0400
Received: from mail-eopbgr70090.outbound.protection.outlook.com ([40.107.7.90]:24349
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfFCTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BNzFMUgJjai20ENr4cV9FqDq6vBCbEYUtdITG1exhM=;
 b=j0XbqT8ZhLjOvPACzwlztp6EtSqgzozQH6OxOrHwp8V4G/TPiKTFFySs0nyf2Otd6ryfVpiwfmcZ5EoFzspS6MEj/vi1M17cu1ubNYky3vj6lhtEGfs5y3Ug91yFXY2qblgDNkf1ILL02dRsmaSpmgbTkNYqvTuIdEKmxemyNEo=
Received: from VI1PR10MB2639.EURPRD10.PROD.OUTLOOK.COM (20.178.126.80) by
 VI1PR10MB2510.EURPRD10.PROD.OUTLOOK.COM (20.177.59.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 19:53:36 +0000
Received: from VI1PR10MB2639.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8844:426d:816b:f5d5]) by VI1PR10MB2639.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8844:426d:816b:f5d5%6]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 19:53:36 +0000
From:   Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCH v3 0/6] soc/fsl/qe: cleanups and new DT binding
Thread-Topic: [PATCH v3 0/6] soc/fsl/qe: cleanups and new DT binding
Thread-Index: AQHVCX0WBepWBUryR0K8DhsVu6ZcHqaKeRAA
Date:   Mon, 3 Jun 2019 19:53:36 +0000
Message-ID: <e11c1e55-1e11-7ce3-3c0f-0b723ab260aa@prevas.se>
References: <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
 <20190513111442.25724-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190513111442.25724-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0309.eurprd05.prod.outlook.com
 (2603:10a6:7:93::40) To VI1PR10MB2639.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.186.118.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f27868fe-709b-411f-9666-08d6e85d2a68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR10MB2510;
x-ms-traffictypediagnostic: VI1PR10MB2510:
x-microsoft-antispam-prvs: <VI1PR10MB25108FE6C241FFDDF7475C668A140@VI1PR10MB2510.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39850400004)(199004)(189003)(44832011)(71446004)(53936002)(66066001)(25786009)(316002)(6246003)(14454004)(5660300002)(52116002)(486006)(4744005)(7416002)(110136005)(2616005)(446003)(6512007)(4326008)(2906002)(476003)(3846002)(6486002)(11346002)(54906003)(229853002)(6116002)(6436002)(73956011)(64756008)(8676002)(66476007)(102836004)(256004)(81166006)(305945005)(7736002)(76176011)(81156014)(86362001)(66556008)(31686004)(2501003)(72206003)(26005)(99286004)(71200400001)(8936002)(66446008)(478600001)(74482002)(71190400001)(31696002)(68736007)(186003)(386003)(6506007)(36756003)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2510;H:VI1PR10MB2639.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bHHqEOSKRRdFRJUk0NLOMa/EJxHT58PIMySffURmEJMakwrQPeGBgTuYHJSMFP73/2xz4zMYbQg0ji4nU5ab8Wk/Ry6F+Mxo8jhHscg4xsYrVzwB+O9VYwRcL3SC+jhi6cQ4S9fVRx0IddBgJmmOeUVtfO/HfPYvdcTwPHGqQzLT66wzCZxQBfiqUiD6/p9i9MVYLV5uoM0NG73Efiyoq0ZOHorQ707etMWcBrPe9T7nTVstNfLlT89023M4Djg/ElNEp9BPVra5uS0O8wGlKTlq9QSBEP0TFs8p0fpss5afR7rmY1jf/b3t6wcq1kA063ziCv2l/pjB4lsYgw19UJb+0DXE8kB/enr9YVoRnJl7BnCpz+rkI5500ClTk0DNBzyCxbFjfb64PsRsiaYydQwCTx4hP1JlJ0hfUm1Bee0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <623556BC6EE58D43987924910752EF6D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f27868fe-709b-411f-9666-08d6e85d2a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 19:53:36.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rasmus.Villemoes@prevas.dk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDUvMjAxOSAxMy4xNCwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4gVGhpcyBzbWFs
bCBzZXJpZXMgY29uc2lzdHMgb2Ygc29tZSBzbWFsbCBjbGVhbnVwcyBhbmQgc2ltcGxpZmljYXRp
b25zDQo+IG9mIHRoZSBRVUlDQyBlbmdpbmUgZHJpdmVyLCBhbmQgaW50cm9kdWNlcyBhIG5ldyBE
VCBiaW5kaW5nIHRoYXQgbWFrZXMNCj4gaXQgbXVjaCBlYXNpZXIgdG8gc3VwcG9ydCBvdGhlciB2
YXJpYW50cyBvZiB0aGUgUVVJQ0MgZW5naW5lIElQIGJsb2NrDQo+IHRoYXQgYXBwZWFycyBpbiB0
aGUgd2lsZDogVGhlcmUncyBubyByZWFzb24gdG8gZXhwZWN0IGluIGdlbmVyYWwgdGhhdA0KPiB0
aGUgbnVtYmVyIG9mIHZhbGlkIFNOVU1zIHVuaXF1ZWx5IGRldGVybWluZXMgdGhlIHNldCBvZiBz
dWNoLCBzbyBpdCdzDQo+IGJldHRlciB0byBzaW1wbHkgbGV0IHRoZSBkZXZpY2UgdHJlZSBzcGVj
aWZ5IHRoZSB2YWx1ZXMgKGFuZCwNCj4gaW1wbGljaXRseSB2aWEgdGhlIGFycmF5IGxlbmd0aCwg
YWxzbyB0aGUgY291bnQpLg0KPiANCj4gV2hpY2ggdHJlZSBzaG91bGQgdGhpcyBnbyB0aHJvdWdo
Pw0KDQpQaW5nPyBUaGVzZSBwYXRjaGVzIHNob3VsZCBiZSByZWFkeSB0byBnbyBpbiwgYnV0IEkg
ZG9uJ3Qga25vdyB3aG8gaXMNCnN1cHBvc2VkIHRvIHBpY2sgdGhlbSB1cC4NCg0KVGhhbmtzLA0K
UmFzbXVzDQo=
