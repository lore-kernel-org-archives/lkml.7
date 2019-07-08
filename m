Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C8FC606B0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A757216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa4ykB4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfGHXQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:16:40 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:36700 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfGHXQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:16:39 -0400
Received: by mail-lj1-f169.google.com with SMTP id i21so17657997ljj.3;
        Mon, 08 Jul 2019 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9jTnl/UShTZpHRfBUwPJTiplUcO0GIxTXHSrQ4MD+M=;
        b=Fa4ykB4lqbBNATfeIOD3e6BfGjg99XLQuDmszUAD5s/kUNzNqW08HFcRNcDDDG4xmE
         ggC6yB41fTaYI0HzlcgxdzZkccfl6Lrb5I0U1vBfHRSsZKRGvuqQsnuuJ/60Na9SoLuP
         z1dgQFqppKCjSdjT+wXcJWgP77RT6e/nCIpqD/85aMZr6HNNB0aGe3BxkPYU/5k3tExD
         FoxFCUxGwowFTn39BzoFAq7ja/6ad6p1O/79u2U7G0tMWck5t4+3gB4C0KFk649DtV83
         AiGbBp3ThEz4vXakVn866B0yydiqSTgP0s7YGP+CsDVmMRITKlsPmPDMVn90l4BMuGSX
         7M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9jTnl/UShTZpHRfBUwPJTiplUcO0GIxTXHSrQ4MD+M=;
        b=kRFsw5iZaMBVjfxrW3F/SHlzl/3ejXrDwGQw5WndQ5Z0poY6FjGKhLX2BD6erT4XWr
         Poa19/6my89FhZzMHMvFm9pJ/1szuI65+0ETkAAX8c+BrxHpRsF0Yn4m2Kso71GOdLmp
         79fb/16Mmqjh2rHoBg2rWfwWO7vhidCBC9BcimABVk350GP9LCisyTLY0YIbnxzEpBp7
         KY4mxlTFX+DN4AP0YIWzRxpEbXJWxUi9t2zytWOwD7mXPUqu7afNzpGP30SzPvfDJV+I
         fJa94FdGWHWA1A4/ld64/Nh5imFrL04dpOVpNqRgI+C7I4PCGfgwGxXBcfta+/YuWEY0
         r0EA==
X-Gm-Message-State: APjAAAVXsGZVjHd772m4QjeBm4Mj+ljPfQmPwwkA4hW+8cGy4wC1LCVd
        yKr3DBDFsvLXl0Lbvb1U30Uq8ifdNwKrDeM7Cf4Igk69
X-Google-Smtp-Source: APXvYqwPsM3hXfisr9ailEuIahoSOLrraeLlphgeRS9Zdgjh9z0VzoRq7FSobQVhUDLj0/O2RAJ6i/PJlCp5r0UUV8Y=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr8337917ljc.210.1562627797057;
 Mon, 08 Jul 2019 16:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
 <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
 <20190706202942.GA123403@gmail.com> <20190707013206.don22x3tfldec4zm@treble>
 <20190707055209.xqyopsnxfurhrkxw@treble> <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
 <20190708223834.zx7u45a4uuu2yyol@treble> <CAADnVQKWDvzsvyjGoFvSQV7VGr2hF2zzCsC9vnpncWMxOJWYdw@mail.gmail.com>
 <20190708225359.ewk44pvrv6a4oao7@treble> <20190708230201.mol27wzansuy3n2v@treble>
In-Reply-To: <20190708230201.mol27wzansuy3n2v@treble>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 8 Jul 2019 16:16:25 -0700
Message-ID: <CAADnVQ+imsK-reGBiSzY02e+KdyGYZxm1su7T1bWvti=YmSV-Q@mail.gmail.com>
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kairui Song <kasong@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 4:02 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > modprobe test_bpf
> > > selftests/bpf/test_progs
> > > both print runtime.
> > > Some of test_progs have high run-to-run variations though.
> >
> > Thanks, I'll give it a shot.
>
> I modprobed test_bpf with JIT disabled.
>
> Before: 2.493018s
> After:  2.523572s
>
> So it looks like it's either no change, or slightly slower.

total time is hard to compare.
Could you compare few tests?
like two that are called "tcpdump *"

I think small regression is ok.
Folks that care about performance should be using JIT.
