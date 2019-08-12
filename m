Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D4C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366AF20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="Zpnnnq2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfHLNDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:03:12 -0400
Received: from mail-eopbgr80123.outbound.protection.outlook.com ([40.107.8.123]:43102
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728651AbfHLNDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbNT4sFaRa/PW5hhjIttqOMkTB+9XWglhpPFNDUUmeQoxwyhvqqP0yyDFcuZ1N+YCj63j+yvJKZ1XOy/onZY/bEj7jg/ixAm8TKAU37CoxEMRJu9n1K521gquBZR5GBFh8w6c+Hh0Q1/FxWh6Ve6f4GmE+24V90rnOTveaUa8p20WXrdGlrtbZqWEtPipD6VCNqimOZhtX724eiv9g8gynGI/tac3QNyeNJFOg4VenRVRwmZwFaeU2cWg8AtZ3Um4Yfw1B5PIKZw7RSN/u2HV7HyK83386bPKiHQypzKtYq8NCexzHAJfNieI9Ue+vc073/KkCHsK8QHlt0DbtvwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SbfqvsTQbd6Jhu7v73AipmIyY5AbVnTT0hW5s7R1C8=;
 b=RcAkUg20hDUccWL6nz86SzjEOu1NiXu4O+0XRE4uMsxz/ycYYQtg8F3aCttozjTCXoyxfdetF45XOBo7QHoVCzBeH0mFwNCGLkT0TZtgFOfbpALaZz8WIL1zZMLqA21BLGgrRZiQxNhSl1bwoFHMqYF6Dg6dZLbP0Rv28i/4ER7b8KppHzyBGZRbsXFJF3Z2nst5fgGty8S0rjO3aVOuMOEwFzT9Mpj+LzEqKYXNhrTXDzuggiMOy7MLBQmNU7sj9zxu+L09S2aqE/adFa5miTkUMJlrnO/SJk+YBB/5wnM7DIpgHa+5aR8xU74j9i2Zvc4DJq11uOzrUyhU0cqdmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SbfqvsTQbd6Jhu7v73AipmIyY5AbVnTT0hW5s7R1C8=;
 b=Zpnnnq2DJn/AkxLNFDRRWwWKFoNOO7wF6lmEug43WWnwfSrMHCoschu2lsHWcY5f+w49hCXFNNEdMlLFGt+Yfp3hoeFIaRRtxKRqwDQQhtyOYR2IOJlhjWBWwwKFZSZfmBomNU/+H+ahLhr7wrqbxVGJf12OCIXBS2sGhJqHH+w=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB2797.eurprd04.prod.outlook.com (10.172.255.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Mon, 12 Aug 2019 13:02:28 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 13:02:28 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device
 ID
Thread-Topic: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Thread-Index: AQHVTidIVfq9W1HbR0i2bNtry39Joab0Aj2AgAN9ywA=
Date:   Mon, 12 Aug 2019 13:02:27 +0000
Message-ID: <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org>
In-Reply-To: <20190810074317.GA18582@infradead.org>
Reply-To: Stephen Douthit <stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:405:15::19) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6844c787-0299-41d4-cd7c-08d71f2553d2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB2797;
x-ms-traffictypediagnostic: VI1PR0402MB2797:
x-microsoft-antispam-prvs: <VI1PR0402MB2797201806751C0F673104F294D30@VI1PR0402MB2797.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39850400004)(189003)(199004)(3846002)(14454004)(53936002)(6116002)(64756008)(86362001)(76176011)(6486002)(31696002)(53546011)(66446008)(66556008)(26005)(2906002)(386003)(6506007)(66476007)(186003)(66946007)(3450700001)(25786009)(4326008)(102836004)(31686004)(6246003)(478600001)(66066001)(6916009)(229853002)(5660300002)(8676002)(486006)(99286004)(71200400001)(71190400001)(43066004)(81166006)(36756003)(81156014)(256004)(8936002)(305945005)(316002)(52116002)(6436002)(6512007)(446003)(11346002)(7736002)(54906003)(476003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB2797;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eat08B1Zy41Wvy5I6vJdvoAiK7G56DcoXn3wQzlsm1txFkFMevsk6lpwXscqAGo+2YATlNtEs9YJ8LU+oELLalUyvCBH4Hq3uFG5Z9nDa/zcYVGjRhmzKPyBczR5AzYvWm+wVafajN1/SehVkkxHZq0P1bIPRaq5dbDJdOSfKoquSCK7z0t806Nz/zAn4MyOW02ZBnboPfVr8jeSsjnp17b0HSVQgcGUgFxom5OqUkiHXFWHTy/maz6wH7dGdDOdPZLDV/4T78JewkxS/GtrnTivdewVxCd42oxr70uh6svj2g3VXRTlAawGW1m3urFLxV8Zl2f0HmIM6YOGrdW0MuZfK774pbzE6Oj/S6NepJDbMgsGD5KhOb/VqC/2KYH5RqwYhxoEPyXwreqoSuEmQrQxR80muiOYThr9NC0dpbQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B99C8D56EB6684D8FE2860F550E47DF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6844c787-0299-41d4-cd7c-08d71f2553d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 13:02:27.9338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0P66+KkogscynsoR+VjLv/OP6hYPlAo1l7XrO8kiSwYJUV+yraubi6q+k5eHsk+zyOf3R+9KRFBReb259Qc9q1AF45sh16400nbAht4ZmG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2797
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMC8xOSAzOjQzIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1LCBB
dWcgMDgsIDIwMTkgYXQgMDg6MjQ6MzFQTSArMDAwMCwgU3RlcGhlbiBEb3V0aGl0IHdyb3RlOg0K
Pj4gSW50ZWwgbW92ZWQgdGhlIFBDUyByZWdpc3RlciBmcm9tIDB4OTIgdG8gMHg5NCBvbiBEZW52
ZXJ0b24gZm9yIHNvbWUNCj4+IHJlYXNvbiwgc28gbm93IHdlIGdldCB0byBjaGVjayB0aGUgZGV2
aWNlIElEIGJlZm9yZSBwb2tpbmcgaXQgb24gcmVzZXQuDQo+IA0KPiBBbmQgbm93IHlvdSBqdXN0
IG1hdGNoIG9uIHRoZSBuZXcgSURzLCB3aGljaCBtZWFucyB3ZSdsbCBwZXJwZXR1YWxseQ0KPiBj
YXRjaCB1cCBvbiBhbnkgbmV3IGRldmljZS4gIERhbiwgY2FuIHlvdSByZWFjaCBvdXQgaW5zaWRl
IEludGVsIHRvDQo+IGZpZ3VyZSBvdXQgaWYgdGhlcmUgaXMgYSB3YXkgdG8gZmluZCBvdXQgdGhl
IFBDUyByZWdpc3RlciBsb2NhdGlvbg0KPiB3aXRob3V0IHRoZSBQQ0kgSUQgY2hlY2s/DQo+IA0K
PiANCj4+ICAgc3RhdGljIGludCBhaGNpX3BjaV9yZXNldF9jb250cm9sbGVyKHN0cnVjdCBhdGFf
aG9zdCAqaG9zdCkNCj4+ICAgew0KPj4gICAJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lf
ZGV2KGhvc3QtPmRldik7DQo+PiBAQCAtNjM0LDEzICs2NjksMTQgQEAgc3RhdGljIGludCBhaGNp
X3BjaV9yZXNldF9jb250cm9sbGVyKHN0cnVjdCBhdGFfaG9zdCAqaG9zdCkNCj4+ICAgDQo+PiAg
IAlpZiAocGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfSU5URUwpIHsNCj4+ICAgCQlzdHJ1
Y3QgYWhjaV9ob3N0X3ByaXYgKmhwcml2ID0gaG9zdC0+cHJpdmF0ZV9kYXRhOw0KPj4gKwkJaW50
IHBjcyA9IGFoY2lfcGNzX29mZnNldChob3N0KTsNCj4+ICAgCQl1MTYgdG1wMTY7DQo+PiAgIA0K
Pj4gICAJCS8qIGNvbmZpZ3VyZSBQQ1MgKi8NCj4+IC0JCXBjaV9yZWFkX2NvbmZpZ193b3JkKHBk
ZXYsIDB4OTIsICZ0bXAxNik7DQo+PiArCQlwY2lfcmVhZF9jb25maWdfd29yZChwZGV2LCBwY3Ms
ICZ0bXAxNik7DQo+PiAgIAkJaWYgKCh0bXAxNiAmIGhwcml2LT5wb3J0X21hcCkgIT0gaHByaXYt
PnBvcnRfbWFwKSB7DQo+PiAtCQkJdG1wMTYgfD0gaHByaXYtPnBvcnRfbWFwOw0KPj4gLQkJCXBj
aV93cml0ZV9jb25maWdfd29yZChwZGV2LCAweDkyLCB0bXAxNik7DQo+PiArCQkJdG1wMTYgfD0g
aHByaXYtPnBvcnRfbWFwICYgMHhmZjsNCj4+ICsJCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQocGRl
diwgcGNzLCB0bXAxNik7DQo+PiAgIAkJfQ0KPj4gICAJfQ0KPiANCj4gQW5kIFN0ZXBoZW4sIHdo
aWxlIHlvdSBhcmUgYXQgaXQsIGNhbiB5b3Ugc3BsaXQgdGhpcyBJbnRlbC1zcGVjaWZpYw0KPiBx
dWlyayBpbnRvIGEgc2VwYXJhdGUgaGVscGVyPw0KDQpJIGNhbiBkbyB0aGF0LiAgSSdsbCB3YWl0
IHVudGlsIHdlIGhlYXIgYmFjayBmcm9tIERhbiBpZiB0aGVyZSdzIGENCmJldHRlciBzY2hlbWUg
dGhhbiBhIGRldmljZSBJRCBsb29rdXAuDQo=
