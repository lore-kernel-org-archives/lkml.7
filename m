Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0441C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19AE206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfDBHAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:00:40 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:43096 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725863AbfDBHAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:00:40 -0400
X-IronPort-AV: E=Sophos;i="5.60,298,1549900800"; 
   d="scan'208";a="58278672"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Apr 2019 15:00:37 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id E59BC4CD7909;
        Tue,  2 Apr 2019 15:00:39 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 2 Apr 2019 15:00:43 +0800
Date:   Tue, 2 Apr 2019 15:59:39 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3] x86/boot/KASLR: skip the specified crashkernel region
Message-ID: <20190402075939.GA6560@localhost.localdomain>
References: <1554178246-8162-1-git-send-email-kernelfans@gmail.com>
 <20190402061926.GA1555@localhost.localdomain>
 <CAFgQCTv+2oVVeH6rarSgObQNwsBVBCr3phHp8rManLB3hrVOjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFgQCTv+2oVVeH6rarSgObQNwsBVBCr3phHp8rManLB3hrVOjA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: E59BC4CD7909.AECA2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:58:53PM +0800, Pingfan Liu wrote:
>On Tue, Apr 2, 2019 at 1:20 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>>
>> On Tue, Apr 02, 2019 at 12:10:46PM +0800, Pingfan Liu wrote:
>> >crashkernel=x@y or or =range1:size1[,range2:size2,...]@offset option may
>> or or?
>> >fail to reserve the required memory region if KASLR puts kernel into the
>> >region. To avoid this uncertainty, asking KASLR to skip the required
>> >region.
>> >
>> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>> >Cc: Thomas Gleixner <tglx@linutronix.de>
>> >Cc: Ingo Molnar <mingo@redhat.com>
>> >Cc: Borislav Petkov <bp@alien8.de>
>> >Cc: "H. Peter Anvin" <hpa@zytor.com>
>> >Cc: Baoquan He <bhe@redhat.com>
>> >Cc: Will Deacon <will.deacon@arm.com>
>> >Cc: Nicolas Pitre <nico@linaro.org>
>> >Cc: Pingfan Liu <kernelfans@gmail.com>
>> >Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> >Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> >Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >Cc: linux-kernel@vger.kernel.org
>> >---
>> [...]
>> >+
>> >+/* handle crashkernel=x@y or =range1:size1[,range2:size2,...]@offset options */
>>
>> Before review, I want to say more about the background.
>> It's very hard to review the code for someone who is not so familiar
>> with kdump, so could you please explain more ahout
>> the uasge of crashkernel=range1:size1[,range2:size2,...]@offset.
>> And also there are so many jobs who are parsing string. So I really
>> need your help to understand the PATCH.
>>
>> >+static void mem_avoid_specified_crashkernel_region(char *option)
>> >+{
>> >+      unsigned long long crash_size, crash_base = 0;
>> >+      char    *first_colon, *first_space, *cur = option;
>> Is there a tab after char?
>> >+
>> >+      first_colon = strchr(option, ':');
>> >+      first_space = strchr(option, ' ');
>> >+      /* if contain ":" */
>> >+      if (first_colon && (!first_space || first_colon < first_space)) {
>> >+              int i;
>> >+              u64 total_sz = 0;
>> >+              struct boot_e820_entry *entry;
>> >+
>> >+              for (i = 0; i < boot_params->e820_entries; i++) {
>> >+                      entry = &boot_params->e820_table[i];
>> >+                      /* Skip non-RAM entries. */
>> >+                      if (entry->type != E820_TYPE_RAM)
>> >+                              continue;
>> >+                      total_sz += entry->size;
>> I wonder whether it's needed to consider the memory ranges here.
>> I think it's OK to only record the regions should to be avoid.
>Maybe not catch you exactly. In the case of
>crashkernel=range1:size1[,range2:size2,...]@offset, the size of avoid
>region depends on the size of total system ram.

Got it, I midunderstand it.

Thanks,
Chao Fan
>> I remeber I ever talked with Baoquan about the similiar problems.
>> @Baoquan, I am not sure if I misunderstand something.
>>
>> Thanks,
>> Chao Fan
>> >+              }
>> >+              handle_crashkernel_mem(option, total_sz, &crash_size,
>> >+                      &crash_base);
>> >+      } else {
>> >+              crash_size = memparse(option, &cur);
>> >+              if (option == cur)
>> >+                      return;
>> >+              while (*cur && *cur != ' ' && *cur != '@')
>> >+                      cur++;
>> >+              if (*cur == '@') {
>> >+                      option = cur + 1;
>> >+                      crash_base = memparse(option, &cur);
>> >+              }
>> >+      }
>> >+      if (crash_base) {
>> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
>> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
>> >+      } else {
>> >+              /*
>> >+               * Clearing mem_avoid if no offset is given. This is consistent
>> >+               * with kernel, which uses the last crashkernel= option.
>> >+               */
>> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].start = 0;
>> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].size = 0;
>> >+      }
>> >+}
>> >
>> > static void handle_mem_options(void)
>> > {
>> >@@ -248,7 +358,7 @@ static void handle_mem_options(void)
>> >       u64 mem_size;
>> >
>> >       if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
>> >-              !strstr(args, "hugepages"))
>> >+              !strstr(args, "hugepages") && !strstr(args, "crashkernel="))
>> >               return;
>> >
>> >       tmp_cmdline = malloc(len + 1);
>> >@@ -284,6 +394,8 @@ static void handle_mem_options(void)
>> >                               goto out;
>> >
>> >                       mem_limit = mem_size;
>> >+              } else if (strstr(param, "crashkernel")) {
>> >+                      mem_avoid_specified_crashkernel_region(val);
>> >               }
>> >       }
>> >
>> >@@ -412,7 +524,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>> >
>> >       /* We don't need to set a mapping for setup_data. */
>> >
>> >-      /* Mark the memmap regions we need to avoid */
>> >+      /* Mark the regions we need to avoid */
>> >       handle_mem_options();
>> >
>> >       /* Enumerate the immovable memory regions */
>> >--
>> >2.7.4
>> >
>> >
>> >
>>
>>
>
>


