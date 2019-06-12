Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE0AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AC320896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GBjTNP40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfFLRqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:46:11 -0400
Received: from mail-eopbgr730044.outbound.protection.outlook.com ([40.107.73.44]:8928
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfFLRqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJyJx+oAPmKgYm5rdwQCGSLlJqiV7JOv/dfUWbLX9pQ=;
 b=GBjTNP40m8TyYawC875i1o++nfZlGpSbd0NlDzNhMu34xDt7FSUuK5vUWfyFGWrcXk207xmGLaajh0mr4lWZ6C1TFliT2WM+39MUByTq7gFHS+A7NUfgkJxhaoYPWnXNvYQYsz1MRqTwrewbfi5JVKEFLvk5/8P1mA87jqXzfA0=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 17:46:07 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.012; Wed, 12 Jun 2019
 17:46:07 +0000
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
Thread-Index: AQHVISNEIgHKCEThME+IPHE9yhs80KaYHOiAgAAuPIA=
Date:   Wed, 12 Jun 2019 17:46:07 +0000
Message-ID: <42f8b183-caae-9147-4021-3dee3462c0db@amd.com>
References: <d565e0c8e9867132c75648fe67416c3f51a0efbd.1560346329.git.thomas.lendacky@amd.com>
 <053ded24-eb70-0e88-5e0c-312ea93a6fd0@intel.com>
In-Reply-To: <053ded24-eb70-0e88-5e0c-312ea93a6fd0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0104.namprd12.prod.outlook.com
 (2603:10b6:802:21::39) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b667fd9c-d33a-46b9-28a3-08d6ef5dd8e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3947;
x-ms-traffictypediagnostic: DM6PR12MB3947:
x-microsoft-antispam-prvs: <DM6PR12MB394783B206D139B9FF565BFEECEC0@DM6PR12MB3947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(199004)(6506007)(66066001)(2201001)(386003)(6246003)(53546011)(6436002)(2501003)(6512007)(110136005)(26005)(102836004)(446003)(31686004)(53936002)(478600001)(31696002)(4744005)(71190400001)(2906002)(86362001)(256004)(71200400001)(5660300002)(36756003)(305945005)(7736002)(486006)(81166006)(14454004)(72206003)(8676002)(81156014)(76176011)(6116002)(3846002)(52116002)(99286004)(8936002)(73956011)(229853002)(11346002)(2616005)(476003)(316002)(7416002)(68736007)(66556008)(66446008)(64756008)(66946007)(66476007)(4326008)(54906003)(25786009)(6486002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3947;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zpigwRCZdUtRV3tXCsx+fHtfFJkdg8OdeLisxY8PQe7YXdbHkv8jxAVode45UtpQMqpQqRNndKcLqnKPPFl9G0T3XYiuX/rRwZiPgTRY6CUfvBYqFn4zrsHgVJJpAyHy19bkqdb/ni3c6LXKGyI9+9g9wYzeZKVXA5dQ2AKzH0reNjyQ1EpTM+jyOvb7x7LOA19HYX3OTnLLwVnpVPvumgp3qn5NuLDjAYdfbDuwEBKrJgFRC6QCRY3bQMlnUqoJmN2kqbd0Yt4uk9tFLW0ez6Rsk4ZOGffE3mKw1PL73omssMwR1JQceyI5w1OUmZ6Ou7D0mwEsgMUCSstJtbGh1z8nkaXXiRsbYfTXTknyrLjsMtwColCVEuFNSUqTj7LCtrKtJpRdyhRD5ezUu+mUwAcc0+EmUDtSpeAKgLd5FN8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FE5996BB96BA041ACE4E438DC887A98@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b667fd9c-d33a-46b9-28a3-08d6ef5dd8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 17:46:07.2831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xMi8xOSAxMDowMCBBTSwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+IE9uIDYvMTIvMTkgNjoz
MiBBTSwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+IENyZWF0ZSBhIHNlY3Rpb24gZm9yIFNN
RSBpbiB0aGUgdm1saW51eC5sZHMuUy4gIFBvc2l0aW9uIGl0IGFmdGVyICJfZW5kIg0KPj4gc28g
dGhhdCB0aGUgbWVtb3J5IHdpbGwgYmUgcmVjbGFpbWVkIGR1cmluZyBib290IGFuZCwgc2luY2Ug
aXQgaXMgYWxsDQo+PiB6ZXJvZXMsIGl0IGNvbXByZXNzZXMgd2VsbC4gDQo+IA0KPiBJIGRvbid0
IHRoaW5rIEkgcmVhbGl6ZWQgdGhhdCB0aGluZ3MgYWZ0ZXIgX2VuZCBnZXQgcmVjbGFpbWVkLiAg
RG8gd2UgZG8NCj4gdGhhdCBhdCB0aGUgc2FtZSBzcG90IHRoYXQgd2UgZG8gaW5pdCBkYXRhIG9y
IHNvbWV3aGVyZSBlbHNlPw0KDQpJIHdhcyBsb29raW5nIGF0IHRoZSBzdGFydCBvZiBzZXR1cF9h
cmNoKCkgaW4gYXJjaC94ODYva2VybmVsL3NldHVwLmMsDQp3aGVyZSB0aGVyZSdzIGEgbWVtYmxv
Y2tfcmVzZXJ2ZSgpIGRvbmUgZm9yIHRoZSBrZXJuZWwgKGl0IHJlc2VydmVzIGZyb20NCl90ZXh0
IHRvIF9fYnNzX3N0b3AsIG5vdCBhbGwgdGhlIHdheSB0byBfZW5kLCBhbmQgbGF0ZXIgdGhlIGJy
ayBhcmVhDQppcyByZXNlcnZlZCkuIEF0IHRoYXQgcG9pbnQsIG15IHRha2Ugd2FzIHRoYXQgdGhl
IG1lbW9yeSBvdXRzaWRlIHRoZQ0KcmVzZXJ2ZWQgYXJlYSBpcyBub3cgYXZhaWxhYmxlIChhbmQg
dGhlcmUncyBhIGNvbW1lbnQgYmVsb3cgdGhhdCB0byB0aGF0DQplZmZlY3QsIGFsc28pLCBzbyB0
aGUgLnNtZSBzZWN0aW9uIHdvdWxkIGJhc2ljYWxseSBiZSBkaXNjYXJkZWQgYW5kDQpyZS1jbGFp
bWVkIGZvciBnZW5lcmFsIHBhZ2UgdXNhZ2UuDQoNCj4gDQo+IEhvdyBtdWNoIGRvZXMgY29tcHJl
c3NpbmcgOE1CIG9mIHplcm9zIHNsb3cgZG93biBteSBrZXJuZWwgY29tcGlsZT8gOykNCg0KSGVo
LCBJIGRpZG4ndCBtZWFzdXJlIHRoYXQuIDopDQoNClRoYW5rcywNClRvbQ0KDQo+IA0K
