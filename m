Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F76C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117C0208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="CR7Jdbdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfGKKU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:20:58 -0400
Received: from mail-eopbgr130127.outbound.protection.outlook.com ([40.107.13.127]:61052
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbfGKKU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsSR8DX8hCulohWUxa/i+HlQMvpugLkP/Bem6olghKE=;
 b=CR7JdbdrPxG5Dg2OqjI5srdXLuGiyuxznWflpvNMebk6RHAjS81vOiap27KNP+RhkP0FUMpggwA6Qogit6LCfTVTS7PsziJTHluRDG0yFS8+zbDMOVXtmUjYe/lrcgJ4TMUc3gxBwqPbfYkdk2F91h89iO9xzgvBMCrziVjSLsI=
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com (10.186.171.86) by
 AM7PR05MB6696.eurprd05.prod.outlook.com (10.186.170.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 11 Jul 2019 10:20:55 +0000
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5]) by AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5%3]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 10:20:55 +0000
From:   Igor Opaniuk <igor.opaniuk@toradex.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
CC:     Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 2/6] ASoC: sgtl5000: add ADC mute control
Thread-Topic: [PATCH v2 2/6] ASoC: sgtl5000: add ADC mute control
Thread-Index: AQHVKyqRRD0zb81hRk+Jt1ntvt3D5qbFTkKA
Date:   Thu, 11 Jul 2019 10:20:54 +0000
Message-ID: <CAByghJbOVX9RNA+TLz45cFUPHm=6_QHnvK7RFvGTGjPy-Mp67w@mail.gmail.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
 <20190625074937.2621-3-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-3-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::31) To AM7PR05MB6741.eurprd05.prod.outlook.com
 (2603:10a6:20b:13e::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=igor.opaniuk@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAW5l+QHJAdSI67uoolj+wr1xOqQhaucVhOfHkGXpyTJF4CLHL5X
        SEfwyE4A1mzvi7hZw7V37Ly12gAYP1ejxBxH3ew=
x-google-smtp-source: APXvYqw5+fVxrxycXy0PTxStgsoPaTYCbZT9VhKi+rjPtT95tgr/6+qWfbPDAN32oX44HhyZNTRtV3EzABSRvIYLi7k=
x-received: by 2002:a17:907:2130:: with SMTP id
 qo16mr2396664ejb.235.1562840454251; Thu, 11 Jul 2019 03:20:54 -0700 (PDT)
x-gmail-original-message-id: <CAByghJbOVX9RNA+TLz45cFUPHm=6_QHnvK7RFvGTGjPy-Mp67w@mail.gmail.com>
x-originating-ip: [209.85.208.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce0b987c-9388-4445-5cfd-08d705e9751b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM7PR05MB6696;
x-ms-traffictypediagnostic: AM7PR05MB6696:
x-microsoft-antispam-prvs: <AM7PR05MB669617E3DF973892FC26604F9EF30@AM7PR05MB6696.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(7736002)(107886003)(316002)(5660300002)(305945005)(25786009)(53936002)(6246003)(66066001)(71200400001)(44832011)(71190400001)(61266001)(446003)(14454004)(11346002)(486006)(476003)(6436002)(66446008)(52116002)(99286004)(386003)(6506007)(102836004)(53546011)(26005)(76176011)(64756008)(6116002)(3846002)(55446002)(66556008)(66476007)(66946007)(81156014)(81166006)(6486002)(8676002)(8936002)(498394004)(9686003)(6512007)(4326008)(186003)(6862004)(2906002)(68736007)(229853002)(61726006)(95326003)(478600001)(6636002)(256004)(54906003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM7PR05MB6696;H:AM7PR05MB6741.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ScRnO1a8knDbMTVIbkEaGyoaVIx2FQNtM2b1UqsLBXKNlK9BxY0iKkl00/Tky+ZTgfI9XhbBobpnMk8D/kjlwCrhIq7vfIax/uPIKhH8ZAdSS6/KsVfQNMIcrs3aheVnMRZ0EhBwcB07Fp8tJn60p/A0ml2JgNc/z2cEl7gobxeJukW7gCEDDLgWmaOj3oYtZM6Zxpd254S6yJXb5IEFXYR6xhiXfuqa1FvGTCpWVORPMYbpflc0fLhgaDSEDFp5EHoVxP6Ef5O9hw0DT/E/XQxksl8Ook6rNEjYILmp6JaEyYI0xaRnm3tHHy2kBVUFipASjVwgnimlQ6VwqCChzg5nNEzLyOfJMsvOHQoJx2A4ly9+jQ18oKkyhwTfPphOPSPWOQW6hHL9VaLmuzn8iJFMNl+5fP5znF4Wk0bf6N4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F6EDD477997AE4F8DD1FE2870287B37@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0b987c-9388-4445-5cfd-08d705e9751b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 10:20:54.7691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igor.opaniuk@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMjUsIDIwMTkgYXQgMTA6NDkgQU0gT2xla3NhbmRyIFN1dm9yb3YNCjxvbGVr
c2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+DQo+IFRoaXMgY29udHJvbCBtdXRl
L3VubXV0ZSB0aGUgQURDIGlucHV0IG9mIFNHVEw1MDAwDQo+IHVzaW5nIGl0cyBDSElQX0FOQV9D
VFJMIHJlZ2lzdGVyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xl
a3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQo+IC0tLQ0KPg0KPiAgc291bmQvc29jL2NvZGVj
cy9zZ3RsNTAwMC5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4N
Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYyBiL3NvdW5kL3NvYy9j
b2RlY3Mvc2d0bDUwMDAuYw0KPiBpbmRleCA1ZTQ5NTIzZWUwYjY3Li5iYjU4Yzk5N2M2OTE0IDEw
MDY0NA0KPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gKysrIGIvc291bmQv
c29jL2NvZGVjcy9zZ3RsNTAwMC5jDQo+IEBAIC01NTYsNiArNTU2LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IHNndGw1MDAwX3NuZF9jb250cm9sc1tdID0gew0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBTR1RMNTAwMF9DSElQX0FOQV9BRENfQ1RSTCwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgOCwgMSwgMCwgY2FwdHVyZV82ZGJfYXR0ZW51YXRlKSwNCj4g
ICAgICAgICBTT0NfU0lOR0xFKCJDYXB0dXJlIFpDIFN3aXRjaCIsIFNHVEw1MDAwX0NISVBfQU5B
X0NUUkwsIDEsIDEsIDApLA0KPiArICAgICAgIFNPQ19TSU5HTEUoIkNhcHR1cmUgU3dpdGNoIiwg
U0dUTDUwMDBfQ0hJUF9BTkFfQ1RSTCwgMCwgMSwgMSksDQo+DQo+ICAgICAgICAgU09DX0RPVUJM
RV9UTFYoIkhlYWRwaG9uZSBQbGF5YmFjayBWb2x1bWUiLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICBTR1RMNTAwMF9DSElQX0FOQV9IUF9DVFJMLA0KPiAtLQ0KPiAyLjIwLjENCj4NCg0KUmV2
aWV3ZWQtYnk6IElnb3IgT3Bhbml1ayA8aWdvci5vcGFuaXVrQHRvcmFkZXguY29tPg0KDQotLSAN
CkJlc3QgcmVnYXJkcyAtIEZyZXVuZGxpY2hlIEdyw7xzc2UgLSBNZWlsbGV1cmVzIHNhbHV0YXRp
b25zDQoNClNlbmlvciBEZXZlbG9wbWVudCBFbmdpbmVlciwNCklnb3IgT3Bhbml1aw0KDQpUb3Jh
ZGV4IEFHDQpBbHRzYWdlbnN0cmFzc2UgNSB8IDYwNDggSG9ydy9MdXplcm4gfCBTd2l0emVybGFu
ZCB8IFQ6ICs0MSA0MSA1MDAgNDgNCjAwIChtYWluIGxpbmUpDQo=
