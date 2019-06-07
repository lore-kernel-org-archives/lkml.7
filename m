Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F796C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492352067C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ARWdiSgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfFGQmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:42:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40345 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfFGQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:42:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so1441386pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3TTLOXXcpR9XuUBUyHDzbbYgbaX5kAwJMikkFjQ5N/Q=;
        b=ARWdiSgXbp8dMuoSG523O+z9vmW+ibHq2p0MG2WPmsdkcYuPQezu8YE9UdlLPF8+at
         VQqs5KBgoWx8uBd5GsHRkSLmSe9cdCmRb5mtYswRFXsXU6sqs4QDMwX9rQq9tMlZ5BJv
         0LY4L1iWWm2ZpQpCf8Px/E4J3LQ5S2pwM0nXKAznQ9kLjmjQPjT34o4yFSoH5ksagKN+
         Cjo0ttnZs9GmdITe/S8q2kS4QW0GP1+v+7o5ruxwcP5TC65q+VQFr4Yr7RT2I1GF4mtK
         AEBgO6Bt5POb+ehUtLL+E1RE4jvi6r5sFZ3S9VnXfMUbunnfn94wLAio8AELyM2IVJDa
         0u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3TTLOXXcpR9XuUBUyHDzbbYgbaX5kAwJMikkFjQ5N/Q=;
        b=p4ONDqQmGwI0EbkVjhNDGf1ZTFKwXvdW2r492S49/SH5FCQ184O4uqlgZa4dXDahfu
         6un+JAAvOj037CIBQJHTR7gcYvb0cKhElZQTwpH65jVu6BlY+nztuJJB9z74xxphAlVY
         RCbGkRfjY/UebzG8ZBx+5L70rhsRRp0uxALLWw6kIkjF5hxTWTA0+qAGXldk4Z3xmhI0
         BVjD3y7RuxJMP6kX7EdkOy39IvqdsLwdmVn5ZwnLDc5yGyXf7WivHUGhzHiXUAfBFQAA
         N0i7SUrFv+3QX4V/QC4YeZ0dTwoeJS6fa6yOk6Z1ZmkZKzAZ2A5gZ8NKkGu+NJSWatod
         Mh3Q==
X-Gm-Message-State: APjAAAW5RAJiNp5AvXCpOfx/d/r41IWus22LpwAM1c+JRjLIry1ad1xg
        p10P3lQIpDL4R+MpUVCv19DpRw==
X-Google-Smtp-Source: APXvYqzPiFm/14Fg5xxpArs5EHeY4puuj4QftT2sbF2LauTZf3fWsWq+AimfMcWz+lKr4P3sasVeCw==
X-Received: by 2002:a65:4c4b:: with SMTP id l11mr3762992pgr.9.1559925737003;
        Fri, 07 Jun 2019 09:42:17 -0700 (PDT)
Received: from ?IPv6:2600:1012:b044:6f30:60ea:7662:8055:2cca? ([2600:1012:b044:6f30:60ea:7662:8055:2cca])
        by smtp.gmail.com with ESMTPSA id m5sm7584412pgn.59.2019.06.07.09.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 09:42:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages for flushing
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <B41673A7-6CA3-440D-87AA-59E07BE8B656@vmware.com>
Date:   Fri, 7 Jun 2019 09:42:14 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B830032A-C36C-44F4-B790-922E6C572704@amacapital.net>
References: <20190531063645.4697-1-namit@vmware.com> <20190531063645.4697-12-namit@vmware.com> <CALCETrU0=BpGy5OQezQ7or33n-EFgBVDNe5g8prSUjL2SoRAwA@mail.gmail.com> <5F153080-D7A7-4054-AB4A-AEDD5F82E0B9@vmware.com> <48CECB5C-CA5B-4AD0-9DA5-6759E8FEDED7@amacapital.net> <67BFA611-F69E-4AE4-A03F-2EF546DC291A@vmware.com> <B41673A7-6CA3-440D-87AA-59E07BE8B656@vmware.com>
To:     Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 6, 2019, at 10:28 PM, Nadav Amit <namit@vmware.com> wrote:

>> On May 31, 2019, at 3:07 PM, Nadav Amit <namit@vmware.com> wrote:
>>=20
>>> On May 31, 2019, at 2:47 PM, Andy Lutomirski <luto@amacapital.net> wrote=
:
>>>=20
>>>=20
>>> On May 31, 2019, at 2:33 PM, Nadav Amit <namit@vmware.com> wrote:
>>>=20
>>>>> On May 31, 2019, at 2:14 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>>>>=20
>>>>>> On Thu, May 30, 2019 at 11:37 PM Nadav Amit <namit@vmware.com> wrote:=

>>>>>> When we flush userspace mappings, we can defer the TLB flushes, as lo=
ng
>>>>>> the following conditions are met:
>>>>>>=20
>>>>>> 1. No tables are freed, since otherwise speculative page walks might
>>>>>> cause machine-checks.
>>>>>>=20
>>>>>> 2. No one would access userspace before flush takes place. Specifical=
ly,
>>>>>> NMI handlers and kprobes would avoid accessing userspace.
>>>>>=20
>>>>> I think I need to ask the big picture question.  When someone calls
>>>>> flush_tlb_mm_range() (or the other entry points), if no page tables
>>>>> were freed, they want the guarantee that future accesses (initiated
>>>>> observably after the flush returns) will not use paging entries that
>>>>> were replaced by stores ordered before flush_tlb_mm_range().  We also
>>>>> need the guarantee that any effects from any memory access using the
>>>>> old paging entries will become globally visible before
>>>>> flush_tlb_mm_range().
>>>>>=20
>>>>> I'm wondering if receipt of an IPI is enough to guarantee any of this.=

