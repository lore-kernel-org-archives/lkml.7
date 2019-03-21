Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6038EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D9D20850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="fAMDh+Dy";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="hGd5XDhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfCUO5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:57:35 -0400
Received: from sessmg22.ericsson.net ([193.180.251.58]:61608 "EHLO
        sessmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfCUO5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/relaxed;
        q=dns/txt; i=@ericsson.com; t=1553180244; x=1555772244;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BCfnl8hkpUqjnTCf1hzyajosb271ODnfAa15lPXIOk0=;
        b=fAMDh+Dy8Oprpku3THk6/fjFTdxGDSTw5KE8rkQte5YXtUfW8y0SIIfVXSEF7tvg
        vvHzRzma44uZ9i/Z2EHfZ7kIH6me7FxsiR1iD6g2nqT8FURp46v5k5gbggxyxhts
        44fje1S0ChT35oi2NspwDQlLxvQJDrcl9zdQrw/AGe4=;
X-AuditID: c1b4fb3a-017ff70000001645-38-5c93a6548e95
Received: from ESESSMB502.ericsson.se (Unknown_Domain [153.88.183.120])
        by sessmg22.ericsson.net (Symantec Mail Security) with SMTP id 6A.71.05701.456A39C5; Thu, 21 Mar 2019 15:57:24 +0100 (CET)
Received: from ESESSMB505.ericsson.se (153.88.183.166) by
 ESESSMB502.ericsson.se (153.88.183.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 21 Mar 2019 15:57:24 +0100
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESSMB505.ericsson.se (153.88.183.166) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5 via Frontend Transport; Thu, 21 Mar 2019 15:57:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCfnl8hkpUqjnTCf1hzyajosb271ODnfAa15lPXIOk0=;
 b=hGd5XDhgO8qINppUwYx6wtf6v9+8+7zBIKYmvwY4Viy3f3ylz0i2xNemHK3GBm3lZd73uMRhNUMMx7zQYb2NrVTQeHdRAjxQiJ4jA1KLM+mP+m2ywyvOzLssrNOrZs46y7KsQY8edsHKoZ+ZSuEnV1DKOoX5UqbdsvIOC+wuLiE=
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com (52.132.21.33) by
 BL0PR1501MB2051.namprd15.prod.outlook.com (52.132.21.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 14:57:21 +0000
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047]) by BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047%4]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 14:57:21 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
Thread-Topic: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
Thread-Index: AQHU1URbJbY3pMcMUU6L6QM6fD+WRaYU9eYAgAAcz4CAAPnLAIAANGKA
Date:   Thu, 21 Mar 2019 14:57:21 +0000
Message-ID: <BL0PR1501MB2003762D0D1CB08622C9244F9A420@BL0PR1501MB2003.namprd15.prod.outlook.com>
References: <20190308001723.GA11197@archlinux-ryzen>
 <20190320190752.GA28744@archlinux-ryzen>
 <CAKwvOd=6916txvLmtEC3BcZgjLTNdtU-ou=YM+_dsd8CC-T_zw@mail.gmail.com>
 <CAK8P3a2pGo8HeHS5zcFnc_jLiLkXSPWKe4AYVm4TAmZxc_h2GA@mail.gmail.com>
