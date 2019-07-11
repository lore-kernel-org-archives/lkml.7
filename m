Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F54BC74A51
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4418521537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="c51o7eBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfGKKVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:21:05 -0400
Received: from mail-eopbgr130095.outbound.protection.outlook.com ([40.107.13.95]:16270
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbfGKKVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+8xtqSsxWxJ2ih66qi++cmRC4H3sRRs7oHudOFHWRo=;
 b=c51o7eBkCCbXFmWH5OjdorTYpn3/N4/tJJN+o5bE98tgs3Y12AL31JFoNqkFgxpaDNOXdH8zT5tb2hT43CgPnjSTcUmnW32SOEenNB9wGSWVMjt0VG2REDzOYtO3Yn2s6rh0dTkzazV/mvvHihZg7g/XxPzG1LXNSs+QdLJxh4s=
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com (10.186.171.86) by
 AM7PR05MB6696.eurprd05.prod.outlook.com (10.186.170.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 11 Jul 2019 10:21:00 +0000
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5]) by AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5%3]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 10:21:00 +0000
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
Subject: Re: [PATCH v2 4/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Topic: [PATCH v2 4/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Index: AQHVKyqTSzg5w7HHF0OmUYP9Fd4wVabFTNkA
Date:   Thu, 11 Jul 2019 10:21:00 +0000
Message-ID: <CAByghJYJDTiq=3Y8njfvmnnE6rqnEjjDukrJY=pbH8gcDEoxQA@mail.gmail.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
 <20190625074937.2621-5-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-5-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::34) To AM7PR05MB6741.eurprd05.prod.outlook.com
 (2603:10a6:20b:13e::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=igor.opaniuk@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAU2WFqdjKMBD79SRPH71vThrGOFGFv1Yt5s1cyEt3PdiYLEwg6s
        y6MKnEEpTn9HG8+0bJMJmDYdoY6aBOF2qxQEXHM=
x-google-smtp-source: APXvYqy8o7niB89ApJwsX+a410i3mugrhpoFOAXDncjIinkI0BgQYPtDzN+gSWIvD6oE9EacRlsDPOiL+5Z5BPaAq/Q=
x-received: by 2002:a17:906:5f92:: with SMTP id
 a18mr2392296eju.153.1562840151766; Thu, 11 Jul 2019 03:15:51 -0700 (PDT)
x-gmail-original-message-id: <CAByghJYJDTiq=3Y8njfvmnnE6rqnEjjDukrJY=pbH8gcDEoxQA@mail.gmail.com>
x-originating-ip: [209.85.208.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d0ae61c-e92f-43f1-5c38-08d705e978a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM7PR05MB6696;
x-ms-traffictypediagnostic: AM7PR05MB6696:
x-microsoft-antispam-prvs: <AM7PR05MB6696A77B18485C4B7CAC2DC09EF30@AM7PR05MB6696.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(7736002)(107886003)(316002)(5660300002)(305945005)(25786009)(53936002)(6246003)(66066001)(71200400001)(44832011)(71190400001)(61266001)(446003)(14454004)(11346002)(486006)(476003)(6436002)(66446008)(52116002)(99286004)(386003)(6506007)(102836004)(53546011)(26005)(76176011)(64756008)(6116002)(3846002)(55446002)(66556008)(66476007)(66946007)(81156014)(81166006)(6486002)(8676002)(8936002)(498394004)(9686003)(6512007)(4326008)(186003)(6862004)(2906002)(68736007)(229853002)(61726006)(95326003)(478600001)(6636002)(256004)(54906003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM7PR05MB6696;H:AM7PR05MB6741.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CVpwxqUi1AycGZI3DohjrGJXA01vkEXaX3ehndevfuqr9bL13HRcO+3+COPpfm5/kNrnSkfLukejsqyCM7idY5TohbbHKo1GazDsaTHIfRmDmPKIpzh9wevM7QBb6bQPf/rACXpk3UtBCUA44Ex7LZfMUAcxLC4ZEEWyBqkhx0MJSFfo1yMbMjOygboVBB53BITl73gYnt3j55ZKBkFZ2CQOEj5KYIPFv/WObhF0arWMmgspIj7of5x3OUZH8Wcn+Se5sf3DTDOpgwmwjQqkmxagtkb9T7sdGz+b1Ouy4QZU3jNkwdlIi+ycOrzQsHw4/b1SZuWwVrglBEJfelFonDHSxGzXA5hfBxJIyhIjWQvwYKII3b1HVo3JBYg+ZOuDxi04gxBnDV2Lv1OSLYjVrVYPAzoRpfqkYbeBuB63v6w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A00D1113DCABC48A1204006A240E505@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0ae61c-e92f-43f1-5c38-08d705e978a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 10:21:00.6626
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

SGkgT2xla3NhbmRyLA0KDQpPbiBUdWUsIEp1biAyNSwgMjAxOSBhdCAxMDo1NiBBTSBPbGVrc2Fu
ZHIgU3V2b3Jvdg0KPG9sZWtzYW5kci5zdXZvcm92QHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4g
SWYgVkREQSAhPSBWRERJTyBhbmQgYW55IG9mIHRoZW0gaXMgZ3JlYXRlciB0aGFuIDMuMVYsIGNo
YXJnZSBwdW1wDQo+IHNvdXJjZSBjYW4gYmUgYXNzaWduZWQgYXV0b21hdGljYWxseS4NCm1pbm9y
OiBDb3VsZCBhbHNvIHlvdSBwbGVhc2UgYWRkIGEgcmVmZXJlbmNlIGxpbmsgdG8gdGhlIGNvbW1p
dCBtZXNzYWdlLA0Kd2hlcmUgdGhpcyBiZWhhdmlvciBpcyBkZWZpbmVkPw0KDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IE9sZWtzYW5kciBTdXZvcm92IDxvbGVrc2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNv
bT4NCj4gLS0tDQo+DQo+ICBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMgfCAxNCArKysrKysr
KystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYyBiL3NvdW5k
L3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KPiBpbmRleCBlODEzYTM3OTEwYWY0Li5lZTFlNGJmNjEz
MjI3IDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gKysrIGIv
c291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQo+IEBAIC0xMTc0LDEyICsxMTc0LDE2IEBAIHN0
YXRpYyBpbnQgc2d0bDUwMDBfc2V0X3Bvd2VyX3JlZ3Moc3RydWN0IHNuZF9zb2NfY29tcG9uZW50
ICpjb21wb25lbnQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBT
R1RMNTAwMF9JTlRfT1NDX0VOKTsNCj4gICAgICAgICAgICAgICAgIC8qIEVuYWJsZSBWRERDIGNo
YXJnZSBwdW1wICovDQo+ICAgICAgICAgICAgICAgICBhbmFfcHdyIHw9IFNHVEw1MDAwX1ZERENf
Q0hSR1BNUF9QT1dFUlVQOw0KPiAtICAgICAgIH0gZWxzZSBpZiAodmRkaW8gPj0gMzEwMCAmJiB2
ZGRhID49IDMxMDApIHsNCj4gKyAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgYW5h
X3B3ciAmPSB+U0dUTDUwMDBfVkREQ19DSFJHUE1QX1BPV0VSVVA7DQo+IC0gICAgICAgICAgICAg
ICAvKiBWRERDIHVzZSBWRERJTyByYWlsICovDQo+IC0gICAgICAgICAgICAgICBscmVnX2N0cmwg
fD0gU0dUTDUwMDBfVkREQ19BU1NOX09WUkQ7DQo+IC0gICAgICAgICAgICAgICBscmVnX2N0cmwg
fD0gU0dUTDUwMDBfVkREQ19NQU5fQVNTTl9WRERJTyA8PA0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgU0dUTDUwMDBfVkREQ19NQU5fQVNTTl9TSElGVDsNCj4gKyAgICAgICAgICAgICAg
IC8qIGlmIHZkZGlvID09IHZkZGEgdGhlIHNvdXJjZSBvZiBjaGFyZ2UgcHVtcCBzaG91bGQgYmUN
Cj4gKyAgICAgICAgICAgICAgICAqIGFzc2lnbmVkIG1hbnVhbGx5IHRvIFZERElPDQo+ICsgICAg
ICAgICAgICAgICAgKi8NCm1pbm9yOiBwbGVhc2UgY2hlY2sgdGhlIHByZWZlcnJlZCBzdHlsZSBm
b3IgbG9uZyAobXVsdGktbGluZSkgY29tbWVudHMNCmluIGNvZGluZy1zdHlsZS5yc3QsDQpmaXJz
dCBsaW5lIHNob3VsZCBiZSBlbXB0eS4NCg0KPiArICAgICAgICAgICAgICAgaWYgKHZkZGlvID09
IHZkZGEpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgbHJlZ19jdHJsIHw9IFNHVEw1MDAw
X1ZERENfQVNTTl9PVlJEOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBscmVnX2N0cmwgfD0g
U0dUTDUwMDBfVkREQ19NQU5fQVNTTl9WRERJTyA8PA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBTR1RMNTAwMF9WRERDX01BTl9BU1NOX1NISUZUOw0KPiArICAgICAgICAg
ICAgICAgfQ0KPiAgICAgICAgIH0NCj4NCj4gICAgICAgICBzbmRfc29jX2NvbXBvbmVudF93cml0
ZShjb21wb25lbnQsIFNHVEw1MDAwX0NISVBfTElOUkVHX0NUUkwsIGxyZWdfY3RybCk7DQo+IC0t
DQo+IDIuMjAuMQ0KPg0KDQpXaXRoIG15IGNvbW1lbnRzIGFkZHJlc3NlZDoNClJldmlld2VkLWJ5
OiBJZ29yIE9wYW5pdWsgPGlnb3Iub3Bhbml1a0B0b3JhZGV4LmNvbT4NCg0KLS0gDQpCZXN0IHJl
Z2FyZHMgLSBGcmV1bmRsaWNoZSBHcsO8c3NlIC0gTWVpbGxldXJlcyBzYWx1dGF0aW9ucw0KDQpT
ZW5pb3IgRGV2ZWxvcG1lbnQgRW5naW5lZXIsDQpJZ29yIE9wYW5pdWsNCg0KVG9yYWRleCBBRw0K
QWx0c2FnZW5zdHJhc3NlIDUgfCA2MDQ4IEhvcncvTHV6ZXJuIHwgU3dpdHplcmxhbmQgfCBUOiAr
NDEgNDEgNTAwIDQ4DQowMCAobWFpbiBsaW5lKQ0K
