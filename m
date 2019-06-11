Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB8DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA2F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X0hfOSxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406056AbfFKRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:22:23 -0400
Received: from mail-eopbgr740051.outbound.protection.outlook.com ([40.107.74.51]:38081
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405821AbfFKRWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qveEYYJpYp9alGa55/6JKsEiC6BHhb/niSVyfqBPKI=;
 b=X0hfOSxAiTBtKTF0gNDoFBXvk14mTbcuvVG5IaRixDoi8+kaPiJ0rPYf9Asyi69EOPSGPoT6HbWA9EY6jEThD8x7l0uJ3EQOE0BLj4KQ/rLWbWpDTKx0TwjfPZ7ULS7kQvErcMbHAMKNbXLV9BIqC7b9ygg7fEJSyMgKwkAC6FQ=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3418.namprd12.prod.outlook.com (20.178.198.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Tue, 11 Jun 2019 17:22:21 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 17:22:21 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Thread-Topic: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Thread-Index: AQHVG7eo9DadWxocuEyUuoulbDK/BaaNWbaAgAgVJQCAAU4lgA==
Date:   Tue, 11 Jun 2019 17:22:21 +0000
Message-ID: <18994abb-a2a8-47f4-9a35-515165c75942@amd.com>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
 <20190605180035.GA3402@hirez.programming.kicks-ass.net>
 <20190610212620.GA4772@codeblueprint.co.uk>
In-Reply-To: <20190610212620.GA4772@codeblueprint.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR01CA0001.prod.exchangelabs.com (2603:10b6:805:b6::14)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f30f4325-0528-415b-daf2-08d6ee915c81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3418;
x-ms-traffictypediagnostic: DM6PR12MB3418:
x-microsoft-antispam-prvs: <DM6PR12MB3418F033CA9EE812E879EA33ECED0@DM6PR12MB3418.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(366004)(199004)(189003)(102836004)(66476007)(2906002)(76176011)(386003)(305945005)(31686004)(66446008)(73956011)(64756008)(66556008)(53546011)(99286004)(316002)(7736002)(6436002)(36756003)(6506007)(25786009)(71190400001)(52116002)(71200400001)(110136005)(14444005)(54906003)(4744005)(5660300002)(66946007)(256004)(229853002)(66066001)(6116002)(8676002)(81156014)(14454004)(3846002)(6512007)(86362001)(8936002)(81166006)(6246003)(26005)(31696002)(186003)(11346002)(72206003)(476003)(2616005)(478600001)(68736007)(53936002)(6486002)(4326008)(486006)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3418;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M0TG0kFdhopdj0seotlZ0X3we3FJhLEp/pv907HLKsEt+euvQgZcabsCx1ULaO0yHw944ldpPKJxcsnKHrptAxEbXDZHuBltkdPW4aylkRD3ah5xYN40bEMsNrwGtZ0Egk4/ur7AYW8QK34LkkkrM25Mefqr6zJe1X3Uu0kvLpKRqwNG/GbevWVExFPkJQmaQt2lurY2c8CMd1fqEDZe4g7rf8lOR5V+F1w3Yy1xpqXcGoozoSHKdREECh42m9dqwdg+teViHpP5hfloX/5l19/NwgVd47GpZiq1e0Gs5CEaUXAupyrCix1u1lmYR3Kq+Q2p1qbeABRw3mjtrpRhPcGJyFYDwc4AG0mli7hINL5ohcC4ZrHFsGTJzQVT8oORoq+YaOqRNUSHJfU/VC5LYzBNm5TWKheuY6UqiqFz5Ck=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62720F147696C743911EA712811F493F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f4325-0528-415b-daf2-08d6ee915c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 17:22:21.3034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3418
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xMC8xOSA0OjI2IFBNLCBNYXR0IEZsZW1pbmcgd3JvdGU6DQo+IE9uIFdlZCwgMDUgSnVu
LCBhdCAwODowMDozNVBNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+DQo+PiBBbmQgdGhlbiB3
ZSBoYWQgdHdvIG1hZ2ljIHZhbHVlcyA6Lw0KPj4NCj4+IFNob3VsZCB3ZSBub3QgJ2ZpeCcgUkVD
TEFJTV9ESVNUQU5DRSBmb3IgRVBZQyBvciBzb21ldGhpbmc/IEJlY2F1c2UNCj4+IHN1cmVseSwg
aWYgd2Ugd2FudCB0byBsb2FkLWJhbGFuY2UgYWdyZXNzaXZlbHkgb3ZlciAzMCwgdGhlbiBzbyB0
b28NCj4+IHNob3VsZCB3ZSBkbyBub2RlX3JlY2xhaW0oKSBJJ20gdGhpa25pbmcuDQo+IA0KPiBZ
ZWFoIHdlIGNhbiBmaXggaXQganVzdCBmb3IgRVBZQywgTWVsIHN1Z2dlc3RlZCB0aGF0IGFwcHJv
YWNoIG9yaWdpbmFsbHkuDQo+IA0KPiBTdXJhdmVlLCBUb20sIHdoYXQncyB0aGUgYmVzdCB3YXkg
dG8gZGV0ZWN0IHRoZXNlIEVQWUMgbWFjaGluZXMgdGhhdCBuZWVkIHRvDQo+IG92ZXJyaWRlIFJF
Q0xBSU1fRElTVEFOQ0U/DQoNCllvdSBzaG91bGQgYmUgYWJsZSB0byBkbyBpdCBiYXNlZCBvbiB0
aGUgZmFtaWx5LiBUaGVyZSdzIGFuIGluaXRfYW1kX3puKCkNCmZ1bmN0aW9uIGluIGFyY2gveDg2
L2tlcm5lbC9jcHUvYW1kLmMuICBZb3UgY2FuIGFkZCBzb21ldGhpbmcgdGhlcmUgb3IsDQpzaW5j
ZSBpbml0X2FtZF96bigpIHNldHMgWDg2X0ZFQVRVUkVfWkVOLCB5b3UgY291bGQgY2hlY2sgZm9y
IHRoYXQgaWYgeW91DQpwcmVmZXIgcHV0dGluZyBpdCBpbiBhIGRpZmZlcmVudCBsb2NhdGlvbi4N
Cg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo=
