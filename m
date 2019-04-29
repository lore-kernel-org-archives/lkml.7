Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4CFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC7E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8IFLqsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfD2N6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:58:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36371 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2N6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:58:32 -0400
Received: by mail-it1-f196.google.com with SMTP id v143so5830563itc.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yBqAecH2iMERB2XptWXFnvjoW+/LbAkUvoUiYUsxMQ=;
        b=H8IFLqsVTioPnFzsttyOnlep0coSrOrWCS37pjfa0OgbTmda4FiXimrZ5P+vjxoALK
         UZv/WOk2FWaYwIxekrGVAm3RJguJ3RCjCVckuQiyBPbpopsMiOCp+i00kjNEc3pBEQGF
         xTggZ5zpZgQ/zBSWgXTvWBV/srSHJ7fydTu3faycj7FAl9Jf8HjY8Hjtr2CYUiTjr+uA
         sIDlTEFg/R3aSx1VuYO+nJ5F8yHGxUCmfHzbOlK4pZgdyr2fTvCaPww7mbUqu8rluLuf
         XRZ0LwS74md6xXHRmCzFKrom1vzkhbMdPC052gV0GCC6/IJqyDsCkc7qiwHv4JK9HiCV
         /64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yBqAecH2iMERB2XptWXFnvjoW+/LbAkUvoUiYUsxMQ=;
        b=nYPDpLC2bXJ+4rIvEUMAt7hzEx5R5YWBogpEQBl+lAtE3PEz8YuOF303L4HwBJ5om9
         Jw9CHoJXJUJseie2F7dEWPaMTWTqZFdIj2Bq0LMET1aFXwZaD0AppGtF1N4xEpBB1rVa
         HleRoDcmg+EngwIGKvGuGla3Y81+Brw91Fjao1iHGhLL3t4DDlDNns963arRiaB3fEFp
         DRDSq00kDnLlqmU+Jp40MhyxqHR7EOXgrf0fC08eVd3ML6FjAH470f/FQmyvxKCQ/PV1
         mQkKkt0YlfHIlSG650E4zp53luLrMEbSHsmfqeuGvtMG/pB0CyKqWzBj5ujjL7BTgV80
         DYzA==
X-Gm-Message-State: APjAAAWz6POyWjUI8g+H0RBkxyFHGk10OC0lXxREgUrBIjDT8c4B596t
        NsGOpPlb9l0dDH+P1/FRAxEspikPmFn+Omz/p4qaZw==
X-Google-Smtp-Source: APXvYqyiwt5BVlpvV6Y0wkkhZ5mt+N+lm0LfrF5+oZEjFh91oJYj7HR38a0cigWNbSekz5xrE0yu05PFx+meTXd6U8o=
X-Received: by 2002:a05:660c:38a:: with SMTP id x10mr19073981itj.12.1556546311259;
 Mon, 29 Apr 2019 06:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181221213657.27628-1-sean.j.christopherson@intel.com> <20181221213657.27628-3-sean.j.christopherson@intel.com>
In-Reply-To: <20181221213657.27628-3-sean.j.christopherson@intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Apr 2019 15:58:20 +0200
Message-ID: <CACT4Y+Z96anrG1da1-8VXA8BLMd-RA16ysicA=X-CUoSuGAw0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/fault: Decode and print #PF oops in human
 readable form
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:37 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Linus pointed out that deciphering the raw #PF error code and printing
> a more human readable message are two different things, and also that
> printing the negative cases is mostly just noise[1].  For example, the
> USER bit doesn't mean the fault originated in user code and stating
> that an oops wasn't due to a protection keys violation isn't interesting
> since an oops on a keys violation is a one-in-a-million scenario.
>
> Remove the per-bit decoding of the error code and instead print:
>   - the raw error code
>   - why the fault occurred
>   - the effective privilege level of the access
>   - the type of access
>   - whether the fault originated in user code or kernel code
>
> This provides the user with the information needed to triage 99.9% of
> oopses without polluting the log with useless information or conflating
> the error_code with the CPL.
>
> Sample output:
>
>     BUG: kernel NULL pointer dereference, address = 0000000000000008
>     #PF: supervisor-privileged instruction fetch from kernel code
>     #PF: error_code(0x0010) - not-present page
>
>     BUG: unable to handle page fault for address = ffffbeef00000000
>     #PF: supervisor-privileged instruction fetch from kernel code
>     #PF: error_code(0x0010) - not-present page
>
>     BUG: unable to handle page fault for address = ffffc90000230000
>     #PF: supervisor-privileged write access from kernel code
>     #PF: error_code(0x000b) - reserved bit violation



