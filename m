Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A84E2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vipChzRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbfHHVB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:01:57 -0400
Received: from mail-eopbgr800089.outbound.protection.outlook.com ([40.107.80.89]:18144
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbfHHVB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:01:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm1TUiFLVTeFk1U7e8IZucu8tKqJelbSEhMtXUzfK8mtag4AMSiIrN0iugaYTkKoPFNou6K1BL4C2ocgFjxjmtQzRQ9VtVH4pZgU8667N8RVQnf+8+BnKYyzLfAgpJj3ADi6Xuph5RUliuJBqgpYv0Gb+ZRrCeiPKZEEzYTsIPmFhfwp7EkIFA0WtXO8x6X2c7wsFiAOVDUNIrQTMX49k5abN95HYCQ1JEOr13YBtK8VJZWH3rqfCI8kTPIw6SLpaNDF0yFj/pz7T8MZ4UfpTYNR7UMyetFoI79aBZrDfnEMpPE4aafdBbfoG8LxzwsoLlGafqOpQHHD37QVppk4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKk0ivlCA4FPt8lfgrrHWEwjFSN0KZLykJuNIZ8M0xA=;
 b=PegwCPoDvsdBPgvD9U3Ddzod5zVUQMGNKfgjetqkJVtSGDpKg9gryiK0cleKcZG+PHEN3tlrv59ugGGAZjdZgYQTu9d60ePCNPwLw6bO6gRLYb4OKTEw5ruLqvdSWJqCj80k305hwQzQMgkuJpDRkMlpZhfZnAu2BL8Zw0LfDX3bJM1KuUjhcqvHaZWHzzUDjJCK/aq1cnzl5oFPmaT0e8LHWmJN+RE0weqzMBbZHpGaAYRhFMrQphPb90S+j9PSINvtAXr9BNf1HZ1xB78zWm189YG14gE0/74l7d5OP+jvoMgUbXekKW9TIo66B4do4VwmPzRnCvL4hm2+D7OrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKk0ivlCA4FPt8lfgrrHWEwjFSN0KZLykJuNIZ8M0xA=;
 b=vipChzRoIzNrW9TsBKJQw0rulvvfIzlRUII9NR7vglA8GeRfa8o8TZeo49aoN5iWnFBH+kvJwF9da17XMB9zeds0nGDSW+IC3uB2z98PZsQamPDPmjcYQtLktmlNKQt2EqV6Z5mUN1JVpy2azO1YCWJyRWNiuveMaNTqxuAjP9Q=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3723.namprd12.prod.outlook.com (10.255.172.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Thu, 8 Aug 2019 21:01:52 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 21:01:51 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
Thread-Topic: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
Thread-Index: AQHVSDHageyJLuj1e02we0A4NQI8qKbl4bwAgAAFR4CAAAXXgIAABMSAgAACPYCAAB85AIAAXHyAgAtSC4CAAAbxAA==
Date:   Thu, 8 Aug 2019 21:01:51 +0000
Message-ID: <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
 <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com>
 <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
 <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com>
 <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:805:f2::38) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d675d49-a848-4e50-dbd7-08d71c43a2cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3723;
x-ms-traffictypediagnostic: DM6PR12MB3723:
x-microsoft-antispam-prvs: <DM6PR12MB3723E9CC5C91720A1D4460F0ECD70@DM6PR12MB3723.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(199004)(189003)(6512007)(186003)(66446008)(66556008)(99286004)(6916009)(76176011)(71190400001)(52116002)(6506007)(53546011)(71200400001)(386003)(6486002)(14454004)(316002)(31686004)(7736002)(305945005)(478600001)(54906003)(6436002)(229853002)(86362001)(31696002)(3846002)(6116002)(8676002)(53936002)(8936002)(66476007)(64756008)(6246003)(66946007)(25786009)(66066001)(36756003)(4326008)(256004)(14444005)(446003)(2616005)(11346002)(476003)(486006)(81156014)(102836004)(2906002)(26005)(5660300002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3723;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jAcO/MH65Jqpx/+NyiuRnbsRdjA7cLtTAMcj3zMbebYfa9BWjZaKJxjSYwZFczHX9Lr4JFPv3ojq2TgVCbrVxCCUa+qOCVNhQteHtd7Qb9lzvCHx5hD3bAngr6lwgHxe/nYgN+WRWzvvZTa9EdYojnE54ZM06g3rMNAff9c7LjUih01G+gpq9rzxBml5rGyVC1Bd634ByiWWJFx6KHJSij9mcNucxKuqIv0djnVHmdLpdZcowcbNOBAYk+yI9L1yyHLglntxsIKcAp+VOT6rpd9OAShWKl+A7uzyjUAGZ0HTW+CqoIYNeQqiprNEERdLWxm+yNtoglKnLvDJ4bTGdufpeWAjnZ1iR0XM6RLiPTN7RTNt5iii9FEWblaZLVaQh+r1NTnknygi2FuTFY+lZfvB3En3JqRHGBDc/1CJKz8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <17B16FCF6834F64693DEA0A3F867000A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d675d49-a848-4e50-dbd7-08d71c43a2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 21:01:51.7931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8+7pEntXrdss2bTf5idIy9Z9VNB7vB22ozqbSnLFvOyr5e1ZVLLniKpcbP5TCJgudwoPEvGilxPYrXbz+M1Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLA0KDQpPbiA4LzgvMTkgMzozNiBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0K
PiBUb20sDQo+IA0KPiBPbiBUaHUsIDEgQXVnIDIwMTksIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6
DQo+PiBPbiA4LzEvMTkgNToxMyBBTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+ICAgIDIu
MS45IFRpbWVycw0KPj4+DQo+Pj4gICAgIEVhY2ggY29yZSBpbmNsdWRlcyB0aGUgZm9sbG93aW5n
IHRpbWVycy4gVGhlc2UgdGltZXJzIGRvIG5vdCB2YXJ5IGluDQo+Pj4gICAgIGZyZXF1ZW5jeSBy
ZWdhcmRsZXNzIG9mIHRoZSBjdXJyZW50IFAtc3RhdGUgb3IgQy1zdGF0ZS4NCj4+Pg0KPj4+ICAg
ICAqIENvcmU6Olg4Njo6TXNyOjpUU0M7IHRoZSBUU0MgaW5jcmVtZW50cyBhdCB0aGUgcmF0ZSBz
cGVjaWZpZWQgYnkgdGhlDQo+Pj4gICAgICAgUDAgUHN0YXRlLiBTZWUgQ29yZTo6WDg2OjpNc3I6
OlBTdGF0ZURlZi4NCj4+Pg0KPj4+ICAgICAqIFRoZSBBUElDIHRpbWVyIChDb3JlOjpYODY6OkFw
aWM6OlRpbWVySW5pdGlhbENvdW50IGFuZA0KPj4+ICAgICAgIENvcmU6Olg4Njo6QXBpYzo6VGlt
ZXJDdXJyZW50Q291bnQpLCB3aGljaCBpbmNyZW1lbnRzIGF0IHRoZSByYXRlIG9mDQo+Pj4gICAg
ICAgMnhDTEtJTjsgdGhlIEFQSUMgdGltZXIgbWF5IGluY3JlbWVudCBpbiB1bml0cyBvZiBiZXR3
ZWVuIDEgYW5kIDguDQo+Pj4NCj4+PiBUaGUgUnl6ZW5zIHVzZSBhIDEwME1IeiBpbnB1dCBjbG9j
ayBmb3IgdGhlIEFQSUMgbm9ybWFsbHksIGJ1dCBJJ20gbm90IHN1cmUNCj4+PiB3aGV0aGVyIHRo
aXMgaXMgc3ViamVjdCB0byBvdmVyY2xvY2tpbmcuIElmIHNvIHRoZW4gaXQgc2hvdWxkIGJlIHBv
c3NpYmxlDQo+Pj4gdG8gZmlndXJlIHRoYXQgb3V0IHNvbWVob3cuIFRvbT8NCj4+DQo+PiBMZXQg
bWUgY2hlY2sgd2l0aCB0aGUgaGFyZHdhcmUgZm9sa3MgYW5kIEknbGwgZ2V0IGJhY2sgdG8geW91
Lg0KPiANCj4gYW55IHVwZGF0ZSBvbiB0aGlzPyBUaGUgcHJvYmxlbSBzZWVtcyB0byBjb21lIGlu
IGZyb20gc2V2ZXJhbCBzaWRlcyBub3cuDQoNClllcywgc29ydCBvZi4gVGhlcmUgYXJlIHR3byB3
YXlzIHRvIG92ZXJjbG9jayBhbmQgaXQgYWxsIGRlcGVuZHMgb24gd2hpY2gNCm9uZSB3YXMgdXNl
ZC4gSWYgdGhlIG92ZXJjbG9ja2luZyBpcyBkb25lIGJ5IGNoYW5naW5nIHRoZSBtdWx0aXBsaWVy
cywNCnRoZW4gdGhhdCAxMDBNSHogY2xvY2sgd2lsbCBzdGlsbCBiZSAxMDBNSHouIEJ1dCBpZiB0
aGUgb3ZlcmNsb2NraW5nIGlzDQpkb25lIGJ5IGluY3JlYXNpbmcgdGhlIGlucHV0IGNsb2NrLCB0
aGVuIHRoYXQgMTAwTUh6IGNsb2NrIHdpbGwgYWxzbw0KaW5jcmVhc2UuDQoNCkkgd2FzIHRyeWlu
ZyB0byBnZXQgYSBiaXQgbW9yZSBjbGFyaWZpY2F0aW9uIG9uIHRoaXMgYmVmb3JlIHJlcGx5aW5n
LCBidXQNCml0IGNhbiBiZSBkZXRlY3RlZCBpbiBzb2Z0d2FyZS4gVGhlIGJhc2UgY2xvY2sgaXMg
MTAwTUh6LCBzbyByZWFkIHRoZSBQMA0KbXVsdGlwbGllciBhbmQgdGhlIFRTQyBzaG91bGQgYmUg
Y291bnRpbmcgYXQgUDAgKiAxMDBNSHouIElmIHlvdSBjYWxpYnJhdGUNCnRoZSBzcGVlZCBvZiB0
aGUgVFNDIHdpdGggdGhlIEhQRVQgeW91IGNhbiBzZWUgd2hhdCBzcGVlZCB0aGUgVFNDIGlzDQpj
b3VudGluZyBhdC4gSWYgeW91IGRpdmlkZSB0aGUgVFNDIGRlbHRhIGZyb20gdGhlIEhQRVQgY2Fs
aWJyYXRpb24gYnkgdGhlDQpQMCBtdWx0aXBsaWVyIHlvdSB3aWxsIGVpdGhlciBnZXQgMTAwTUh6
IGlmIHRoZXJlIGlzIG5vIG92ZXJjbG9ja2luZyBvciBpZg0KdGhlIG11bHRpcGxpZXIgbWV0aG9k
IG9mIG92ZXJjbG9ja2luZyB3YXMgdXNlZCwgb3RoZXJ3aXNlIHlvdSdsbCBnZXQgYQ0KaGlnaGVy
IHZhbHVlIGlmIHRoZSBpbnB1dCBjbG9jayBtZXRob2Qgd2FzIHVzZWQuIEVpdGhlciB3YXksIHRo
YXQgc2hvdWxkDQpnaXZlIHlvdSB0aGUgQVBJQyBjbG9jayBzcGVlZCBiYXNlZCBvbiBhIHN0YXJ0
aW5nIGFzc3VtcHRpb24gb2YgMTAwTUh6Lg0KDQpJJ20gbm90IGFsbCB0aGF0IGZhbWlsaWFyIHdp
dGggdGhpcyBzdHVmZiwgYnV0IEkgdGhpbmsgSSB0cmFuc2xhdGVkIHdoYXQNCndhcyB0b2xkIHRv
IG1lIHByb3Blcmx5LiBJJ20gYWxzbyBub3Qgc3VyZSBpZiB0aGlzIG1ldGhvZCBjYW4gYmUgdXNl
ZCBhdA0KdGhlIHBvaW50IGluIHRoZSBjb2RlIHRoaXMgaXMgYWxsIGhhcHBlbmluZy4gTGV0IG1l
IGtub3cgaWYgaXQgbWFrZXMgc2Vuc2UNCm9yIG5vdC4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+
IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo+IA0K