>>>>> If CPU 1 sets a dirty bit and CPU 2 writes to the APIC to send an IPI
>>>>> to CPU 1, at what point is CPU 2 guaranteed to be able to observe the
>>>>> dirty bit?  An interrupt entry today is fully serializing by the time
>>>>> it finishes, but interrupt entries are epicly slow, and I don't know
>>>>> if the APIC waits long enough.  Heck, what if IRQs are off on the
>>>>> remote CPU?  There are a handful of places where we touch user memory
>>>>> with IRQs off, and it's (sadly) possible for user code to turn off
>>>>> IRQs with iopl().
>>>>>=20
>>>>> I *think* that Intel has stated recently that SMT siblings are
>>>>> guaranteed to stop speculating when you write to the APIC ICR to poke
>>>>> them, but SMT is very special.
>>>>>=20
>>>>> My general conclusion is that I think the code needs to document what
>>>>> is guaranteed and why.
>>>>=20
>>>> I think I might have managed to confuse you with a bug I made (last min=
ute
>>>> bug when I was doing some cleanup). This bug does not affect the perfor=
mance
>>>> much, but it might led you to think that I use the APIC sending as
>>>> synchronization.
>>>>=20
>>>> The idea is not for us to rely on write to ICR as something serializing=
. The
>>>> flow should be as follows:
>>>>=20
>>>>=20
>>>> CPU0                    CPU1
>>>>=20
>>>> flush_tlb_mm_range()
>>>> __smp_call_function_many()
>>>> [ prepare call_single_data (csd) ]
>>>> [ lock csd ]=20
>>>> [ send IPI ]
>>>> (*)
>>>> [ wait for csd to be unlocked ]
>>>>                 [ interrupt ]
>>>>                 [ copy csd info to stack ]
>>>>                 [ csd unlock ]
>>>> [ find csd is unlocked ]
>>>> [ continue (**) ]
>>>>                 [ flush TLB ]
>>>>=20
>>>>=20
>>>> At (**) the pages might be recycled, written-back to disk, etc. Note th=
at
>>>> during (*), CPU0 might do some local TLB flushes, making it very likely=
 that
>>>> CSD will be unlocked by the time it gets there.
>>>>=20
>>>> As you can see, I don=E2=80=99t rely on any special micro-architectural=
 behavior.
>>>> The synchronization is done purely in software.
>>>>=20
>>>> Does it make more sense now?
>>>=20
>>> Yes.  Have you benchmarked this?
>>=20
>> Partially. Numbers are indeed worse. Here are preliminary results, compar=
ing
>> to v1 (concurrent):
>>=20
>>    n_threads    before        concurrent    +async
>>    ---------    ------        ----------    ------
>>    1        661        663        663
>>    2        1436        1225 (-14%)    1115 (-22%)
>>    4        1571        1421 (-10%)    1289 (-18%)
>>=20
>> Note that the benefit of =E2=80=9Casync" would be greater if the initiato=
r does not
>> flush the TLB at all. This might happen in the case of kswapd, for exampl=
e.
>> Let me try some micro-optimizations first, run more benchmarks and get ba=
ck
>> to you.
>=20
> So I ran some more benchmarking (my benchmark is not very suitable), and t=
ried
> more stuff that did not help (checking for more work before returning from=
 the
> IPI handler, and avoid redundant IPIs in such case).
>=20
> Anyhow, with a fixed version, I ran a more standard benchmark on DAX:
>=20
> $ mkfs.ext4 /dev/pmem0
> $ mount -o dax /dev/pmem0 /mnt/mem
> $ cd /mnt/mem
> $ bash -c 'echo 0 > /sys/devices/platform/e820_pmem/ndbus0/region0/namespa=
ce0.0/block/pmem0/dax/write_cache=E2=80=99
> $ sysbench fileio --file-total-size=3D3G --file-test-mode=3Drndwr    \
>    --file-io-mode=3Dmmap --threads=3D4 --file-fsync-mode=3Dfdatasync prepa=
re
> $ sysbench fileio --file-total-size=3D3G --file-test-mode=3Drndwr    \
>    --file-io-mode=3Dmmap --threads=3D4 --file-fsync-mode=3Dfdatasync run
>=20
> ( as you can see, I disabled the write-cache, since my machine does not ha=
ve
>  clwb/clflushopt and clflush appears to become a bottleneck otherwise )
>=20
>=20
> The results are:
>                events (avg/stddev)
>                -------------------
> base                1263689.0000/11481.10
> concurrent            1310123.5000/19205.79    (+3.6%)
> concurrent + async        1326750.2500/24563.61    (+4.9%)
>=20
> So which version do you want me to submit? With or without the async part?=


I think it would be best to submit it without the async part. You can always=
 submit that later.
