Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD6AC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6446A20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Po7rBXy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfGKK0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:26:18 -0400
Received: from mail-eopbgr00119.outbound.protection.outlook.com ([40.107.0.119]:34949
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbfGKK0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:26:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5hfWetMKFgq8XVJFvQXKze5Tml5xAbTreTDEH6imOB5CSt2DrV1Q4ZBvD14bMn/plPvGqv+r6MWKLT+iSIHDiG3n7gBzA3N/V9xWQytuVmktQwDfR4RX7YSWWBDlQpkQQhL3cyutj65C0OOVxQMf56iJ+tLeo4yT3RM/LzHh8Jot89I5olTERXGg7itfz/L+v2DY/XciSeoFZI5L9vLNhJQSA6/JEkPdXsSkH4bGxI/zlQyeAwQ7Ms3d9gnYTg3FvUl/pD69wg708ak3IQjhxZm+c13jFqTuohj/eEny2jYpWPbyhkbyYs71PTHVbcM3nvCAiCGELdqY1y5hBQ/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N4wouQPy1ZMvlDig4i4f8qddSubLi7/KWNJ98n28qc=;
 b=mq0hXMUM4jAK+qE3KCirDvd+BpXJBs0pMAZXDvNxffDmJ0+rTff4ZolZzoc1GvdfFynLN7AtoJRKZXKuH2aft1wGnQh/9dSs5bpa9zkc5DRNUmN0DsF+iEIWDfM7eDtcAqOOD3jOJnGOKUx2F6TwS/92Bm+Yon0TQexItXnPTtro1OWhZSToBU1eKbNF5RTl1SK9Hf5L3IDM3hd1x45fpcQ9rv/jcppqLyzv2KTkxbX+qP4sARlNfafhsauUfJL+f+EjWTVq6qYhbbySY64ZGevzgux8JZ5kxeTL2DvsVa/aeDrtG5Kic99J7FUHx7gFHdhZ0Ty/Omt7SjtCDjzzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N4wouQPy1ZMvlDig4i4f8qddSubLi7/KWNJ98n28qc=;
 b=Po7rBXy8X3OzgsbjKxOJ+T8GZPwDAD0LwfMYcEcRXMZHDyYFpmfiyLkdhwChXMO7+q+8mQz4p1/GO2oWuxlhhqhr97l5rihZXt7epmueEdDBq+9NJ8jSQInIjxzFXjq31Mj3ZnQotJAyeo1lIdi766MzX1ENJ+cmHPqbGlS6AEY=
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com (10.186.171.86) by
 AM7PR05MB6741.eurprd05.prod.outlook.com (10.186.171.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Thu, 11 Jul 2019 10:26:15 +0000
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5]) by AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5%3]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 10:26:15 +0000
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
Subject: Re: [PATCH v2 5/6] ASoC: Define a set of DAPM pre/post-up events
Thread-Topic: [PATCH v2 5/6] ASoC: Define a set of DAPM pre/post-up events
Thread-Index: AQHVKyqU2fHSSCNLBEK3y0FoLy1SDabFTYGA
Date:   Thu, 11 Jul 2019 10:26:15 +0000
Message-ID: <CAByghJY-338xh8srU-PetjqER-kt6TwuULffqVeZ8cLLGyaubA@mail.gmail.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
 <20190625074937.2621-6-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-6-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0080.eurprd02.prod.outlook.com
 (2603:10a6:208:154::21) To AM7PR05MB6741.eurprd05.prod.outlook.com
 (2603:10a6:20b:13e::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=igor.opaniuk@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAWZ62A0fnZq6Bn0YSdttHYTcX7LhepY/I89Da7cctnuOxOCs6I1
        Q10iNNm0mF+C9s2GHaWnMxFRLc6y6CJ/29Bjtg8=
x-google-smtp-source: APXvYqzMh4W//NXLEr8XKUVvwDtElo6qYR2v9KBzntX0Cqyc4+ESP64jCEVciGf/gvaVmKve2b0KbZ70VL5eZeIH1aM=
x-received: by 2002:a17:906:2191:: with SMTP id
 17mr2407276eju.157.1562840292839; Thu, 11 Jul 2019 03:18:12 -0700 (PDT)
x-gmail-original-message-id: <CAByghJY-338xh8srU-PetjqER-kt6TwuULffqVeZ8cLLGyaubA@mail.gmail.com>
x-originating-ip: [209.85.208.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fefa61b7-5f76-478c-10e3-08d705ea3402
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM7PR05MB6741;
x-ms-traffictypediagnostic: AM7PR05MB6741:
x-microsoft-antispam-prvs: <AM7PR05MB67417599D96661A3692479FA9EF30@AM7PR05MB6741.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39850400004)(376002)(366004)(136003)(396003)(189003)(199004)(305945005)(81166006)(107886003)(71190400001)(3846002)(99286004)(81156014)(7736002)(8676002)(6436002)(71200400001)(76176011)(66446008)(6506007)(386003)(6486002)(95326003)(53546011)(64756008)(66476007)(66556008)(6116002)(5660300002)(25786009)(102836004)(2906002)(486006)(66946007)(8936002)(26005)(6862004)(256004)(229853002)(44832011)(316002)(68736007)(478600001)(61266001)(66066001)(53936002)(6636002)(6246003)(14454004)(498394004)(476003)(52116002)(446003)(4326008)(11346002)(61726006)(55446002)(186003)(9686003)(86362001)(54906003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM7PR05MB6741;H:AM7PR05MB6741.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sx+4wWlAzQ19xnhbtp6DUvsN90V4cs1qBBThDBfrBfmCKtuRZcBfAe5BqNj2tCe1XNfvRRaCAAV6PKhbcanL0P+eRu7yeQ+FacYTrhqXrLOfq/7tQMUXwDjsf1FvVlNErlRveFtmIGk6waV/cx7PFsDbE5i78AIE/xR4cO4R1epndWKWt5wELeD30CHWk4FqiBZa19gVIATdiXUn7NF7UcaS8iV91TJ/UFKxXzfbBEqToWUaernd734KqdO5T28CHl8FhlB2fPqpcVZo+9+WkQlsjoQM0u8Li2gzdDo6FcwlLXmsbmQ9w9WXXWnR9ErgxBIiCk0UZFbomTxzy5EIaSkg9scOlE211n4Iw9JwkXFBur8OE3Jv97In9iQo6yKI/yBK2sU2sqbcRptCRH26S7fQXz1bDaNAys+l7wmaBmA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF89F7C3DA1EDE459AAB3064D5160AB4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefa61b7-5f76-478c-10e3-08d705ea3402
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 10:26:15.0081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igor.opaniuk@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMjUsIDIwMTkgYXQgMTA6NTUgQU0gT2xla3NhbmRyIFN1dm9yb3YNCjxvbGVr
c2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+DQo+IFByZXBhcmUgdG8gdXNlIFNO
RF9TT0NfREFQTV9QUkVfUE9TVF9QTVUgZGVmaW5pdGlvbiB0bw0KPiByZWR1Y2UgY29taW5nIGNv
ZGUgc2l6ZSBhbmQgbWFrZSBpdCBtb3JlIHJlYWRhYmxlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBP
bGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQo+IC0tLQ0K
Pg0KPiAgaW5jbHVkZS9zb3VuZC9zb2MtZGFwbS5oIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zb3VuZC9zb2MtZGFw
bS5oIGIvaW5jbHVkZS9zb3VuZC9zb2MtZGFwbS5oDQo+IGluZGV4IGMwMGEwYjhhZGUwODYuLjZj
NjY5NDE2MDEzMDcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvc291bmQvc29jLWRhcG0uaA0KPiAr
KysgYi9pbmNsdWRlL3NvdW5kL3NvYy1kYXBtLmgNCj4gQEAgLTM1Myw2ICszNTMsOCBAQCBzdHJ1
Y3QgZGV2aWNlOw0KPiAgI2RlZmluZSBTTkRfU09DX0RBUE1fV0lMTF9QTUQgICAweDgwICAgIC8q
IGNhbGxlZCBhdCBzdGFydCBvZiBzZXF1ZW5jZSAqLw0KPiAgI2RlZmluZSBTTkRfU09DX0RBUE1f
UFJFX1BPU1RfUE1EIFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoU05EX1NP
Q19EQVBNX1BSRV9QTUQgfCBTTkRfU09DX0RBUE1fUE9TVF9QTUQpDQo+ICsjZGVmaW5lIFNORF9T
T0NfREFQTV9QUkVfUE9TVF9QTVUgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IChTTkRfU09DX0RBUE1fUFJFX1BNVSB8IFNORF9TT0NfREFQTV9QT1NUX1BNVSkNCj4NCj4gIC8q
IGNvbnZlbmllbmNlIGV2ZW50IHR5cGUgZGV0ZWN0aW9uICovDQo+ICAjZGVmaW5lIFNORF9TT0Nf
REFQTV9FVkVOVF9PTihlKSAgICAgICBcDQo+IC0tDQo+IDIuMjAuMQ0KPg0KDQpSZXZpZXdlZC1i
eTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+DQoNCi0tIA0KQmVzdCBy
ZWdhcmRzIC0gRnJldW5kbGljaGUgR3LDvHNzZSAtIE1laWxsZXVyZXMgc2FsdXRhdGlvbnMNCg0K
U2VuaW9yIERldmVsb3BtZW50IEVuZ2luZWVyLA0KSWdvciBPcGFuaXVrDQoNClRvcmFkZXggQUcN
CkFsdHNhZ2Vuc3RyYXNzZSA1IHwgNjA0OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwgVDog
KzQxIDQxIDUwMCA0OA0KMDAgKG1haW4gbGluZSkNCg==
