Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CB7C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F7C20663
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyLyUJt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfF0A5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:57:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37372 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfF0A5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:57:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id d11so360813lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lMZ1piiT78tmacK8Hh1QGTfmPTfuG8GnhzPjO+SIDU=;
        b=fyLyUJt0cAtc+SmMP1iYSE3DjsxUXmn0roX+f9Mkcv9Up1/0CDuQR5RQA9zGPOwsun
         0jYqtCw5YT8TMU1sFTFBvvtpfNl9w7Adk9IQijj2MGrsE6XUsJq4RIrou19wummjt+ha
         JLJ5x571vac2cVP5Vc/3Zjq3swYa7JXEMVsB8uh+ZjQeJnlLMb/S0K/nBV5BpE90L4rk
         1zI84s3247WnDWzjUEAN/8FUQRnB/jvuiADCHNqh+DCLleFzxd2eYX6GkGzWEpzGpFxq
         raI+1wdvCgmOmsJUSDv3sUCuYNjWPUtALBsKyxlqsHdysd5vjVdXL7RMUKbS1rX8lDVA
         KGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lMZ1piiT78tmacK8Hh1QGTfmPTfuG8GnhzPjO+SIDU=;
        b=H6+Viy4Ri57s9WkCk2cUhvFEQNKbi5pt9bCE+VN/tAorGtipyeysmyAaPyVq5mB/EP
         UxQwuRYl6EHouBO8qV1/oDuctTz/WuOXkNq7DIXHe1XjWCaKbLjd8wCYrelc6Hy7M7Ph
         7wtWL6fpa+o2mqk83QpW+6dslcYKjSkXQcOIQoCA6+hEp/e1r6oLKtR7Au4c4Qe2SGLo
         BMwrQW41F2PDVHrIU6MtWPkiLKhErv0FRQ1qNz14y7zeOxiZb8EyP0x/Ig9u1MwRnSTo
         Jcp4ggAiW5/SpU2mXN00F1ezCEY0kQB/o0i5FX4fMcKZo4PBrYStw32eQXTD6ix6yHEN
         ytiA==
X-Gm-Message-State: APjAAAWI9KJmNf+kDLyygTdaGdMJgr4XKnqpHvxf1Kqp4KxfYZI1k97O
        oveSbL3L64ViCpP/bG/jmzdfpbdvo1UQD/1s9mw=
X-Google-Smtp-Source: APXvYqwTLieOueKiUwNGGZ5/kwOpfwqURhlDkGx3yQenIoS3xc7sYF1Qcd+0XEItLs1oUd4IP60Ijkvt/shn6IrTF10=
X-Received: by 2002:a19:4:: with SMTP id 4mr463017lfa.162.1561597040095; Wed,
 26 Jun 2019 17:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561595111.git.jpoimboe@redhat.com> <a5a486434d31d77297d39c4adccea22fac3027c1.1561595111.git.jpoimboe@redhat.com>
In-Reply-To: <a5a486434d31d77297d39c4adccea22fac3027c1.1561595111.git.jpoimboe@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Jun 2019 17:57:08 -0700
Message-ID: <CAADnVQL2z4BPUvtem-1C_JxzSgc_L8ED=VjGLu7ypPSq3wwC4w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] bpf: Fix ORC unwinding in non-JIT BPF code
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 5:36 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Objtool previously ignored ___bpf_prog_run() because it didn't
> understand the jump table.  This resulted in the ORC unwinder not being
> able to unwind through non-JIT BPF code.
>
> Now that objtool knows how to read jump tables, remove the whitelist and
> rename the variable to "jump_table" so objtool can recognize it.
>
> Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> Reported-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  kernel/bpf/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 080e2bb644cc..ff66294882f8 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1299,7 +1299,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>  {
>  #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
>  #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
> -       static const void *jumptable[256] = {
> +       static const void *jump_table[256] = {
>                 [0 ... 255] = &&default_label,
>                 /* Now overwrite non-defaults ... */
>                 BPF_INSN_MAP(BPF_INSN_2_LBL, BPF_INSN_3_LBL),
> @@ -1315,7 +1315,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>  #define CONT_JMP ({ insn++; goto select_insn; })
>
>  select_insn:
> -       goto *jumptable[insn->code];
> +       goto *jump_table[insn->code];

I thought we were clear that it is a nack?
Either live it alone or rename to something like jump_table_bpf_interpreter
or bpf_interpreter_jump_table.
