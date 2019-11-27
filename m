Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E99C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81CD20665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NktEcG2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfK0FBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:01:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44413 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfK0FBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:01:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id g3so22840381ljl.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 21:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=88N65tITeUm1d09hBoEF1qm64IaDFJNm12UuzH3e9e4=;
        b=NktEcG2e8yadXluupJSS3uaewBg8wR0v4z/zJ8eCuSpIFm0g5SYC1PgNBSW4LiVW5b
         fUm4tcR65alpJ/hGiI3oHRSjDBGa4PXZJ4SVp9kbmBuXA/oaeXqt52AixsYCW9SCWlnN
         BY5DaA1dtFy81h2575vYh/1t0hOoOjoXGNjctwX/f3hse5A2PSjlEQsCYFkUviUlFzT9
         bZWmK2oHaDwk/joPS2FTiHTpkCk2U33h/ci0hMwPwF1UWEcgumBgddLnhCnvStsRQbdH
         WArEGanfh1JJBOubDbDM7bTJt2/hRhShuOReGw9bnNrh+KUEa2Q0HtBWhOWNWXNk21xL
         jKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=88N65tITeUm1d09hBoEF1qm64IaDFJNm12UuzH3e9e4=;
        b=PC8+KDbWQBV1AeffcodkpZE0pubnx/+zl/MasXxCL0TLj/Btru0gsx7trbscjTPFeI
         2diGvKo53PXk40fx7MtIDN39MvC2sLtnTj8hLothWx7+1nhwXhdoJ0fur7zUSRt+nkBR
         WaBJP2QdCC7f0pvuu006wdr1rYJ/oBM1kqjUcw8XquSx0PttYhGkr+FGKmBLC4/cmVn1
         E31QdsHWeUAulOGWDfqx8GWLwhpOis+crKmOFDNoZfGmzkskVkZLoQCp30hQyyiZbENn
         WPBiCnitsVI01BLNSJLH31p8hZSk4GYuzjT3d6dQY6GtTa2q2U+PjGr7O+/fuPfF4H39
         KaHA==
X-Gm-Message-State: APjAAAU6iF9xQ7msIyzbQUBshSa3gNM3T6WKf/ezzTnYD+n0+HMvA73W
        C1sPrJMkerF8ZgbbfJh9m3cBkkH3ipJyQYIy348=
X-Google-Smtp-Source: APXvYqygXxhnf5Rbo0cFJa4hPmgAPk3DoFhGfeo3CN/k1g0tatvMEh3IYNqbNa+xzjaNaOIUv9ZLOaDewvuPZbESJbk=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr29875900lji.142.1574830878290;
 Tue, 26 Nov 2019 21:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20191111131252.921588318@infradead.org> <20191125125534.2aaaccf00c38a9a25dee623a@kernel.org>
 <20191125123245.5ae9cb60@gandalf.local.home> <20191126091104.5e0cdc61e3b143fae4ed4cfd@kernel.org>
 <20191126175812.c6e0cd1249422989007c91fe@kernel.org> <20191126185809.91574fb8eb02f3b2dd3af863@kernel.org>
 <20191127084854.55ce1916e4f6d372f9731ed4@kernel.org> <CAADnVQK4twuXzFhD-qLHmCVK0n1h-GDENQLu+4PVV3Hp++R6kQ@mail.gmail.com>
 <CAADnVQ+y9-JRA1u+UMD8uWjq1dt9AZrJKeOMe_zDNRL=wZ39TA@mail.gmail.com>
In-Reply-To: <CAADnVQ+y9-JRA1u+UMD8uWjq1dt9AZrJKeOMe_zDNRL=wZ39TA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Nov 2019 21:01:06 -0800
Message-ID: <CAADnVQJtNzyVrEy96tGhCiOfUEbLhzGzeF_7kXmS0SEG1=Upvg@mail.gmail.com>
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and more)
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        bristot <bristot@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        jbaron@akamai.com, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 8:32 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 26, 2019 at 4:03 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> >
> >
> > On Tue, Nov 26, 2019 at 3:49 PM Masami Hiramatsu <mhiramat@kernel.org> =
wrote:
> >>
> >> On Tue, 26 Nov 2019 18:58:09 +0900
> >> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >> > I applied following patch, but it seems not enough. While disabling =
256 kprobes,
> >> > system was frozen (no BUG message).
> >>
> >> Aah, this is another bug in optprobe. I'll send a series for fix these=
 bugs.
> >
> >
> > Awesome! I=E2=80=99ve started looking at this crash as well.
> > Could you share a brief description of the bug and cc me on fixes?
> > I=E2=80=99d like to test them too.
> > Thanks
>
> I noticed that your config doesn't have CONFIG_KPROBES_ON_FTRACE=3Dy
> and without it most test.d/kprobe/ tests fail, but in your log they are p=
assing.
> Also do you have KPROBE_EVENTS_ON_NOTRACE=3Dy ?
> Since without these two configs the crash wasn't reproducing for me.
> Anyhow waiting for your fixes.

fwiw I bisected it down to commit 5b8ad1c9bc44 ("x86/kprobes: Fix
ordering while text-patching")
Reverting it fixes the crash. I bet Masami fix will be more correct.
