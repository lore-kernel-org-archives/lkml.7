Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF7EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089BB22DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ew8+qID2";
	dkim=temperror (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mynpM7W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfHTWYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 18:24:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23742 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbfHTWYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566339892; x=1597875892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+ZQsapbw25RmXHksLaual3EsTd6wQNBtj5LNKixCOKs=;
  b=Ew8+qID2Y54oiCOgYeBI2Xvk0InUtsMxAUK24SyjipZUQs64Sbm5c65Q
   TsG6S8higUGxB8bqkLzuSlSES6I1R80BSucEYp39DxuZ9ugoiekB3kUIS
   Srw8E3lDSpvvQVm8S0O+Rpqab9817cfOYYAr2b9+eZ+Vd9xf/TSTZ2O27
   uCM7pzTHwaKzc74oZzvXVCDfupr4zlo+D03IuON5/8fRWyGOUO0Hws16h
   XH7aiy6ugMJSPxM2l5QnwjX0j6JFKWNivQm2w03JL0Fn21bHupK3XenkI
   g4nnPXUoSz/UfPutjSRELAgTrHRZR+mbAm2s/cl2JYxDxevFxzvP8d8l2
   Q==;
IronPort-SDR: xkuNVHo0OYeUtOJamCtAwwzR4vaYms3R87FR6vJ8LRXC/nowoUoXLZPjU2Qkrqp++qLV8wSpsQ
 gySb/TmzUOIgqbT5vWynYJ5g+4u3kCqOGxvodcyReMaHkLTSa4E6T1EY8x2eCPiS7Q+ZhFDXgE
 6i5aRLxnW/6YotKRd1CB1dhhEaN5Wl0sG4SwVX9A+wfko7xPTg83XY99rv09DWkw9wY07EdidJ
 8m4euR4pAfZcHnTSZmEGvzU1R7S29nMXuu2MgDvyJMEARRILTmy2O3C8WzYa6jQ4AXIkZt2SYQ
 N+Y=
X-IronPort-AV: E=Sophos;i="5.64,410,1559491200"; 
   d="scan'208";a="116282190"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 06:24:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPg4cnYA5LGLGoH+0OjvfKmghGLOHqv9dY3+bFN19X5ZvBgKzkpescbC8/Z7ZUrCM6uGKBAd158fgP7zo6TZmhg//HPe1nOTrP9v98pMAFibtp7hpROYKt2qAaLLgUdnFqrgj+u36eVl9LfuJsT7mVLYxhv6Qu0RlCilsNRxnO1QF19pJn3Zp1gmJ5seWMPjnw/t+6eRc6EPQBqYHqAmgs8DaE9J2skJsAFIqgnnwD+TQnP+WyUkAykofJUS2IxMTvPOFSLMBtqJ6Gw4LwnpjbslXM59MtkFSl64BbJzKeyttaLeZNNXBj9/1tbpDF99OMDqUdX2QBHr+PH3RyuELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZQsapbw25RmXHksLaual3EsTd6wQNBtj5LNKixCOKs=;
 b=HXwVgHjgcaE4Qdk/lAH9/BdQDFdtNGarDK7ChOqfzJydH7faUm9SDGMKrGRY01oFt0lvMH39Zd+Cqkuyt2pmGI5vfdQayL+2IPzXPBZrfq+kEgfgxhc2pZDnc0Lu+jsWQ4d1bzaDtqVMMMQ8uI+YCy6iagaGXKWCsqelyJTHNjTFv+ItKhEUmcSt6UaqckvixbG15u2/OmEuNOb61hVoxFgcYhkv7RPY+5e3WK1JIXSF+UZB7rUTb56JmE5j7tLv02X6IHwOEuMYACrXyLQou9UcknMwXVkbzoAkUrV9No+YKEf/1fTX0vEzYZbdKZ2NCRUhTvim4rOzyJhl1uoMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZQsapbw25RmXHksLaual3EsTd6wQNBtj5LNKixCOKs=;
 b=mynpM7W3e735XFM0SrH0jQSHtKAx0AtBKBo7Qe4FO6ID9pmuv8tfbJSeSTsj2OFkfZqHSskaAi9ol8dKAz0Z4mv1sV3GXdJ5NRQ+bWKVMkGCelDqOdjavb7ymno36jiVRdCJmPid91NdpTwTRbcPub0n0HON9PQP0kGX9G1BBIs=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5607.namprd04.prod.outlook.com (20.179.56.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 22:24:44 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 22:24:44 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Topic: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Index: AQHVVvDfUBJCIAOoL0y7jXfLdcYugacDqN07gAAPmgCAAAsggIAAujWAgAAen4CAAAHUgA==
Date:   Tue, 20 Aug 2019 22:24:44 +0000
Message-ID: <a9c7e078bd1944652274b4606dba7fa52b6112f5.camel@wdc.com>
References: <20190820004735.18518-1-atish.patra@wdc.com>
         <mvmh86cl1o3.fsf@linux-m68k.org>
         <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com>
         <20190820092207.GA26271@infradead.org>
         <76467815b464709f4c899444c957d921ebac87db.camel@wdc.com>
         <20190820221811.GA2256@infradead.org>
In-Reply-To: <20190820221811.GA2256@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2ec0f04-8b10-4082-d45a-08d725bd341a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5607;
x-ms-traffictypediagnostic: BYAPR04MB5607:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB5607D4A0FBB63BFE8224BD28FAAB0@BYAPR04MB5607.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(81166006)(316002)(186003)(2501003)(256004)(71200400001)(6246003)(2906002)(5660300002)(99286004)(7736002)(8936002)(6916009)(4326008)(66066001)(71190400001)(6306002)(86362001)(8676002)(966005)(36756003)(118296001)(6512007)(1730700003)(305945005)(53936002)(66446008)(66556008)(76176011)(64756008)(478600001)(6506007)(5640700003)(66476007)(81156014)(6116002)(54906003)(76116006)(476003)(446003)(26005)(4744005)(66946007)(486006)(6436002)(11346002)(2616005)(229853002)(5024004)(14454004)(6486002)(102836004)(2351001)(25786009)(3846002)(562404015);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5607;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hJcUZevKC/+/e7BRjXbW7/BjZ5wTSJRi1yRhNcYoxLd9+SHym2bjNyBShkzQSiFRvpEyV3FxUx63NVUpDFDS2LP/esN9kIYoodjVXQGffSHR4cKPwKloOILg4m47GkQ1rHzpTDbQnMYDiRNhvnuK25mdeWJQ7HdRoUhN99uPks8aXi1awrvZoz9VasrudNwavuiet0jisPHvOZpTMJ84eR633MHofM4BRaFBju5U+/beTQeofYVb4kbbvLAF8QI4qjMKPjdG1qX1LX3zzDdSAbpGxPXbiSZWhsLe5xrL3kkZY7PPhJyG6CUM/8fPHiOWBTelmojQHAxVMvw9MxBrFfggXhFiLNMZIrmRBxaqfYBH1OBoAtrSNXo1ovBVY/OUCiUbjYRAsAjJNnC9VYZp6jjO9awx/N7vK677vSNUaaY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <800C977B9016CC4EB7C894007593F47F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ec0f04-8b10-4082-d45a-08d725bd341a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 22:24:44.7855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAqcDeJaN9RUR/YMxIyI4P9waZArOtXnH36Z98N57hyR5nYO6wdDkLLm8l9FQN12n6HZyYL60tV1+OcY5IzI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTIwIGF0IDE1OjE4IC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBXZXN0
ZXJuIERpZ2l0YWwuIERvDQo+IG5vdCBjbGljayBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UgcmVjb2duaXplIHRoZQ0KPiBzZW5kZXIgYW5kIGtub3cgdGhhdCB0aGUgY29u
dGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIFR1ZSwgQXVnIDIwLCAyMDE5IGF0IDA4OjI4OjM2
UE0gKzAwMDAsIEF0aXNoIFBhdHJhIHdyb3RlOg0KPiA+ID4gaHR0cDovL2dpdC5pbmZyYWRlYWQu
b3JnL3VzZXJzL2hjaC9yaXNjdi5naXQvY29tbWl0ZGlmZi9lYTQwNjdhZTYxZTIwZmNmY2Y0NmE2
ZjZiZDFjYzI1NzEwY2UzYWZlDQo+ID4gDQo+ID4gVGhpcyBkb2VzIHNlZW0gYSBsb3QgY2xlYW5l
ciB0byBtZS4gV2UgY2FuIHJldXNlIHNvbWUgb2YgdGhlIGNvZGUNCj4gPiBmb3INCj4gPiB0aGlz
IHBhdGNoIGFzIHdlbGwuIEJhc2VkIG9uIE5BVElWRV9DTElOVCBjb25maWd1cmF0aW9uLCBpdCB3
aWxsDQo+ID4gc2VuZA0KPiA+IGFuIElQSSBvciBTQkkgY2FsbC4NCj4gPiANCj4gPiBJIGNhbiBy
ZWJhc2UgbXkgcGF0Y2ggb24gdG9wIG9mIHlvdXJzIGFuZCBJIGNhbiBzZW5kIGl0IHRvZ2V0aGVy
IG9yDQo+ID4geW91DQo+ID4gY2FuIGluY2x1ZGUgaW4geW91ciBzZXJpZXMuDQo+ID4gDQo+ID4g
TGV0IG1lIGtub3cgeW91ciBwcmVmZXJlbmNlLg0KPiANCj4gSSB0aGluayB0aGUgbmF0aXZlIGNs
aW50IGZvciBTLW1vZGUgd2lsbCBuZWVkIG1vcmUgZGlzY3Vzc2lvbiwgc28geW91DQo+IHNob3Vs
ZCBub3Qgd2FpdCBmb3IgaXQuDQoNCk9rIHN1cmUuIEkgd2lsbCBtb3ZlIHRoZSBjb2RlIHRvIHRs
YmZsdXNoLmMgYW5kIHJlZmFjdG9yIHRoZSB0bGIgZmx1c2gNCmZ1bmN0aW9ucyBzaW1pbGFyIHRv
IHdoYXQgeW91IGhhdmUgaW4geW91ciBwYXRjaC4NCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
