Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0ACCA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7252120869
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfJTT2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 15:28:51 -0400
Received: from mail-oln040092071092.outbound.protection.outlook.com ([40.92.71.92]:32130
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfJTT2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:28:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh8NIKCMseYRDKP9+mbJxiJ8beOFj0AK041oY/ougZZxeF7k5UlmvgadNkzYqCCNf1ascDywDTrNvLWjHYhvdisGgbk0ZB/VtzV2c4z66MfWSjdZQ8VWiqhkVZBPzMA/hhxaCiivolNU/ndxrgidhF8/lDb+W1BLxY8vEHj6yHOoHahGSQJQ9e8THnAPrVCXciDkiYCrc7tXAftZJQjqj6lO5uMOkfgGW+gCTSSyM/Db9H2IbmV9vm4Et0pZC0s+vecIBeOT71FmwgkWLvv+5SVPF/Xqrk/7XMJK05KfxQBlLL+HNfOGTeS8OPs3tQUkdDQ7uO94tAbYfh3WyTosQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56xACLdxG0IWQT7TR8hxsIp6mfe5Bof1mY4889BoPBI=;
 b=Nq4V6g1M+30Xwx268imnsLze0LpnlUj0IvqaoZVlhy5Pvk9Vhu37GifkgKQtleLSGzWLIFhNKaRqPRv6NdYGOshzqwVimEFgW8lCee4KTZSdv1tSWPJFILA9kEYBM9v3JFi76T8HiqHIaA2nk7xaQdn803W8aN6T1eqWqseEhyD+42vzVkfOEpLRhhFUXQtD401eedlZdx2gi72c7kN34YrKtRBlmzf7IljIgXaXQEhqCVbPY44eIga6PMmICoMwmIROL44JAOuO//n3OA7+jvg/Bcjlu/RuZNF/TDimuDw/cuw3aSJELwcJq8hD30OeFgo0l6VHL3/O2tOURoZKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (10.152.18.55) by VE1EUR03HT068.eop-EUR03.prod.protection.outlook.com
 (10.152.18.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15; Sun, 20 Oct
 2019 19:28:46 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com (10.152.18.56) by
 VE1EUR03FT014.mail.protection.outlook.com (10.152.19.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Sun, 20 Oct 2019 19:28:46 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247]) by AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247%6]) with mapi id 15.20.2347.028; Sun, 20 Oct 2019
 19:28:46 +0000
From:   Anatol Belski <weltling@outlook.de>
To:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: byteorder: cpu_to_le32_array vs cpu_to_be32_array function API
 differences
Thread-Topic: byteorder: cpu_to_le32_array vs cpu_to_be32_array function API
 differences
Thread-Index: AQHVh3kRz65p1edy+E6pOH2HIjxbDqdj6jkA
Date:   Sun, 20 Oct 2019 19:28:46 +0000
Message-ID: <AM0PR0502MB3668C7B77C05918FF96EF10DBA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
References: <2acb30fb3c9a86ac8cc882fb787cd04e5864224b.camel@perches.com>
In-Reply-To: <2acb30fb3c9a86ac8cc882fb787cd04e5864224b.camel@perches.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-clientproxiedby: AM0PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::34) To AM0PR0502MB3668.eurprd05.prod.outlook.com
 (2603:10a6:208:19::11)
