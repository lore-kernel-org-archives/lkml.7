Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0214C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6F226F72
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Gg/PbC/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfEaVrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:47:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34002 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaVrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:47:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id h2so1498581pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y/qtDzfRQ/W3yULCUxx+xpHfZRz8qoHUesDtUOfX044=;
        b=Gg/PbC/8q0ok2xlMXNmq6cYpWxq8Z9TK1nPVE/Qr31rCh4rtRGOQ8NKp/BHkOlKBFa
         5tubCy1r3Eu21ZIIBBdpiLZ3taEkoiKkQzP3irx+Y1+slNGQ6LGt1mXsAwSfIoKzl2jA
         BP5+wXc7UU5sJ4tYhj5A7XYYFXHkODhSUq0Y5UqW2lBD7ysaS7cvUPhq9OH1pm7Xsy1j
         HcqhngJ/insIji4orvBdY0EMzh/c24xVkXrBWie2O9BcB7QO3ty3sPjOwP6cJRhMAcSl
         J2dRzuVUe6/TANbp0JRfucEFGczjaqw4M8iOa98VmI18pXXcq1Qn3uTOknAV7YARkXGD
         oC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y/qtDzfRQ/W3yULCUxx+xpHfZRz8qoHUesDtUOfX044=;
        b=H2I6+QfIRtGHYcCXXKvV+3TPElFOS01oBnbhSKFYLHJY13fQYfBMJQdMmveYh6428u
         8+FlU0e5q/0siXkuCId1P0EoGaVoDuwBhqK4ggMlfCwuPrYaoXXXTC/D8ynhbJclqfqK
         rbgQuYVxG1XVGUj8FX6xXpPyL/sm+afENHSBje63U/VgZMqYVpAFw77BcrsOr5LSuUQ4
         PwNmpeNRn9exg2sob4xoWk3UmxqEYaBYqvjwNH4Nd9wELKkcbYctDFiZiBzjetVlCe28
         0xzoa9+ayjn23iVc108PedARkQFEIUo0ML5f5Cp3xftLQlxxJopBgLtvyV+pLChRmsuD
         fOUw==
X-Gm-Message-State: APjAAAW8MsKv7E3qOuovfqGub19WilmgtEwi0oRl5MlcQcpwHnLp28rp
        0HiMt5YIqhfZBNDV4eXW9E8TOg==
X-Google-Smtp-Source: APXvYqzPD7WMsOUPPGShovZFakF+ujEPyN+ES3CreH3CsQSgrRu7lC4M/TJn5ydl2CRCLQAz/ehdaQ==
X-Received: by 2002:aa7:8294:: with SMTP id s20mr4841341pfm.75.1559339233903;
        Fri, 31 May 2019 14:47:13 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:ec0c:2d9e:92:467e? ([2601:646:c200:1ef2:ec0c:2d9e:92:467e])
        by smtp.gmail.com with ESMTPSA id m3sm1937402pfh.23.2019.05.31.14.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 14:47:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages for flushing
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <5F153080-D7A7-4054-AB4A-AEDD5F82E0B9@vmware.com>
Date:   Fri, 31 May 2019 14:47:12 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <48CECB5C-CA5B-4AD0-9DA5-6759E8FEDED7@amacapital.net>
References: <20190531063645.4697-1-namit@vmware.com> <20190531063645.4697-12-namit@vmware.com> <CALCETrU0=BpGy5OQezQ7or33n-EFgBVDNe5g8prSUjL2SoRAwA@mail.gmail.com> <5F153080-D7A7-4054-AB4A-AEDD5F82E0B9@vmware.com>
To:     Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On May 31, 2019, at 2:33 PM, Nadav Amit <namit@vmware.com> wrote:

>> On May 31, 2019, at 2:14 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>>> On Thu, May 30, 2019 at 11:37 PM Nadav Amit <namit@vmware.com> wrote:
>>> When we flush userspace mappings, we can defer the TLB flushes, as long
>>> the following conditions are met:
>>>=20
>>> 1. No tables are freed, since otherwise speculative page walks might
>>>  cause machine-checks.
>>>=20
>>> 2. No one would access userspace before flush takes place. Specifically,=

>>>  NMI handlers and kprobes would avoid accessing userspace.
>>=20
>> I think I need to ask the big picture question.  When someone calls
>> flush_tlb_mm_range() (or the other entry points), if no page tables
>> were freed, they want the guarantee that future accesses (initiated
>> observably after the flush returns) will not use paging entries that
>> were replaced by stores ordered before flush_tlb_mm_range().  We also
>> need the guarantee that any effects from any memory access using the
>> old paging entries will become globally visible before
>> flush_tlb_mm_range().
>>=20
>> I'm wondering if receipt of an IPI is enough to guarantee any of this.
>> If CPU 1 sets a dirty bit and CPU 2 writes to the APIC to send an IPI
>> to CPU 1, at what point is CPU 2 guaranteed to be able to observe the
>> dirty bit?  An interrupt entry today is fully serializing by the time
>> it finishes, but interrupt entries are epicly slow, and I don't know
>> if the APIC waits long enough.  Heck, what if IRQs are off on the
>> remote CPU?  There are a handful of places where we touch user memory
>> with IRQs off, and it's (sadly) possible for user code to turn off
>> IRQs with iopl().
>>=20
>> I *think* that Intel has stated recently that SMT siblings are
>> guaranteed to stop speculating when you write to the APIC ICR to poke
>> them, but SMT is very special.
>>=20
>> My general conclusion is that I think the code needs to document what
>> is guaranteed and why.
>=20
> I think I might have managed to confuse you with a bug I made (last minute=

> bug when I was doing some cleanup). This bug does not affect the performan=
ce
> much, but it might led you to think that I use the APIC sending as
> synchronization.
>=20
> The idea is not for us to rely on write to ICR as something serializing. T=
he
> flow should be as follows:
>=20
>=20
>    CPU0                    CPU1
>=20
> flush_tlb_mm_range()
> __smp_call_function_many()
>  [ prepare call_single_data (csd) ]
>  [ lock csd ]=20
>  [ send IPI ]
>    (*)
>  [ wait for csd to be unlocked ]
>                    [ interrupt ]
>                    [ copy csd info to stack ]
>                    [ csd unlock ]
>  [ find csd is unlocked ]
>  [ continue (**) ]
>                    [ flush TLB ]
>=20
>=20
> At (**) the pages might be recycled, written-back to disk, etc. Note that
> during (*), CPU0 might do some local TLB flushes, making it very likely th=
at
> CSD will be unlocked by the time it gets there.
>=20
> As you can see, I don=E2=80=99t rely on any special micro-architectural be=
havior.
> The synchronization is done purely in software.
>=20
> Does it make more sense now?
>=20

Yes.  Have you benchmarked this?=
