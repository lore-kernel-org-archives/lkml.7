Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8DDC04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B996206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557191506;
	bh=MG2r32ktFgzOal1wvYw74JG8a2gg4ZYTUxCYzLcr9jo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1HtpaK0ojOL6Qre47id3GaVQGis7bS5scKc/E42Aqp4VBawuHwIEvfJPFpyEgwlsc
	 3RAs9HdKLmtNQ/XF9W3DlFeIx+1F669XOlEVQY2byqtWLBmKrfMX8rvjyEtNy9MYvf
	 luo6WL6VM6z4E36E8ai9mMs+911xoOV12ibj80zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfEGBLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 21:11:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34682 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfEGBLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:11:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id v18so8304436lfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 18:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsyI73dXroFmIqVe+jpEPNjDuWdsj9KSbzEVBNIEYrs=;
        b=dQElmRAKArIck7yA9+RfVsOvJW3DDcGCwatkGx9cmG4psAifaTuQoFxV4JgZzLUHcA
         rXzE0x3JnhgeqIaLirr0ycOXAmNEUaNkAXj1VvSRU4MGQjxMtL45XwDPT8r4iFT9XcpB
         9yTyrUgNoF6ya1p1+4Zxq6b5yvVO+gRHpXFFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsyI73dXroFmIqVe+jpEPNjDuWdsj9KSbzEVBNIEYrs=;
        b=pQC6tuFRnnlHetIfTF6sQ8/IOYax56Lp/ub5xZJ7Ub/mKSRrH1H+23HLkBrNPObfSN
         IlhuBoUoNsREM67Etj7+n2HxTTNNWybEs8coCJVZyysUmGxgYhvPwHRP1zJjMmQ52Zlg
         lTykHe5AOHoSMiEQ6Ir6mlenavekr5X8ma0CxON8Icdhq+xnnkNIMRQYsto5Vd+ef00S
         cEa/z+2fee5drxDoQBbGlpBVc8qM6LOJp/L7ReC8JR5ply4d+ByN6qF+veyHTnOmXh3o
         OT83qcBwFwhDLnkmwlhzYpKrjGqwcDqUZ+O3iUlyi/yf2cag32uikgjWS3917A//zRzF
         hlAA==
X-Gm-Message-State: APjAAAXgur2fIiJQKanTKHGiGWHdtENFRLy7mbnQH/2oxlQ7NfNWuTXk
        iVoiZwsGgBqR10vAucQgF33z69uHApY=
X-Google-Smtp-Source: APXvYqy2lrr+RIJuPduru9lk5vtjdPdcL3W2vWw2z7c2VHiQrKTzvnQtCzMYM3VtyBczQA4pFjmMCQ==
X-Received: by 2002:a19:f705:: with SMTP id z5mr4608930lfe.164.1557191502110;
        Mon, 06 May 2019 18:11:42 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id q29sm2823495ljc.8.2019.05.06.18.11.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 18:11:41 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id r76so1659708lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 18:11:41 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr15262932lja.125.1557191189183;
 Mon, 06 May 2019 18:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190503092247.20cc1ff0@gandalf.local.home> <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
 <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
 <CAHk-=wje38dbYFGNw0y==zd7Zo_4s2WOQjWaBDyr24RCdK2EPQ@mail.gmail.com> <20190506201014.484e7b65@oasis.local.home>
In-Reply-To: <20190506201014.484e7b65@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 18:06:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVLnVHhjU4=sdBSpP9eviqwv00xvtCDamdQkhDRA_EmQ@mail.gmail.com>
Message-ID: <CAHk-=whVLnVHhjU4=sdBSpP9eviqwv00xvtCDamdQkhDRA_EmQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 5:10 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But the CPU that was rewriting instructions does a run_sync() after
> removing the int3:
>
> static void run_sync(void)
> {
>         int enable_irqs;
>
>         /* No need to sync if there's only one CPU */
>         if (num_online_cpus() == 1)
>                 return;
>
>         enable_irqs = irqs_disabled();
>
>         /* We may be called with interrupts disabled (on bootup). */
>         if (enable_irqs)
>                 local_irq_enable();
>         on_each_cpu(do_sync_core, NULL, 1);
>         if (enable_irqs)
>                 local_irq_disable();
> }
>
> Which sends an IPI to all CPUs to make sure they no longer see the int3.

Duh. I have been looking back and forth in that file, and I was mixing
ftrace_modify_code_direct() (which only does a local sync) with
ftrace_modify_code() (which does run_sync()). The dangers of moving
around by searching for function names.

That file is a maze of several functions that are very similarly named
and do slightly different things.

But yes, I was looking at the "direct" sequence.

> I think you are missing the run_sync() which is the heavy hammer to
> make sure all CPUs are in sync. And this is done at each stage:
>
>         add int3
>         run_sync();
>         update call cite outside of int3
>         run_sync()
>         remove int3
>         run_sync()
>
> HPA said that the last run_sync() isn't needed, but I kept it because I
> wanted to make sure. Looks like your analysis shows that it is needed.

Absolutely. I think we could get rid of it, but yes, to then avoid the
race we'd need to be a lot more clever.

Yeah, with the three run_sunc() things, the races I thought it had can't happen.

             Linus
