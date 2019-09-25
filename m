Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAFDC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DFF207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408344AbfIYRgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408309AbfIYRf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:35:59 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2394D7FDCA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 17:35:59 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id u18so909879ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+gsfBJ80Xo+s2iz6GLpohcHVVaPnorUB2p0jTHQBV4=;
        b=G2gt2QeveGvQwQNlWrJyqdncICn6mLFQ/rGIAldyyvH28nyI49hZvKUwQlmVDlLJIb
         1AcddJu1oLxmTfaF+wJd35naRZYdf4rxbHwJ+hmMoszTD2XAt5nGo+u77sMyIPGVdWNr
         bqmLlTLwXIAD7CFDEpEGlHKNRmCNWroqOhL2B2n57MK4mCX8VmonPWiI+W1EZ0P4ERv3
         TTPWc0boNWNb3zuE2Sz8h0pZL1Y0KIgDtnG+sTETgqS6bJfkRjwqjDuqqUNN1CjndZzg
         /Y+d1qy19ABNG82hBDT5rrLTbKJeIC7ejmJ9Dd29fjNL/fPUqHZFUMMlvCLebong4Xf2
         H33Q==
X-Gm-Message-State: APjAAAV+r82v04W7XqIDexm5kySu7zinOmlRlTNejEGqKG1YrcJWU0xa
        Ack690dhKhMspbkHvWbUJ5AWTu/TNxC80H9Sl3rCWpMlJYpvZROSO9YT+dCxBbf3jq6q+QCWLjJ
        qQbzFJun7i5wHUe1NFn/FzJMpdln9JTKD9ziUFYVs
X-Received: by 2002:a92:5c13:: with SMTP id q19mr1249905ilb.249.1569432958474;
        Wed, 25 Sep 2019 10:35:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwoKj8HpdH+Dl4OvyuizdO0KGNH4Io3djddrF8hh/2diekqKLdeh5PPvS2fpQ3VK8VrMTvK7cj/BbXpFDnFxrg=
X-Received: by 2002:a92:5c13:: with SMTP id q19mr1249882ilb.249.1569432958022;
 Wed, 25 Sep 2019 10:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190919160521.13820-1-kasong@redhat.com> <20190925095527.GE31919@MiWiFi-R3L-srv>
In-Reply-To: <20190925095527.GE31919@MiWiFi-R3L-srv>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 26 Sep 2019 01:35:46 +0800
Message-ID: <CACPcB9df97J2UP8xQEOkhABbeo9pZ56GOxMvFwrE6gPRkF2TQg@mail.gmail.com>
Subject: Re: [PATCH v2] x86, efi: never relocate kernel below lowest
 acceptable address
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 5:55 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 09/20/19 at 12:05am, Kairui Song wrote:
> > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > And it's a potential issue on all platforms.
> >
> > It's caused a broken kernel relocation on EFI systems, when below three
> > conditions are met:
> >
> > 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
> >    by the loader.
> > 2. There isn't enough room to contain the kernel, starting from the
> >    default load address (eg. something else occupied part the region).
> > 3. In the memmap provided by EFI firmware, there is a memory region
> >    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
> >    kernel.
>
> Thanks for the effort, Kairui.
>
> Let me summarize what I got from this issue, please correct me if
> anything missed:
>
> ***
> Problem:
> This bug is reported on Hyper-V platform. The kernel will reset to
> firmware w/o any console printing in 1st kernel and kdump kernel
> sometime.
>
> ***
> Root cause:
> With debugging, the resetting to firmware is triggered when execute
> 'rep     movsq' line of /boot/compressed/head_64.S. The reason is that
> efi boot stub may put kernel image below 16M, then later head_64.S will
> relocate kernel to 16M directly. That relocation will conflict with some
> efi reserved region, then cause the resetting.
>
> A more detail process based on the problem occurred on that HyperV
> machine:
>
> - kernel (INIT_SIZE: 56820K) got loaded at 0x3c881000 (not aligned,
>   and not equal to pref_address 0x1000000), need to relocate.
>
> - efi_relocate_kernel is called, try to allocate INIT_SIZE of memory
>   at pref_address, failed, something else occupied this region.
>
> - efi_relocate_kernel call efi_low_alloc as fallback, and got the address
>   0x800000 (Below 0x1000000)
>
> - Later in arch/x86/boot/compressed/head_64.S:108, LOAD_PHYSICAL_ADDR is
>   force used as the new load address as the current address is lower than
>   that. Then kernel try relocate to 0x1000000.
>
> - However the memory starting from 0x1000000 is not allocated from EFI
>   firmware, writing to this region caused the system to reset.
>
> ***
> Solution:
> Alwasys search area above LOAD_PHYSICAL_ADDR, namely 16M to put kernel
> image in /boot/compressed/eboot.c. Then efi boot stub in eboot.c will
> search an suitable area in efi memmap, to make sure no any reserved
> region will conflict with the target area of kernel image. Besides,
> kernel won't be relocated in /boot/compressed/head_64.S since it has
> been above 16M.
>
> #ifdef CONFIG_RELOCATABLE
>         leaq    startup_32(%rip) /* - $startup_32 */, %rbp
>         movl    BP_kernel_alignment(%rsi), %eax
>         decl    %eax
>         addq    %rax, %rbp
>         notq    %rax
>         andq    %rax, %rbp
>         cmpq    $LOAD_PHYSICAL_ADDR, %rbp
>         jge     1f
> #endif
>         movq    $LOAD_PHYSICAL_ADDR, %rbp
> 1:
>
>         /* Target address to relocate to for decompression */
>         movl    BP_init_size(%rsi), %ebx
>         subl    $_end, %ebx
>         addq    %rbp, %rbx
>

