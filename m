Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DCC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D770206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3YUiBw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfHLOm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:42:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46018 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfHLOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:42:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id m24so6634328otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WELxyn8EB6WPI2l7zvhxd4ilv3SK0lcmspLR027X0a0=;
        b=Y3YUiBw8r8uTMpvc7czFR+WK7s/fG1UDdumOUyZ6rtPKC1y8NxH643SJrG2JfUnYaI
         aXtEOfckoVtSP9Z1m32korvdGHjomzw/E2PvRaoEdAWOquQFLmdpk/LnD7lfKaPWGRe+
         RPCqqtweTE8aVgUt1NTpB0TZzAuUVDtL+AMA6+5O9SoPI0teWlpuCkUNT/vsokNgXHxy
         RDwQzMqez/9S7rmALCnqkPx56R5gnnOiUPtnSOtxWQQfXTD6xbclzzZEe9yws0rJ7SV3
         MC4uJ0AeftC8O90pcuYM8qJ73f2g3tFCCKjVCrMwz404pMLm8RB2+YfveUPgRHIbxnqk
         E9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WELxyn8EB6WPI2l7zvhxd4ilv3SK0lcmspLR027X0a0=;
        b=uCtsFRw7eod4OuwzpRDWn+tsMMCragXhqPvxK8f/6Fku3vm/0b2jDIVT677/mzNEEP
         ebJKKWQOAzWIDWOwIfKBI8c3xOR+ysJ8lqlbnXnS8ji2ZGdIZr3isrXaPYxsrfRVRDjq
         BHSWsQP53/3iLPfX0wTbP90tgxYOOIbGbGwmFEzYT5OLX36ekxhs0jGfvWDJTqSpi384
         p5mYj29VuklCxwLCC14TZQ3O7xAsp9ACWWe0HhbLJ3qFm4lJi6LXnS6JTpxwbSK3CMj+
         S2/5yQBCE3mc7XKGqOIYcwMgwgqpMAanZ0OOlsvE2yNRCUmpTKmkFZwDISXufNJzQ2eL
         9GFg==
X-Gm-Message-State: APjAAAVieL2FkFv0ZzaKttKl1dkoYHj4qmaXI1OZSk4yX3Q7/+DrEw39
        KvynQnJZBytxXQoGOxb8FPpi9YM18J163y0Cnri5
X-Google-Smtp-Source: APXvYqyqI+0j2qoso/KUQQqjdB3DGMegmTyZR5TJmdaiKadI6KSHdRLdK5WerL8xBzp9wzRhTf/YMBUecfJ0+LYPI3k=
X-Received: by 2002:a6b:fb10:: with SMTP id h16mr33486899iog.195.1565620976827;
 Mon, 12 Aug 2019 07:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <2e70a6e2-23a6-dbf2-4911-1e382469c9cb@gmail.com>
 <CAM6Zs0WqdfCv=EGi5qU5w6Dqh2NHQF2y_uF4i57Z9v=NoHHwPA@mail.gmail.com>
 <CAM6Zs0X_TpRPSR9XRikkYxHSA4vZsFr7WH_pEyq6npNjobdRVw@mail.gmail.com>
 <11dc5f68-b253-913a-4219-f6780c8967a0@intel.com> <594c424c-2474-5e2c-9ede-7e7dc68282d5@gmail.com>
 <CAM6Zs0XzBvoNFa5CSAaEEBBJHcxvguZFRqVOVdr5+JDE=PVGVw@mail.gmail.com>
 <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de> <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com>
In-Reply-To: <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com>
From:   Woody Suwalski <terraluna977@gmail.com>
Date:   Mon, 12 Aug 2019 10:42:38 -0400
Message-ID: <CAM6Zs0WLQG90EQ+38NE1Nv8bcnbxW8wO4oEfxSuu4dLhfT1YZA@mail.gmail.com>
Subject: Re: Kernel 5.3.x, 5.2.2+: VMware player suspend on 64/32 bit guests
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas, Rafael,
I have added a timeout counter in __synchronize_hardirq().
At the bottom I have converted while(inprogress); to while(inprogress
&& timeout++ < 100);

That is bypassing the suspend lockup problem. On both 32-bit and
64-bit VMs the countdown is triggered by sync of irq9.
Which probably means that there is some issue in ACPI handler and
synchronize_hardirq() is stuck on it?
I will try to repeat with 5.3-rc4 tomorrow....

Thanks, Woody

