Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568B5C35280
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE492070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nF6ztrce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfJHQx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:53:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39080 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfJHQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:53:57 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so38042599ioc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fme5fFYUj0wdKTaXtPchzRO/hZyN3IQGJxfMnt1qVJI=;
        b=nF6ztrceJdjl9xNuXNv5mwqCWU5zJiJnq0FWCZzdURWJFCyF8lq29UW/vjWY6vTYma
         A2vyFCS8QnTpZRdKfqpcLtymIzPuly4yfU+HNeOcaOe8C0t7yiMkXCpg2oYL6hJvEsee
         Up6y0FoUSqnDLGgBNM9DYqZNWygDKvbsDednwj+Rj3AVL0cd8Y1O1AwblvHbnErAyM1s
         Oq0JalZDIlpzXA79i8F9OCTZDMF/7uK8H/ZB1T0tKbINfE1H1l9gPgxcdjjjRcVQZPUw
         RGUnyj/xgKxNMmLsrq5wWKfa0asvyNQqKOi+g7hq2lwcgkhXkMCPWXJ4T/K8unUXl+j+
         FosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fme5fFYUj0wdKTaXtPchzRO/hZyN3IQGJxfMnt1qVJI=;
        b=Wauk1bLNrrXddSuqEEYDe4BHsP0INLWYkPjGe/L+FEiS+ppY7ynlFvKSeVjecKTiJb
         pUx5P7gCoyT+3D6JgBSt+2x+x8JNZ0EWDeNyuFlOoU3ieTslTIUdOxoVjLVt9ana4+/T
         gautdKpKR5USU3WLI8RKr1MaSoEyd1KTpQnkd48vkm8gM9FQhwJLJJUpmO18XiOMUA7L
         nZJ7P4/NxzS/JaF7uH19Kc9SA2TValC/6F9XJ/YQRgAP26VpCtgj78KalbOja7Mk4Apm
         ugC2A04dK0HfHqxLJYdUL9nlGOjTiM1o5VwUBgocEcIE2rRS7r0x2aTWOigA8pdyImRI
         irKA==
X-Gm-Message-State: APjAAAWM6NzjcHp9UQYPNwocdTjWFhSVGYTAMRh88Kdp5IWmIulCX1eO
        MF5kSd+U8IofBpHjugNMGjxjbkQykFiCEi1nbyFPcw==
X-Google-Smtp-Source: APXvYqwDWGOf+yElISRWjmDcwEri92PuzaR9Mbp5SH1x+dezCLs5TRcNt3I5EnwbB6Klb9T5kpEFj0FvbeItRICFmbk=
X-Received: by 2002:a6b:1606:: with SMTP id 6mr32477437iow.108.1570553635857;
 Tue, 08 Oct 2019 09:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191004215615.5479-1-sean.j.christopherson@intel.com>
 <20191004215615.5479-12-sean.j.christopherson@intel.com> <55f45459-47bf-df37-a12b-17c4c5c6c19a@redhat.com>
 <20191007195638.GG18016@linux.intel.com> <bd2cffea-6427-b3cc-7098-a881e3d4522d@redhat.com>
In-Reply-To: <bd2cffea-6427-b3cc-7098-a881e3d4522d@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 8 Oct 2019 09:53:44 -0700
Message-ID: <CALMp9eSM=rq+jEEzPwWNHNxv03F1s2Dysa7euWJ==PaE=b1sMw@mail.gmail.com>
Subject: Re: [PATCH 11/16] x86/cpu: Print VMX features as separate line item
 in /proc/cpuinfo
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 11:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/10/19 21:56, Sean Christopherson wrote:
> > On Mon, Oct 07, 2019 at 07:12:37PM +0200, Paolo Bonzini wrote:
> >> On 04/10/19 23:56, Sean Christopherson wrote:
> >>> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> >>> index cb2e49810d68..4eec8889b0ff 100644
> >>> --- a/arch/x86/kernel/cpu/proc.c
> >>> +++ b/arch/x86/kernel/cpu/proc.c
> >>> @@ -7,6 +7,10 @@
> >>>
> >>>  #include "cpu.h"
> >>>
> >>> +#ifdef CONFIG_X86_VMX_FEATURE_NAMES
> >>> +extern const char * const x86_vmx_flags[NVMXINTS*32];
> >>> +#endif
> >>> +
> >>>  /*
> >>>   * Get CPU information for use by the procfs.
> >>>   */
> >>> @@ -102,6 +106,17 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >>>             if (cpu_has(c, i) && x86_cap_flags[i] != NULL)
> >>>                     seq_printf(m, " %s", x86_cap_flags[i]);
> >>
> >> I'm afraid this is going to break some scripts in the wild.  I would
> >> simply remove the seq_puts below.
> >
> > Can you elaborate?  I'm having trouble connecting the dots...
>
> Somebody is bound to have scripts doing "grep ^flags.*ept /proc/cpuinfo"
> or checking for VMX flags under some kind of "if (/^flags/)", so it's
> safer not to separate VMX and non-VMX flags.

Yep. Not quite that exact syntax, but we do have, e.g.:

./x86/feature_check.sh ept

...and you can imagine what feature_check.sh does.