In-Reply-To: <CAK8P3a2pGo8HeHS5zcFnc_jLiLkXSPWKe4AYVm4TAmZxc_h2GA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [195.39.71.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76ad6ac1-6bc2-432b-d802-08d6ae0d857f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB2051;
x-ms-traffictypediagnostic: BL0PR1501MB2051:
x-microsoft-antispam-prvs: <BL0PR1501MB205115E7AB9C713EF1FA4C739A420@BL0PR1501MB2051.namprd15.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(13464003)(53936002)(446003)(476003)(11346002)(76176011)(106356001)(8936002)(7696005)(102836004)(33656002)(68736007)(6506007)(53546011)(99286004)(4326008)(74316002)(26005)(305945005)(7736002)(186003)(8676002)(14444005)(81156014)(6246003)(6436002)(54906003)(25786009)(110136005)(71190400001)(97736004)(9686003)(229853002)(256004)(2906002)(66066001)(81166006)(5660300002)(55016002)(316002)(71200400001)(6116002)(14454004)(3846002)(105586002)(52536014)(486006)(86362001)(93886005)(478600001)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1501MB2051;H:BL0PR1501MB2003.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oiheTwZnH5rD6j3HEmrlCsjndj35tR0Bsx6z75hjfDvfzdlJuf+LFzkyjBak6/7X2QgNIINw+UGvru6IvdoruvjA178Pe/0dMdSRv2mr3gY4uj3pCK86AjrLLX8uxaFRx+nADjmgbH59dXHF2kkGFGPr+mQjkVDhMfwQowEXrS5r4yFSh6zYQxWghrdyxTl3WIUJnQn6h680Z3Kse4S2D6qUQyILCB+klUsfrbLVe/rsG+BJu/Byk9jy19yAn1T6jY2PIO2VBvsAT+U8CzTxYaAIYJJCBNVHUeNgXuUpNNRONAZVoH/Un20/fDdZfvm2hmSh6EAtOendD0P4KKDc6MEIJhVpSGuqn4vBGOLf0jHOp2l8EuGFU1Sv0JGkiXytSiD8CY2YHxqq0YvI1rOsuYriHeS9UvYJmMlKJbtlFLo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ad6ac1-6bc2-432b-d802-08d6ae0d857f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 14:57:21.5168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2051
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGuTOzs+PSwnXzcdDUXKjM1LUHNWVIFtQU9jD6I20plxzU0tV2
        1sggkNQSLV0fmK6WIqapmWgbmuYjS0FDtCLUwkw0xbIyelhZ2o6zQf/9vnO/c75z4DKkqkPm
        wkTrjbxBr4tR0wqq8GjjOd8jFbla//fTGvZPTrecfTNTRLPF/SkU+7y5mGZnPxjZWdMiwXaX
        OrGW/lPs+OAgucOOm/+VgzhL1TDB3TePyLnShgTuQXYPzbWUfiG4Lw3uXJ3lHnGICVNsj+Bj
        os/yBk1guCJqYHaSju/wOFe0uCYJDbmnIzsG8CbIflqL0pGCUeHHCHI/Tsgl8R3BQkESIYly
        AkYyy2lRUNhEQn1Xo60nnwCzJYWWxCSCxq9pMnEyjb1gOj8NieyA98NA0xWZaCLxDAH9bT+X
        TMvxHjC13SUlEwcFP77ZeDdMZz6lRKbwKmhpXaRFVuJwGLUM2dI+WDe8cckqGMYOh8CLaoXo
        QdgJ5npvEyKT2BleTpQQ0qkYyh/0kxI7wvT4gkxsRTgUnrwNlcqeUNPXjiR2g2clGUi0gHX/
        iYFdYirgVwievy6RSx4fGL3eZ+M4MFXU0BKvgLrhMkJq+CaD9syppaEqzENlbaotwB2qr45R
        JuRj/m9VszWPxGuhrlkjlT0hL2NMbl663h56CieoUkRVI0eBF4TYyA0b/HhD9ElBiNP76Xlj
        A7L+q4eW+W1N6OFUUCfCDFIvUx7Mz9WqZLqzQmJsJwKGVDsom49ZS8oIXeJ53hB3wpAQwwud
        yJWh1M7K3yp7rQpH6oz8aZ6P5w3/XgnGziUJxV3ozQ5I6GksOBjgfWe1MVgTuDn5/rstrWvr
        Sf2tjUHXynyTg/1ycg6fKcmrz7JY9pZxc5lF+7ce6eh6t3LYNazlps+g3Gu0R/vx0eVgk8dV
        p1QH1LQuy/fx8U/7tigcGxKpReeLJzmF1j9kV5WPm2ZnZTjWZjl9/v7ogGd1zJxXm5oSonTr
        vUmDoPsLM0zJR1MDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogMjEtTWFyLTE5IDEyOjQ1DQo+IFRvOiBOaWNrIERlc2F1
bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4NCj4gQ2M6IE5hdGhhbiBDaGFuY2VsbG9y
IDxuYXRlY2hhbmNlbGxvckBnbWFpbC5jb20+OyBKb24gTWFsb3kNCj4gPGpvbi5tYWxveUBlcmlj
c3Nvbi5jb20+OyBZaW5nIFh1ZSA8eWluZy54dWVAd2luZHJpdmVyLmNvbT47IERhdmlkIFMuDQo+
IE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IHRpcGMtZGlzY3Vzc2lvbkBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQ7DQo+IE5ldHdvcmtpbmcgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+OyBMS01M
IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IGNsYW5nLWJ1aWx0LWxpbnV4QGdv
b2dsZWdyb3Vwcy5jb20NCj4gU3ViamVjdDogUmU6IC1Xc29tZXRpbWVzLXVuaW5pdGlhbGl6ZWQg
Q2xhbmcgd2FybmluZyBpbiBuZXQvdGlwYy9ub2RlLmMNCj4gDQo+IE9uIFdlZCwgTWFyIDIwLCAy
MDE5IGF0IDk6NTEgUE0gJ05pY2sgRGVzYXVsbmllcnMnIHZpYSBDbGFuZyBCdWlsdCBMaW51eA0K
PiA8Y2xhbmctYnVpbHQtbGludXhAZ29vZ2xlZ3JvdXBzLmNvbT4gd3JvdGU6DQo+ID4gT24gV2Vk
LCBNYXIgMjAsIDIwMTkgYXQgMTI6MDcgUE0gTmF0aGFuIENoYW5jZWxsb3INCj4gPiA8bmF0ZWNo
YW5jZWxsb3JAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSB1c2UgaW4gdGlwY19iZWFy
ZXJfeG1pdCgpIGlzbid0IGV2ZW4gZ3VhcmFudGVlZCB0byBzZXQgdGhlIGluL291dA0KPiA+IHBh
cmFtZXRlciwgc28gZXZlbiBpZiB0aGUgaWYgaXMgdGFrZW4gZG9lc24ndCBndWFyYW50ZWUgdGhh
dCBtYWRkciBpcw0KPiA+IGFsd2F5cyBpbml0aWFsaXplZCBiZWZvcmUgY2FsbGluZyB0aXBjX2Jl
YXJlcl94bWl0KCkuDQo+IA0KPiBSaWdodCwgaXQgaXMgb25seSBpbml0aWFsaXplZCBpbiBjZXJ0
YWluIHN0YXRlcy4gSXQgd2FzIGFsd2F5cyBpbml0aWFsaXplZCB1bnRpbA0KPiBjb21taXQgNTk4
NDExZDcwZjg1ICgidGlwYzogbWFrZSByZXNldHRpbmcgb2YgbGlua3Mgbm9uLWF0b21pYyIpLA0K
PiBhZnRlcndhcmRzIG9ubHkgaWYgdGhlIGxpbmsgd2FzIG5vdCByZXNldCwgYW5kIGFzIG9mIGNv
bW1pdCA3M2Y2NDZjZWMzNTQNCj4gKCJ0aXBjOiBkZWxheSBFU1RBQkxJU0ggc3RhdGUgZXZlbnQg
d2hlbiBsaW5rIGlzIGVzdGFibGlzaGVkIikgb25seSBpZiBpdCdzIG5vdA0KPiAnZXN0YWJsaXNo
aW5nJyBvciAncmVzZXQnLg0KPiANCj4gPiBBdCB0aGUgbWluaW11bSwgd2Ugc2hvdWxkIGluaXRp
YWxpemUgbWFkZHIgdG8gTlVMTC4gIEkgdGhpbmsgd2UnZA0KPiA+IHByZWZlciB0byByaXNrIHRo
ZSBwb3NzaWJpbGl0eSBvZiBhIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSB0byB0aGUNCj4gPiBw
b3NzaWJpbGl0eSBvZiB3b3JraW5nIHdpdGggdW5pbml0aWFsaXplZCBtZW1vcnkuICBUbyBiZSBj
bGVhciwgYm90aA0KPiA+IGFyZSBiYWQsIGJ1dCBvbmUgaXMgZWFzaWVyIHRvIHNwb3QvZGVidWcg
bGF0ZXIgdGhhbiB0aGUgb3RoZXIuDQo+IA0KPiBJIGRpc2FncmVlIHdpdGggc2V0dGluZyBpdCB0
byBOVUxMLCBnaXZlbiB0aGF0IGl0IGlzIHN0aWxsIGFuIG9idmlvdXNseSBpbmNvcnJlY3QNCj4g
dmFsdWUuIFdlIGNvdWxkIGFkZCBhIGlmKG1hZGRyKSBjaGVjayBiZWZvcmUgY2FsbGluZyB0aXBj
X2JlYXJlcl94bWl0KCksIGJ1dA0KPiBJIHRoaW5rIGl0IHdvdWxkIGJlIGNsZWFyZXIgdG8gY2hl
Y2sNCj4gc2tiX3F1ZXVlX2VtcHR5KHhtaXRxKSkgaWYgdGhhdCBhdm9pZHMgdGhlIHdhcm5pbmc6
DQoNCkkgbWF5IGJlIHdyb25nLCBidXQgSSB3b3VsZCBiZSBzdXJwcmlzZWQgaWYgdGhhdCB3b3Vs
ZCBlbGltaW5hdGUgdGhlIHdhcm5pbmcuDQpUbyBtZSwgc2V0dGluZyBtYWRkciB0byBOVUxMIGFu
ZCB0aGVuIHRlc3RpbmcgZm9yIGl0IGxvb2tzIGJvdGggbW9yZSBjb21wcmVoZW5zaWJsZSBhbmQg
aXMgZ3VhcmFudGVlZCB0byBmaXggdGhlIHdhcm5pbmcuDQoNCj4gDQo+IGRpZmYgLS1naXQgYS9u
ZXQvdGlwYy9ub2RlLmMgYi9uZXQvdGlwYy9ub2RlLmMgaW5kZXgNCj4gMmRjNDkxOWFiMjNjLi4x
NDc3ODY3OTVlNDggMTAwNjQ0DQo+IC0tLSBhL25ldC90aXBjL25vZGUuYw0KPiArKysgYi9uZXQv
dGlwYy9ub2RlLmMNCj4gQEAgLTg0NCw3ICs4NDQsOCBAQCBzdGF0aWMgdm9pZCB0aXBjX25vZGVf
bGlua19kb3duKHN0cnVjdCB0aXBjX25vZGUgKm4sDQo+IGludCBiZWFyZXJfaWQsIGJvb2wgZGVs
ZXRlKQ0KPiAgICAgICAgIHRpcGNfbm9kZV93cml0ZV91bmxvY2sobik7DQo+ICAgICAgICAgaWYg
KGRlbGV0ZSkNCj4gICAgICAgICAgICAgICAgIHRpcGNfbW9uX3JlbW92ZV9wZWVyKG4tPm5ldCwg
bi0+YWRkciwgb2xkX2JlYXJlcl9pZCk7DQo+IC0gICAgICAgdGlwY19iZWFyZXJfeG1pdChuLT5u
ZXQsIGJlYXJlcl9pZCwgJnhtaXRxLCBtYWRkcik7DQo+ICsgICAgICAgaWYgKHNrYl9xdWV1ZV9l
bXB0eSh4bWl0cSkpDQo+ICsgICAgICAgICAgICAgICB0aXBjX2JlYXJlcl94bWl0KG4tPm5ldCwg
YmVhcmVyX2lkLCAmeG1pdHEsIG1hZGRyKTsNCj4gICAgICAgICB0aXBjX3NrX3JjdihuLT5uZXQs
ICZsZS0+aW5wdXRxKTsgIH0NCj4gDQo+IFRoaXMgZHVwbGljYXRlcyB0aGUgY2hlY2sgaW5zaWRl
IG9mIHNrYl9xdWV1ZV9lbXB0eSgpLCBidXQgSSBkb24ndCBrbm93IGlmDQo+IHRoZSBjb21waWxl
ciBjYW4gc2VlIHRocm91Z2ggdGhlIGxvZ2ljIGJlaGluZCB0aGUgaW5saW5lZCBmdW5jdGlvbiBj
YWxscy4NCg0KUHJvYmFibHkgbm90LCBidXQgdGhpcyBpcyBub3QgaW4gYW55IHdheSB0aW1lIGNy
aXRpY2FsLg0KDQovLy9qb24NCg0KPiANCj4gICAgICAgQXJuZA0K
