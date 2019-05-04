Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC47C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 20:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C76F2063F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 20:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557002135;
	bh=Ai+NE6T4WMicrnJa8DVQV2dFeTgORqXZUzRQm2S8boI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dQFZA5cP/aag7VTMSgX0Ua80Ap74YvNrJou37krXkbray6/5AWvIh7DFT7eqKHayG
	 veeHz6g12utd9qkRdOv2deNpPjdBhn3fzqWE5BfhWN8HGz5VMBqF5iWaAxEZDbSSxC
	 3gFmlSHzqnJCJ4Xr+UE7Kp9CYagC7WNA3GD3Kd2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfEDUfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 16:35:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43779 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfEDUfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 16:35:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id u27so6338498lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SaUefhj41Vo9ICd62i3E2YPs3qFZSdkbgRUMEL66AdI=;
        b=YWFWemqJ0JLsacxwcohY3H1Ru+7m68bmnSG7LYrodNEBsa1vqFIe7N+Z7/ib2SOef8
         WWNNvU+E2HH25gh9czdMXSA1W+PtOHyDLxhTntgAp0nZMXOMd6zYnlK0dQqvtzAQo8bz
         LSBMlFzIL2Q2R5LmuSDspX30nFFTSIPoTZtwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SaUefhj41Vo9ICd62i3E2YPs3qFZSdkbgRUMEL66AdI=;
        b=K/aKQCCw4JNTcZfXYpqVwtFLx7w/Nu3EhouOXptDp3U3w/9vl/iB3lgSI47cFYGV7G
         PwOmuhUxgo7GMiR9q4WzzVXdPm82xe2nctie8qNYU7ch90lpui6eJHC4GnIFybbEVy+l
         J3psBnKLF7MggNv4eLHdfIIP6q2nRd/8UzmjeV3zNDnNJtLPoNg2jPkkUdNfYgRnAU8S
         sTgRMKzFCUncuVDPe81PbFMwgWnGQIhfjToa4KrFW8dErnDEyHrsK5oJZFp54xk8H5B3
         vYU9PDuTJacQUK02PVaqO/mt2NXLlAYWtfi0Xu8hmMg0EIZ5ZM2MCmLTY+Q1Te26RKqD
         YfqA==
X-Gm-Message-State: APjAAAW8O03C/zcoCPsWO2dOUEyqHHWUpHtOn7z/P6baj58fAljvZS02
        uX8Y73Iz0mOyKmwDNnGw9gMwvQEtKyc=
X-Google-Smtp-Source: APXvYqxrQwuE9l8o/kHf+hw3fuMx8NsHeSkMZiW/cXG9j98Q+E3avPe8bkTPAJwCpWgeRd1LOYen5Q==
X-Received: by 2002:a19:ec12:: with SMTP id b18mr8359518lfa.149.1557002131001;
        Sat, 04 May 2019 13:35:31 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id p4sm1075426lji.41.2019.05.04.13.35.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 13:35:30 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id z26so3153217ljj.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 13:35:30 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr8970707lja.125.1557001696580;
 Sat, 04 May 2019 13:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202830.347656894@goodmis.org> <20190501203152.397154664@goodmis.org>
 <20190501232412.1196ef18@oasis.local.home> <20190502162133.GX2623@hirez.programming.kicks-ass.net>
 <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
 <20190502181811.GY2623@hirez.programming.kicks-ass.net> <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <CAHk-=wh8bi5c_GkyjPtDAiaXaZRqtmhWs30usUvs4qK_F+c9tg@mail.gmail.com>
 <20190503152405.2d741af8@gandalf.local.home> <CAHk-=wiA-WbrFrDs-kOfJZMXy4zMo9-SZfk=7B-GfmBJ866naw@mail.gmail.com>
 <20190503184919.2b7ef242@gandalf.local.home> <CAHk-=wh2vPLvsGBi6JtmEYeqHxB5UpTzHDjY5JsWG=YR0Lypzw@mail.gmail.com>
 <20190504001756.17fad840@oasis.local.home> <CAHk-=wiuSFbv_rELND-BLWcP0GSZ0yF=xOAEcf61GE3bU9d=yg@mail.gmail.com>
 <CAHk-=wjGNx8xcwg=7nE_0-nLQ_d4UALHvJ8O+TurbA25n8MyNg@mail.gmail.com> <2BF1AE4B-8105-49F0-8B6A-AA3B11FD66FD@amacapital.net>
In-Reply-To: <2BF1AE4B-8105-49F0-8B6A-AA3B11FD66FD@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 May 2019 13:28:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwc8NDahj455iBWmYyvDDS+sN1TObFsxxS51gNbtZ9iw@mail.gmail.com>
Message-ID: <CAHk-=wiwc8NDahj455iBWmYyvDDS+sN1TObFsxxS51gNbtZ9iw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 4, 2019 at 1:12 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> As an aside, is it even *possible* to get #BP from v8086 mode?  On a quic=
k SDM read, the INT3 instruction causes #GP if VM=3D1 and IOPL<3.  And, if =
we allow vm86() to have IOPL=3D3, we should just remove that ability. It=E2=
=80=99s nuts.

We've definitely historically allowed IOPL=3D3 with the whole "iopl()"
system call. And yes, afaik it works together with the vm86 system
call too. I think we copy the unsafe bits from the original eflags, so
if you do iopl(3) followed by vm86(), you will be running in vm86 mode
with iopl 3.

> (We should maybe consider a config option for iopl() that defaults off. W=
e=E2=80=99ve supported ioperm() for a long, long time.)

It's entirely possible that nobody uses iopl() and we should make it a
config option that defaults to off.

But we've already done that with the VM86 support entirely, and I'm
not sure modern distros even enable it.

And obviously vm86 mode isn't available at all with a 64-bit kernel,
so this is all slowly becoming more or less moot.

                  Linus
