Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6118CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7F120652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfCETkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:40:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36411 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCETkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:40:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id g9so8225680eds.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yVGGHadMBLCEifisCqx+V2DGYz+XNZi9yoKHC5pqmog=;
        b=jjrbNrvTpjvxUJRIAoFEDaol+1JtySjcKpJOp3xWnPfvi9uOvktSwcl1Kygj/Jgmdc
         1Ed6w7/rsCUWyJG+JhSwmW6925YBABVYxsB3Mteuw1Enj6MoXAels/EgBCqsO4jOoPP+
         kWF9Q98Es1rcg+e1PnWX4HGkZ5aS7Jcj+elBFiYZDDdcySLYkusR3arf52FXbQreCN7n
         bmgnEqbvU8nkjElWN2xy4QY+dArymKZMiVuUHoa12SRcC2EaRig/4LKYGsloa0S05DEy
         zh2ZENbGD2dGXOWF4AdPhB4rp1JCGcmalBO17LRBkN0aQYVJiCKuJuMNTHqsiwBYlOZu
         mPew==
X-Gm-Message-State: APjAAAU5Nfn+u5tGOKmapqdvr7449Jzj6+eIRS+EUBnrJNbqvM8QCo+1
        SQNJAiDVRan7hrf40EEVWNQ18A==
X-Google-Smtp-Source: APXvYqwmbpfHgGdiN8bC+V9DIb8AcB/z/Or2YwTGDACqj0MEt+3Wcz2b4yr8worIVtJ67XmZbc5Kog==
X-Received: by 2002:aa7:da0f:: with SMTP id r15mr20826277eds.34.1551814804010;
        Tue, 05 Mar 2019 11:40:04 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t9sm3326912edb.13.2019.03.05.11.40.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:40:03 -0800 (PST)
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
 <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
 <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com>
 <cef82f75-8dc6-8198-ac41-492c200f6d57@redhat.com>
 <57b32bc1-8ef2-1e1e-a70f-04444f5919a2@amd.com>
 <6fbcd261-f9e2-1685-1ef7-f148007aab9d@redhat.com>
 <51078b59-161a-0e13-6d8d-87d37c3375f2@redhat.com>
 <62f91d1a-4dc7-9628-5c87-5ffca0cd1a0f@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <92a886e1-1eca-7b94-2c62-9f42abc66bcf@redhat.com>
