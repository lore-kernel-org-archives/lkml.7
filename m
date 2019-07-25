Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84CCC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918A821851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f7phIf/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfGYQhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:37:10 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25862
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729324AbfGYQhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5T5H0Q6d5sraIicSMWKV7nBLeVsp51znd2u2R3lvXKIvpZgQVw9s/ITv8TJEHkIhhJjvB3BYbI0zGNVQlmJMp1lYUkPcaoLfrjM0oNeMMPTQlQMcwI1z0sXQulxgMwyZCsoATw9f/mavtJ3MEvHGITfr0RJ12nsTyOoICcVFYmU3nyWHDnDuE5y4oC2KdOcYymMTSoNaaI8LNYEfFpMuP5aSgMeFQrU7DruyqIB4dWhKUJUk/B5c3hEYzn/zAxNiblQAbz4xdO0OHo5ulx3P3WJl794yvxpp1tCgf/uVQ0UaJCI1mhwLkBCtrt0OuLc09nM+JfOcD0F0Mkiq9eeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3lKPtARfX8irZnqbO+T70kXqq7C8tFOomEiUJ2tfRc=;
 b=O7LuPToDKYb77yoA2d3z83Z/VCcnMcmjTsjNM+wl0zHiwSB3RmxdjTTCZnNBYH2AwpPmGrlawgcUiBNaROV/mnb/hj01J1BpJIujOLLDewmotALyJty3LOvOyHIht5NdeEbFBlsbpCRUW4u7QE6IpWwuxgk65g6BUzR7AjGMWECLD4VZgpzmpsYTYWWCANGKkYJfeRHsT1/8qbx7kqZCVs3OjKW/L0bXfd/K/gY7lyZtNnryxkF9Vl1vikwq8GIY9DgxhtrZCfAJP1ky/ducO3LnqPwwi/ezt9vByuXcjw37Ktamovh8jbiQicaNTEOuYAzbJeITLNDA/ECfeMOHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3lKPtARfX8irZnqbO+T70kXqq7C8tFOomEiUJ2tfRc=;
 b=f7phIf/32NUoU3ReSQ1nwWRNEWeyx3wnpkFYdzvfg/67LGBB+g83a4ECGrfm7SkEyAVQ/NKpuUkcp8AI9HBEGwSG5UG5MBx/PazOm2G/srPQFlGq7Zh4JrDPUSajx/MxIgrZQV4u7Og4VbYQLjiXZVuQSZu2g5VBvmSgrOo0h7U=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2651.namprd12.prod.outlook.com (20.176.116.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 16:37:06 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::a91d:8752:288:ed5f]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::a91d:8752:288:ed5f%6]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 16:37:06 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] sched/topology: Improve load balancing on AMD EPYC
Thread-Topic: [PATCH v3] sched/topology: Improve load balancing on AMD EPYC
Thread-Index: AQHVQUQuWpmTgVll6kON9CtQMyLhiabbi9iA
Date:   Thu, 25 Jul 2019 16:37:06 +0000
Message-ID: <a8241850-7111-2d93-2330-d28b00797e56@amd.com>
References: <20190723104830.26623-1-matt@codeblueprint.co.uk>
In-Reply-To: <20190723104830.26623-1-matt@codeblueprint.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [165.204.77.11]
x-clientproxiedby: SN2PR01CA0026.prod.exchangelabs.com (2603:10b6:804:2::36)
 To DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25a50617-0bf6-4728-b5ea-08d7111e54bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2651;
