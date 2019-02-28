Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFD8205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ou0vEybH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfB1MyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:54:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37800 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfB1MyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:54:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so17525012otp.4;
        Thu, 28 Feb 2019 04:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xFNUqMofSYseMxhCALx1eC6X92lUhDLNawEeb1GorTQ=;
        b=ou0vEybH374E7P0VkuWyPIdMhDSuGvFf8IuK5faWf4dh25naM2tmRggxToepZ5t60q
         WEpOdNPMXBMkS/QLsTuvgsrPOMwa9KwVqHzyn9/eQFxU/dnASnJiI1mU/8m+7BoXjUyz
         q5JVc6NGt1+0hzHmb1Fj1wqKtZU1dIdDpVXtPk2aE5NGeZldawJH9haKpl09afnqnmsd
         p5ZVo7MrD5YLQkY18fwcQYNmaXQkPYZHgSzX60FcX33D7oL+xdAeFg80G24/p9Duy3/q
         AB13ypIxH6i0BWb4BrZWSf706qpw3i4v8mRyNUfZ5qTvr2/46+ZBPt3ns/0s17bMIbOP
         R+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xFNUqMofSYseMxhCALx1eC6X92lUhDLNawEeb1GorTQ=;
        b=APuv3td4K/h9ZJkdUUqPS2l8zsFCVYJfSmwOxkwpWN6hmOJKiIZWvfifC9GLem4UsK
         0Afr5KDjFv31AqFD95Tq1XmQb2P+LYllKsX5yQSsjChuBdpFSoP9tygApYV7iVXAFY0u
         I4cQDNfLqFKWOzJ+CQbSTwEmLcKJQ8zvpRWksFDKgdj64W6Fjo8A3zHUKnEmSJyCRk2o
         DPSxeH+rgjtAZtvUH/QYKI40O3JEk6tiRRYrKAVM7Bim/QKnhqPOl6LJmWLwkxIyoetf
         Pou7XrNQWq2M5ZJ1l2zf/cWuHfcuiKqIjFlu/4AIz96dgflrAGioxBY+hGkO7zWa388r
         6XdQ==
X-Gm-Message-State: AHQUAuaGw120UQPxwqcoIAtbpulAFuolGah5SUEb1cc0QCrZfQrljpSh
        m0g6QHawJp1c6JdeCragg6Ga+Olrqsn2aBa1A84=
X-Google-Smtp-Source: AHgI3IaEpJ3baKUubliN7R3S+jp8FFAezwjkEpRmqBcZ4ZhGaTU+9mOm0wsxj8mKH6bS/506yPtlRiSMfYp/PwaPE04=
X-Received: by 2002:a9d:4808:: with SMTP id c8mr5407100otf.328.1551358449908;
 Thu, 28 Feb 2019 04:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20190221221941.29358-1-daniel@iogearbox.net> <tip-ce02ef06fcf7a399a6276adb83f37373d10cbbe1@git.kernel.org>
 <33bf951448e7d916fd4a6ad41cd3d040e9d1f118.camel@infradead.org>
In-Reply-To: <33bf951448e7d916fd4a6ad41cd3d040e9d1f118.camel@infradead.org>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 28 Feb 2019 04:53:34 -0800
Message-ID: <CAMe9rOrcOVRWuNWy3xp7NMD=2UbGH+C5zifDhd=-AxrrzEVrmw@mail.gmail.com>
Subject: Re: [tip:x86/build] x86, retpolines: Raise limit for generating
 indirect calls from switch-case
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     daniel@iogearbox.net, Ingo Molnar <mingo@kernel.org>,
        bjorn.topel@intel.com, David Miller <davem@davemloft.net>,
        brouer@redhat.com, magnus.karlsson@intel.com,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ast@kernel.org,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 3:27 AM David Woodhouse <dwmw2@infradead.org> wrote=
:
>
> On Thu, 2019-02-28 at 03:12 -0800, tip-bot for Daniel Borkmann wrote:
> > Commit-ID:  ce02ef06fcf7a399a6276adb83f37373d10cbbe1
> > Gitweb:     https://git.kernel.org/tip/ce02ef06fcf7a399a6276adb83f37373=
d10cbbe1
> > Author:     Daniel Borkmann <daniel@iogearbox.net>
> > AuthorDate: Thu, 21 Feb 2019 23:19:41 +0100
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Thu, 28 Feb 2019 12:10:31 +0100
> >
> > x86, retpolines: Raise limit for generating indirect calls from switch-=
case
> >
> > From networking side, there are numerous attempts to get rid of indirec=
t
> > calls in fast-path wherever feasible in order to avoid the cost of
> > retpolines, for example, just to name a few:
> >
> >   * 283c16a2dfd3 ("indirect call wrappers: helpers to speed-up indirect=
 calls of builtin")
> >   * aaa5d90b395a ("net: use indirect call wrappers at GRO network layer=
")
> >   * 028e0a476684 ("net: use indirect call wrappers at GRO transport lay=
er")
> >   * 356da6d0cde3 ("dma-mapping: bypass indirect calls for dma-direct")
> >   * 09772d92cd5a ("bpf: avoid retpoline for lookup/update/delete calls =
on maps")
> >   * 10870dd89e95 ("netfilter: nf_tables: add direct calls for all built=
in expressions")
> >   [...]
> >
> > Recent work on XDP from Bj=C3=B6rn and Magnus additionally found that m=
anually
> > transforming the XDP return code switch statement with more than 5 case=
s
> > into if-else combination would result in a considerable speedup in XDP
> > layer due to avoidance of indirect calls in CONFIG_RETPOLINE enabled
> > builds.
>
> +HJL
>
> This is a GCC bug, surely? It should know how expensive each
> instruction is, and choose which to use accordingly. That should be
> true even when the indirect branch "instruction" is a retpoline, and
> thus enormously expensive.
>
> I believe this is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D86952 so
> please at least reference that bug, and be prepared to turn this hack
> off when GCC is fixed.

We couldn't find a testcase to show jump table with indirect branch
is slower than direct branches.

--=20
H.J.
