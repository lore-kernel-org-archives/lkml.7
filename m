Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9152CC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458B52171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="cJh4UC16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDLPS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:18:59 -0400
Received: from mail-eopbgr740087.outbound.protection.outlook.com ([40.107.74.87]:39444
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfDLPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5+l/XjtcLR9zfmXm9UeCUJ7B/3VDbE716x95KNxBdM=;
 b=cJh4UC16dAwZ22ioGen9J/tV3bCzBtPj5Dg3GUuEHVFIQ6SUWOqB+rIbX27UecbHLidseMkBfoAPs3iJvnmCfZidMxSxK3Up4TaKsZrxDl9q3qrBzcFIP0XI9gAyDwflVLJdoObvc+898PloQ2C/LpwuJe5ywbOjTQuEfhhgfYM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5958.namprd05.prod.outlook.com (20.178.52.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.11; Fri, 12 Apr 2019 15:18:50 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4140:b8f2:8e3:f5fd]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4140:b8f2:8e3:f5fd%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 15:18:50 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Nadav Amit <namit@vmware.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, LKP <lkp@01.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"):  BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Thread-Topic: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"):  BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Thread-Index: AQHU8R5sUhi0mJ9uO0aA/EiVew3tvaY4YIQAgABBN4CAAAIWgA==
Date:   Fri, 12 Apr 2019 15:18:50 +0000
Message-ID: <EA0B97AF-D046-4EE8-9897-F90254085724@vmware.com>
References: <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com>
 <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net>
 <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
 <20190412111756.GO14281@hirez.programming.kicks-ass.net>
 <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com>