x-incomingtopheadermarker: OriginalChecksum:34E4B76D9F3F8D3463DD07D6A91B9D0E7BF226EF968246F7FD672651207FA4FC;UpperCasedChecksum:6A5DC56BF886D8078465498BECA0E6B802512E071F8032C56841F8C0C10B08A5;SizeAsReceived:7944;Count:52
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [XpTXFOEhg9lwYh/gR+QFvRr1m2dmPYZrPI/NCTo/zJiIBclTro3Cn+fwtAPOyI4RvKyyyFZgy7U=]
x-microsoft-original-message-id: <600e3aaa36fb26cfac68ba54c12524b162b58312.camel@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 52
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: VE1EUR03HT068:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vdznUPoFImj7TL6fsSZrCzkrTSuN3xITjWAaD7wU61hkty2I4sTPhBr39XdusjKQyerbScL6FIS8JYnpRjTCJlsTC35APvZGiR6YI0q6yEFqbf3wYHGWuLnoTeFA1PhjOXtf5RBaOjWdEgWI30hXbsHPN/mTZI26DJ/q17tl7PYMNrwlqno7aW/TGkj24gnt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B22F3BAB9733B4A90060234ADBB8930@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bacc7f-2e69-43e0-c6ae-08d75593b973
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2019 19:28:46.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFN1biwgMjAxOS0xMC0yMCBhdCAxMjowMiAtMDcwMCwgSm9lIFBlcmNoZXMgd3Jv
dGU6DQo+IFRoZXJlJ3MgYW4gYXJndW1lbnQgaW5jb25zaXN0ZW5jeSBiZXR3ZWVuIHRoZXNlIDQg
ZnVuY3Rpb25zDQo+IGluIGluY2x1ZGUvbGludXgvYnl0ZW9yZGVyL2dlbmVyaWMuaA0KPiANCj4g
SXQnZCBiZSBtb3JlIGEgY29uc2lzdGVudCBBUEkgd2l0aCBvbmUgZm9ybSBhbmQgbm90IHR3by4N
Cj4gDQo+ICAgIHN0YXRpYyBpbmxpbmUgdm9pZCBsZTMyX3RvX2NwdV9hcnJheSh1MzIgKmJ1Ziwg
dW5zaWduZWQgaW50IHdvcmRzKQ0KPiAgICB7DQo+ICAgIAl3aGlsZSAod29yZHMtLSkgew0KPiAg
ICAJCV9fbGUzMl90b19jcHVzKGJ1Zik7DQo+ICAgIAkJYnVmKys7DQo+ICAgIAl9DQo+ICAgIH0N
Cj4gDQo+ICAgIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfdG9fbGUzMl9hcnJheSh1MzIgKmJ1Ziwg
dW5zaWduZWQgaW50IHdvcmRzKQ0KPiAgICB7DQo+ICAgIAl3aGlsZSAod29yZHMtLSkgew0KPiAg
ICAJCV9fY3B1X3RvX2xlMzJzKGJ1Zik7DQo+ICAgIAkJYnVmKys7DQo+ICAgIAl9DQo+ICAgIH0N
Cj4gDQo+IHZzDQo+IA0KPiAgICBzdGF0aWMgaW5saW5lIHZvaWQgY3B1X3RvX2JlMzJfYXJyYXko
X19iZTMyICpkc3QsIGNvbnN0IHUzMiAqc3JjLA0KPiBzaXplX3QgbGVuKQ0KPiAgICB7DQo+ICAg
IAlpbnQgaTsNCj4gDQo+ICAgIAlmb3IgKGkgPSAwOyBpIDwgbGVuOyBpKyspDQo+ICAgIAkJZHN0
W2ldID0gY3B1X3RvX2JlMzIoc3JjW2ldKTsNCj4gICAgfQ0KPiANCj4gICAgc3RhdGljIGlubGlu
ZSB2b2lkIGJlMzJfdG9fY3B1X2FycmF5KHUzMiAqZHN0LCBjb25zdCBfX2JlMzIgKnNyYywNCj4g
c2l6ZV90IGxlbikNCj4gICAgew0KPiAgICAJaW50IGk7DQo+IA0KPiAgICAJZm9yIChpID0gMDsg
aSA8IGxlbjsgaSsrKQ0KPiAgICAJCWRzdFtpXSA9IGJlMzJfdG9fY3B1KHNyY1tpXSk7DQo+ICAg
IH0NCj4gDQo+IA0KDQpzaXplX3QgaXMgdGhlIHJpZ2h0IGNob2ljZSBmb3IgdGhpcywgYXMgaXQn
bGwgZ2VuZXJhdGUgbW9yZSBjb3JyZWN0DQpiaW5hcnkgZGVwZW5kaW5nIG9uIDMyLzY0IGJpdC4g
SSd2ZSBzZW50IGEgcGF0Y2ggaW4NCidpbmNsdWRlL2xpbnV4L2J5dGVvcmRlci9nZW5lcmljLmg6
IGZpeCBzaWduZWQvdW5zaWduZWQgd2FybmluZ3MnDQpiZWZvcmUsIGJ1dCBvbmx5IHRvdWNoZWQg
dGhlIHBsYWNlIHdoZXJlIGkndmUgc2VlbiB3YXJuaW5ncy4gTXkgdmVyeQ0KYmV0IGlzLCB0aGF0
IGNoYW5naW5nIGJldHdlZW4gc2l6ZV90L3Vuc2lnbmVkLCB3aGlsZSBpdCB3b3VsZCBiZQ0KY29u
c2lzdGVudCwgd291bGRuJ3QgY2hhbmdlIHRoZSBmdW5jdGlvbmFsaXR5LiBJdCdkIHByb2JhYmx5
IG1ha2Ugc2Vuc2UNCnRvIGV4dGVuZCB0aGUgYWZvcmVtZW50aW9uZWQgcGF0Y2ggdG8gbW92ZSB1
bnNpZ25lZCAtPiBzaXplX3QuDQoNClJlZ2FyZHMNCg0KQW5hdG9sDQoNCg==
