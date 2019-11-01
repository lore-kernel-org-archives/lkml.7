Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9B2CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2525B2086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="BH2vruoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfKAKDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:03:25 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:59945 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbfKAKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:03:24 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 06:03:22 EDT
IronPort-SDR: fpAfgNYmekzmA5Hs3sXzEoar/SivzpCyGjOJ2ZIpNySNoLOzxj+ZN6zi+YeZDC7aEbVlHczzZZ
 qCGGdga9utKYPFVGBdAb0TthyFS16hNPdoF3WnUgSaQ9MFdLUBqLMJz7XyInJTDP2bUgaZkcuK
 FCC8T6GIpi23fWHevaAmhP0wEOftyFA/0jq1sclCyTRasnRYc2rXSmPGVjqw0LSPugdtQGCh/7
 VqphpeyXSFF9Y016XnqSeyLYZ2P78Kf85/4A4NhiOmBMfh/pRC/w+gM1DMq6ucFUpnNGm0ggx5
 NUE=
X-IronPort-AV: E=McAfee;i="6000,8403,9427"; a="15546854"
X-IronPort-AV: E=Sophos;i="5.68,254,1569250800"; 
   d="scan'208";a="15546854"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 01 Nov 2019 18:56:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmiCJ3kiSltUAJY1TXQ//MH1SWapHyS2tVxlGHeCRC9mF+fFZDM6cag0LOjGb2laGMMtXiRHvOBEto7HE9vXLiRppwPFLE6pjokEU7psBVBEOKBOFHe1GugN4junrmLyZE1bzMpj0eXYWPrmY1F6bVjhRAo/HfhrDzrYIGreYTL+OXwr6m01CoGAIF1bqVuusmvg3y3iK/R/fDtCV0vpdrdBemxGykuOLhmddPEkYlAHhkqfArpgkjRVCr/Uhx/YcLN8+cXeadhcO8opAQYLHj9W5cKMEpvC0x6cAQDvzk0opOTFbV6cphavLL/wTXuojeBDeXkd3ocZaBfcs3Tlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeRHjfNrL9B5OfN89QxebMEJWkuCAk2e2cr1fZNbkUY=;
 b=WD96+dTRD84CIIhfZ5vrrGdkK8ADhGPQxZfa9oDiccWJXYfNMJTJGAkW3wE60KYHgjDR7lYSEv94JGqs30rlWCmjjXTfNlj7MWfrIBSzUvnMncobd277GEWBWCUFuWylTLTNOi9u0OHyenaTKemGhTvfsWXkFJyGZ014bWmTyDdyVEMYvpeJ22L41h2M4li5VOeYlLkATHRaJk0IQz/CRItLt9SPvYip5wWNafQTkwfQRZXSNWJUGuWs7d5Z+863LfMjvIWvTrEW4Bh5C34jdlOq9Kor9/F2veLhDO6w8j0jZvqbdOKEbeUzvaXaaiwpDSo3cjRlbyxz9zOb4U1fzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeRHjfNrL9B5OfN89QxebMEJWkuCAk2e2cr1fZNbkUY=;
 b=BH2vruoWod1vusfqFwu8DctajE/f6CNOZELTOMLVrIfPQ4z13I7D8N2p5H3tE1aj7ebCNZc3zT5QIE8muzw07o6IxHA+Dswq5O35hJfvKIlrQ/RMYzqmD5BARTQHCipG73tjyPoggRXhv1kEK6kmsGvBM8FmSQwsch8meHrRlPg=