On Sat, Aug 10, 2019 at 7:24 AM Woody Suwalski <terraluna977@gmail.com> wro=
te:
>
> Moving the thread to LKML, as suggested by Thomas...
> >
> >> ---------- Forwarded message ---------
> >> From: Woody Suwalski <terraluna977@gmail.com>
> >> Date: Thu, Aug 1, 2019 at 3:45 PM
> >> Subject: Intermittent suspend on 5.3 / 5.2
> >> To: Rafael J. Wysocki <rjw@rjwysocki.net>
> >>
> >>
> >> Hi Rafa=C5=82,
> >> I know that you are investigating some issues between these 2 kernels,
> >> however I see probably an unrelated problem with suspend on 5.3 and
> >> 5.2.4. I think it has creeped in to 5.1.21 as well, but not sure (it i=
s
> >> intermittent). So far 4.20.17 works OK, and  I think 5.2.0 works OK.
> >> The problem I see is on both 32 and 64 bit VMs, in VMware workstation
> >> 15. The VM is trying to suspend when no activity. It leaves out a blac=
k
> >> box with cursor in top-left position. Upon wakeup from VMware it goes =
to
> >> vmware pre-bios screen, and then expands the black box to the run-size
> >> and switches to X.
> >> The problem with new kernels is that (I think) the suspend fails - the
> >> black box with cursor is there, but seems bigger, and of course is not
> >> wake'able (have to reset). In kern.log suspend seems be running OK, an=
d
> >> then new dmesg lines kick in, and no obvious culprit.
> >> So looking for a free advice .
> >> a. You already know what it is
> >> b. You may have suggestions as to which upstream patch could be to bla=
me
> >> c. I should boot with some debug params (console_off=3D0, or some othe=
r?)
> >> and get some real info?
> >>
> >> BTW. For suspend to work I had to override mem_sleep to [shallow], or
> >> maybe later to [s2idle] (the actual VMs are at work, referring from
> >> memory...)
> >>
> >> If you have any ideas, all are welcomed
> >> Thanks, Woody
>
>
>
> On 8/6/2019 3:18 PM, Woody Suwalski wrote:
> > Rafal, the patch (in 5.3-rc3)
> >
> > Fixes: f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in
> > special cases")
> >
> > does not fix the issue - it must be something else...
>
> Sorry for the late response.
>
> There are known issues in 5.3-rc related to power management which
> should be fixed in -rc4.  Please try that one when it is out.
>
> Cheers!
>
>
>
> Thomas Gleixner wrote:
> > Woody,
> >
> > On Fri, 9 Aug 2019, Woody Suwalski wrote:
> >
> > For future things like this, please CC LKML. There is nothing secrit he=
re
> > and CC'ing the mailing list allows other people to find this and spare
> > themself the whole bisection pain. Asided of that private mail does not
> > scale. On the list other people can look at it and give input eventuall=
y.
> >
> >> After bisecting I have found the potential culprit:
> >> dfe0cf8b  x86/ioapic: Implement irq_get irqchip_state() callback
> >>
> >> I am repeating the bisection from start to re-confirm.
> >>
> >> Reverse-patch on 5.3-rc3 (64bit) is fixing the problem for me.
> >> What is unclear - just adding the patch to 5.2.1 does not seem to
> >> break it. So there is some more magic involved.
> > Of course it does not do anything because 5.2.1 is not having
> >
> > f4999a2a3a48 ("genirq: Add optional hardware synchronization for shutdo=
wn")
> >
> >> Thomas, any suggestions?
> > What that means is that there is an interrupt shutdown which hits the
> > condition where an interrupt _IS_ marked in the IOAPIC as delivered to =
a
> > CPU, but not serviced yet.
> >
> > Now the question is why it is not serviced. suspend_device_irqs() is
> > calling into synchronize_irq(), which is probably the place where that
> > it hangs. But that's called with CPUs online and interrupts enabled.
> >
> >> The reproduce methodology: use VMware player 15, either 32 or 64 bit b=
uild.
> >> reboot and run "systemctl suspend". The first suspend works OK. The
> >> second usually locks on kernels 5.2.2 and up. Maybe try 4 times to
> >> confirm good (it is intermittent).
> > -ENOVMWAREPLAYER and I'm traveling so I don't have a machine handy to
> > install it. So if you can't debug it deeper down, I'm not going to have=
 a
> > chance to look at it before the end of next week.
> >
> > That said, can we please move this to LKML?
> >
> > Thanks,
> >
> >       tglx
> >
> >
> I can add some printk's into synchronize_irq(), however no idea if they
> will be survive in the kmsg log after a next power-reset. I can wait for
> a week :-)
>
> Thanks, Woody
>
