Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06091C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF2626E5F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="sS2Kwh94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfEaUmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:42:47 -0400
Received: from mail-eopbgr770051.outbound.protection.outlook.com ([40.107.77.51]:28039
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfEaUmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oepn0buGdc4j2wZ8Zz75FF2ZN76RlMoQrQn210D61rE=;
 b=sS2Kwh94rp3DYLAxEFkBsQyNxaeHCc/H/M5E78VOwLYugxJpygofjuQn/ChDUjjsShVxbo4g9rkTAJ+J//ShjK9JMdVx763ioKVP57EOF1VDZW4GTUqJgp0kuizLc/LKVN+AUD1+r/NAeHUWGlTGfFzvOURbmwM+PpZYHrTsz8g=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5430.namprd05.prod.outlook.com (20.177.185.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.9; Fri, 31 May 2019 20:42:43 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 20:42:43 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Topic: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Index: AQHVF3tKnfrC/xKd0kyiVp6wMVDUEqaFEHMAgACCTICAAA0WgIAAC7yAgAAG1wCAAAFqAA==
Date:   Fri, 31 May 2019 20:42:43 +0000
Message-ID: <F2F9A98B-2496-41D3-80ED-748078D21943@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-12-namit@vmware.com>
 <20190531105758.GO2623@hirez.programming.kicks-ass.net>
 <16D8E001-98A0-4ABC-AFE8-0F230B869027@amacapital.net>
 <82DB7035-D7BE-4D79-BBC0-B271FB4BF740@vmware.com>
 <4e0ed5a5-0e5e-3481-e646-3f032f17ac60@intel.com>
 <CALCETrVf9dh4GxEXsHbP65x6YuzOBf+7HWqOgBBjUma+7nB6Nw@mail.gmail.com>
In-Reply-To: <CALCETrVf9dh4GxEXsHbP65x6YuzOBf+7HWqOgBBjUma+7nB6Nw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a299729c-2d04-4baf-bdaf-08d6e608882b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5430;
x-ms-traffictypediagnostic: BYAPR05MB5430:
x-microsoft-antispam-prvs: <BYAPR05MB543085AD9193DFDD118A690FD0190@BYAPR05MB5430.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(316002)(26005)(14454004)(6916009)(6246003)(66556008)(64756008)(86362001)(305945005)(25786009)(5660300002)(99286004)(14444005)(66066001)(66476007)(6512007)(66446008)(73956011)(66946007)(476003)(2906002)(186003)(2616005)(68736007)(76116006)(102836004)(486006)(53936002)(82746002)(229853002)(256004)(4326008)(6116002)(3846002)(6486002)(33656002)(7736002)(478600001)(54906003)(8676002)(76176011)(53546011)(81156014)(36756003)(81166006)(71190400001)(8936002)(6436002)(446003)(71200400001)(6506007)(83716004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5430;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8LUCc7k6KYZ8IoMF3ar6wP/S1qyrxcqcpuXq6nOqUSl4IhYvTmiUDIGQsuXEfCPFRC7C8hnvsx7fSbLE20/mJZ0abYVNCePHqSKVBv+T0o8kFrLC2B+VsQa89CGaLf/AKXiJnq2gLGIpSbJ4VsAIUyT6EOJpjh2lnnDn6joDPII9cWOVvMSVDiMMXqwPBgvoQX4tCVzZhn9O29iHXLD/Z6oQrEaXyigpIrKtjmybGqTZxN44PBbHRdxiDojvCf8mIebQH8gLXoJO9KJADc73Nq4SxllhQuF/hoNNC/sajNjlDRv5LJixI6mccREBmC0RqZxqSw+VcCdkizZ5ZtV9giIskfUH68IfsBb/48gg52h7jXJaq4HA9W9SjqlVa/On5E0uGK0X0EK+jN8zq0LlQCg658ORTao7Uf1dKJrYTIU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F14E46CE2A5CD429B863BC7B44EB1A8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a299729c-2d04-4baf-bdaf-08d6e608882b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 20:42:43.7179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 31, 2019, at 1:37 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Fri, May 31, 2019 at 1:13 PM Dave Hansen <dave.hansen@intel.com> wrote=
:
>> On 5/31/19 12:31 PM, Nadav Amit wrote:
>>>> On May 31, 2019, at 11:44 AM, Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On May 31, 2019, at 3:57 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
>>>>>=20
>>>>>> On Thu, May 30, 2019 at 11:36:44PM -0700, Nadav Amit wrote:
>>>>>> When we flush userspace mappings, we can defer the TLB flushes, as l=
ong
>>>>>> the following conditions are met:
>>>>>>=20
>>>>>> 1. No tables are freed, since otherwise speculative page walks might
>>>>>> cause machine-checks.
>>>>>>=20
>>>>>> 2. No one would access userspace before flush takes place. Specifica=
lly,
>>>>>> NMI handlers and kprobes would avoid accessing userspace.
>>>>>>=20
>>>>>> Use the new SMP support to execute remote function calls with inline=
d
>>>>>> data for the matter. The function remote TLB flushing function would=
 be
>>>>>> executed asynchronously and the local CPU would continue execution a=
s
>>>>>> soon as the IPI was delivered, before the function was actually
>>>>>> executed. Since tlb_flush_info is copied, there is no risk it would
>>>>>> change before the TLB flush is actually executed.
>>>>>>=20
>>>>>> Change nmi_uaccess_okay() to check whether a remote TLB flush is
>>>>>> currently in progress on this CPU by checking whether the asynchrono=
usly
>>>>>> called function is the remote TLB flushing function. The current
>>>>>> implementation disallows access in such cases, but it is also possib=
le
>>>>>> to flush the entire TLB in such case and allow access.
>>>>>=20
>>>>> ARGGH, brain hurt. I'm not sure I fully understand this one. How is i=
t
>>>>> different from today, where the NMI can hit in the middle of the TLB
>>>>> invalidation?
>>>>>=20
>>>>> Also; since we're not waiting on the IPI, what prevents us from freei=
ng
>>>>> the user pages before the remote CPU is 'done' with them? Currently t=
he
>>>>> synchronous IPI is like a sync point where we *know* the remote CPU i=
s
>>>>> completely done accessing the page.
>>>>>=20
>>>>> Where getting an IPI stops speculation, speculation again restarts
>>>>> inside the interrupt handler, and until we've passed the INVLPG/MOV C=
R3,
>>>>> speculation can happen on that TLB entry, even though we've already
>>>>> freed and re-used the user-page.
>>>>>=20
>>>>> Also, what happens if the TLB invalidation IPI is stuck behind anothe=
r
>>>>> smp_function_call IPI that is doing user-access?
>>>>>=20
>>>>> As said,.. brain hurts.
>>>>=20
>>>> Speculation aside, any code doing dirty tracking needs the flush to ha=
ppen
>>>> for real before it reads the dirty bit.
>>>>=20
>>>> How does this patch guarantee that the flush is really done before som=
eone
>>>> depends on it?
>>>=20
>>> I was always under the impression that the dirty-bit is pass-through - =
the
>>> A/D-assist walks the tables and sets the dirty bit upon access. Otherwi=
se,
>>> what happens when you invalidate the PTE, and have already marked the P=
TE as
>>> non-present? Would the CPU set the dirty-bit at this point?
>>=20
>> Modulo bugs^Werrata...  No.  What actually happens is that a
>> try-to-set-dirty-bit page table walk acts just like a TLB miss.  The old
>> contents of the TLB are discarded and only the in-memory contents matter
>> for forward progress.  If Present=3D0 when the PTE is reached, you'll ge=
t
>> a normal Present=3D0 page fault.
>=20
> Wait, does that mean that you can do a lock cmpxchg or similar to
> clear the dirty and writable bits together and, if the dirty bit was
> clear, skip the TLB flush?  If so, nifty!  Modulo errata, of course.
> And I seem to remember some exceptions relating to CET shadow stack
> involving the dirty bit being set on not-present pages.

I did something similar with the access-bit in the past.

Anyhow, I have a bug here - the code does not wait for the indication that
the IPI was received. I need to rerun performance measurements again once I
fix it.

