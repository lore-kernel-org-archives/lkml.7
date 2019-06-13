Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37527C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6F920B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BIcezhu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfFMS6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:58:18 -0400
Received: from mail-eopbgr800044.outbound.protection.outlook.com ([40.107.80.44]:6704
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727273AbfFMS6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBO47RpmlKob8IReHBw7if80yzbrr98sFF3Biy5W6aw=;
 b=BIcezhu/9m+LEZg+/YxUSaC06l9PCEv6xKc1SBmhV6kbZFbP9goJ3RSRNIFeKmvmT8qtiMEral2Dm4EiQZJrLBkK4nGiOLvWqIHyffhUSpd+O+QBW4qC0uDH9zuqLDEVOUEw0T56lfcNKiKXt9KgKzJwmJ2sgpat9q7lodpxjMM=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3819.namprd12.prod.outlook.com (10.255.173.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 18:58:15 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 18:58:15 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH] x86/mm: Create an SME workarea in the kernel for early
 encryption
Thread-Topic: [PATCH] x86/mm: Create an SME workarea in the kernel for early
 encryption
Thread-Index: AQHVISNEIgHKCEThME+IPHE9yhs80KaYHOiAgAAuPICAAZLcgP//r0SAgABV7ICAAA5vAA==
Date:   Thu, 13 Jun 2019 18:58:14 +0000
Message-ID: <de6ed405-11bf-6cc8-7f12-42b123c5bb25@amd.com>
References: <d565e0c8e9867132c75648fe67416c3f51a0efbd.1560346329.git.thomas.lendacky@amd.com>
 <053ded24-eb70-0e88-5e0c-312ea93a6fd0@intel.com>
 <42f8b183-caae-9147-4021-3dee3462c0db@amd.com>
 <a4bdf881-50f2-78eb-066a-816e532af149@intel.com>
 <49a73751-9ede-234e-3432-74cfa62af0e3@amd.com>
 <170db1df-6305-b1dc-9825-3696a1ed065d@intel.com>
In-Reply-To: <170db1df-6305-b1dc-9825-3696a1ed065d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:805:3e::17) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ed0340d-b531-4cd6-c137-08d6f03116ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3819;
x-ms-traffictypediagnostic: DM6PR12MB3819:
x-microsoft-antispam-prvs: <DM6PR12MB38192603D1AF1DB8D7E29625ECEF0@DM6PR12MB3819.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(189003)(199004)(54534003)(6436002)(53546011)(66446008)(2906002)(2201001)(99286004)(2616005)(31686004)(52116002)(76176011)(229853002)(31696002)(386003)(6506007)(4326008)(6246003)(86362001)(446003)(73956011)(305945005)(66476007)(7736002)(66556008)(64756008)(11346002)(66946007)(486006)(476003)(256004)(14454004)(68736007)(6512007)(71200400001)(8676002)(25786009)(6486002)(71190400001)(7416002)(3846002)(110136005)(26005)(2501003)(5660300002)(8936002)(102836004)(72206003)(186003)(6116002)(4744005)(478600001)(316002)(53936002)(36756003)(54906003)(81166006)(81156014)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3819;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0YEMXh6VFkvwAsTDy9OTtyayVAvcf+z67tLhC5JTcP4e91OiS+b+FgUSnWx3mxd6P+mzio9TW1taLBY9+QiYXrbtudaR6baqBKVN7k+aF8l+XViKyNv8beS5X0uu8ddY/Jzp6NI3mOniWMQmMVMB444Z7d3h8GyiNvxIrJ2JM+3Isqzqd3vQ2RdlgSdl7wcJBQpcqMgsKuG7OMJa09b/4ChCIEmNV4yJB1lvRR4xJNMkb5jr0f7eA3gV7jVdMauXfjKGg4U10f6iqKvvOcSBPMFBzCNjhDoOGZUsizeIaBtX8XzFMg2Yo0Sb4YLdngsCct0XuT7HE8wfDNpncPLhVVmy37QOIImFOUpRBeUm50Y5Rq1CGA3f+3HlSIkPngvlEIftp3s+WstBZpKiXVbvRfQInCI6xxsfAbZIlTN5Ps8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAC5149809F0F24398DCC3E997E4D40A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed0340d-b531-4cd6-c137-08d6f03116ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 18:58:14.8842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xMy8xOSAxOjA2IFBNLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4gT24gNi8xMy8xOSAxMDo1
OSBBTSwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+PiBBZnRlciBJIHNheSBhbGwgdGhhdC4u
LiAgV2h5IGNhbid0IHlvdSBqdXN0IHN0aWNrIHlvdXIgZGF0YSBpbiBhIG5vcm1hbCwNCj4+PiB2
YW5pbGxhIF9faW5pdCB2YXJpYWJsZT8gIFdvdWxkbid0IHRoYXQgYmUgYSBsb3QgbGVzcyBzdWJ0
bGU/DQo+PiBUaGUgYXJlYSBuZWVkcyB0byBiZSBvdXRzaWRlIG9mIHRoZSBrZXJuZWwgcHJvcGVy
IGFzIHRoZSBrZXJuZWwgaXMNCj4+IGVuY3J5cHRlZCAiaW4gcGxhY2UuIiBTbyBhbiBfX2luaXQg
dmFyaWFibGUgd29uJ3Qgd29yayBoZXJlLg0KPiANCj4gQWhoLCB0aGF0IG1ha2VzIHNlbnNlLiAg
QWxzbyBzb3VuZHMgbGlrZSBnb29kIGNoYW5nZWxvZyBmb2RkZXIuDQo+IA0KPiBGV0lXLCB5b3Ug
KmNvdWxkKiB1c2UgYW4gX19pbml0IGFyZWEsIGJ1dCBJIHRoaW5rIHlvdSdkIGhhdmUgdG8gd29y
aw0KPiBhcm91bmQgaXQgaW4gc21lX2VuY3J5cHRfa2VybmVsKCksIHJpZ2h0PyAgQmFzaWNhbGx5
IGluIHRoZQ0KPiBrZXJuZWxfc3RhcnQvZW5kIGxvZ2ljIHlvdSdkIG5lZWQgdG8gc2tpcCBvdmVy
IGl0LiAgVGhhdCdzIHByb2JhYmx5IG1vcmUNCj4gZnJhZ2lsZSB0aGFuIHdoYXQgeW91IGhhdmUg
aGVyZSwgdGhvdWdoLg0KDQpZZXMsIEkgdGhpbmsgaGF2aW5nIHRoZSB3b3JrYXJlYSBvdXRzaWRl
IHRoZSBrZXJuZWwgaXMgYmVzdC4NCg0KSSdsbCBzZW5kIGEgVjIgd2l0aCB0aGUgcHJlLXBhdGNo
IGFuZCBzdWdnZXN0ZWQgY2hhbmdlcy4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo=
