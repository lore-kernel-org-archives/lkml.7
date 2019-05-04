Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C1C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 20:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544472063F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 20:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557002195;
	bh=vV5507wJbZVKbJj3SVUGqgF/EssTZCyMkGS0QBSnGB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mEjYFMEzFslHR++JSPtYhwlBjT5J9UJqgvKuEO8za1gXvFAYC8977m/Rx8gwHqQ3u
	 bj029mZk3KvSD7yApRbj54sLBsf9hhcbYXjmjRhKvC+HRypzohvmijsOBKl85+5DrC
	 1MnSRIdFOjJ8lf41+UVvBbBUjpbkyAuJvBsxQXMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfEDUge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 16:36:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38819 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfEDUgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 16:36:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id e18so7979812lja.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=avpeditiG05762mr+ZBdVz17aE8sPPywlzbuzRkmGu8=;
        b=eBpIF9Qh2Hh0a0CcqEOOixnUMFDAfxwLic/0D52BIV/HRO+FWsY+c08Ox/yuCHEacF
         mJC8j9rp5rLkkT9f+c1BKX/iz9KrtGntnPsK8AK0jGNLBjYY4668h41M7CZS5dbNLsey
         YaMrbtqOGLf0xVoZWCaQuSJHUjRnRlFE0Y9iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=avpeditiG05762mr+ZBdVz17aE8sPPywlzbuzRkmGu8=;
        b=ZboK4SkDtAoq3sbi6g0TJbCcY1nEYUZ0P32m/H2T13ArZIbangja7F/NUyF/uPFd79
         Vh4sjuothnWafAHh61O8hRe3fvUYhbFI9gtuztILRl/yPss5ENWv3ajDBV+jFKnORnWr
         GoOtf3MsZN2AU3jMU13gECeTWjaMnRQ0uTNrj5TVtAsh17hEvjaDLjHngoIaQxw/P/cN
         ZMuAH15WBPWxvgc8BmUS9/blu2rGA29Uje9HAJBCfj3amtmdvXhjf0hQHBbNgRTbJwD/
         bigmCvqeoR7cvA8LBfoFgy/x6+fBtB/nMwSBXN5BYvhiFDo8XOsLNP21S3+Giq+iLYUm
         YKzg==
X-Gm-Message-State: APjAAAWlWjU+YMlDYMXllXlkvHwV942S61oPnrijbJghQdfApouXULou
        Q6aehdzd3Zm6M3q261G8FblhZ7Boj60=
X-Google-Smtp-Source: APXvYqyn2Rn3X5kPiANHd9jqFouWdK4rsjWZ8Whd44stwOc0wrFmFm3QsZEApnOSzWZoGveffq0i2w==
X-Received: by 2002:a2e:6384:: with SMTP id s4mr3669864lje.63.1557002191365;
        Sat, 04 May 2019 13:36:31 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id h26sm1108577lfm.11.2019.05.04.13.36.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 13:36:28 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id h126so6610509lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 13:36:28 -0700 (PDT)
X-Received: by 2002:ac2:4567:: with SMTP id k7mr8933590lfm.166.1557002188058;
 Sat, 04 May 2019 13:36:28 -0700 (PDT)
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
Date:   Sat, 4 May 2019 13:36:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEDAFUKRR=iELwUCk1kpoACk4eOfyyQhnYb78H9AEaSw@mail.gmail.com>
Message-ID: <CAHk-=wgEDAFUKRR=iELwUCk1kpoACk4eOfyyQhnYb78H9AEaSw@mail.gmail.com>
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

Oh, and I think you mis-read the SDM.

Yes, iopl matters for "int X" (cd xx) instruction in vm86 mode.

But no, iopl does *not* matter for the special "int3/into/int1"
(cc/ce/f1) instructions, I think.

              Linus
