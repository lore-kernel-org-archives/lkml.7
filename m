Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B088C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444DF24651
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KYSgUTVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfLEOcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:32:46 -0500
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:19544
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729187AbfLEOcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:32:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNMAkDmq+BHVkzeDiWWNdkE3daTmsMv4vQSk/9SiZW7EkpYnpEzqwMi+zSH1Dk37UwkZ3kG3RW8/XEJVRjYLq03V3u2ZM2snvHi2ZqnvOVEebSQAQzkTdOe0KBpr9q/IzlUta36o3tUFAtz1s7jvQnb/WatIGl9wFtOKGp7anwEowE/Ohi/LHe7jWD9F3+dM7jEhWBywVupxk+kCZyCv0EizGVYWnSnwKc1v7WsFRZ+WK07DJ7iovXgig6YBBKHh9/hjG5WMlTXYPdgIKIK6oP/Qf0wzg1jwIzKHthV0aM34VKCLsWnvRvbuMl5ae3yOQUSCSTWstLl9ErYSQd91cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfoxEXZxHbCbmU2Y+qi+PiVmMoJvHCcJeSpPezHx+JA=;
 b=Z0sV39XKEQm5pOxxokSGugaB2+m0Q0xMtFsoJyWrXEU9pKLIeH4vlQMDfGK4idGal5OwsqP28nfbDG16E8xQn3iV/jNXjpYyVz+BRy8EU59t5AtXIMCFdlvrFU8QFbdw1HTGX5SoCuBSvb4Y0korMvI0OeXmuMN10dw3uQlk8709l51uN/Go5zbt8+LjoWCcTfldkfFTGT0vUK3L4d4h5n7QR/ltX+jIX1TeJKCicJHA5GSLeuXidwSDJRah0hIFkkntY3bqfmZgUJGJM3PcwmOtQMFbcS+1VHn3JuW99CoDzac2xkmnXephWXVuyTRBJCXvoL9EJuz7OWk5zW6P/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfoxEXZxHbCbmU2Y+qi+PiVmMoJvHCcJeSpPezHx+JA=;
 b=KYSgUTVgEU90vOYLDDv9+yvdRZMHygKx7Kzh4mj9JEmQMHFG/uTB2Amxu5xSTO3QwZoCvt+i6T79ofHR+W4LJwoBKARwZuxSRBTtPfwIn3HZwfOW4o/V8XAiFxWBYsm7yTZDmiuMPsOC+ktiqgVoGuhCVWOC9qW1GSTZGyYhD2Q=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6256.namprd05.prod.outlook.com (20.178.242.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.4; Thu, 5 Dec 2019 14:32:42 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8%7]) with mapi id 15.20.2516.003; Thu, 5 Dec 2019
 14:32:42 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "cai@lca.pw" <cai@lca.pw>,
        "Steven.Price@arm.com" <Steven.Price@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "david@redhat.com" <david@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "James.Morse@arm.com" <James.Morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Mark.Rutland@arm.com" <Mark.Rutland@arm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v15 00/23] Generic page walk and ptdump
Thread-Topic: [PATCH v15 00/23] Generic page walk and ptdump
Thread-Index: AQHVqsB6USxvVndKC0O+X8JyjIw6Nqerhn8AgAAVsoA=
Date:   Thu, 5 Dec 2019 14:32:42 +0000
Message-ID: <e1f4ec12f9b3f92e481a42698cc1a5645e0e7c0f.camel@vmware.com>
References: <20191204163235.GA1597@arm.com>
         <A22DE6B7-23A1-41FA-AF82-9613778277C7@lca.pw>
