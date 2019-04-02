Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57039C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CA7206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o26jZ2bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfDBG7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:59:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38298 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfDBG7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:59:06 -0400
Received: by mail-io1-f67.google.com with SMTP id v4so10010821ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xD6KqcXvFjEwZJRjEhSWecpKous7xQHuUjBwKQcvOw=;
        b=o26jZ2bw6+eXLeq2k0Z71BvaamZmQCvfnayRz6+AbggOznXEN2Fb6nc1B340egBX4d
         WnanyjadnyklUNTnn/01HhS6HtcJraE8g94Ox+BChs26wXowyHuvj0x/WuKN4llBJ0PZ
         wD9KmCArOZHhAtBsg+3/Qqcj2rCWVvsXDbwW9HQLrRkCAzpNNsh9qtBts1b26NWd6dn5
         fklpMUHaMzTV5Yz+WHaHbojcwm6B7SmtEzijuooulo73BMdVxIeJoCGGQ/9bEiE9TodI
         LWecDiZ87WVBUIuWW0YtejGZv7IIuXd8/y8/WSAReV8+vR843Kx9ux7hloq2Nzo8CWRo
         qJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xD6KqcXvFjEwZJRjEhSWecpKous7xQHuUjBwKQcvOw=;
        b=LjU4etbAcGacdNqVIhXTXVbDz+aE27dfk4cugCbh4K7VyoUGsIDUnqo5J9yfoY5+Vh
         RmUR0k85GPUzvCuGVBfUy3fPXNUAhuAG+Cooo7SiLcE0qtOgFhs2E1e2O76fjN8Z+y7e
         J9tIBLe8B56hfoM6hK7exgwu1+QaJQ4GZn3BUun00J7eggGTS9wASflGwDgvNzCZsNl4
         77B3NdgUNC0bToMubD4dCjn/NgEResbwySEZDbaqSeebyQdl8AgcGqQq2QSfP0UyGmIx
         o/IUhNMK60vY+ueCivec89uwxn4mA1Bz/jURA7rieri59ASMbKOD+hQLQXCIk1gi/SsD
         ZcOg==
X-Gm-Message-State: APjAAAWZMAXIxfv+oHyndbOPi05gpK2Zc4+m1jSJigrQkMP1I9H1DUhF
        +8ApvqpuwXtZ68/U71VwRr7CuUnizbd5Py7Otw==
X-Google-Smtp-Source: APXvYqwpp9gvqkFosT8pbNVuhgSFwjGtb2LDTxb9e3T+Hjr7UW/Vd9GgF6VZTcjpqpoL/6m7ImNDDRSZ/KOU7EJvaHI=
X-Received: by 2002:a6b:f10f:: with SMTP id e15mr47535049iog.106.1554188345368;
 Mon, 01 Apr 2019 23:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <1554178246-8162-1-git-send-email-kernelfans@gmail.com> <20190402061926.GA1555@localhost.localdomain>
In-Reply-To: <20190402061926.GA1555@localhost.localdomain>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 2 Apr 2019 14:58:53 +0800
Message-ID: <CAFgQCTv+2oVVeH6rarSgObQNwsBVBCr3phHp8rManLB3hrVOjA@mail.gmail.com>
Subject: Re: [PATCHv3] x86/boot/KASLR: skip the specified crashkernel region
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 1:20 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Tue, Apr 02, 2019 at 12:10:46PM +0800, Pingfan Liu wrote:
> >crashkernel=x@y or or =range1:size1[,range2:size2,...]@offset option may
> or or?
> >fail to reserve the required memory region if KASLR puts kernel into the
> >region. To avoid this uncertainty, asking KASLR to skip the required
> >region.
> >
> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@redhat.com>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >Cc: Baoquan He <bhe@redhat.com>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Cc: Nicolas Pitre <nico@linaro.org>
> >Cc: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> >Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >Cc: linux-kernel@vger.kernel.org
> >---
> [...]
> >+
> >+/* handle crashkernel=x@y or =range1:size1[,range2:size2,...]@offset options */
>
> Before review, I want to say more about the background.
> It's very hard to review the code for someone who is not so familiar
> with kdump, so could you please explain more ahout
> the uasge of crashkernel=range1:size1[,range2:size2,...]@offset.
> And also there are so many jobs who are parsing string. So I really
> need your help to understand the PATCH.
>
> >+static void mem_avoid_specified_crashkernel_region(char *option)
> >+{
> >+      unsigned long long crash_size, crash_base = 0;
> >+      char    *first_colon, *first_space, *cur = option;
> Is there a tab after char?
> >+
> >+      first_colon = strchr(option, ':');
> >+      first_space = strchr(option, ' ');
> >+      /* if contain ":" */
> >+      if (first_colon && (!first_space || first_colon < first_space)) {
> >+              int i;
> >+              u64 total_sz = 0;
> >+              struct boot_e820_entry *entry;
> >+
> >+              for (i = 0; i < boot_params->e820_entries; i++) {
> >+                      entry = &boot_params->e820_table[i];
> >+                      /* Skip non-RAM entries. */
> >+                      if (entry->type != E820_TYPE_RAM)
> >+                              continue;
> >+                      total_sz += entry->size;
> I wonder whether it's needed to consider the memory ranges here.
> I think it's OK to only record the regions should to be avoid.
Maybe not catch you exactly. In the case of
crashkernel=range1:size1[,range2:size2,...]@offset, the size of avoid
region depends on the size of total system ram.
> I remeber I ever talked with Baoquan about the similiar problems.
> @Baoquan, I am not sure if I misunderstand something.
>
> Thanks,
> Chao Fan
> >+              }
> >+              handle_crashkernel_mem(option, total_sz, &crash_size,
> >+                      &crash_base);
> >+      } else {
> >+              crash_size = memparse(option, &cur);
> >+              if (option == cur)
> >+                      return;
> >+              while (*cur && *cur != ' ' && *cur != '@')
> >+                      cur++;
> >+              if (*cur == '@') {
> >+                      option = cur + 1;
> >+                      crash_base = memparse(option, &cur);
> >+              }
> >+      }
> >+      if (crash_base) {
> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> >+      } else {
> >+              /*
> >+               * Clearing mem_avoid if no offset is given. This is consistent
> >+               * with kernel, which uses the last crashkernel= option.
> >+               */
> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].start = 0;
> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].size = 0;
> >+      }
> >+}
> >
> > static void handle_mem_options(void)
> > {
> >@@ -248,7 +358,7 @@ static void handle_mem_options(void)
> >       u64 mem_size;
> >
> >       if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
> >-              !strstr(args, "hugepages"))
> >+              !strstr(args, "hugepages") && !strstr(args, "crashkernel="))
> >               return;
> >
> >       tmp_cmdline = malloc(len + 1);
> >@@ -284,6 +394,8 @@ static void handle_mem_options(void)
> >                               goto out;
> >
> >                       mem_limit = mem_size;
> >+              } else if (strstr(param, "crashkernel")) {
> >+                      mem_avoid_specified_crashkernel_region(val);
> >               }
> >       }
> >
> >@@ -412,7 +524,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
> >
> >       /* We don't need to set a mapping for setup_data. */
> >
> >-      /* Mark the memmap regions we need to avoid */
> >+      /* Mark the regions we need to avoid */
> >       handle_mem_options();
> >
> >       /* Enumerate the immovable memory regions */
> >--
> >2.7.4
> >
> >
> >
>
>