In-Reply-To: <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5193581f-08bc-4945-8a0e-08d6bf5a2b06
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5958;
x-ms-traffictypediagnostic: BYAPR05MB5958:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB59585D207EDC72A9EB3636B4D0280@BYAPR05MB5958.namprd05.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(105586002)(81166006)(6246003)(7416002)(186003)(25786009)(6862004)(11346002)(36756003)(486006)(446003)(8936002)(6306002)(5660300002)(99286004)(68736007)(6512007)(4326008)(305945005)(93886005)(2616005)(7736002)(6436002)(6506007)(33656002)(6486002)(66066001)(14444005)(76176011)(476003)(53546011)(256004)(3846002)(26005)(71200400001)(14454004)(71190400001)(966005)(8676002)(6116002)(6200100001)(106356001)(102836004)(86362001)(53936002)(478600001)(97736004)(83716004)(316002)(54906003)(82746002)(37006003)(2906002)(4001150100001)(81156014)(229853002)(561944003)(45080400002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5958;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6+S7ezK5Pq7/7I+FrfwbGofBilVuFuxLikmoZiik24LtJACMvNKADFK0HJPg7uaRaaelG5AqblywggA3M8v+UX4jOHyql3ph5gmi+c03dMWE0All5/46OTMxznREyvmB5DsA1RfYOI1+yS8Bm3FO0k3Fmdx3jxQCs2ECNeNLA/LsidpNoQzUW2+jgpDIryMtkSdBBcvxVyP22wszHvM9m4EuAeznZiqZIZtT20MpDwhr10BoRdmWVvaxW7I5EM24WESmaKCkAWJTrQ6l60mgaIKR9N+oVKtyheev9VAlbdCmu7UNm+erixzLyeNeUQKh0SEM0Bby381+d9F8ofc0hNDWiueBG5oWUXrJoVwxzs6V+a/Xxby+yDF/GRtARMpV/vhwRDa4AHu5/n4Ere0lUARSrjQntmBKzMPM0VxbRz8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D374FA26FC0D54A8F36E822321AB309@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5193581f-08bc-4945-8a0e-08d6bf5a2b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 15:18:50.3720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5958
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 12, 2019, at 8:11 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
>> On Apr 12, 2019, at 4:17 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>=20
>> On Fri, Apr 12, 2019 at 12:56:33PM +0200, Peter Zijlstra wrote:
>>> On Thu, Apr 11, 2019 at 11:13:48PM +0200, Peter Zijlstra wrote:
>>>> On Thu, Apr 11, 2019 at 09:54:24PM +0200, Peter Zijlstra wrote:
>>>>> On Thu, Apr 11, 2019 at 09:39:06PM +0200, Peter Zijlstra wrote:
>>>>>> I think this bisect is bad. If you look at your own logs this patch
>>>>>> merely changes the failure, but doesn't make it go away.
>>>>>>=20
>>>>>> Before this patch (in fact, before tip/core/mm entirely) the errror
>>>>>> reads like the below, which suggests there is memory corruption
>>>>>> somewhere, and the fingered patch just makes it trigger differently.
>>>>>>=20
>>>>>> It would be very good to find the source of this corruption, but I'm
>>>>>> fairly certain it is not here.
>>>>>=20
>>>>> I went back to v4.20 to try and find a time when the below error did =
not
>>>>> occur, but even that reliably triggers the warning.
>>>>=20
>>>> So I also tested v4.19 and found that that was good, which made me
>>>> bisect v4.19..v4.20
>>>>=20
>>>> # bad: [8fe28cb58bcb235034b64cbbb7550a8a43fd88be] Linux 4.20
>>>> # good: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
>>>> git bisect start 'v4.20' 'v4.19'
>>>> # bad: [ec9c166434595382be3babf266febf876327774d] Merge tag 'mips_fixe=
s_4.20_1' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
>>>> git bisect bad ec9c166434595382be3babf266febf876327774d
>>>> # bad: [50b825d7e87f4cff7070df6eb26390152bb29537] Merge git://git.kern=
el.org/pub/scm/linux/kernel/git/davem/net-next
>>>> git bisect bad 50b825d7e87f4cff7070df6eb26390152bb29537
>>>> # good: [99e9acd85ccbdc8f5785f9e961d4956e96bd6aa5] Merge tag 'mlx5-upd=
ates-2018-10-17' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/lin=
ux
>>>> git bisect good 99e9acd85ccbdc8f5785f9e961d4956e96bd6aa5
>>>> # good: [c403993a41d50db1e7d9bc2d43c3c8498162312f] Merge tag 'for-linu=
s-4.20' of https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgithub.com%2Fcminyard%2Flinux-ipmi&amp;data=3D02%7C01%7Cnamit%40vmware.=
com%7Ca1c3ea5d4bc34cfc785508d6bf388ff3%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7=
C0%7C0%7C636906647013777573&amp;sdata=3D3VSR3VdE5rxOitAdkqFNPpAnAtLgDmYLzJt=
oUrs5v9Y%3D&amp;reserved=3D0
>>>> git bisect good c403993a41d50db1e7d9bc2d43c3c8498162312f
>>>> # good: [c05f3642f4304dd081876e77a68555b6aba4483f] Merge branch 'perf-=
core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>> git bisect good c05f3642f4304dd081876e77a68555b6aba4483f
>>>> # bad: [44786880df196a4200c178945c4d41675faf9fb7] Merge branch 'parisc=
-4.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-lin=
ux
>>>> git bisect bad 44786880df196a4200c178945c4d41675faf9fb7
>>>> # bad: [99792e0cea1ed733cdc8d0758677981e0cbebfed] Merge branch 'x86-mm=
-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>> git bisect bad 99792e0cea1ed733cdc8d0758677981e0cbebfed
>>>> # good: [fec98069fb72fb656304a3e52265e0c2fc9adf87] Merge branch 'x86-c=
pu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>> git bisect good fec98069fb72fb656304a3e52265e0c2fc9adf87
>>>> # bad: [a31acd3ee8f7dbc0370bdf4a4bfef7a8c13c7542] x86/mm: Page size aw=
are flush_tlb_mm_range()
>>>> git bisect bad a31acd3ee8f7dbc0370bdf4a4bfef7a8c13c7542
>>>> # good: [a7295fd53c39ce781a9792c9dd2c8747bf274160] x86/mm/cpa: Use flu=
sh_tlb_kernel_range()
>>>> git bisect good a7295fd53c39ce781a9792c9dd2c8747bf274160
>>>> # good: [9cf38d5559e813cccdba8b44c82cc46ba48d0896] kexec: Allocate dec=
rypted control pages for kdump if SME is enabled
>>>> git bisect good 9cf38d5559e813cccdba8b44c82cc46ba48d0896
>>>> # good: [5b12904065798fee8b153a506ac7b72d5ebbe26c] x86/mm/doc: Clean u=
p the x86-64 virtual memory layout descriptions
>>>> git bisect good 5b12904065798fee8b153a506ac7b72d5ebbe26c
>>>> # good: [cf089611f4c446285046fcd426d90c18f37d2905] proc/vmcore: Fix i3=
86 build error of missing copy_oldmem_page_encrypted()
>>>> git bisect good cf089611f4c446285046fcd426d90c18f37d2905
>>>> # good: [a5b966ae42a70b194b03eaa5eaea70d8b3790c40] Merge branch 'tlb/a=
sm-generic' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux in=
to x86/mm
>>>> git bisect good a5b966ae42a70b194b03eaa5eaea70d8b3790c40
>>>> # first bad commit: [a31acd3ee8f7dbc0370bdf4a4bfef7a8c13c7542] x86/mm:=
 Page size aware flush_tlb_mm_range()
>>>>=20
>>>> And 'funnily' the bad patch is one of mine too :/
>>>>=20
>>>> I'll go have a look at that tomorrow, because currrently I'm way past
>>>> tired.
>>>=20
>>> OK, so the below patchlet makes it all good. It turns out that the
>>> provided config has:
>>>=20
>>> CONFIG_X86_L1_CACHE_SHIFT=3D7
>>>=20
>>> which then, for some obscure raisin, results in flush_tlb_mm_range()
>>> compiling to use 320 bytes of stack:
>>>=20
>>> sub    $0x140,%rsp
>>>=20
>>> Where a 'defconfig' build results in:
>>>=20
>>> sub    $0x58,%rsp
>>>=20
>>> The thing that pushes it over the edge in the above fingered patch is
>>> the addition of a field to struct flush_tlb_info, which grows if from 3=
2
>>> to 36 bytes.
>>>=20
>>> So my proposal is to basically revert that, unless we can come up with
>>> something that GCC can't screw up.
>>=20
>> To clarify, 'that' is Nadav's patch:
>>=20
>> 515ab7c41306 ("x86/mm: Align TLB invalidation info")
>>=20
>> which turns out to be the real problem.
>=20
> Sorry for that. I still think it should be aligned, especially with all t=
he
> effort the Intel puts around to avoid bus-locking on unaligned atomic
> operations.
>=20
> So the right solution seems to me as putting this data structure off stac=
k.
> It would prevent flush_tlb_mm_range() from being reentrant, so we can kee=
p a
> few entries for this matter and atomically increase the entry number ever=
y
> time we enter flush_tlb_mm_range().
>=20
> But my question is - should flush_tlb_mm_range() be reentrant, or can we
> assume no TLB shootdowns are initiated in interrupt handlers and #MC
> handlers?

Just to clarify - I obviously suggest a per-cpu structure. The question
is about one core reentering flush_tlb_mm_range().