x-ms-traffictypediagnostic: DM6PR12MB2651:
x-microsoft-antispam-prvs: <DM6PR12MB2651C687C9D69126BE173591F3C10@DM6PR12MB2651.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(54094003)(189003)(199004)(305945005)(486006)(66556008)(66946007)(64756008)(81166006)(65956001)(81156014)(66476007)(36756003)(8936002)(65806001)(64126003)(25786009)(316002)(86362001)(4326008)(14444005)(54906003)(26005)(58126008)(99286004)(31696002)(3846002)(14454004)(110136005)(256004)(102836004)(229853002)(6436002)(76176011)(6246003)(5660300002)(66066001)(31686004)(6506007)(386003)(66446008)(68736007)(11346002)(478600001)(186003)(7736002)(52116002)(2906002)(2616005)(71190400001)(6512007)(71200400001)(65826007)(6116002)(53936002)(476003)(446003)(6486002)(53546011)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2651;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pc/yb6+/vCdDbyrpRmlg8E23XRc5yb68jIetBc7OzD1T5BJxcr5fAY7RZzNcWn+Xc7/GeB4piPU1zUx86o9KXzuIFDD4w/OveSQA4MnvOsPIVBjABJ/MwP3fBxJ82wek+BRX9MN4iEb1nLqybjjpVEjRWtw+qqOVNcBa+XCBeczeDRIm8uEAwFF3YqFHBksjppBikn3qvK5OBY2wuIWQX4uOkaX3JH0wl1vab6SD+P5zGbKgLq016xWbBJtlbelNwfEB8q/a97jqBU9s0ao/Xw4aBp0lZKyeQ6HgDTigb+pqFufxxH8MWvdHlppuy+4R64PInB8QeFgR526kr3r7iPkc/Ht13Lgr4p66dWqUDjd3IhXjZHrEWL6Qsd64h/djZA59D4UICCCRbnfw5hXZITXDRmWAINVuB38OV+GC8zE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89A3A8418C5E954F9E11EC2938AF602F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a50617-0bf6-4728-b5ea-08d7111e54bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 16:37:06.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssuthiku@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWF0dCwNCg0KT24gNy8yMy8yMDE5IDU6NDggQU0sIE1hdHQgRmxlbWluZyB3cm90ZToNCj4gU0Rf
QkFMQU5DRV97Rk9SSyxFWEVDfSBhbmQgU0RfV0FLRV9BRkZJTkUgYXJlIHN0cmlwcGVkIGluIHNk
X2luaXQoKQ0KPiBmb3IgYW55IHNjaGVkIGRvbWFpbnMgd2l0aCBhIE5VTUEgZGlzdGFuY2UgZ3Jl
YXRlciB0aGFuIDIgaG9wcw0KPiAoUkVDTEFJTV9ESVNUQU5DRSkuIFRoZSBpZGVhIGJlaW5nIHRo
YXQgaXQncyBleHBlbnNpdmUgdG8gYmFsYW5jZQ0KPiBhY3Jvc3MgZG9tYWlucyB0aGF0IGZhciBh
cGFydC4NCj4gDQo+IEhvd2V2ZXIsIGFzIGlzIHJhdGhlciB1bmZvcnR1bmF0ZWx5IGV4cGxhaW5l
ZCBpbg0KPiANCj4gICAgY29tbWl0IDMyZTQ1ZmY0M2VhZiAoIm1tOiBpbmNyZWFzZSBSRUNMQUlN
X0RJU1RBTkNFIHRvIDMwIikNCj4gDQo+IHRoZSB2YWx1ZSBmb3IgUkVDTEFJTV9ESVNUQU5DRSBp
cyBiYXNlZCBvbiBub2RlIGRpc3RhbmNlIHRhYmxlcyBmcm9tDQo+IDIwMTEtZXJhIGhhcmR3YXJl
Lg0KPiANCj4gQ3VycmVudCBBTUQgRVBZQyBtYWNoaW5lcyBoYXZlIHRoZSBmb2xsb3dpbmcgTlVN
QSBub2RlIGRpc3RhbmNlczoNCj4gDQo+IG5vZGUgZGlzdGFuY2VzOg0KPiBub2RlICAgMCAgIDEg
ICAyICAgMyAgIDQgICA1ICAgNiAgIDcNCj4gICAgMDogIDEwICAxNiAgMTYgIDE2ICAzMiAgMzIg
IDMyICAzMg0KPiAgICAxOiAgMTYgIDEwICAxNiAgMTYgIDMyICAzMiAgMzIgIDMyDQo+ICAgIDI6
ICAxNiAgMTYgIDEwICAxNiAgMzIgIDMyICAzMiAgMzINCj4gICAgMzogIDE2ICAxNiAgMTYgIDEw
ICAzMiAgMzIgIDMyICAzMg0KPiAgICA0OiAgMzIgIDMyICAzMiAgMzIgIDEwICAxNiAgMTYgIDE2
DQo+ICAgIDU6ICAzMiAgMzIgIDMyICAzMiAgMTYgIDEwICAxNiAgMTYNCj4gICAgNjogIDMyICAz
MiAgMzIgIDMyICAxNiAgMTYgIDEwICAxNg0KPiAgICA3OiAgMzIgIDMyICAzMiAgMzIgIDE2ICAx
NiAgMTYgIDEwDQo+IA0KPiB3aGVyZSAyIGhvcHMgaXMgMzIuDQo+IA0KPiBUaGUgcmVzdWx0IGlz
IHRoYXQgdGhlIHNjaGVkdWxlciBmYWlscyB0byBsb2FkIGJhbGFuY2UgcHJvcGVybHkgYWNyb3Nz
DQo+IE5VTUEgbm9kZXMgb24gZGlmZmVyZW50IHNvY2tldHMgLS0gMiBob3BzIGFwYXJ0Lg0KPiAN
Cj4gRm9yIGV4YW1wbGUsIHBpbm5pbmcgMTYgYnVzeSB0aHJlYWRzIHRvIE5VTUEgbm9kZXMgMCAo
Q1BVcyAwLTcpIGFuZCA0DQo+IChDUFVzIDMyLTM5KSBsaWtlIHNvLA0KPiANCj4gICAgJCBudW1h
Y3RsIC1DIDAtNywzMi0zOSAuL3NwaW5uZXIgMTYNCj4gDQo+IGNhdXNlcyBhbGwgdGhyZWFkcyB0
byBmb3JrIGFuZCByZW1haW4gb24gbm9kZSAwIHVudGlsIHRoZSBhY3RpdmUNCj4gYmFsYW5jZXIg
a2lja3MgaW4gYWZ0ZXIgYSBmZXcgc2Vjb25kcyBhbmQgZm9yY2libHkgbW92ZXMgc29tZSB0aHJl
YWRzDQo+IHRvIG5vZGUgNC4NCg0KSSBhbSB0ZXN0aW5nIHRoaXMgcGF0Y2ggb24gdGhlIExpbnV4
LTUuMiwgYW5kIEkgYWN0dWFsbHkgZG8gbm90DQpub3RpY2UgZGlmZmVyZW5jZSBwcmUgdnMgcG9z
dCBwYXRjaC4NCg0KQmVzaWRlcyB0aGUgY2FzZSBhYm92ZSwgSSBoYXZlIGFsc28gcnVuIGFuIGV4
cGVyaW1lbnQgd2l0aA0KYSBkaWZmZXJlbnQgbnVtYmVyIG9mIHRocmVhZHMgYWNyb3NzIHR3byBz
b2NrZXRzOg0KDQooTm90ZTogSSBvbmx5IGZvY3VzIG9uIHRocmVhZDAgb2YgZWFjaCBjb3JlLikN
Cg0Kc1huWSA9IFNvY2tldCBYIE5vZGUgWQ0KDQogICAgICogczBuMCArIHMwbjEgKyBzMW4wICsg
czFuMQ0KICAgICBudW1hY3RsIC1DIDAtMTUsMzItNDcgLi9zcGlubmVyIDMyDQoNCiAgICAgKiBz
MG4yICsgczBuMyArIHMxbjIgKyBzMW4zDQogICAgIG51bWFjdGwgLUMgMTYtMzEsNDgtNjMgLi9z
cGlubmVyIDMyDQoNCiAgICAgKiBzMCArIHMxDQogICAgIG51bWFjdGwgLUMgMC02MyAuL3NwaW5u
ZXIgNjQNCg0KTXkgb2JzZXJ2YXRpb25zIGFyZToNCg0KICAgICAqIEkgc3RpbGwgbm90aWNlIGlt
cHJvcGVyIGxvYWQtYmFsYW5jZSBvbiBvbmUgb2YgdGhlIHRhc2sgaW5pdGlhbGx5DQogICAgICAg
Zm9yIGEgZmV3IHNlY29uZHMgYmVmb3JlIHRoZXkgYXJlIGxvYWQtYmFsYW5jZWQgY29ycmVjdGx5
Lg0KDQogICAgICogSXQgaXMgdGFraW5nIGxvbmdlciB0byBsb2FkIGJhbGFuY2Ugdy8gbW9yZSBu
dW1iZXIgb2YgdGFza3MuDQoNCkkgd29uZGVyIGlmIHlvdSBoYXZlIHRyaWVkIHdpdGggYSBkaWZm
ZXJlbnQga2VybmVsIGJhc2U/DQoNClJlZ2FyZHMsDQpTdXJhdmVlDQo=