In-Reply-To: <A22DE6B7-23A1-41FA-AF82-9613778277C7@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 124be9a0-716f-429f-5876-08d7798ffcf7
x-ms-traffictypediagnostic: MN2PR05MB6256:
x-microsoft-antispam-prvs: <MN2PR05MB625669D66CD3443A1F73D97EA15C0@MN2PR05MB6256.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(51444003)(478600001)(118296001)(91956017)(71200400001)(71190400001)(25786009)(99286004)(4744005)(14454004)(6506007)(81166006)(81156014)(102836004)(53546011)(11346002)(26005)(229853002)(8676002)(14444005)(5660300002)(186003)(8936002)(110136005)(6512007)(76176011)(54906003)(2616005)(2906002)(36756003)(66476007)(6486002)(64756008)(66556008)(66946007)(66446008)(316002)(86362001)(7416002)(305945005)(76116006)(4326008)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6256;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QU4Cf3eSmzVw0r7os7uFmTHNjhK+9MIBlIvb/rmgpYKhobMJ/NZfQ/sEEuWFVsEm1VorbqkGqVRlFiHaih9aIX6I7yUJVMhRXlHJOhY/gqOv6rx1xLE+qnCgOd5Hta7scbu2/iNEZi+UcMEsTodaltDR0OBUxLKb9siL9Axn54mX9VvWLdy7DqXD593PSHHM/As1lMLjF07yQ2AydnuvUJbL4aKORPapVYuIsFFuikbjR1wVRSLHBlxRADQ6+kDWBJki9hstii1KaRAJG/pSEUsySgdgjNR74MXYCGx6dscpuqb1pLi0geUIbN6E6utadnC8jruGHMedUFQsJEf4j/4RDuf5RmMXc01+H95zoLdjzI5eH6IohspA4EICABakuQIpj3nhZmi8JYSoCO1OkcejKHNE8kwdDDxJgETOc8ePpu6jt2owS44RsEafE7C2gysydEYAn9h6ZBxBVVySjffVA+BvLpWdMWalqNkXK4o6VNPfFelQXN21tE9R3jwVKqzOdX+ALy7aF9bX8Szf/A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0994E79E8BDA142B9B53DD6041EC256@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124be9a0-716f-429f-5876-08d7798ffcf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 14:32:42.6138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRp0/HU5dCIkuF37RT00HuB6swrBHCUjIoiXQNODN4DJI+gbFm7bCY6JylisgvukU+FUT4SDECEBSiYh0X70zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTA1IGF0IDA4OjE1IC0wNTAwLCBRaWFuIENhaSB3cm90ZToNCj4gPiBP
biBEZWMgNCwgMjAxOSwgYXQgMTE6MzIgQU0sIFN0ZXZlbiBQcmljZSA8U3RldmVuLlByaWNlQGFy
bS5jb20+DQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gSSd2ZSBiaXNlY3RlZCB0aGlzIHByb2JsZW0g
YW5kIGl0J3MgYSBtZXJnZSBjb25mbGljdCB3aXRoOg0KPiA+IA0KPiA+IGFjZTg4ZjEwMThiOCAo
Im1tOiBwYWdld2FsazogVGFrZSB0aGUgcGFnZXRhYmxlIGxvY2sgaW4NCj4gPiB3YWxrX3B0ZV9y
YW5nZSgpIikNCj4gDQo+IFNpZ2gsIGhvdyBkb2VzIHRoYXQgY29tbWl0IGVuZCB1cCBtZXJnaW5n
IGluIHRoZSBtYWlubGluZSB3aXRob3V0DQo+IGdvaW5nIHRocm91Z2ggQW5kcmV34oCZcyB0cmVl
IGFuZCBtaXNzZWQgYWxsIHRoZSBsaW51eC1uZXh0IHRlc3Rpbmc/IEl0DQo+IHdhcyBtZXJnZWQg
aW50byB0aGUgbWFpbmxpbmUgT2N0IDR0aD8NCg0KSXQgd2FzIGFja2VkIGJ5IEFuZHJldyB0byBi
ZSBtZXJnZWQgdGhyb3VnaCBhIGRybSB0cmVlLCBzaW5jZSBpdCB3YXMNCnBhcnQgb2YgYSBncmFw
aGljcyBkcml2ZXIgZnVuY3Rpb25hbGl0eS4gSXQgd2FzIHByZWNlZGVkIGJ5IGEgZmFpcmx5DQps
ZW5naHR5IGRpc2N1c3Npb24gb24gbGludXgtbW0gLyBsaW51eC1rZXJuZWwuDQoNCkl0IHdhcyBt
ZXJnZWQgaW50byBkcm0tbmV4dCBvbiAxOS0xMS0yOCwgSSB0aGluayB0aGF0J3Mgd2hlbiBpdA0K
bm9ybWFsbHkgaXMgc2VlbiBieSBsaW51eC1uZXh0LiBNZXJnZWQgaW50byBtYWlubGluZSAxOS0x
MS0zMC4gQW5kcmV3J3MNCnRyZWUgZ290IG1lcmdlZCAxOS0xMi0wNS4NCg0KbGludXgtbmV4dCBz
aWduYWxlZCBhIG1lcmdlIGNvbmZsaWN0IGZyb20gb25lIG9mIHRoZSBwYXRjaGVzIGluIHRoaXMN
CnNlcmllcyAobm90IHRoaXMgb25lKSByZXNvbHZlZCBtYW51YWxseSB3aXRoIHRoZSBha3BtIHRy
ZWUgb24gMTktMTItMDIuDQoNClRob21hcw0KDQoNCg0KDQoNCg0K
