Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA658CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15A5214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572049658;
	bh=OxoWV/8MGbWjGNY8ZbA6IGGQbLDSYSHvlpPbwgSb1aI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xUNCBGcWZ6FdAKsIvavsGdIe0svIV3dQ61pOz24ahsqCYEqfThJ/Ro+WybW+ixufs
	 inMRRWDT4Q8UsAt6x4rZFaMpDWbBtsfL2CvmlwDQIPE1NfguI56JTGW3e3YIOy9vJw
	 jw0Xof3M/m2UeLYd+10Blj6wkLb26HHNDRk9ljfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfJZA1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 20:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfJZA1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 20:27:37 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377AB214DA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 00:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572049655;
        bh=OxoWV/8MGbWjGNY8ZbA6IGGQbLDSYSHvlpPbwgSb1aI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rivMcYDdtEE8KSs5ULRXc+fzoXaDbSjoiR7YHc9VHyEpEBCza7j9R5SUx3ZuNwvx4
         BzbNL5aFtakb/5jQLBetI1zjdvj0nP8fl5yA9uEmE3FyvRVN6daHi80+Ry3QOg0P07
         kLXbzW6Y4MTFcZAYAh4/3rEm0P5kKZ9bSKh6m6ZA=
Received: by mail-wm1-f54.google.com with SMTP id 22so3560537wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 17:27:35 -0700 (PDT)
X-Gm-Message-State: APjAAAVHpiwIgSxvegkhCCVA7Db1ke8jYKaNPJrLQg2vH+siZ5irPzgP
        TV16FHRtw7L5w0IwUUvOBUlmHQdJ0/zpXURot/Dpfw==
X-Google-Smtp-Source: APXvYqwxH3cIf9EBcCsLbOj9hRvFkH0lcK06HML56lbIEsA7s8RgSbraikgDgbWmc8AcafFralr8O+7TWk6/vE3ZZMQ=
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr5730543wmh.76.1572049653656;
 Fri, 25 Oct 2019 17:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
 <20191025091310.05770edc@hermes.lan>
In-Reply-To: <20191025091310.05770edc@hermes.lan>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 25 Oct 2019 17:27:22 -0700
X-Gmail-Original-Message-ID: <CALCETrW1HT_sSbjEodukboy9GxXosVu1uopWX8CBdFh8S7JiSQ@mail.gmail.com>
Message-ID: <CALCETrW1HT_sSbjEodukboy9GxXosVu1uopWX8CBdFh8S7JiSQ@mail.gmail.com>
Subject: Re: [dpdk-dev] Please stop using iopl() in DPDK
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Andy Lutomirski <luto@kernel.org>, dev@dpdk.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Oct 25, 2019, at 9:13 AM, Stephen Hemminger <stephen@networkplumber.or=
g> wrote:
>
> =EF=BB=BFOn Thu, 24 Oct 2019 21:45:56 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
>
>> Hi all-
>>
>> Supporting iopl() in the Linux kernel is becoming a maintainability
>> problem.  As far as I know, DPDK is the only major modern user of
>> iopl().
>>
>> After doing some research, DPDK uses direct io port access for only a
>> single purpose: accessing legacy virtio configuration structures.
>> These structures are mapped in IO space in BAR 0 on legacy virtio
>> devices.
>
> Yes. Legacy virtio seems to have been designed without consideration
> of how to use it in userspace. Xen, Vmware and Hyper-V all use memory
> as a doorbell mechanism which is easier to use from userspace.
>
>
>> There are at least three ways you could avoid using iopl().  Here they
>> are in rough order of quality in my opinion:
>>
>> 1. Change pci_uio_ioport_read() and pci_uio_ioport_write() to use
>> read() and write() on resource0 in sysfs.
>
> The cost of entering the kernel for a doorbell mechanism is too
> expensive and would kill performance.
>
>
>> 2. Use the alternative access mechanism in the virtio legacy spec:
>> there is a way to access all of these structures via configuration
>> space.
>
> There is no way to use memory doorbell on older versions of virtio.
> Users want to run DPDK on old stuff like RHEL6 and even older
> kernel forks. There are even use cases where virtio is used for
> a non-Linux host; such as GCP.
>
>
>> 3. Use ioperm() instead of iopl().
>
> Ioperm has the wrong thread semantics. All DPDK applications have
> multiple threads and the initialization logic needs to work even
> if the thread is started later; threads can also be started by
> the user application.
>
> Iopl applies to whole process so this is not an issue.

This is not true. ioperm() and iopl() have identical thread semantics.
I think what you=E2=80=99re seeing is that you can set iopl(3) early withou=
t
knowing which port range to request. You could alternatively set
ioperm() early and ask for a very wide range.  In principle, we could
make ioperm() be per thread, but I=E2=80=99m not sure we should add that ki=
nd
of complexity to support a mostly obsolete use case like this.

There's actually an argument to be made that per-mm ioperm would be
easier to handle in the kernel than per-task due to the vagaries of
KPTI.

All this being said, what are the actual performance implications of
write() to /sys/.../resource0?  Off the top of my head, I would guess
that the actual OUTB or OUTL instruction itself is incredibly slow due
to being trapped and emulated and that virtio-legacy hypervisors
aren't particularly fast to begin with and that, as a result, the
write() might not actually matter that much.

>
>>
>>
>> We are considering changes to the kernel that will potentially harm
>> the performance of any program that uses iopl(3) -- in particular,
>> context switches will become more expensive, and the scheduler might
>> need to explicitly penalize such programs to ensure fairness.  Using
>> ioperm() already hurts performance, and the proposed changes to iopl()
>> will make it even worse.  Alternatively, the kernel could drop iopl()
>> support entirely.  I will certainly make a change to allow
>> distributions to remove iopl() support entirely from their kernels,
>> and I expect that distributions will do this.
>>
>> Please fix DPDK.
>
> Please fix virtio.

Done, with the new version of virtio :)