Received: from OSBPR01MB3653.jpnprd01.prod.outlook.com (20.178.97.18) by
 OSBPR01MB5175.jpnprd01.prod.outlook.com (20.179.181.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Fri, 1 Nov 2019 09:56:05 +0000
Received: from OSBPR01MB3653.jpnprd01.prod.outlook.com
 ([fe80::d02e:9620:ee4:de50]) by OSBPR01MB3653.jpnprd01.prod.outlook.com
 ([fe80::d02e:9620:ee4:de50%4]) with mapi id 15.20.2408.019; Fri, 1 Nov 2019
 09:56:05 +0000
From:   "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Jon Masters <jcm@jonmasters.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "indou.takao@fujitsu.com" <indou.takao@fujitsu.com>,
        "maeda.naoaki@fujitsu.com" <maeda.naoaki@fujitsu.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        "tokamoto@jp.fujitsu.com" <tokamoto@jp.fujitsu.com>
Subject: Re: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Thread-Topic: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Thread-Index: AQHVJRmVihUXsBTsv0iIDHwIrvWdbKd26vQA
Date:   Fri, 1 Nov 2019 09:56:05 +0000
Message-ID: <93009dbd-b31c-7364-86d2-21f0fac36676@jp.fujitsu.com>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
In-Reply-To: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qi.fuli@fujitsu.com; 
x-originating-ip: [211.13.147.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff01006b-9784-41e9-5c79-08d75eb1b60d
x-ms-traffictypediagnostic: OSBPR01MB5175:|OSBPR01MB5175:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <OSBPR01MB5175F31E5990FBAD1304DAA8F7620@OSBPR01MB5175.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(51914003)(189003)(199004)(14454004)(54906003)(76116006)(91956017)(110136005)(66946007)(7736002)(81166006)(81156014)(305945005)(476003)(66556008)(64756008)(66476007)(66446008)(3846002)(6116002)(8676002)(11346002)(8936002)(186003)(26005)(76176011)(99286004)(86362001)(316002)(6506007)(446003)(31696002)(53546011)(102836004)(107886003)(85182001)(478600001)(31686004)(2906002)(6246003)(6436002)(66066001)(4326008)(486006)(25786009)(14444005)(2501003)(966005)(71190400001)(71200400001)(6306002)(5660300002)(256004)(229853002)(6486002)(6512007)(777600001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB5175;H:OSBPR01MB3653.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQVWh14TOt1/MS85b+poalc03TPsnxq6qdLYnUfv622w21U0cqY6XWA86IDMtMH94lORxCyqaHQw2kmRN85/x2YHNVHWe69WEqGZeYymiYH4Z/9VxGcDP1qQE5TKFmVAg8euL9ANMLCRhahWDm3yJpfz/6s0nQohAHq3cw8I8512YFAdvKCK6tUtcAO0B2zTqW7dNBO6XonRkSQredKk4/UBoX6Z4tcWm1OhjMFuZYnEVv+t0bAPN/kk8rVQrSb//uiIZVuoCXIUnyLCqkVI0RKFyqpgXMVIk93mG4gjoQgEhbK7tUd9r3r0+tfmbxQwqQgNGALfeh5qUrYol5Al/H56w0eR6fWNh6XD56wNgCMd7jPJMU1QUIaxsVe7voxBor9xstDPyl7b6Bpfe1a+FKsMmlLDdngytmwGohy7QmRwINUujztc9YR0u790MQVI1IjBCPhcYS4byoRlVTT0RZgzpPHV6JqRST8pQrFWNJw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD601C4E61A0204F9BCE39661D0CD546@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff01006b-9784-41e9-5c79-08d75eb1b60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 09:56:05.1196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAHXgp2QZ4EN609PZ0vfzmVZ9TFOP0NlfUsKT5r7TblJDvziXC7zlYS/4KQvhhg64dt06ER8+Q+dzVae6ZH4EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkZpcnN0IG9mIGFsbCB0aGFua3MgZm9yIHRoZSBjb21tZW50cyBmb3IgdGhlIHBhdGNo
Lg0KDQpJJ20gc3RpbGwgc3RydWdnbGluZyB3aXRoIHRoaXMgcHJvYmxlbSB0byBmaW5kIG91dCB0
aGUgc29sdXRpb24uDQpBcyBhIHJlc3VsdCBvZiBhbiBpbnZlc3RpZ2F0aW9uIG9uIHRoaXMgcHJv
YmxlbSwgYWZ0ZXIgYWxsLCBJIHRoaW5rIGl0IA0KaXMgbmVjZXNzYXJ5IHRvIGltcHJvdmUgVExC
IGZsdXNoIG1lY2hhbmlzbSBvZiB0aGUga2VybmVsIHRvIGZpeCB0aGlzIA0KcHJvYmxlbSBjb21w
bGV0ZWx5Lg0KDQpTbywgSSdkIGxpa2UgdG8gcmVzdGFydCBhIGRpc2N1c3Npb24uIEF0IGZpcnN0
LCBJIHN1bW1hcml6ZSB0aGlzIHByb2JsZW0gDQp0byByZWNhbGwgd2hhdCB3YXMgdGhlIHByb2Js
ZW0gYW5kIHRoZW4gSSB3YW50IHRvIGRpc2N1c3MgaG93IHRvIGZpeCBpdC4NCg0KU3VtbWFyeSBv
ZiB0aGUgcHJvYmxlbToNCkEgZmV3IG1vbnRocyBhZ28gSSBwcm9wb3NlZCBwYXRjaGVzIHRvIHNv
bHZlIGEgcGVyZm9ybWFuY2UgcHJvYmxlbSBkdWUgDQp0byBUTEIgZmx1c2guWzFdDQoNCkEgcHJv
YmxlbSBpcyB0aGF0IFRMQiBmbHVzaCBvbiBhIGNvcmUgYWZmZWN0cyBhbGwgb3RoZXIgY29yZXMg
ZXZlbiBpZiANCmFsbCBvdGhlciBjb3JlcyBkbyBub3QgbmVlZCBhY3R1YWwgZmx1c2gsIGFuZCBp
dCBjYXVzZXMgcGVyZm9ybWFuY2UgDQpkZWdyYWRhdGlvbi4NCg0KSW4gdGhpcyB0aHJlYWQsIEkg
ZXhwbGFpbmVkIHRoYXQ6DQoqIEkgZm91bmQgYSBwZXJmb3JtYW5jZSBwcm9ibGVtIHdoaWNoIGlz
IGNhdXNlZCBieSBUTEJJLWlzIGluc3RydWN0aW9uLg0KKiBUaGUgcHJvYmxlbSBvY2N1cnMgbGlr
ZSB0aGlzOg0KICAxKSBPbiBhIGNvcmUsIE9TIHRyaWVzIHRvIGZsdXNoIFRMQiB1c2luZyBUTEJJ
LWlzIGluc3RydWN0aW9uDQogIDIpIFRMQkktaXMgaW5zdHJ1Y3Rpb24gY2F1c2VzIGEgYnJvYWRj
YXN0IHRvIGFsbCBvdGhlciBjb3JlcywgYW5kDQogIGVhY2ggY29yZSByZWNlaXZlZCBoYXJkLXdp
cmVkIHNpZ25hbA0KICAzKSBFYWNoIGNvcmUgY2hlY2sgaWYgdGhlcmUgYXJlIFRMQiBlbnRyaWVz
IHdoaWNoIGhhdmUgdGhlIHNwZWNpZmllZCANCkFTSUQvVkENCiAgNCkgVGhpcyBjaGVjayBjYXVz
ZXMgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24NCiogV2UgcmFuIEZXUVsyXSBhbmQgZGV0ZWN0ZWQg
T1Mgaml0dGVyIGR1ZSB0byB0aGlzIHByb2JsZW0sIHRoaXMgbm9pc2UNCiAgaXMgc2VyaW91cyBm
b3IgSFBDIHVzYWdlLg0KDQpUaGUgbm9pc2UgbWVhbnMgaGVyZSBhIGRpZmZlcmVuY2UgYmV0d2Vl
biBtYXhpbXVtIHRpbWUgYW5kIG1pbmltdW0gdGltZSANCndoaWNoIHRoZSBzYW1lIHdvcmsgdGFr
ZXMuDQoNCkhvdyB0byBmaXg6DQpJIHRoaW5rIHRoZSBjYXVzZSBpcyBUTEIgZmx1c2ggYnkgVExC
SS1pcyBiZWNhdXNlIHRoZSBpbnN0cnVjdGlvbiANCmFmZmVjdHMgY29yZXMgdGhhdCBhcmUgbm90
IHJlbGF0ZWQgdG8gaXRzIGZsdXNoLg0KDQpTbyB0aGUgcHJldmlvdXMgcGF0Y2ggSSBwb3N0ZWQg
aXMNCiogVXNlIG1tX2NwdW1hc2sgaW4gbW1fc3RydWN0IHRvIGZpbmQgYXBwcm9wcmlhdGUgQ1BV
cyBmb3IgVExCIGZsdXNoDQoqIEV4ZWMgVExCSSBpbnN0ZWFkIG9mIFRMQkktaXMgb25seSB0byBD
UFVzIHNwZWNpZmllZCBieSBtbV9jcHVtYXNrDQogIChUaGlzIGlzIHRoZSBzYW1lIGJlaGF2aW9y
IGFzIGFybTMyIGFuZCB4ODYpDQoNCkFuZCBhZnRlciB0aGUgZGlzY3Vzc2lvbiBhYm91dCB0aGlz
IHBhdGNoLCBJIGdvdCB0aGUgZm9sbG93aW5nIGNvbW1lbnRzLg0KMSkgVGhpcyBwYXRjaCBzd2l0
Y2hlcyB0aGUgYmVoYXZpb3IgKG9yaWdpbmFsIGZsdXNoIGJ5IFRMQkktaXMgYW5kIG5ldyANCmZs
dXNoIGJ5IFRMQkkpIGJ5IGJvb3QgcGFyYW1ldGVyLCB0aGlzIGltcGxlbWVudGF0aW9uIGlzIG5v
dCBhY2NlcHRhYmxlIA0KZHVlIHRvIGJhZCBtYWludGFpbmFiaWxpdHkuDQoyKSBFdmVuIGlmIHRo
aXMgcGF0Y2ggZml4ZXMgdGhpcyBwcm9ibGVtLCBpdCBtYXkgY2F1c2UgYW5vdGhlciANCnBlcmZv
cm1hbmNlIHByb2JsZW0uDQoNCkknZCBsaWtlIHRvIHN0YXJ0IG92ZXIgdGhlIGltcGxlbWVudGF0
aW9uIGJ5IGNvbnNpZGVyaW5nIHRoZXNlIHBvaW50cy4NCkZvciB0aGUgc2Vjb25kIGNvbW1lbnQg
YWJvdmUsIEkgd2lsbCBydW4gYSBiZW5jaG1hcmsgdGVzdCB0byBhbmFseXplIHRoZSANCmltcGFj
dCBvbiBwZXJmb3JtYW5jZS4NClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgb3RoZXIg
cG9pbnRzIEkgc2hvdWxkIHRha2UgaW50byANCmNvbnNpZGVyYXRpb24uDQoNClsxXSBodHRwczov
L2xrbWwub3JnL2xrbWwvMjAxOS82LzE3LzcwMw0KWzJdIGh0dHBzOi8vYXNjLmxsbmwuZ292L3Nl
cXVvaWEvYmVuY2htYXJrcy9GVFFfc3VtbWFyeV92MS4xLnBkZg0KDQpUaGFua3MsDQpRSSBGdWxp
DQoNCg0KT24gNi8xNy8xOSAxMTozMiBQTSwgVGFrYW8gSW5kb2ggd3JvdGU6DQo+IEZyb206IFRh
a2FvIEluZG9oIDxpbmRvdS50YWthb0BmdWppdHN1LmNvbT4NCj4gDQo+IEkgZm91bmQgYSBwZXJm
b3JtYW5jZSBpc3N1ZSByZWxhdGVkIG9uIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBMaW51eCdzIFRM
Qg0KPiBmbHVzaCBmb3IgYXJtNjQuDQo+IA0KPiBXaGVuIEkgcnVuIGEgc2luZ2xlLXRocmVhZGVk
IHRlc3QgcHJvZ3JhbSBvbiBtb2RlcmF0ZSBlbnZpcm9ubWVudCwgaXQNCj4gdXN1YWxseSB0YWtl
cyAzOW1zIHRvIGZpbmlzaCBpdHMgd29yay4gSG93ZXZlciwgd2hlbiBJIHB1dCBhIHNtYWxsDQo+
IGFwcHJpY2F0aW9uLCB3aGljaCBqdXN0IGNhbGxzIG1wcm90ZXN0KCkgY29udGludW91c2x5LCBv
biBvbmUgb2Ygc2libGluZw0KPiBjb3JlcyBhbmQgcnVuIGl0IHNpbXVsdGFuZW91c2x5LCB0aGUg
dGVzdCBwcm9ncmFtIHNsb3dzIGRvd24gc2lnbmlmaWNhbnRseS4NCj4gSXQgYmVjb21lcyA0OW1z
KDEyNSUpIG9uIFRodW5kZXJYMi4gSSBhbHNvIGRldGVjdGVkIHRoZSBzYW1lIHByb2JsZW0gb24N
Cj4gVGh1bmRlclgxIGFuZCBGdWppdHN1IEE2NEZYLg0KPiANCj4gSSBzdXBwb3NlIHRoZSByb290
IGNhdXNlIG9mIHRoaXMgaXNzdWUgaXMgdGhlIGltcGxlbWVudGF0aW9uIG9mIExpbnV4J3MgVExC
DQo+IGZsdXNoIGZvciBhcm02NCwgZXNwZWNpYWxseSB1c2Ugb2YgVExCSS1pcyBpbnN0cnVjdGlv
biB3aGljaCBpcyBhIGJyb2FkY2FzdA0KPiB0byBhbGwgcHJvY2Vzc29yIGNvcmUgb24gdGhlIHN5
c3RlbS4gSW4gY2FzZSBvZiB0aGUgYWJvdmUgc2l0dWF0aW9uLA0KPiBUTEJJLWlzIGlzIGNhbGxl
ZCBieSBtcHJvdGVjdCgpLg0KPiANCj4gVGhpcyBpcyBub3QgYSBwcm9ibGVtIGZvciBzbWFsbCBl
bnZpcm9ubWVudCwgYnV0IHRoaXMgY2F1c2VzIGEgc2lnbmlmaWNhbnQNCj4gcGVyZm9ybWFuY2Ug
bm9pc2UgZm9yIGxhcmdlLXNjYWxlIEhQQyBlbnZpcm9ubWVudCwgd2hpY2ggaGFzIG1vcmUgdGhh
bg0KPiB0aG91c2FuZCBub2RlcyB3aXRoIGxvdyBsYXRlbmN5IGludGVyY29ubmVjdC4NCj4gDQo+
IFRvIGZpeCB0aGlzIHByb2JsZW0sIHRoaXMgcGF0Y2ggYWRkcyBuZXcgYm9vdCBwYXJhbWV0ZXIN
Cj4gJ2Rpc2FibGVfdGxiZmx1c2hfaXMnLiAgSW4gdGhlIGNhc2Ugb2YgZmx1c2hfdGxiX21tKCkg
KndpdGhvdXQqIHRoaXMNCj4gcGFyYW1ldGVyLCBUTEIgZW50cnkgaXMgaW52YWxpZGF0ZWQgYnkg
X190bGJpKGFzaWRlMWlzLCBhc2lkKS4gQnkgdGhpcw0KPiBpbnN0cnVjdGlvbiwgYWxsIENQVXMg
d2l0aGluIHRoZSBzYW1lIGlubmVyIHNoYXJlYWJsZSBkb21haW4gY2hlY2sgaWYgdGhlcmUNCj4g
YXJlIFRMQiBlbnRyaWVzIHdoaWNoIGhhdmUgdGhpcyBBU0lELCB0aGlzIGNhdXNlcyBwZXJmb3Jt
YW5jZSBub2lzZS4gT1RPSCwNCj4gd2hlbiB0aGlzIG5ldyBwYXJhbWV0ZXIgaXMgc3BlY2lmaWVk
LCBUTEIgZW50cnkgaXMgaW52YWxpZGF0ZWQgYnkNCj4gX190bGJpKGFzaWRlMSwgYXNpZCkgb25s
eSBvbiB0aGUgQ1BVcyBzcGVjaWZpZWQgYnkgbW1fY3B1bWFzayhtbSkuDQo+IFRoZXJlZm9yZSBU
TEIgZmx1c2ggaXMgZG9uZSBvbiBtaW5pbWFsIENQVXMgYW5kIHBlcmZvcm1hbmNlIHByb2JsZW0g
ZG9lcw0KPiBub3Qgb2NjdXIuIEFjdHVhbGx5IEkgY29uZmlybSB0aGUgcGVyZm9ybWFuY2UgcHJv
YmxlbSBpcyBmaXhlZCBieSB0aGlzDQo+IHBhdGNoLg0KPiANCj4gVGFrYW8gSW5kb2ggKDIpOg0K
PiAgICBhcm02NDogbW06IFJlc3RvcmUgbW1fY3B1bWFzayAocmV2ZXJ0IGNvbW1pdCAzOGQ5NjI4
NzUwNGEgKCJhcm02NDogbW06DQo+ICAgICAga2lsbCBtbV9jcHVtYXNrIHVzYWdlIikpDQo+ICAg
IGFybTY0OiB0bGI6IEFkZCBib290IHBhcmFtZXRlciB0byBkaXNhYmxlIFRMQiBmbHVzaCB3aXRo
aW4gdGhlIHNhbWUNCj4gICAgICBpbm5lciBzaGFyZWFibGUgZG9tYWluDQo+IA0KPiAgIC4uLi9h
ZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgICAgICAgICB8ICAgNCArDQo+ICAgYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oICAgICAgICAgIHwgICA3ICstDQo+ICAg
YXJjaC9hcm02NC9pbmNsdWRlL2FzbS90bGJmbHVzaC5oICAgICAgICAgICAgIHwgIDYxICsrLS0t
LS0NCj4gICBhcmNoL2FybTY0L2tlcm5lbC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAg
IDIgKy0NCj4gICBhcmNoL2FybTY0L2tlcm5lbC9zbXAuYyAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDYgKw0KPiAgIGFyY2gvYXJtNjQva2VybmVsL3RsYmZsdXNoLmMgICAgICAgICAgICAgICAg
ICB8IDE1NSArKysrKysrKysrKysrKysrKysNCj4gICBhcmNoL2FybTY0L21tL2NvbnRleHQuYyAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgIDcgZmlsZXMgY2hhbmdlZCwgMTg2IGlu
c2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2tlcm5lbC90bGJmbHVzaC5jDQo+IA==
