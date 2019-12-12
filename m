Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A12C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C11206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fernfh.onmicrosoft.com header.i=@fernfh.onmicrosoft.com header.b="iq0wGDEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfLLSmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:42:42 -0500
Received: from mail-eopbgr60096.outbound.protection.outlook.com ([40.107.6.96]:10402
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730255AbfLLSmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:42:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEoeN5zc2o827TIADWRqkr9PPohHOIqfoDntvzP8pazlNDcYENaJBnC04p1mbn7Wqh3i3i8HapXdn8Dke9Eorarp7IX5Wz/5D3ytrQV/eEV+SkAZPR/B50EDnFTyPMtSS55jy1Usgj1B862mGG45ZRfmN5RM+akuObHxN2CiXqrw1iQOC2LRYWKZ7RjSMEQFmER/TuMOycUOIoG0Upp8/OnKJMD98Kb4ULZY9MN0A3IX0ECdzMB+A7144tj0fWnDB36FaR8zFKQ3qKlZPSLGEaea62wb0XCez5z7H7b3qJPgmBP/ZwyMsazDXRwPq7afs1g8l/q3CKYYLupFS/modw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95ZqWF8h8XuSB5KDMDHlG3GuTLHnz+ElGFR5tdEkH7E=;
 b=lor3CIN4OqsTygYyoxQJZUgkwXLbfO2+7XccNkg71L0toWrNMA9U6ZAZpTtN0gLFKRWfbxxLXXsfuG5NNGYpdcJZnLMf8RcgezNvOdj4YjfH0EyaLijECUh/LdwIFh1x62/LvfMwWb5UwIbgfjCFlT/5hX1HCkKjYkobYpZlcyrZp1zgiLzHlb8zed/z/mbz8Z0n431hPYcTQI1SOJzyHvvXbZqq2Gf1GITHAqeKtA79xiqLQXNv+wDwqTxNettiP4rrmwoXhaKSizDjXn9ZLaDjLswD4Yc70McAU9y02uHfyi18oKFmFhREC4cqHvFIIKMqbSv6M2CVD0v5/zNW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.fernfh.ac.at; dmarc=pass action=none
 header.from=mail.fernfh.ac.at; dkim=pass header.d=mail.fernfh.ac.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fernfh.onmicrosoft.com; s=selector2-fernfh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95ZqWF8h8XuSB5KDMDHlG3GuTLHnz+ElGFR5tdEkH7E=;
 b=iq0wGDEqrh8KcUjgY71u+c28CGGRR9UbmrbrYnH45yjpSzKw3J+yoV+c3jwEYU+ZBzfDDem1VBMvgxACewVoFzJVOSVXfVdHK7un/KyWI05I7ozBxevlsrmUSHw7qi7D1TQmFwm5crSMjq/JB1/w9Is71plrjkI2RUttzmbOwnc=
Received: from VI1PR04MB4207.eurprd04.prod.outlook.com (52.134.30.160) by
 VI1PR04MB7072.eurprd04.prod.outlook.com (10.186.158.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 12 Dec 2019 18:42:38 +0000
Received: from VI1PR04MB4207.eurprd04.prod.outlook.com
 ([fe80::6184:c205:89db:910a]) by VI1PR04MB4207.eurprd04.prod.outlook.com
 ([fe80::6184:c205:89db:910a%3]) with mapi id 15.20.2538.012; Thu, 12 Dec 2019
 18:42:38 +0000
From:   Focke Christian <christian.focke@mail.fernfh.ac.at>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Power management on HP EliteBook x360 1030 G3
Thread-Topic: Power management on HP EliteBook x360 1030 G3
Thread-Index: AQHVsRvtSfrEUt28b02AOJBWYUqVNQ==
Date:   Thu, 12 Dec 2019 18:42:38 +0000
Message-ID: <91938add34c9b310dd612d525263ae50ad618d38.camel@mail.fernfh.ac.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0125.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::18) To VI1PR04MB4207.eurprd04.prod.outlook.com
 (2603:10a6:803:3d::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=christian.focke@mail.fernfh.ac.at; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.144.214.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fbe147a-90c1-4c70-34f1-08d77f330ff4
x-ms-traffictypediagnostic: VI1PR04MB7072:
x-microsoft-antispam-prvs: <VI1PR04MB707241200D0ABD63E515D6C7E0550@VI1PR04MB7072.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(5660300002)(6512007)(6486002)(66946007)(71200400001)(4744005)(6506007)(2616005)(26005)(66476007)(478600001)(186003)(81156014)(316002)(64756008)(786003)(52116002)(66446008)(6916009)(66556008)(86362001)(8936002)(8676002)(2906002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB7072;H:VI1PR04MB4207.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: mail.fernfh.ac.at does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oV5dgGJ7HGJFo7bN8jS1MVARukv2QkJT4qawHHWc5njmZORAdnqPMt4Wz6tdyJWV4FiqiE2txjy9/RkHHCocrX935IJXsnGOhPctHLx4v7EyboMa3C/YNCQTDwU8IhxH5OXEpkmf1MF/tK+gLX627XrLzjaBOJBiv1GTXg7m7gJlTIXSTX7kT1iV6q2DigmTbLlu/7UNX5zl1EoolbJT149ffMWl1hTr8Iuf2pZAUkWFCHTyXmwSUtQD3rG8ZaSVpwW54XA+uu9sb0Kcq5tzFb2+DvaWSgBgSg7HlCQh5bq4ZPfSv6CfWq0gTLNUfAWPxZHY7NwydRUUwoUAvOmiRW1gkARPA5b3owDe8puIz/YSr5CY5C4Wp7uai3DreViRkARTPR9J5WYFCAWXXyAAhhr/F03pfQr6nn39YlklOkXO15GGpgnHMhDeBE1lmCrM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <261B81BBA7068C458E17FA5A3FBE73D4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.fernfh.ac.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbe147a-90c1-4c70-34f1-08d77f330ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 18:42:38.6185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a94a81de-eb39-48c0-adc6-b3c18a5199fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdX6mSPFNhCL4A1N5c5uSilV3bLaprvXqFPfdjmIPJUurls4TimZCnluJ9j06uvebP66ELrGmRZWM5zF4drg45KpiD1RnNWJ20rAJRuerhX8Z2q8HmHAIgeynT22pFyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCm15IEhQIEVsaXRlQm9vayB4MzYwIDEwMzAgRzMNCjEuIG9mdGVuIHJlZnVzZXMgdG8g
c3VzcGVuZCAoSSBoYXZlIHRvIHRyaWdnZXIgaXQgdHdpY2Ugb3IgbW9yZSBvZnRlbikNCjIuIG9m
dGVuIHdha2VzIHVwIHdpdGhvdXQgYW55IGV4dGVybmFsIHRyaWdnZXIgKGxpZCBvcGVuZWQgLyBr
ZXkNCnByZXNzZWQpDQoNClF1ZXN0aW9ucw0KaS4gV2hhdCBtYXkgYmUgdGhlIHJlYXNvbiBmb3Ig
dGhpcyBzdHJhbmdlIGJlaGF2aW9yPw0KaWkuIEhvdyB0byBpbnZlc3RpZ2F0ZSBpdD8gKEkgZm91
bmQgbm90aGluZyBtZWFuaW5nZnVsIGluIHN5c2xvZy4pDQoNCkkgYW0gcnVubmluZyBEZWJpYW4g
MTAuMiB3aXRoIEdOT01FIG9uIFhvcmcsIGlmIHRoYXQncyBwb3NzaWJseQ0KaW1wb3J0YW50Lg0K
DQpUaGFua3MgZm9yIGFsbCBoaW50cywgQ2hyaXN0aWFuDQoNClAuUy4NCkluIGFsbCBteSBMZW5v
dm8gVGhpbmtQYWRzIEkndmUgaGFkIGJlZm9yZSwgc3VzcGVuZCAvIHdha2UgdXAgd2FzIG5ldmVy
DQphbiBpc3N1ZS4NCg0K
