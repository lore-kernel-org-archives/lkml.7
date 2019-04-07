Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E949BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6AC20870
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="lmENiy4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDGODp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 10:03:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44535 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDGODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 10:03:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id g12so5738828pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v7Ch0PfbwEgdOSPQGBxSs5UldFVH/iOsM3TIA1X0FVc=;
        b=lmENiy4AY1fAtk8nQrZLIKq5bEe76y8B/xY9X0qFb3QX1g5xXfkcnFMXtPVA6aCpLA
         5WMPfV3iyHB/61a1rzLr/QlFsEi3eNloCOQJs7AmxgH7gAZeJUtvxncX2oeUvZcgQQ8r
         X6BUeUUrELOFcuxjdfNoZ3aPlRvKH7JppLKJtoNo2bGCyow6us1cXD3CoV98i4CPlIYQ
         jMdbTOuBrTFm2uX8BPde1hf2z/6g2wAb9YVf2TpwLptWmb1IwdpY3Wtyhs2zVeXYfcM+
         zxRte/MbQ9fHY7DAQlVJJlalnWd+vLq/2YFYmNtgtfqdJFcik1QoThsyoF0fkNGS9ct1
         srpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v7Ch0PfbwEgdOSPQGBxSs5UldFVH/iOsM3TIA1X0FVc=;
        b=KghrBvESb77634CTm6kdbz7AJWp8ehzEidXyN6/IGXdEkjzNQgm2+j/Xaw0hdZzWDM
         y8Lixs6rSRyl3xsolwRaHaSlxAyDCB0zt5+PegmxGYsC8AcNiRB9INvfzMnOW6mv4Be/
         OOcdjLGjrC1l0KN2R8J7u2PIrD3SEa/WnnMaTuTKHwbLcmXMikXFBL71k6EzO7hI/SjA
         51QRuGPbq6Fw/JL9nc/olV+oTQgZmlvt0FFveXr9g2VrFr6y7sFO9jpJZVwQ6rFwgSSf
         9G5hXFvG8SsIi4ssYpZrT+VsW3sEUwZ9TRTfkEj96VZZdIOYAfvbY+OsMoUnSOWOcKcN
         4AFA==
X-Gm-Message-State: APjAAAUBA/t9QS7H8GtRUqsb2UCyPUyAyEMfWrua+wev4VT71h3L5OjX
        0CvPIc1LwGh6fO/aQOfPbkb/Dg==
X-Google-Smtp-Source: APXvYqyS9RNy5dkxS8L103RUkh7sHRBz7uf5dmLGO8gdxAuidmA/Vc/g59BtjaVd0wBWfi6P0fZNuw==
X-Received: by 2002:a17:902:ec0c:: with SMTP id cy12mr2520214plb.291.1554645823412;
        Sun, 07 Apr 2019 07:03:43 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:8daf:800d:46cf:9ade? ([2601:646:c200:1ef2:8daf:800d:46cf:9ade])
        by smtp.gmail.com with ESMTPSA id i24sm35725905pfo.85.2019.04.07.07.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 07:03:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V2 28/29] x86/irq/64: Remap the IRQ stack with guard pages
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <alpine.DEB.2.21.1904071132120.1840@nanos.tec.linutronix.de>
Date:   Sun, 7 Apr 2019 07:03:41 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC80432F-4880-442F-80CE-70F3564B327D@amacapital.net>
References: <20190405150658.237064784@linutronix.de> <20190405150930.967389183@linutronix.de> <CALCETrWF_YgQODJ=Rpm2MnhFxJXCfoo4H792hUQni0GS9on7og@mail.gmail.com> <alpine.DEB.2.21.1904070803200.1840@nanos.tec.linutronix.de> <50F7A079-11F5-45EA-B378-7527B5920A7C@amacapital.net> <alpine.DEB.2.21.1904071132120.1840@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 7, 2019, at 2:34 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Sun, 7 Apr 2019, Andy Lutomirski wrote:
>>> On Apr 6, 2019, at 11:08 PM, Thomas Gleixner <tglx@linutronix.de> wrote:=

>>>=20
>>>>> On Sat, 6 Apr 2019, Andy Lutomirski wrote:
>>>>> On Fri, Apr 5, 2019 at 8:11 AM Thomas Gleixner <tglx@linutronix.de> wr=
ote:
>>>>>=20
>>>>> From: Andy Lutomirski <luto@kernel.org>
>>>>>=20
>>>>> The IRQ stack lives in percpu space, so an IRQ handler that overflows i=
t
>>>>> will overwrite other data structures.
>>>>>=20
>>>>> Use vmap() to remap the IRQ stack so that it will have the usual guard=

>>>>> pages that vmap/vmalloc allocations have. With this the kernel will pa=
nic
>>>>> immediately on an IRQ stack overflow.
>>>>=20
>>>> The 0day bot noticed that this dies with DEBUG_PAGEALLOC on.  This is
>>>> because the store_stackinfo() function is utter garbage and this patch
>>>> correctly detects just how broken it is.  The attached patch "fixes"
>>>> it.  (It also contains a reliability improvement that should probably
>>>> get folded in, but is otherwise unrelated.)
>>>>=20
>>>> A real fix would remove the generic kstack_end() function entirely
>>>> along with __HAVE_ARCH_KSTACK_END and would optionally replace
>>>> store_stackinfo() with something useful.  Josh, do we have a generic
>>>> API to do a little stack walk like this?  Otherwise, I don't think it
>>>> would be the end of the world to just remove the offending code.
>>>=20
>>> Yes, I found the same yesterday before heading out. It's already broken
>>> with the percpu stack because there is no guarantee that the per cpu sta=
ck
>>> is thread size aligned. It's guaranteed to be page aligned not more.
>>>=20
>>> I'm all for removing that nonsense, but the real question is whether the=
re
>>> is more code which assumes THREAD_SIZE aligned stacks aside of the threa=
d
>>> stack itself.
>>>=20
>>>=20
>> Well, any code like this is already busted, since the stacks alignment
>> doesn=E2=80=99t really change with these patches applied.
>=20
> It does. The existing code has it aligned by chance because the irq stack
> is the first entry in the per cpu area. But yes, there is no reason to req=
uire
> that alignment for irqstacks.
>=20

Isn=E2=80=99t it the first entry in the percpu area (the normal one, not cea=
)?  Is that aligned beyond PAGE_SIZE?=
