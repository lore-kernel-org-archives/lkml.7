Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA56C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C39D20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LQGcX8HM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZRli9/uW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfEQQXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:23:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49340 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728551AbfEQQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:23:16 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HG4EFX032471;
        Fri, 17 May 2019 09:22:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=PRb/bFXZ9N3UognEP+TkJlJCup1nhCalqvBnurkQ46Q=;
 b=LQGcX8HM1G2D7/oNnk21SRzmdOrWHs7uhzZw/esi/eD5hJf4WZJTKKr1DinxVkz+mK4B
 8ALSghK9FU8n3IbfOXjXtbLS+hnsaxALNl97T2KfyUexSKudkzfLP/l7KARADjBSjjdp
 xDvkuFh4ZjBkguqK2lWsFSSVdnpXyS6iQJI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2shsqghaf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 09:22:34 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 17 May 2019 09:22:33 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 17 May 2019 09:22:32 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 17 May 2019 09:22:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRb/bFXZ9N3UognEP+TkJlJCup1nhCalqvBnurkQ46Q=;
 b=ZRli9/uWJHvk1yF4iIuOwWIcq/Jvr4s3wRJ7rF6VpSQ+skzKa7e+hXU+S8+I/Rcbrp9PMW1mfB+GfSYafmqRaZ3Sr1bW5u7Aof5ZiOq0av9Bmv2pyHWaUeyBegWmbjy4hm8v4aMDcPpV3pHM8qEgaTnoVMyBLx61LwmJoynsEbY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1886.namprd15.prod.outlook.com (10.174.100.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 16:22:31 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 16:22:31 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Kairui Song <kasong@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel() 
Thread-Topic: Getting empty callchain from perf_callchain_kernel() 
Thread-Index: AQHVDEJXbyjc1nknl06FlgTGlvLrzKZu8J8AgAAG+ICAAAFQgIAABKSAgACDYwA=
Date:   Fri, 17 May 2019 16:22:31 +0000
Message-ID: <C5AAB1C4-2DCD-4589-8233-AB50152505C8@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <CACPcB9cf1NWnR_hUiuA2vYNUyAhzXHbfEVamUVrKFm46Fww3VA@mail.gmail.com>
In-Reply-To: <CACPcB9cf1NWnR_hUiuA2vYNUyAhzXHbfEVamUVrKFm46Fww3VA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:7648]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aece493-b5ba-4a89-8672-08d6dae3dc90
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1886;
x-ms-traffictypediagnostic: MWHPR15MB1886:
x-microsoft-antispam-prvs: <MWHPR15MB1886BDB36ECA8FA00ACC7BC2B30B0@MWHPR15MB1886.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(446003)(486006)(11346002)(2906002)(14454004)(86362001)(57306001)(6246003)(6116002)(53936002)(316002)(2616005)(6436002)(186003)(54906003)(6512007)(36756003)(82746002)(33656002)(476003)(46003)(229853002)(81156014)(71190400001)(64756008)(83716004)(73956011)(66476007)(5660300002)(6486002)(305945005)(14444005)(66556008)(99286004)(76116006)(68736007)(7736002)(66446008)(256004)(102836004)(71200400001)(53546011)(66946007)(76176011)(4326008)(81166006)(478600001)(6506007)(25786009)(6916009)(8676002)(50226002)(4743002)(8936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1886;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c5bjSkrNiiWMAhBsE1/BgxoEXEXDMToqgn/ChGQ6OSOvP33K2nbr2wNZNRyGXJuKq/vMV/6dJ+QhLLpghWobj76exrjv0nG+GhvHoxQ3C9IOi3fzoEeJZvBLZYVusbCOrvRQUR7MAtis9IgUdU7aLOjRcQF+0bX7VjXHj+Ut2x/exrFOoCO8bNIohFyTVsCiineKXgqxQbwuKTsh4w+LunRWcdCrfPuf4hcEB+yMmq5CRlYKqHcuYugb+q3/MsJad4PGcmvNk9o/yNVyWlJTbIdihYA/chOwVWX0WadKnXw45hX8mOZe6uYSJ9PeErMUDJNkSA+Bpa95gw7EZX0KHt6wD6V4R5MVJE44iAe5uW1a6dh5dobCL7l86E8xdy+Kzrsid54qbvXP5SQey66fKc1RcHfNyQNanwoQD2xxwK8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8643C00BB1394A4A9354428CEFF3E3C7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aece493-b5ba-4a89-8672-08d6dae3dc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 16:22:31.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1886
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 17, 2019, at 1:32 AM, Kairui Song <kasong@redhat.com> wrote:
>=20
> On Fri, May 17, 2019 at 4:15 PM Kairui Song <kasong@redhat.com> wrote:
>>=20
>> On Fri, May 17, 2019 at 4:11 PM Peter Zijlstra <peterz@infradead.org> wr=
ote:
>>>=20
>>> On Fri, May 17, 2019 at 09:46:00AM +0200, Peter Zijlstra wrote:
>>>> On Thu, May 16, 2019 at 11:51:55PM +0000, Song Liu wrote:
>>>>> Hi,
>>>>>=20
>>>>> We found a failure with selftests/bpf/tests_prog in test_stacktrace_m=
ap (on bpf/master
>>>>> branch).
>>>>>=20
>>>>> After digging into the code, we found that perf_callchain_kernel() is=
 giving empty
>>>>> callchain for tracepoint sched/sched_switch. And it seems related to =
commit
>>>>>=20
>>>>> d15d356887e770c5f2dcf963b52c7cb510c9e42d
>>>>> ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
>>>>>=20
>>>>> Before this commit, perf_callchain_kernel() returns callchain with re=
gs->ip. With
>>>>> this commit, regs->ip is not sent for !perf_hw_regs(regs) case.
>>>>=20
>>>> So while I think the below is indeed right; we should store regs->ip
>>>> regardless of the unwind path chosen, I still think there's something
>>>> fishy if this results in just the 1 entry.
>>>>=20
>>>> The sched/sched_switch event really should have a non-trivial stack.
>>>>=20
>>>> Let me see if I can reproduce with just perf.
>>>=20
>>> $ perf record -g -e "sched:sched_switch" -- make clean
>>> $ perf report -D
>>>=20
>>> 12 904071759467 0x1790 [0xd0]: PERF_RECORD_SAMPLE(IP, 0x1): 7236/7236: =
0xffffffff81c29562 period: 1 addr: 0
>>> ... FP chain: nr:10
>>> .....  0: ffffffffffffff80
>>> .....  1: ffffffff81c29562
>>> .....  2: ffffffff81c29933
>>> .....  3: ffffffff8111f688
>>> .....  4: ffffffff81120b9d
>>> .....  5: ffffffff81120ce5
>>> .....  6: ffffffff8100254a
>>> .....  7: ffffffff81e0007d
>>> .....  8: fffffffffffffe00
>>> .....  9: 00007f9b6cd9682a
>>> ... thread: sh:7236
>>> ...... dso: /lib/modules/5.1.0-12177-g41bbb9129767/build/vmlinux
>>>=20
>>>=20
>>> IOW, it seems to 'work'.
>>>=20
>>=20
>> Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
>> some other bfp functions) is now broken, or, strating an unwind
>> directly inside a bpf program will end up strangely. It have following
>> kernel message:
>>=20
>> WARNING: kernel stack frame pointer at 0000000070cad07c in
>> test_progs:1242 has bad value 00000000ffd4497e
>>=20
>> And in the debug message:
>>=20
>> [  160.460287] 000000006e117175: ffffffffaa23a0e8
>> (get_perf_callchain+0x148/0x280)
>> [  160.460287] 0000000002e8715f: 0000000000c6bba0 (0xc6bba0)
>> [  160.460288] 00000000b3d07758: ffff9ce3f9790000 (0xffff9ce3f9790000)
>> [  160.460289] 0000000055c97836: ffff9ce3f9790000 (0xffff9ce3f9790000)
>> [  160.460289] 000000007cbb140a: 000000010000007f (0x10000007f)
>> [  160.460290] 000000007dc62ac9: 0000000000000000 ...
>> [  160.460290] 000000006b41e346: 1c7da01cd70c4000 (0x1c7da01cd70c4000)
>> [  160.460291] 00000000f23d1826: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
>> [  160.460292] 00000000f9a16017: 000000000000007f (0x7f)
>> [  160.460292] 00000000a8e62d44: 0000000000000000 ...
>> [  160.460293] 00000000cbc83c97: ffffb89d00d8d000 (0xffffb89d00d8d000)
>> [  160.460293] 0000000092842522: 000000000000007f (0x7f)
>> [  160.460294] 00000000dafbec89: ffffb89d00c6bc50 (0xffffb89d00c6bc50)
>> [  160.460296] 000000000777e4cf: ffffffffaa225d97 (bpf_get_stackid+0x77/=
0x470)
>> [  160.460296] 000000009942ea16: 0000000000000000 ...
>> [  160.460297] 00000000a08006b1: 0000000000000001 (0x1)
>> [  160.460298] 000000009f03b438: ffffb89d00c6bc30 (0xffffb89d00c6bc30)
>> [  160.460299] 000000006caf8b32: ffffffffaa074fe8 (__do_page_fault+0x58/=
0x90)
>> [  160.460300] 000000003a13d702: 0000000000000000 ...
>> [  160.460300] 00000000e2e2496d: ffff9ce300000000 (0xffff9ce300000000)
>> [  160.460301] 000000008ee6b7c2: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
>> [  160.460301] 00000000a8cf6d55: 0000000000000000 ...
>> [  160.460302] 0000000059078076: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
>> [  160.460303] 00000000c6aac739: ffff9ce3f1e18eb0 (0xffff9ce3f1e18eb0)
>> [  160.460303] 00000000a39aff92: ffffb89d00c6bc60 (0xffffb89d00c6bc60)
>> [  160.460305] 0000000097498bf2: ffffffffaa1f4791 (bpf_get_stackid_tp+0x=
11/0x20)
>> [  160.460306] 000000006992de1e: ffffb89d00c6bc78 (0xffffb89d00c6bc78)
>> [  160.460307] 00000000dacd0ce5: ffffffffc0405676 (0xffffffffc0405676)
>> [  160.460307] 00000000a81f2714: 0000000000000000 ...
>>=20
>> # Note here is the invalid frame pointer
>> [  160.460308] 0000000070cad07c: ffffb89d00a1d000 (0xffffb89d00a1d000)
>> [  160.460308] 00000000f8f194e4: 0000000000000001 (0x1)
>> [  160.460309] 000000002134f42a: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
>> [  160.460310] 00000000f9345889: ffff9ce3f1e18eb0 (0xffff9ce3f1e18eb0)
>> [  160.460310] 000000008ad22a42: 0000000000000000 ...
>> [  160.460311] 0000000073808173: ffffb89d00c6bce0 (0xffffb89d00c6bce0)
>> [  160.460312] 00000000c9effff4: ffffffffaa1f48d1 (trace_call_bpf+0x81/0=
x100)
>> [  160.460313] 00000000c5d8ebd1: ffffb89d00c6bcc0 (0xffffb89d00c6bcc0)
>> [  160.460315] 00000000bce0b072: ffffffffab651be0
>> (event_sched_migrate_task+0xa0/0xa0)
>> [  160.460316] 00000000355cf319: 0000000000000000 ...
>> [  160.460316] 000000003b67f2ad: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
>> [  160.460316] 000000009a77e20b: ffff9ce3fba25000 (0xffff9ce3fba25000)
>> [  160.460317] 0000000032cf7376: 0000000000000001 (0x1)
>> [  160.460317] 000000000051db74: ffffb89d00c6bd20 (0xffffb89d00c6bd20)
>> [  160.460318] 0000000040eb3bf7: ffffffffaa22be81
>> (perf_trace_run_bpf_submit+0x41/0xb0)
>>=20
>> Simply store the IP still won't really fix the problem, it just passed
>> the test. Just had a try to have bpf functions set the
>> X86_EFLAGS_FIXED for the flags and always dump the bp, it bypassed
>> this specified problem.
>>=20
>> Using frame pointer unwinder for testing this, and seems ORC is fine wit=
h this.
>=20
> Correction: ORC won't print an error, but it also give empty callstack.

Yes, we are using ORC here, and getting empty callstack. bpf_get_stackid()
takes empty callstack as error, so we need up getting nothing.=20

Does it make sense to add regs->ip back?

Thanks,
Song



