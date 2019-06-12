Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEF220645
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UAdQ4j0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409466AbfFLQw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:52:26 -0400
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:21157
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407158AbfFLQw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZSzOWGP9teX1VGTd3B75IMFarAf4hyW5qmyjZsketE=;
 b=UAdQ4j0vYX2+z/eUlZ+RLYtIpiSi3HZ7o6mPuy6ZaRGqtUVWcV+2TjxcbWJ2iyhfpz5iN1h35haCjMJLanFACUBg4bw1FKf6e45Gu1KuhNoJRB/OapRxztMLmLCy5lCAmqND+CNMgAWj+AmN4ywf41xCNWJ7YjV4xX3vzHzizJ0=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2971.namprd12.prod.outlook.com (20.178.29.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Wed, 12 Jun 2019 16:52:23 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.012; Wed, 12 Jun 2019
 16:52:23 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>
CC:     lijiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel e820
 table
Thread-Topic: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Thread-Index: AQHU+XQhuS6zcOyueUSKdtOdksdWDqaAW4GAgBBiQoCAAKstgIAAWDEAgAAOS4CAAAFSgIAABcKAgAM4cYCAAoIQgIAA3gyAgAAccAA=
Date:   Wed, 12 Jun 2019 16:52:22 +0000
Message-ID: <3dfa5985-008a-20d8-5171-cfe96807c303@amd.com>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic> <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic> <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic> <20190608102659.GA9130@MiWiFi-R3L-srv>
 <20190610113747.GD5488@zn.tnic> <20190612015549.GI26148@MiWiFi-R3L-srv>
 <20190612151033.GJ32652@zn.tnic>
In-Reply-To: <20190612151033.GJ32652@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR06CA0097.namprd06.prod.outlook.com
 (2603:10b6:4:3a::38) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf491eea-06b3-4b04-177f-08d6ef56570f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2971;
x-ms-traffictypediagnostic: DM6PR12MB2971:
x-microsoft-antispam-prvs: <DM6PR12MB297118D88FD13B8485E2DD58ECEC0@DM6PR12MB2971.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(54094003)(189003)(199004)(66556008)(64756008)(186003)(26005)(31686004)(476003)(229853002)(66476007)(68736007)(66946007)(305945005)(73956011)(66446008)(7736002)(4326008)(2616005)(11346002)(52116002)(6246003)(6436002)(25786009)(66066001)(446003)(6512007)(76176011)(6486002)(256004)(14444005)(486006)(53936002)(71190400001)(2906002)(8936002)(54906003)(6116002)(53546011)(6506007)(99286004)(7416002)(5660300002)(71200400001)(386003)(86362001)(8676002)(14454004)(72206003)(81166006)(31696002)(316002)(81156014)(102836004)(478600001)(110136005)(36756003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2971;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lj20g0pmKS9uALHiIqOgvy2VCPug/Ap5cGFsAUWxLlb8DE9JHl0pGAJLvS90/Z9WHD2qVSDg9c1m5O2eKcDQoRu5cyhOq2hVBr/xKUjOeZQRiMWVhoYvfrH997evT4mksHz1EzEzvFZC32iVFFipXi3OcWADa/Fk+3F1whsn0nTFhOnWtjkCdv82KpNkG/2D+rIJZVx073x5qWdMvaLMRQ6ObUgsuD66ZiVXZ2A/xypWIBuys7t33qs7PmkqKQuyZH1lZklCXvN2Rz1+SDePG5oVtl1zwfczRGVq09SmV1O8JYbfM1PFuFxcS7SEEAdKubkkSnjplI36Ql6LHMx2/nBLjniOVzyH+obecYkTIQ7vzSiqO9sP3NJpFm9Xn0RP2LcxDcfVqSf4W9OzxrM/bJSZ9N9AAQlkOLQRIsxL8TI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6679569A387EBA448563B6CE4288BD12@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf491eea-06b3-4b04-177f-08d6ef56570f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 16:52:22.9414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2971
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xMi8xOSAxMDoxMCBBTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBXZWQsIEp1
biAxMiwgMjAxOSBhdCAwOTo1NTo0OUFNICswODAwLCBCYW9xdWFuIEhlIHdyb3RlOg0KPj4gV2l0
aCBmdXJ0aGVyIGludmVzdGlnYXRpb24sIHRoZSBmYWlsdXJlIGFmdGVyIGFwcGx5aW5nIFRvbSdz
IHBhdGNoIGlzDQo+PiBjYXVzZWQgYnkgT09NLiBXaGVuIGluY3JlYXNlIGNyYXNoa2VybmVsIHJl
c2VydmF0aW9uIHRvIDUxMk0sIGtkdW1wDQo+PiBrZXJuZWwgY2FuIGJvb3Qgc3VjY2Vzc2Z1bGx5
LiBJIG5vdGljZWQgeW91ciBjcmFzaGtlcm5lbCByZXNlcnZhdGlvbiBpcw0KPj4gMjU2TSwgdGhh
dCB3aWxsIGZhaWwgYW5kIHN0dWNrIHRoZXJlIHZlcnkgcG9zc2libHkuDQo+Pg0KPj4gU28gVG9t
J3MgcGF0Y2ggY2FuIGZpeCB0aGUgaXNzdWUuIFdlIG5lZWQgZnVydGhlciBjaGVjayB3aHkgbXVj
aCBtb3JlDQo+PiBjcmFzaGtlcm5lbCBtZW1vcnkgaXMgbmVlZGVkIG9uIHRob3NlIEFNRCBib3hl
cyB3aXRoIHNtZSBzdXBwb3J0Li4NCj4gDQo+IFllcywgMjU2TSBmb3IgYSBrZXhlYyBrZXJuZWwg
c291bmRzIHByZXR0eSBtdWNoIGVub3VnaCB0byBtZS4gU28gdGhlcmUncw0KPiBzb21ldGhpbmcg
ZWxzZSBhdCBwbGF5IGhlcmUuIEkgd29uZGVyIGlmIHRoYXQgd29ya2FyZWEgYWZ0ZXIgX2VuZCwg
ZnJvbQ0KPiBUb20ncyBwYXRjaCwgbmVlZHMgc28gbXVjaCByb29tLi4uDQoNCkkgdGhpbmsgdGhl
IGRpc2N1c3Npb24gZW5kZWQgdXAgYmVpbmcgdGhhdCBkZWJ1Z2luZm8gd2Fzbid0IGJlaW5nIHN0
cmlwcGVkDQpmcm9tIHRoZSBrZXJuZWwgYW5kIGluaXRyZCAobWFpbmx5IHRoZSBpbml0cmQpLiAg
V2hhdCBhcmUgdGhlIHNpemVzIG9mDQp0aGUga2VybmVsIGFuZCBpbml0cmQgdGhhdCB5b3UgYXJl
IGxvYWRpbmcgZm9yIGtkdW1wIHZpYSBrZXhlYz8NCg0KRnJvbSBwcmV2aW91cyBwb3N0Og0KICBr
ZXhlYyAtcyAtcCAvYm9vdC92bWxpbnV6LTUuMi4wLXJjMysgLS1pbml0cmQ9L2Jvb3QvaW5pdHJk
LmltZy01LjIuMC1yYzMrDQoNClRoYW5rcywNClRvbQ0KDQo+IA0K
