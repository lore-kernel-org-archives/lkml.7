Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92801C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6220A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SqL9LIrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbfFLTLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:11:03 -0400
Received: from mail-eopbgr810071.outbound.protection.outlook.com ([40.107.81.71]:16288
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfFLTLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jbonh7D9yySrPhrSCN5ofKxwfNf6CkqqLCtLK+vULo=;
 b=SqL9LIrrK5hIJMOI/tojfyPbiG+xI6Kixr+wHsGNt/p1PLM4x1HS1G9u5O1zJEpNcdFdM271xSVN6UMSGQIZYSwwNYzKKHC8uoXkwpZbnsMtI5+g9s8PLlwlT9jTRz5+qqKQHBWsrq9q+QwqISyBqzr7521xOHSdHhelF3KdBiQ=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3788.namprd12.prod.outlook.com (10.255.173.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 19:11:00 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.012; Wed, 12 Jun 2019
 19:11:00 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Baoquan He <bhe@redhat.com>, lijiang <lijiang@redhat.com>,
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
Thread-Index: AQHU+XQhuS6zcOyueUSKdtOdksdWDqaAW4GAgBBiQoCAAKstgIAAWDEAgAAOS4CAAAFSgIAABcKAgAM4cYCAAoIQgIAA3gyA///InwCAAGjKAIAAEcCA
Date:   Wed, 12 Jun 2019 19:10:59 +0000
Message-ID: <d89ef4ef-b85a-ea94-acdf-2eed5666ed78@amd.com>
References: <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv> <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv> <20190608100623.GA9138@zn.tnic>
 <20190608102659.GA9130@MiWiFi-R3L-srv> <20190610113747.GD5488@zn.tnic>
 <20190612015549.GI26148@MiWiFi-R3L-srv> <20190612151033.GJ32652@zn.tnic>
 <3dfa5985-008a-20d8-5171-cfe96807c303@amd.com>
 <20190612180724.GP32652@zn.tnic>
In-Reply-To: <20190612180724.GP32652@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:3:23::18) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8a5aa9a-a461-4a9b-0023-08d6ef69b270
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3788;
x-ms-traffictypediagnostic: DM6PR12MB3788:
x-microsoft-antispam-prvs: <DM6PR12MB3788514C2AA628FCB762687CECEC0@DM6PR12MB3788.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(54094003)(4326008)(66066001)(31686004)(478600001)(8676002)(186003)(99286004)(14454004)(52116002)(86362001)(36756003)(76176011)(81156014)(81166006)(6246003)(316002)(72206003)(31696002)(446003)(26005)(386003)(53546011)(2906002)(102836004)(54906003)(8936002)(53936002)(6506007)(2616005)(486006)(229853002)(11346002)(476003)(71190400001)(71200400001)(256004)(4744005)(68736007)(5660300002)(6512007)(305945005)(6916009)(7736002)(6486002)(25786009)(66446008)(66946007)(6436002)(3846002)(7416002)(66476007)(73956011)(66556008)(64756008)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3788;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hDvBH8ja0fdCUOW0o7shkpLdYikY2f2cJHay2Eab2CBokqUcnpSJ7mfLL2UBcCNhVvyhmVkAd80FH2AmTw37ACYVYW6+ZC5LiVOuFU18T6U5Eo1QdPP8s2Ux2yeEf4FSb7NQ1zxuriUCelf/yOacjkH5XyKUfZM+5EDy/UGle3v86E3Do/BXktgbRHoKGyi2wmOp3W9glW2e8variSailHU8AVY5tCKKGyCX0ZUf0wqGxXhdcmcZgIhO1950WAu0VJAsOE1kCBROfN/Bp3rFPwXUPuExIei8JcTYq1Mm7cHQWpMNa221P5VJJvjkPt2zaDlStSYCgOofFxIVfb8Yn2bNeWN92KogSfOgz0Bjoph0Pq9cKkcpcid/alynD4mvcMGpwOSzioCXN5mcnBw5XJvPfzhjSqs54mb8dYPd2UY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B2A2BFAEA6F6448B86755F60ED6E82C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a5aa9a-a461-4a9b-0023-08d6ef69b270
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 19:11:00.0762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xMi8xOSAxOjA3IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIFdlZCwgSnVu
IDEyLCAyMDE5IGF0IDA0OjUyOjIyUE0gKzAwMDAsIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+
PiBJIHRoaW5rIHRoZSBkaXNjdXNzaW9uIGVuZGVkIHVwIGJlaW5nIHRoYXQgZGVidWdpbmZvIHdh
c24ndCBiZWluZyBzdHJpcHBlZA0KPj4gZnJvbSB0aGUga2VybmVsIGFuZCBpbml0cmQgKG1haW5s
eSB0aGUgaW5pdHJkKS4gIFdoYXQgYXJlIHRoZSBzaXplcyBvZg0KPj4gdGhlIGtlcm5lbCBhbmQg
aW5pdHJkIHRoYXQgeW91IGFyZSBsb2FkaW5nIGZvciBrZHVtcCB2aWEga2V4ZWM/DQo+Pg0KPj4g
RnJvbSBwcmV2aW91cyBwb3N0Og0KPj4gICBrZXhlYyAtcyAtcCAvYm9vdC92bWxpbnV6LTUuMi4w
LXJjMysgLS1pbml0cmQ9L2Jvb3QvaW5pdHJkLmltZy01LjIuMC1yYzMrDQo+IA0KPiBZb3UgbWVh
biB0aG9zZSBzaXplcz8NCj4gDQo+ICQgbHMgLWxoIC9ib290L3ZtbGludXotNS4yLjAtcmMzKyAv
Ym9vdC9pbml0cmQuaW1nLTUuMi4wLXJjMysNCj4gLXJ3LXItLXItLSAxIHJvb3Qgcm9vdCA3LjhN
IEp1biAxMCAxMjo1MyAvYm9vdC9pbml0cmQuaW1nLTUuMi4wLXJjMysNCj4gLXJ3LXItLXItLSAx
IHJvb3Qgcm9vdCA2LjdNIEp1biAxMCAxMjo1MyAvYm9vdC92bWxpbnV6LTUuMi4wLXJjMysNCj4g
DQo+IFRoYXQgc2hvdWxkIGZpdCBlYXNpbHkgaW4gMjU2TSA6KQ0KDQpDZXJ0YWlubHkgc2VlbXMg
bGlrZSB0aGV5IHNob3VsZC4gSSBrbm93IHRoZXJlIGFyZSBvdGhlciB0aGluZ3MgdGhhdCBhcmUN
CmxvYWRlZCwgYnV0IHRoYXQgc2hvdWxkIGJlIHBsZW50eSBvZiByb29tLiBJIHdvbmRlciBpZiBC
YW9xdWFuIG9yIExpYW5ibw0KY291bGQgdHJhY2sgd2hlcmUgdGhpbmdzIGFyZSBiZWluZyBsb2Fk
ZWQgdG8gc2VlIGlmIGV2ZXJ5dGhpbmcgaXMgYmVpbmcNCmNhbGN1bGF0ZWQgYW5kIHBsYWNlZCBw
cm9wZXJseS4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo=