As a note for future.
I see 3 recent changes that shuffle crash format forth and back:

ea2f8d60603efbd1cb4e193a593945a2fe24d264 x86/fault: Make fault
messages more succinct
f28b11a2abd9cf5535baa03e28fc63ad0e14f52a x86/fault: Reword initial BUG
message for unhandled page faults
18ea35c5ed9921867194a8efc2a0ac2d5a3c7d2a x86/fault: Decode and print
#PF oops in human readable form

Ideally, such changes are coordinated with kernel testing for gradual
rollout. Since kernel does not provide an official facility for crash
parsing, the actual output effectively becomes part of public API.
Such changes in format may lead to glues bugs, not duped bugs and
missed bugs (including incorrect bisection, when something stopped
being detected as a crash at all).
Ideally-ideally, kernel provides some kind official output parsing
facility (that can understand when kernel has bugged, when the crash
starts/end and some kind of stable identity for a crash) and includes
output parsing tests for all types of crashes because this types
kernel sabotaging testing happens periodically.

We already have samples for "address =" format, but not for "address:"
yet. So I still can't update parsing for the final format and we have
massively glued crash reports.






> [1] https://lkml.kernel.org/r/CAHk-=whk_fsnxVMvF1T2fFCaP2WrvSybABrLQCWLJyCvHw6NKA@mail.gmail.com
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/mm/fault.c | 42 +++++++++++-------------------------------
>  1 file changed, 11 insertions(+), 31 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 39dccdfef496..a4421cbd230b 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -603,24 +603,9 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
>                  name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
>  }
>
> -/*
> - * This helper function transforms the #PF error_code bits into
> - * "[PROT] [USER]" type of descriptive, almost human-readable error strings:
> - */
> -static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
> -{
> -       if (error_code & mask) {
> -               if (buf[0])
> -                       strcat(buf, " ");
> -               strcat(buf, txt);
> -       }
> -}
> -
>  static void
>  show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long address)
>  {
> -       char err_txt[64];
> -
>         if (!oops_may_print())
>                 return;
>
> @@ -651,27 +636,22 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
>                 pr_alert("BUG: unable to handle page fault for address = %px\n",
>                         (void *)address);
>
> -       err_txt[0] = 0;
> -
> -       /*
> -        * Note: length of these appended strings including the separation space and the
> -        * zero delimiter must fit into err_txt[].
> -        */
> -       err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" );
> -       err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
> -       err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" );
> -       err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
> -       err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
> -       err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
> -
> -       pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
> +       pr_alert("#PF: %s-privileged %s from %s code\n",
> +                (error_code & X86_PF_USER)  ? "user" : "supervisor",
> +                (error_code & X86_PF_INSTR) ? "instruction fetch" :
> +                (error_code & X86_PF_WRITE) ? "write access" :
> +                                              "read access",
> +                            user_mode(regs) ? "user" : "kernel");
> +       pr_alert("#PF: error_code(0x%04lx) - %s\n", error_code,
> +                !(error_code & X86_PF_PROT) ? "not-present page" :
> +                (error_code & X86_PF_RSVD)  ? "reserved bit violation" :
> +                (error_code & X86_PF_PK)    ? "protection keys violation" :
> +                                              "permissions violation");
>
>         if (!(error_code & X86_PF_USER) && user_mode(regs)) {
>                 struct desc_ptr idt, gdt;
>                 u16 ldtr, tr;
>
> -               pr_alert("This was a system access from user code\n");
> -
>                 /*
>                  * This can happen for quite a few reasons.  The more obvious
>                  * ones are faults accessing the GDT, or LDT.  Perhaps
> --
> 2.19.2
>
