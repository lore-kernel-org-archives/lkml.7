Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B295FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F16208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPOVRXIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfFZWOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:14:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34322 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:14:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so153521pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gR5pPMtypASmBCpf8U2BP93BLiVmDxma1kH5nmUB+Vg=;
        b=TPOVRXIzUIdhLwumU7BgEgz/fAAiIKuSWPZsO5KDyLPcM2+LtFMAxHFGX1ti1KkBKF
         Tg9MM7XfRmD6/ZzldWeTX1yajjcGXIUBFt7yvPxuPHMoagFwAsiBUg7vsl/XGzBresYF
         JJ+UMqbQy0xftZXHFucm6I+WUuNNqClmkX04Zn/ZP2GInLzyWoDe5rVcTl2gpz+UyjrC
         GFpDx0cJXGlZRR3+b5LOVzPwN9X8e6+9LohbbOP4shOFtYp6NjhllqxIOpjxztT0m7Cq
         oIwZrBGXdTtvnaKSMifi4Ue/WdZKANspk+DXRC8sVknGC/i9+OZvrZ8/+cJzM1Qcbk7g
         6BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gR5pPMtypASmBCpf8U2BP93BLiVmDxma1kH5nmUB+Vg=;
        b=b2d9z17e6O8WOSO/ngg3d/SsyctVhYZR3/sGuhLExzsi7j3hTENPxocRL5XZZSZxoC
         NB7xHDSoVbFhBlvV4+59gIHkSTmSDDFeWhLDwr4SMgprf+g+pm+N4z7XqTxcYylWmSKB
         j+kaINHYCV8A7C4NYAHhh03GfCc8VzOevBtJccozvsm0z60UqUKF0VnQqeTCOg5joODG
         OYT8bTc7V44vzfpagJNNHQpI3lRrU5mcP/Bp2Ke1xcQPtaPzgpA6vNR22bb/QIkIH3TH
         NVAqIygEFm2RZSlJX7LBWVcWsIZDI1SuqObwZcFehgIfcAy5Isg2WRSqqacum0H9ReOM
         zFMg==
X-Gm-Message-State: APjAAAXIGJhYKGDgc5TQHifRXacIYVl5oopHWmPzi5AxzA3iKJLeFxwB
        y8a/n15YqxYnmLiIadJxiWBeXPYODGelt+Y2XvYttQ==
X-Google-Smtp-Source: APXvYqxTV+5oE0qDKRwdsgR+f6XC2P4UoL0jtUvPojqJAxiyaEX5C/tl6m4ROgIGi06SifrjEPA48hgyrc/0W8RjC2E=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr1648954pjs.73.1561587256569;
 Wed, 26 Jun 2019 15:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190624161913.GA32270@embeddedor> <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
 <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com> <20190626084927.GI3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190626084927.GI3419@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Jun 2019 15:14:05 -0700
Message-ID: <CAKwvOdkp7qnwLGY2=TOx=FQa1k2hEkdi1PO+9GfZkTQEUh49Rg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shawn Landden <shawn@git.icu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chandler Carruth <chandlerc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 1:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 25, 2019 at 11:15:57AM -0700, Nick Desaulniers wrote:
>
> > Unreleased versions of Clang built from source can;
>
> I've bad experiences with using unreleased compilers; life is too short.

Yes; but before release is when they need the help the most in order
for testing to find regressions.

>
> > We're currently planning multiple output constraint support w/ asm
> > goto, and have recently implemented things like
> > __GCC_ASM_FLAG_OUTPUTS__.
>
> That's good to hear.
>
> > If there's other features that we should
> > start implementing, please let us know.
>
> If you've got any ideas on how to make this:
>
>   https://lkml.kernel.org/r/20190621120923.GT3463@hirez.programming.kicks-ass.net
>
> work, that'd be nice. Basically I wanted the asm goto to emit a 2 or 5
> byte JMP/NOP depending on the displacement size. We can trivially get
> JMP right by using:
>
>         jmp \l_yes
>
> and letting the assembler sort it, but getting the NOP right has so far
> eluded me:
>
> .if \l_yes - (. + 2) < 127
>         .byte 0x66, 0x90
> .else
>         .byte STATIC_KEY_INIT_NOP
> .endif
>
> doesn't work. We can ofcourse unconditionally emit the JMP and then
> rewrite the binary afterward, and replace the emitted jumps with the
> right size NOP, but that's a bit yuck.
>
> Once it emits the variable size instruction consistently, we can update
> the patching side to use the same condition to select the new
> instruction (and fix objtool).

Not sure; the assembler directives and their requirements aren't
something I'm too familiar with.

-- 
Thanks,
~Nick Desaulniers