Date:   Tue, 5 Mar 2019 20:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <62f91d1a-4dc7-9628-5c87-5ffca0cd1a0f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-03-19 20:31, Lendacky, Thomas wrote:
> On 3/5/19 1:19 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 05-03-19 17:02, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 05-03-19 15:06, Lendacky, Thomas wrote:
>>>> On 3/3/19 4:57 AM, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 21-02-19 13:30, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 19-02-19 22:47, Lendacky, Thomas wrote:
>>>>>>> On 2/19/19 3:01 PM, Thomas Gleixner wrote:
>>>>>>>> Hans,
>>>>>>>>
>>>>>>>> On Tue, 19 Feb 2019, Hans de Goede wrote:
>>>>>>>>
>>>>>>>> Cc+: ACPI/AMD folks
>>>>>>>>
>>>>>>>>> Various people are reporting false positive "do_IRQ: #.55 No irq
>>>>>>>>> handler for
>>>>>>>>> vector"
>>>>>>>>> messages on AMD ryzen based laptops, see e.g.:
>>>>>>>>>
>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1551605
>>>>>>>>>
>>>>>>>>> Which contains this dmesg snippet:
>>>>>>>>>
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel: smp: Bringing up
>>>>>>>>> secondary CPUs
>>>>>>>>> ...
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel: x86: Booting SMP
>>>>>>>>> configuration:
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel: .... node  #0,
>>>>>>>>> CPUs:      #1
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 1.55 No irq
>>>>>>>>> handler for
>>>>>>>>> vector
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel:  #2
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 2.55 No irq
>>>>>>>>> handler for
>>>>>>>>> vector
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel:  #3
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 3.55 No irq
>>>>>>>>> handler for
>>>>>>>>> vector
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel: smp: Brought up 1 node,
>>>>>>>>> 4 CPUs
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Max logical
>>>>>>>>> packages: 1
>>>>>>>>> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Total of 4
>>>>>>>>> processors
>>>>>>>>> activated (15968.49 BogoMIPS)
>>>>>>>>>
>>>>>>>>> It seems that we get an IRQ for each CPU as we bring it online,
>>>>>>>>> which feels to me like it is some sorta false-positive.
>>>>>>>>
>>>>>>>> Sigh, that looks like BIOS value add again.
>>>>>>>>
>>>>>>>> It's not a false positive. Something _IS_ sending a vector 55 to these
>>>>>>>> CPUs
>>>>>>>> for whatever reason.
>>>>>>>>
>>>>>>>
>>>>>>> I remember seeing something like this in the past and it turned out
>>>>>>> to be
>>>>>>> a BIOS issue.  BIOS was enabling the APs to interact with the legacy
>>>>>>> 8259
>>>>>>> interrupt controller when only the BSP should. During POST the APs were
>>>>>>> exposed to ExtINT/INTR events as a result of the mis-configuration
>>>>>>> (probably due to a UEFI timer-tick using the 8259) and this left a
>>>>>>> pending
>>>>>>> ExtINT/INTR interrupt latched on the APs.
>>>>>>>
>>>>>>> When the APs were started by the OS, the latched ExtINT/INTR
>>>>>>> interrupt is
>>>>>>> processed shortly after the OS enables interrupts. The AP then
>>>>>>> queries the
>>>>>>> 8259 to identify the vector number (which is the value of the 8259's
>>>>>>> ICW2
>>>>>>> register + the IRQ level). The master 8259's ICW2 was set to 0x30 and,
>>>>>>> since no interrupts are actually pending, the 8259 will respond with
>>>>>>> IRQ7
>>>>>>> (spurious interrupt) yielding a vector of 0x37 or 55.
>>>>>>>
>>>>>>> The OS was not expecting vector 55 and printed the message.
>>>>>>>
>>>>>>>    From the Intel Developer's Manual: Vol 3a, Section 10.5.1:
>>>>>>> "Only one processor in the system should have an LVT entry
>>>>>>> configured to
>>>>>>> use the ExtINT delivery mode."
>>>>>>>
>>>>>>> Not saying this is the problem, but very well could be.
>>>>>>
>>>>>> That sounds like a likely candidate, esp. also since this only happens
>>>>>> once per CPU when we first only the CPU.
>>>>>>
>>>>>> Can you provide me with a patch with some printk-s / pr_debugs to
>>>>>> test for this, then I can build a kernel with that patch added and
>>>>>> we can see if your hypothesis is right.
>>>>>
>>>>> Ping? I like your theory, can you provide some help with debugging this
>>>>> further (to prove that your theory is correct ) ?
>>>>
>>>> It's been a very long time since I dealt with this and I was only on the
>>>> periphery. You might be able to print the LVT entries from the APIC and
>>>> see if any of them have an un-masked ExtINT delivery mode.  You would need
>>>> to do this very early before Linux modifies any values.
>>>
>>> I'm afraid I'm not familiar enough with the interrupt / APIC parts of
>>> the kernel to do something like this myself.
>>>
>>>> Or you can report the issue to the OEM and have them check their BIOS
>>>> code to see if they are doing this.
>>>
>>> I will try to go this route, but I'm not really hopeful that will
>>> lead to a solution.
>>
>> A similar issue is also reported here:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1551605
>>
>> There are multiple people with different vectors (so likely / possibly
>> different bugs) commenting on that bug, but I just got confirmation
>> that the vector 55 issue is also happening on an Acer system with an AMD
>> A8 processor (I suspect a Ryzen, but that still needs to be confirmed).
>>
>> So this seems to be a generic issue with (some) AMD laptops and
>> not specific to one OEM.
> 
> I also see that comment 17 is for an Intel based machine, which to me
> implies that it really is a BIOS issue.

That user is seeing "No irq handler for vector" on vectors 33-35 so that
is likely / possibly another bug.

Finger pointing at the firmware if there are multiple vendors involved
is really not going to help here. Esp. since most OEMs will just respond
with "the machine works fine with Windows"

Regards,

Hans
