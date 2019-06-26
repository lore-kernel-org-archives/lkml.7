Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA92C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B9620644
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="kdzC0xpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfFZQjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:39:04 -0400
Received: from mail-eopbgr690051.outbound.protection.outlook.com ([40.107.69.51]:14766
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbfFZQjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM8Yow3v7JTzKW3X2L/PBGVBUsDf7/g9vuqefUu7Olc=;
 b=kdzC0xpApa8Cdf1Ncz39YsDtYY6yQFPGNbnfivJtZgbTsBAxLTzC2tmOcd4FWourB5I1QSmhvA7lok4PCGEzO6EC8mijCf8Ote9w6+XQrSao2Ht4xw0K9MceZ3nVsLfcTXfw8EngeRRICYAn4KbhY8vrncKvAjIf4K0kQP4skLo=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6503.namprd05.prod.outlook.com (20.178.233.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Wed, 26 Jun 2019 16:39:00 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 16:39:00 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5/9] x86/mm/tlb: Optimize local TLB flushes
Thread-Topic: [PATCH 5/9] x86/mm/tlb: Optimize local TLB flushes
Thread-Index: AQHVIbQpBim9779otkWC7xtaAV+uS6as+MIAgAE9ngCAAAGGgA==
Date:   Wed, 26 Jun 2019 16:39:00 +0000
Message-ID: <09591002-92C0-4D1D-AA4B-FB1C49661A59@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
 <20190613064813.8102-6-namit@vmware.com>
 <86e04985-7884-3d33-c479-92614b4e4342@intel.com>
 <CALCETrXbC=w5KyR8x-hD24DC0BzZ3MjHR1FUOoEXkBOPHPXwXQ@mail.gmail.com>
In-Reply-To: <CALCETrXbC=w5KyR8x-hD24DC0BzZ3MjHR1FUOoEXkBOPHPXwXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [24.54.179.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e46187b6-d382-427f-7675-08d6fa54cadf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6503;
x-ms-traffictypediagnostic: BYAPR05MB6503:
x-microsoft-antispam-prvs: <BYAPR05MB65038ED8750F1AF6DB3A1BF8D0E20@BYAPR05MB6503.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(6436002)(66066001)(81156014)(8936002)(3846002)(6116002)(8676002)(26005)(316002)(54906003)(53936002)(6512007)(102836004)(186003)(229853002)(6486002)(68736007)(33656002)(81166006)(25786009)(478600001)(7736002)(99286004)(305945005)(6246003)(6506007)(4326008)(53546011)(76176011)(256004)(36756003)(5660300002)(6916009)(476003)(446003)(66476007)(66556008)(64756008)(66446008)(2616005)(11346002)(76116006)(73956011)(66946007)(14454004)(71190400001)(71200400001)(2906002)(86362001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6503;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CC5mFU2sP9tmsyr18Azkki7XcQiheHbXDxoOnYK3O2eTuCYvaQ7+pDa5yCG/QsLMqYy9qHWSNYH/m3y8XX2YS1AD8IFUXt2PIOAqjins5jyDswwNhmp1SRwjB8+aYwe4U5MFtxg2WHsX7JtaxnD31js/f/kVvtIeiFosnsmDQL9NrZvhuu0YMcmBkVZjneHuzyI/QECDvhHKKwHi0nx/8IkuMUlF8igQpOPzrM7aewwioZfb7ppIKSNfyvkgubceRXoOHEkBvVHyqbsfub27MTM0b5mqqOKte2YrPmFT/eMiCqx/ty+eUQ5q49mFzN28Y4PILGiFpRWsswvrezU3NeqZKB+5HgiV+wA8bNi+zI9miJXeMqZLEMsKOcVjDF16Wc+h1vVDlcpb/BOUQecTJyiSOdWNZ/hxojPr1vq8uOg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F3CE395A8B11E488808BD1DFE25050F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46187b6-d382-427f-7675-08d6fa54cadf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 16:39:00.5494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMjYsIDIwMTksIGF0IDk6MzMgQU0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVuIDI1LCAyMDE5IGF0IDI6MzYgUE0gRGF2
ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4gd3JvdGU6DQo+PiBPbiA2LzEyLzE5IDEx
OjQ4IFBNLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+IFdoaWxlIHRoZSB1cGRhdGVkIHNtcCBpbmZy
YXN0cnVjdHVyZSBpcyBjYXBhYmxlIG9mIHJ1bm5pbmcgYSBmdW5jdGlvbiBvbg0KPj4+IGEgc2lu
Z2xlIGxvY2FsIGNvcmUsIGl0IGlzIG5vdCBvcHRpbWl6ZWQgZm9yIHRoaXMgY2FzZS4NCj4+IA0K
Pj4gT0ssIHNvIGZsdXNoX3RsYl9tdWx0aSgpIGlzIG9wdGltaXplZCBmb3IgZmx1c2hpbmcgbG9j
YWwrcmVtb3RlIGF0IHRoZQ0KPj4gc2FtZSB0aW1lIGFuZCBpcyBhbHNvIChuZWFyPykgdGhlIG1v
c3Qgb3B0aW1hbCB3YXkgdG8gZmx1c2ggcmVtb3RlLW9ubHkuDQo+PiBCdXQsIGl0J3Mgbm90IGFz
IG9wdGltaXplZCBhdCBkb2luZyBsb2NhbC1vbmx5IGZsdXNoZXMuICBCdXQsDQo+PiBmbHVzaF90
bGJfb25fY3B1cygpICppcyogb3B0aW1pemVkIGZvciBsb2NhbC1vbmx5IGZsdXNoZXMuDQo+IA0K
PiBDYW4gd2Ugc3RpY2sgdGhlIG9wdGltaXphdGlvbiBpbnRvIGZsdXNoX3RsYl9tdWx0aSgpIGlu
IHRoZSBpbnRlcmVzdA0KPiBvZiBrZWVwaW5nIHRoaXMgc3R1ZmYgcmVhZGFibGU/DQoNCmZsdXNo
X3RsYl9vbl9jcHVzKCkgd2lsbCBiZSBtdWNoIHNpbXBsZXIgb25jZSBJIHJlbW92ZSB0aGUgZmFs
bGJhY2sNCnBhdGggdGhhdCBpcyBpbiB0aGVyZSBmb3IgWGVuIGFuZCBoeXBlci12LiBJIGNhbiB0
aGVuIG9wZW4tY29kZSBpdCBpbg0KZmx1c2hfdGxiX21tX3JhbmdlKCkgYW5kIGFyY2hfdGxiYmF0
Y2hfZmx1c2goKS4NCg0KPiANCj4gQWxzbywgd291bGQgdGhpcyBzZXJpZXMgYmUgZWFzaWVyIHRv
IHVuZGVyc3RhbmQgaWYgdGhlcmUgd2FzIGEgcGF0Y2gNCj4gdG8ganVzdCByZW1vdmUgdGhlIFVW
IG9wdGltaXphdGlvbiBiZWZvcmUgbWFraW5nIG90aGVyIGNoYW5nZXM/DQoNCklmIHlvdSBqdXN0
IHdhbnQgbWUgdG8gcmVtb3ZlIGl0LCBJIGNhbiBkbyBpdC4gSSBkb27igJl0IGtub3cgd2hvIHVz
ZXMgaXQgYW5kDQp3aGF0IHRoZSBpbXBhY3QgbWlnaHQgYmUuDQoNCg==
