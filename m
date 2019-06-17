Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E044C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C332147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560792345;
	bh=h7nODaHm/maT/oL6I7QneckfiHzF1jLenKdtuPjYT9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ugPoZyF7KHDKlk3PRyyd9/TBnNMhHFSPu4yETXEaXFBELvgbhQvCe6z0AC495z56J
	 PcYmTQ4Vv1dFqL9VBrH5dLm/oDdD2JOkMF/1U1ElVUKLzzbFK6yXwvXQbMCtjj7Mkk
	 /WTC2fgMOoErCDUPT2CfAgIJgkpM9lpKEU3qBFFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfFQRZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfFQRZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:25:43 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB892133F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560792342;
        bh=h7nODaHm/maT/oL6I7QneckfiHzF1jLenKdtuPjYT9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PKt2zXLpyCIfV2w2LDOTyKIoRCmmNs27L8rG8xFX2tCYT25poy4GrUEYVHLsuGUY5
         px9FZ0xMkMQjS1QxEUEd149ThWvALWk+cqw/O3AAgTiX5xGN99+Odn9FzJ7qPeiu+v
         8GoDdP3UgNwWBjsU5W3N7vP/z6dAs9ulmUVjcaGQ=
Received: by mail-wr1-f41.google.com with SMTP id p11so10867946wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:25:42 -0700 (PDT)
X-Gm-Message-State: APjAAAXJlALcYsXWhXZSJy57by/hW2t58CxVZUFxl6PRogdtw82bM2ha
        TdaLbfFO40+6OGF12oYdFZMEB8J4o0Oka25oO2ZG1A==
X-Google-Smtp-Source: APXvYqwB5eRXwdhrqK4/Sy2/TgYTuWI/h0bsIJAMbK1YYc0l3Pd+PJRALVYA+kyXnBkVLGmPSqI3Ykc3YGK9TzjIO48=
X-Received: by 2002:adf:a443:: with SMTP id e3mr24484700wra.221.1560792338770;
 Mon, 17 Jun 2019 10:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190605130753.327195108@infradead.org> <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org> <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net> <20190611080307.GN3436@hirez.programming.kicks-ass.net>
 <20190611112254.576226fe@gandalf.local.home> <20190611155537.GB3436@hirez.programming.kicks-ass.net>
 <D9439F7B-3384-4BD5-B3BA-13EE52FEC15E@vmware.com> <20190617144213.GE3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190617144213.GE3436@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 17 Jun 2019 10:25:27 -0700
X-Gmail-Original-Message-ID: <CALCETrW7u0HFzWvULou5pKDW1=MsPg9pGFqFnOEiHxpniy8S8Q@mail.gmail.com>
Message-ID: <CALCETrW7u0HFzWvULou5pKDW1=MsPg9pGFqFnOEiHxpniy8S8Q@mail.gmail.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate instructions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 7:42 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Wed, Jun 12, 2019 at 07:44:12PM +0000, Nadav Amit wrote:
>
> > I have run into similar problems before.
> >
> > I had two problematic scenarios. In the first case, I had a =E2=80=9Cca=
ll=E2=80=9D in the
> > middle of the patched code-block, but this call was always followed by =
a
> > =E2=80=9Cjump=E2=80=9D to the end of the potentially patched code-block=
, so I did not have
> > the problem.
> >
> > In the second case, I had an indirect call (which is shorter than a dir=
ect
>
> Longer, 6 bytes vs 5 if I'm not mistaken.
>
> > call) being patched into a direct call. In this case, I preceded the
> > indirect call with NOPs so indeed the indirect call was at the end of t=
he
> > patched block.
> >
> > In certain cases, if a shorter instruction should be potentially patche=
d
> > into a longer one, the shorter one can be preceded by some prefixes. If
> > there are multiple REX prefixes, for instance, the CPU only uses the la=
st
> > one, IIRC. This can allow to avoid synchronize_sched() when patching a
> > single instruction into another instruction with a different length.
> >
> > Not sure how helpful this information is, but sharing - just in case.
>
> I think we can patch multiple instructions provided:
>
>  - all but one instruction are a NOP,
>  - there are no branch targets inside the range.
>
> By poking INT3 at every instruction in the range and then doing the
> machine wide IPI+SYNC, we'll trap every CPU that is in-side the range.

How do you know you'll trap them?  You need to IPI, serialize, and get
them to execute an instruction.  If the CPU is in an interrupt and RIP
just happens to be pointed to the INT3, you need them to execute a
whole lot more than just one instruction.
