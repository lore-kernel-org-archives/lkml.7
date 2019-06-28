Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB467C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6AE20828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJq6pJ+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfF1PhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:37:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46454 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1PhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:37:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so6405763ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUj3ptRMzaukymG+xceLi+gsEHWFcj5E/f35gnVJiSE=;
        b=LJq6pJ+FrT6Gv82x4QXduFV77cTjQbB0oF5ZelSpGngVmQZIWBkK+tNce2vAkN3yGW
         yG58ptcbjt6t7b3pngIv/PNhsx0DUfkDKD6Kiza6UfxgQqEFNWIYu2ZVbbk5bt9ooGCr
         hM/jGbpLHEUjLxKXO92LlkL32Wtsy9dlxYLPXwpxuFrzodwOxAVjAuhuIuYDRnIHPG9o
         6ZVNfjlofvde1mOsE/p4O5yAmfSSEIjKRtWIoSfp2bricCvYt3Vf0XIJoCqRtU8h+Xj+
         K+3GRH+4gO63296M6vs/fuinRrx1vR01PN+1FY1WxytzfzhFVFrkZTBI32ntJ4aYINEn
         6RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUj3ptRMzaukymG+xceLi+gsEHWFcj5E/f35gnVJiSE=;
        b=L5Pn8Rm3FaVDNz/fm6L8ATkjPLiZF5NFdBM35ogoeQp0p6lTAMgl48E8qa4cVUMzQT
         sp91UYo1p/Xkw97Ajic4tp3RQamgPn2tIO7+khpD0ERta1Xi9xzmGIon4z5s+H7yFgfI
         oHPU0wzhPgzLftLD4e6g1oXKCNdTqk5hY9aBK3tEAhr1wE7Aq8iszMQpUTNF07OyVsRM
         rJrziiXd+QumBKeRPUonS3wpX0Da1S86UvjLYX3VNUWjPO+/kSnclPcrctTKBVN0b8oG
         /0Vb4tr+AE4JaDEpYCBDsu8PGCpOWwe8vffm3eCAAP02oEktosSYkLEbLaV8UEn4kccV
         y+QA==
X-Gm-Message-State: APjAAAXS0n8d5wKuAuqCRI7y+z2hxiiXaVn+6hKCnjSpFiqhnVYy4ZjH
        jkut7KwoyuvYb/GrpoXBc/sU8nIn9nvRgog45fk=
X-Google-Smtp-Source: APXvYqxOPqNfh3jLY7PLSHk1C/+EA8p3XzLQWgcpQ2T0KgmFjVjNGkQ2rN1RB/Z7IWdBAaVmsUSgzQ61MTuosQ7KMMQ=
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr5185206ljj.17.1561736232869;
 Fri, 28 Jun 2019 08:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561685471.git.jpoimboe@redhat.com> <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
In-Reply-To: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 28 Jun 2019 08:37:01 -0700
Message-ID: <CAADnVQ+tMk9B3S=OfsaNiKNpMv0x-AmqMTxdh=Av+DN8_ZEo7w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] bpf: Fix ORC unwinding in non-JIT BPF code
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 6:51 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Objtool previously ignored ___bpf_prog_run() because it didn't
> understand the jump table.  This resulted in the ORC unwinder not being
> able to unwind through non-JIT BPF code.
>
> Now that objtool knows how to read jump tables, remove the whitelist and
> annotate the jump table so objtool can recognize it.
>
> Also add an additional "const" to the jump table definition to clarify
> that the text pointers are constant.  Otherwise GCC sets the section
> writable flag and the assembler spits out warnings.
>
> Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> Reported-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

I'm traveling atm, but the set looks good.
Acked-by: Alexei Starovoitov <ast@kernel.org>

If tip maintainers can route it to Linus quickly then
please send the whole thing via tip tree.
Or we can send these two patches via bpf tree early next week.
