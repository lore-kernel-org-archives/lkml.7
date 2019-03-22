Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA746C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C5C21904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFXbkKe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfCVHro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:47:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43936 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCVHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:47:43 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so961311iol.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 00:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsOmrGEPuP8++wutW3TM3Q2YBl9uokqXNIy8v3JLltw=;
        b=jFXbkKe0ZDr5qhOvGEmq/LVMscsh1WCT95XIEAHnMevb7L/XpVcmvcrr/OI+w2CRAY
         F8uzNpBG7bTZ1ZeubmxKUhFkJIz9YYbWfwkyXSUmWP2+jZfdkBuUOMj8v9E+8yXuP1ZG
         XQQcPj79gnBPFhKqpZruxLhcbvGZAWtnnvq8UFtHTvtwsoPQ1c05RArPh5qs0E4RinK0
         AcVrpYZ5+c2buqDz5jUkRpWd8uLPG43eCxeSFfvqUoPQF2vC8RvtS5jse4d1Q+YKYhxy
         47/t5wMORdAyYQrd56fgLqicOk4A54VCQZPj3eBnLXFeOczmhWuBth+7FWkjZgXkzkxk
         vXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsOmrGEPuP8++wutW3TM3Q2YBl9uokqXNIy8v3JLltw=;
        b=Spe8AM/kqXQFl94RztzbfTeWLcAf6RzcAjPVVs9cRyvB+FHMHsRCO3tkW8jFCQQBOd
         ZvHP4J5qKSVIfwkbGWax0cQeQmDqtuE6f9o1HQNmUVkYyy9PeClgejZhUdy05sl6i5kO
         73OnKoL3LeWhl4k++6zS4MrYYe6cIMl7pxYrEBkPt34zismdC4oOSLEuzFDpyiCdo6UQ
         PjLmi30G/GvdWXb7mvYlMEP7x3kQpWWF6W2HVTNnH9AgkqAN3YavRRCmh0Hd7C/RCuw4
         nuXfEoLQ064+IzrANnpuYFHcbEU0lqb0+5+B3Vl9uPa54iPQJjB/kCiYAZzhx6eih8Hj
         7C/A==
X-Gm-Message-State: APjAAAVko+z2X69qhefDuSuPQwz9n2aJ84e1fpSDpP/X1q2AuhqDYUfH
        YqZ0ecMzch9OE8MG/ZoFOKpBP+BS/zt/lYVwxw==
X-Google-Smtp-Source: APXvYqz8ms2JOb6nGfJbsba9vPJwcxHk3uuP0ZSjJgv78lovak3u9r5bOP0mvtWlFRfGpGqKJEMa1xRnZVG6kZEAyCk=
X-Received: by 2002:a5d:8251:: with SMTP id n17mr6275451ioo.259.1553240862582;
 Fri, 22 Mar 2019 00:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com> <20190321063740.GG1590@localhost.localdomain>
In-Reply-To: <20190321063740.GG1590@localhost.localdomain>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 22 Mar 2019 15:47:31 +0800
Message-ID: <CAFgQCTuP7y6345wZdD7eqT8YPYLLNhbSw05wBh85_WzEgT6oVQ@mail.gmail.com>
Subject: Re: [PATCHv2] x86/boot/KASLR: skip the specified crashkernel reserved region
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

On Thu, Mar 21, 2019 at 2:38 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Wed, Mar 13, 2019 at 12:19:31PM +0800, Pingfan Liu wrote:
>
> I tested it in Qemu test with 12G memory, and set crashkernel=6G@6G.
> Without this PATCH, it successed to reserve memory just 4 times(total
> 10 times).
> With this PATCH, it successed to reserve memory 15 times(total 15
> times).
>
> So I think if you post new version, you can add:
>
> Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>
Appreciate for your testing. I had done some test on a real machine
with a private patch to narrow down the KASLR range. I think your test
method is more simple and I will add the tested-by you.

Regards,
Pingfan

> Thanks,
> Chao Fan
>
> >crashkernel=x@y option may fail to reserve the required memory region if
> >KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
> >skip the required region.
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
> >v1 -> v2: fix some trival format
> >
> > arch/x86/boot/compressed/kaslr.c | 26 ++++++++++++++++++++++++--
> > 1 file changed, 24 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> >index 9ed9709..e185318 100644
> >--- a/arch/x86/boot/compressed/kaslr.c
> >+++ b/arch/x86/boot/compressed/kaslr.c
> >@@ -109,6 +109,7 @@ enum mem_avoid_index {
> >       MEM_AVOID_BOOTPARAMS,
> >       MEM_AVOID_MEMMAP_BEGIN,
> >       MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
> >+      MEM_AVOID_CRASHKERNEL,
> >       MEM_AVOID_MAX,
> > };
> >
> >@@ -240,6 +241,25 @@ static void parse_gb_huge_pages(char *param, char *val)
> >       }
> > }
> >
> >+/* parse crashkernel=x@y option */
> >+static void mem_avoid_crashkernel_simple(char *option)
> >+{
> >+      unsigned long long crash_size, crash_base;
> >+      char *cur = option;
> >+
> >+      crash_size = memparse(option, &cur);
> >+      if (option == cur)
> >+              return;
> >+
> >+      if (*cur == '@') {
> >+              option = cur + 1;
> >+              crash_base = memparse(option, &cur);
> >+              if (option == cur)
> >+                      return;
> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> >+              mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> >+      }
> >+}
> >
> > static void handle_mem_options(void)
> > {
> >@@ -250,7 +270,7 @@ static void handle_mem_options(void)
> >       u64 mem_size;
> >
> >       if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
> >-              !strstr(args, "hugepages"))
> >+              !strstr(args, "hugepages") && !strstr(args, "crashkernel="))
> >               return;
> >
> >       tmp_cmdline = malloc(len + 1);
> >@@ -286,6 +306,8 @@ static void handle_mem_options(void)
> >                               goto out;
> >
> >                       mem_limit = mem_size;
> >+              } else if (strstr(param, "crashkernel")) {
> >+                      mem_avoid_crashkernel_simple(val);
> >               }
> >       }
> >
> >@@ -414,7 +436,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
> >
> >       /* We don't need to set a mapping for setup_data. */
> >
> >-      /* Mark the memmap regions we need to avoid */
> >+      /* Mark the regions we need to avoid */
> >       handle_mem_options();
> >
> > #ifdef CONFIG_X86_VERBOSE_BOOTUP
> >--
> >2.7.4
> >
> >
> >
>
>
