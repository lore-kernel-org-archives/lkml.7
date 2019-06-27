Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7C6C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971EB20665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwVLXQzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfF0BXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:23:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38168 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfF0BXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:23:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so529095ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mh2SRdIBsPlxzmk8Obx/mp36kGyI/cLithC1IFBL7yw=;
        b=fwVLXQzCdKN1eehCyo2/+3qHt1/8Sdk/PQN9DOsKztEt0BdgKwvgJzhKD10aCHMYPJ
         svNSKtzFi+NuImzVjjrnVWVbWNepxa/UC+gw2ss2QA7w/TedXePCC+JYJ1DhY0NT2MAo
         UmFC1fDTPYirScDUa3mdM9s0GfnKgu+zx1LLfjG7/IMa/PNqp4vq6EJBl64YX7+Pxjrx
         74hj7QprWZ3nHa9dvcRXvl9FFnu2IyWHXlXWmO8jSOkgz/ep34yGBkk1ZiOV1bgyaZjj
         eZepHdEDzFfTykQbffZlKTquJEfqVWVeF8fr6k7RaSZWAZ8iXIj0FF7ZyeyG147ONS6x
         MkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mh2SRdIBsPlxzmk8Obx/mp36kGyI/cLithC1IFBL7yw=;
        b=XHrhl2MUJiIkQnU3hTdKCNzjUv89gvGxovzm0qP3HBKUWXF5t0r0VLZDtQl6voMEs7
         ny+dTfqbIwhE7S1Kl8ZDlqqpO0qlCTcpgeYiqv8RvkpXhhMj48UThnC+hyiQRwT2sZXu
         c+aq3M+kawkAw8mmECMj3Ty6ULoDAhIv1Cdwp0aHDYcbO7jPwcL/HZzrHlOlArVMSP8B
         gHP2hLgnesPntLys0LMkn8KrvzakDIbR2RINlD3fQq2EGIDfEs4WfNw5rgvEEuNxWtmy
         JHiJSG3nx5TmxNU1PModKovttajz8VtlKyiVUBMw9RGwf8QtsggHC5h0WRN5hWPwwOmY
         nsCA==
X-Gm-Message-State: APjAAAV5UlDtcg5yRUZ95EpvrVpeu6rMLz576g/weFsSRtkE+2mWGBAU
        0cylDkteSBVUjOcI+wMPxJ9SaqLzWZFOhdAWRgs=
X-Google-Smtp-Source: APXvYqyNbFVOWgPyBEQRpA1zFr/ISxP1uUZc1Pg/gAt21QQ66Mtm4WfUT+eOB+tyMv7ViLKKg4dU6WVofJpyNcyJK/k=
X-Received: by 2002:a2e:968e:: with SMTP id q14mr673040lji.195.1561598579730;
 Wed, 26 Jun 2019 18:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561595111.git.jpoimboe@redhat.com> <a5a486434d31d77297d39c4adccea22fac3027c1.1561595111.git.jpoimboe@redhat.com>
 <CAADnVQL2z4BPUvtem-1C_JxzSgc_L8ED=VjGLu7ypPSq3wwC4w@mail.gmail.com> <20190627010653.yovvztgmimaywaz5@treble>
In-Reply-To: <20190627010653.yovvztgmimaywaz5@treble>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Jun 2019 18:22:48 -0700
Message-ID: <CAADnVQ+hZvNEx6pjWKEomn=Nh8zM1451kVscvCyyWaJ-DmcehA@mail.gmail.com>
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

On Wed, Jun 26, 2019 at 6:07 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Jun 26, 2019 at 05:57:08PM -0700, Alexei Starovoitov wrote:
> > On Wed, Jun 26, 2019 at 5:36 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > Objtool previously ignored ___bpf_prog_run() because it didn't
> > > understand the jump table.  This resulted in the ORC unwinder not being
> > > able to unwind through non-JIT BPF code.
> > >
> > > Now that objtool knows how to read jump tables, remove the whitelist and
> > > rename the variable to "jump_table" so objtool can recognize it.
> > >
> > > Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> > > Reported-by: Song Liu <songliubraving@fb.com>
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > ---
> > >  kernel/bpf/core.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 080e2bb644cc..ff66294882f8 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -1299,7 +1299,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> > >  {
> > >  #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
> > >  #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
> > > -       static const void *jumptable[256] = {
> > > +       static const void *jump_table[256] = {
> > >                 [0 ... 255] = &&default_label,
> > >                 /* Now overwrite non-defaults ... */
> > >                 BPF_INSN_MAP(BPF_INSN_2_LBL, BPF_INSN_3_LBL),
> > > @@ -1315,7 +1315,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> > >  #define CONT_JMP ({ insn++; goto select_insn; })
> > >
> > >  select_insn:
> > > -       goto *jumptable[insn->code];
> > > +       goto *jump_table[insn->code];
> >
> > I thought we were clear that it is a nack?
> > Either live it alone or rename to something like jump_table_bpf_interpreter
> > or bpf_interpreter_jump_table.
>
> As I have said many times:
>
> The jump table detection is a generic objtool feature.  It makes no
> sense to give a bpf-specific name to a generic objtool feature which can
> be used by other components.

Nacked-by: Alexei Starovoitov <ast@kernel.org>