Hi Baoquan,

Yes, it's all correct. Thanks for adding these details.

>
> ***
> I have one concerns about this patch:
>
> Why this only happen in Hyper-V platform. Qemu/kvm, baremetal, vmware
> ESI don't have this issue? What's the difference?

Let me post part the efi memmap on that machine (and btw the kernel
size is 55M):

kernel: efi: mem00: type=7, attr=0xf,
range=[0x0000000000000000-0x0000000000080000) (0MB)
kernel: efi: mem01: type=4, attr=0xf,
range=[0x0000000000080000-0x0000000000081000) (0MB)
kernel: efi: mem02: type=2, attr=0xf,
range=[0x0000000000081000-0x0000000000082000) (0MB)
kernel: efi: mem03: type=7, attr=0xf,
range=[0x0000000000082000-0x00000000000a0000) (0MB)
kernel: efi: mem04: type=4, attr=0xf,
range=[0x0000000000100000-0x000000000062a000) (5MB)
kernel: efi: mem05: type=7, attr=0xf,
range=[0x000000000062a000-0x0000000004200000) (59MB)
kernel: efi: mem06: type=4, attr=0xf,
range=[0x0000000004200000-0x0000000004400000) (2MB)
kernel: efi: mem07: type=7, attr=0xf,
range=[0x0000000004400000-0x00000000045c6000) (1MB)
kernel: efi: mem08: type=4, attr=0xf,
range=[0x00000000045c6000-0x00000000045e6000) (0MB)
kernel: efi: mem09: type=3, attr=0xf,
range=[0x00000000045e6000-0x000000000460b000) (0MB)
kernel: efi: mem10: type=4, attr=0xf,
range=[0x000000000460b000-0x0000000004613000) (0MB)
kernel: efi: mem11: type=3, attr=0xf,
range=[0x0000000004613000-0x000000000462b000) (0MB)
kernel: efi: mem12: type=7, attr=0xf,
range=[0x000000000462b000-0x0000000004800000) (1MB)
kernel: efi: mem13: type=2, attr=0xf,
range=[0x0000000004800000-0x0000000007f7d000) (55MB)
kernel: efi: mem14: type=7, attr=0xf,
range=[0x0000000007f7d000-0x0000000039a39000) (794MB)
kernel: efi: mem15: type=2, attr=0xf,
range=[0x0000000039a39000-0x0000000040000000) (101MB)
kernel: efi: mem16: type=7, attr=0xf,
range=[0x0000000040000000-0x000000004263d000) (38MB)
kernel: efi: mem17: type=2, attr=0xf,
range=[0x000000004263d000-0x000000007fff2000) (985MB)
kernel: efi: mem18: type=0, attr=0xf,
range=[0x000000007fff2000-0x000000007fff3000) (0MB)
kernel: efi: mem19: type=7, attr=0xf,
range=[0x000000007fff3000-0x00000000f6aaf000) (1898MB)
kernel: efi: mem20: type=2, attr=0xf,
range=[0x00000000f6aaf000-0x00000000f6ab0000) (0MB)
kernel: efi: mem21: type=1, attr=0xf,
range=[0x00000000f6ab0000-0x00000000f6bcd000) (1MB)
kernel: efi: mem22: type=2, attr=0xf,
range=[0x00000000f6bcd000-0x00000000f6cec000) (1MB)
kernel: efi: mem23: type=1, attr=0xf,
range=[0x00000000f6cec000-0x00000000f6dfb000) (1MB)
kernel: efi: mem24: type=6, attr=0x800000000000000f,
range=[0x00000000f6dfb000-0x00000000f6e06000) (0MB)
kernel: efi: mem25: type=9, attr=0xf,
range=[0x00000000f6e06000-0x00000000f6e07000) (0MB)
kernel: efi: mem26: type=3, attr=0xf,
range=[0x00000000f6e07000-0x00000000f6eea000) (0MB)
kernel: efi: mem27: type=9, attr=0xf,
range=[0x00000000f6eea000-0x00000000f6ef2000) (0MB)
kernel: efi: mem28: type=6, attr=0x800000000000000f,
range=[0x00000000f6ef2000-0x00000000f6f1b000) (0MB)
kernel: efi: mem29: type=7, attr=0xf,
range=[0x00000000f6f1b000-0x00000000f73c1000) (4MB)
kernel: efi: mem30: type=4, attr=0xf,
range=[0x00000000f73c1000-0x00000000f7e1b000) (10MB)
kernel: efi: mem31: type=3, attr=0xf,
range=[0x00000000f7e1b000-0x00000000f7f9b000) (1MB)
kernel: efi: mem32: type=5, attr=0x800000000000000f,
range=[0x00000000f7f9b000-0x00000000f7fcb000) (0MB)
kernel: efi: mem33: type=6, attr=0x800000000000000f,
range=[0x00000000f7fcb000-0x00000000f7fef000) (0MB)
kernel: efi: mem34: type=0, attr=0xf,
range=[0x00000000f7fef000-0x00000000f7ff3000) (0MB)
kernel: efi: mem35: type=9, attr=0xf,
range=[0x00000000f7ff3000-0x00000000f7ffb000) (0MB)
kernel: efi: mem36: type=10, attr=0xf,
range=[0x00000000f7ffb000-0x00000000f7fff000) (0MB)
kernel: efi: mem37: type=4, attr=0xf,
range=[0x00000000f7fff000-0x00000000f8000000) (0MB)
kernel: efi: mem38: type=7, attr=0xf,
range=[0x0000000100000000-0x0000000108000000) (128MB)
kernel: efi: mem39: type=0, attr=0x1,
range=[0x00000000000c0000-0x0000000000100000) (0MB)

You see, there is a region:
kernel: efi: mem05: type=7, attr=0xf,
range=[0x000000000062a000-0x0000000004200000) (59MB)

Which fits the kernel, and it's below 0x1000000 (16M), and the loader
didn't load the kernel to a prefered address (16M), so efi-stub will
relocate kernel to that low region.
I didn't observe any other platform's firmware will provide a region
starts below 16M and large enough to contain kernel, and load kernel
into a strange address at the same time.

>
> By the way, I personally like this way better. Because it is fixing a
> potention issue. Efi boot stub code may put kernel below 16M, but the
> relocation code in boot/compressed/head_64.S doesn't consider the
> possible conflict, and head_64.S have no way to know the efi memmap
> information. If this patch can't be accepted, woring around it in
> Hyper-V may be a way.
>
> Thanks
> Baoquan
>

Thanks for the review!

-- 
Best Regards,
Kairui Song
