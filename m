Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B612C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455DC217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LkvK4hE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfI0RUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:20:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40985 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfI0RUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 13:20:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id f5so3240802ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/eekwhhc/lEaErl1cWQvuZyKqEyMda5rbusW6YMK7I=;
        b=LkvK4hE626X9t4s92tPCDu4GVP+JW+rdiOHfvNh9N4jF4NJ9fWlvc7td1nIDU+CA3n
         PEztECpiktmStFqQ0huvXxeFoYFnurGmt4lmEj4thS8is9bkVhtTwcYhaFJXZOE0CtAy
         FW3A90ZFOAblRyxevEgwyKNwOoEO9RZOQsrxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/eekwhhc/lEaErl1cWQvuZyKqEyMda5rbusW6YMK7I=;
        b=awrjseIMJnG7j7NofpADBXLAFEh+3DVFPWEkvp2AQRjUwWiZrvCSq4tpZDBFH+5ZlJ
         U5lcu/C/ev2yIaMTA058VmNciILRo8NwGCACh8FOXrJEbww03eQNRtCJtBK4ccsAGxB3
         RpwGj3xlIgia02KmIapaY5ESHl9URpw7VigaCX7YICaQKCeoT+zf6jGyzeal8JT6SNst
         EaB92tX5QpReyvX5/Nj2DxZQexhLUTNXVUmtuTHWbIHj9jA+e2AnARBAdHgxzmSKlnqW
         1wwtq6BkiXkw9VN0toVkg+kPrhnAPfOHEqQP4ALZzhzMJzOnPIZ8vqoHcCwFyqQgBGn8
         SEDQ==
X-Gm-Message-State: APjAAAUOUqkRQWZ4VYf0U/tl66hVeQS+hDbJzVmIDlX/ifGbSPkVlgRF
        SL2w4p+xThugSJ0LpbXGQdpfxTbx42y9/T9YoK0cUQ==
X-Google-Smtp-Source: APXvYqwQ0sJhbgkRNydnIi4RrSi/dFi7mwr/zU4s+w0Ydcubj32ElrELRy3PvgOlQ56qXz+SBC5iH82TlZ2DYY/65VY=
X-Received: by 2002:a2e:5d17:: with SMTP id r23mr3716224ljb.229.1569604813845;
 Fri, 27 Sep 2019 10:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
 <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
 <20190826145756.GB4664@cisco> <CAEn-LTrtn01=fp6taBBG_QkfBtgiJyt6oUjZJOi6VN8OeXp6=g@mail.gmail.com>
 <201908261043.08510F5E66@keescook> <alpine.DEB.2.21.9999.1908281825240.13811@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908281825240.13811@viisi.sifive.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 27 Sep 2019 10:20:02 -0700
Message-ID: <CAJr-aD=UnCN9E_mdVJ2H5nt=6juRSWikZnA5HxDLQxXLbsRz-w@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, me@carlosedp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 6:30 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> On Mon, 26 Aug 2019, Kees Cook wrote:
>
> > On Mon, Aug 26, 2019 at 09:39:50AM -0700, David Abdurachmanov wrote:
> > > I don't have the a build with SECCOMP for the board right now, so it
> > > will have to wait. I just finished a new kernel (almost rc6) for Fedora,
> >
> > FWIW, I don't think this should block landing the code: all the tests
> > fail without seccomp support. ;) So this patch is an improvement!
>
> Am sympathetic to this -- we did it with the hugetlb patches for RISC-V --
> but it would be good to understand a little bit more about why the test
> fails before we merge it.

The test is almost certainly failing due to the environmental
requirements (i.e. namespaces, user ids, etc). There are some corner
cases in there that we've had to fix in the past. If the other tests
are passing, then I would expect all the seccomp internals are fine --
it's just the case being weird. It's just a matter of figuring out
what state the test environment is in so we can cover that corner case
too.

> Once we merge the patch, it will probably reduce the motivation for others
> to either understand and fix the underlying problem with the RISC-V code
> -- or, if it truly is a flaky test, to drop (or fix) the test in the
> seccomp_bpf kselftests.

Sure, I get that point -- but I don't want to block seccomp landing
for riscv for that. I suggested to David offlist that the test could
just be marked with a FIXME XFAIL on riscv and once someone's in a
better position to reproduce it we can fix it. (I think the test bug
is almost certainly not riscv specific, but just some missing
requirement that we aren't handling correctly.)

How does that sound?

-Kees
