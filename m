Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C9FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36B823431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ff7dgWg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfICQNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:13:31 -0400
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:33959
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729117AbfICQNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:13:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dASWV3X7kwOLx4EP2Nnumnn2+MWjAwfPGSvWl8ZIwE2tJzL0CQAbcsmz3RQ5COTGMBQb0PaBJr9WNIW4AHGOk3UM7GntxzWsj5tOSJmzZLIAl1H7tfbiQgCazyTMmLBTCuhSBYe/jcw338aVBj1pbRx8/AJ5fqRmcjr8p6QmxInneS833OAe9GO97ht9pFqlgiXmRfd9cjSKwis7+4sJd2Cev6iwFLpwDVuAwUlFn64HNNEVivUNb2dUEFZgg0BJMCkXCbTuDnzIXvWCdvA/7txIr8WxdF4aczHuFLTWXlqUDUEIJ8GWpAtl2E4NHGmY5KgVtSvHf+j273mwZu7oLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMC0vfZGQCdo5h27GPMC45ucbZhHZN3xF+vTXQlPG50=;
 b=Itt6do4Su8i96LEtzuVDtjvcUo8SheXoUoGKcSbIBiev5QSniWJIZpnezGKRaHz5YmPDjuyAJT/TAp2zNb5Rt/1hb7VmxILhsh2assa8ONPubjHvyEI5gWnZRLv416kPtHtRFr+2P3jefDbPVesxBJTHXZJIxuf8yfLi/8Y5tGh6Hzt+c5zdCkdVhn0v30EpqC8mqjFz4HRBgswEfcKGE2bMOwMZNUqcGSwykEQqwdeKO78kAxYIQ7dvM0+VznZd6AZQ3fSbwRPqW7R62fzVRCGoGEFyo3DiM/01WOdF9rZxCl4I3ilRWbjs1JH7QMlz9APQguOzDwNPgdt6A/T2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMC0vfZGQCdo5h27GPMC45ucbZhHZN3xF+vTXQlPG50=;
 b=ff7dgWg6XhCNOGib7sGoMduOUDMQ23DVahb1eOJ9dbjkwS/7yv5DwOgdEyvDKQuyCzMStgkX6TEYrtHG0Ig6qw4dOr3QhjNmcW7V5mFiR+yIzjPD8e1K+2morlOzy+O5CaOZQfizeYoprMLo2kCZRHTyw01BIPZ5m6dpG4M2eFc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6006.namprd05.prod.outlook.com (20.178.53.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.11; Tue, 3 Sep 2019 16:13:28 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b5c9:9c17:bcf1:1310]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b5c9:9c17:bcf1:1310%5]) with mapi id 15.20.2241.011; Tue, 3 Sep 2019
 16:13:28 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH v2 0/3] x86/mm/tlb: Defer TLB flushes with PTI
Thread-Topic: [RFC PATCH v2 0/3] x86/mm/tlb: Defer TLB flushes with PTI
Thread-Index: AQHVWkMKQEoGoFlX+E2oGohYzHeU4KcaIOEAgAAPowA=
Date:   Tue, 3 Sep 2019 16:13:28 +0000
Message-ID: <75004C21-C00A-4C62-9A06-EAB4C7FE7480@vmware.com>
References: <20190823225248.15597-1-namit@vmware.com>
 <f63027ae-2e3a-fac0-69f8-bb11c1b680b0@intel.com>
In-Reply-To: <f63027ae-2e3a-fac0-69f8-bb11c1b680b0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d7963d7-4a6f-45e8-04dd-08d73089a842
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6006;
x-ms-traffictypediagnostic: BYAPR05MB6006:
x-microsoft-antispam-prvs: <BYAPR05MB6006CDDBAA49B1BD72F94C1ED0B90@BYAPR05MB6006.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(99286004)(8936002)(5660300002)(6916009)(7736002)(305945005)(86362001)(66066001)(81166006)(66946007)(25786009)(6116002)(76116006)(6436002)(54906003)(53936002)(26005)(446003)(316002)(2906002)(486006)(3846002)(76176011)(53546011)(6506007)(2616005)(6512007)(64756008)(66446008)(102836004)(66476007)(66556008)(11346002)(6246003)(14444005)(256004)(14454004)(478600001)(229853002)(8676002)(81156014)(476003)(4326008)(36756003)(71200400001)(71190400001)(33656002)(6486002)(186003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6006;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BssrdASJ6srs2kH3h0BmfRRZbqJL0d9eO7PVTzHBa77yz1zJjfJ25s8Tbk2+RyBvlqvC5FGkGiXqmkH/G87n301C3MK2mcPyvECbWlbYjA8bHhx6ixI2nC/FkKJ5VYJvRhOx7QnxHTKiKCfZvVCTuZ8hNlSrb9KuQMSL248W2eGLo3NkXOCYl6R/sEJ8hUtK25Uzwr07WpVvuEbYMJAtJf9i+Y+2N49JWHWrjCJDjVzT1v6uXEENhgv8FGOFK5Jz8pJG3oeDtbUQIZRYG1PB6dCs5D9L1ENnNrMyJ0xUSfrP7qlSBu8/TNzH6EbdtIbZecdIWgLH5A6sLlFSeabw4Q8Ui50n3wWVjrpzvSBWRVzwwlYs8Uba9NSV651BygbamvIkmN8lBPYO+nHQfEoCpNblAIgFdjyAgU0CgGxymSk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DDB7E699C036CC449ED693030515BDE6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7963d7-4a6f-45e8-04dd-08d73089a842
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 16:13:28.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csM7Ja4NoBvqWWqr5RxtfaZmrzV+cLROcB4WT9egw/8tqRG5O09qJwWZx0PaH57taCKxOtU2NfgPHcZs0omysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sep 3, 2019, at 8:17 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 8/23/19 3:52 PM, Nadav Amit wrote:
>> n_pages		concurrent	+deferred-pti		change
>> -------		----------	-------------		------
>> 1		2119		1986 			-6.7%
>> 10		6791		5417 			 -20%
>>=20
>> Please let me know if I missed something that affects security or
>> performance.
>=20
> Hi Nadav,
>=20
> Is this in a VM or on bare metal?  Could you also share the bare
> /proc/cpuinfo for one of the CPU threads?  I want to make sure that any
> oddities in the stepping or microcode are known.

Bare-metal. Note that some of the benefit does come from having tighter
loops for INVPCID/INVLPG, but the big difference is due to INVPCID being
slower.

I am kind of surprised that you are surprised. I was under the impression
that INVPCID-single lower performance is known. Let me know if I did
something wrong.

processor	: 55
vendor_id	: GenuineIntel
cpu family	: 6
model		: 79
model name	: Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz
stepping	: 1
microcode	: 0xb000036
cpu MHz		: 2403.035
cache size	: 35840 KB
physical id	: 1
siblings	: 28
core id		: 14
cpu cores	: 14
apicid		: 61
initial apicid	: 61
fpu		: yes
fpu_exception	: yes
cpuid level	: 20
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_=
tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ss=
se3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_=
deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fa=
ult epb cat_l3 cdp_l3 invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vn=
mi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms i=
nvpcid rtm cqm rdt_a rdseed adx smap intel_pt xsaveopt cqm_llc cqm_occup_ll=
c cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts md_clear flush_l1d
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapg=
s
bogomips	: 4001.56
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:




