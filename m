Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD90C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DE220863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfCCK5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 05:57:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38531 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCCK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 05:57:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so1883445edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 02:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXhYNEsypCMY6KDX/zArd7ep+nVvYTSXNgjoraORk9g=;
        b=rm6thjARcYw4NL8YZXYoL1rXiQXCzV+OElhls6PEX46OkKNiNAN4FqIXsoz5nzwUpn
         JAQIUM4BJ0FF+SWTlLaTVltxT2UN1AbQn4pa0t8k7UmxgXIO85e/0zulj+/6xYMnOFAs
         7+4xW42ElrZ9eIrhCLdoggGVo/MkSaBpdAsa3H1rx23s2ymxbML4IYAaLALRduejtZVP
         T9qwO7TV9SBXMtepo1h1YW67hmyimWsUpxbvCgzw84c7OC8Mulmb7nXyLoGqq4BpvXIG
         cIpNY0N3IVte+SPB+fMxPBlUX9q+ZTlN1gsAEry6TVZRGv5F3tG3RMOJe8I71sqFkCWt
         gSkA==
X-Gm-Message-State: APjAAAWa+VDg/80DW3ME2kNLUXMYDRDjgoZkUPszC0g37KgV8I+bqy4q
        L0n51DAhlYliU/TKuurPCriuoRUFjgs=
X-Google-Smtp-Source: APXvYqzmCjL5OrFqglb5esI1sLufNeZy1hRXtf0sL/0cStJsDV/jHldhr3aLfg7A/MjND099U3vxjg==
X-Received: by 2002:aa7:da0f:: with SMTP id r15mr11346394eds.34.1551610634742;
        Sun, 03 Mar 2019 02:57:14 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t9sm1153489edb.13.2019.03.03.02.57.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 02:57:14 -0800 (PST)
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
 <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
 <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com>
Message-ID: <cef82f75-8dc6-8198-ac41-492c200f6d57@redhat.com>
Date:   Sun, 3 Mar 2019 11:57:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21-02-19 13:30, Hans de Goede wrote:
> Hi,
> 
> On 19-02-19 22:47, Lendacky, Thomas wrote:
>> On 2/19/19 3:01 PM, Thomas Gleixner wrote:
>>> Hans,
>>>
>>> On Tue, 19 Feb 2019, Hans de Goede wrote:
>>>
>>> Cc+: ACPI/AMD folks
>>>
>>>> Various people are reporting false positive "do_IRQ: #.55 No irq handler for
>>>> vector"
>>>> messages on AMD ryzen based laptops, see e.g.:
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1551605
>>>>
>>>> Which contains this dmesg snippet:
>>>>
>>>> Feb 07 20:14:29 localhost.localdomain kernel: smp: Bringing up secondary CPUs
>>>> ...
>>>> Feb 07 20:14:29 localhost.localdomain kernel: x86: Booting SMP configuration:
>>>> Feb 07 20:14:29 localhost.localdomain kernel: .... node  #0, CPUs:      #1
>>>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 1.55 No irq handler for
>>>> vector
>>>> Feb 07 20:14:29 localhost.localdomain kernel:  #2
>>>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 2.55 No irq handler for
>>>> vector
>>>> Feb 07 20:14:29 localhost.localdomain kernel:  #3
>>>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 3.55 No irq handler for
>>>> vector
>>>> Feb 07 20:14:29 localhost.localdomain kernel: smp: Brought up 1 node, 4 CPUs
>>>> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Max logical packages: 1
>>>> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Total of 4 processors
>>>> activated (15968.49 BogoMIPS)
>>>>
>>>> It seems that we get an IRQ for each CPU as we bring it online,
>>>> which feels to me like it is some sorta false-positive.
>>>
>>> Sigh, that looks like BIOS value add again.
>>>
>>> It's not a false positive. Something _IS_ sending a vector 55 to these CPUs
>>> for whatever reason.
>>>
>>
>> I remember seeing something like this in the past and it turned out to be
>> a BIOS issue.  BIOS was enabling the APs to interact with the legacy 8259
>> interrupt controller when only the BSP should. During POST the APs were
>> exposed to ExtINT/INTR events as a result of the mis-configuration
>> (probably due to a UEFI timer-tick using the 8259) and this left a pending
>> ExtINT/INTR interrupt latched on the APs.
>>
>> When the APs were started by the OS, the latched ExtINT/INTR interrupt is
>> processed shortly after the OS enables interrupts. The AP then queries the
>> 8259 to identify the vector number (which is the value of the 8259's ICW2
>> register + the IRQ level). The master 8259's ICW2 was set to 0x30 and,
>> since no interrupts are actually pending, the 8259 will respond with IRQ7
>> (spurious interrupt) yielding a vector of 0x37 or 55.
>>
>> The OS was not expecting vector 55 and printed the message.
>>
>>  From the Intel Developer's Manual: Vol 3a, Section 10.5.1:
>> "Only one processor in the system should have an LVT entry configured to
>> use the ExtINT delivery mode."
>>
>> Not saying this is the problem, but very well could be.
> 
> That sounds like a likely candidate, esp. also since this only happens
> once per CPU when we first only the CPU.
> 
> Can you provide me with a patch with some printk-s / pr_debugs to
> test for this, then I can build a kernel with that patch added and
> we can see if your hypothesis is right.

Ping? I like your theory, can you provide some help with debugging this
further (to prove that your theory is correct ) ?

Regards,

Hans
