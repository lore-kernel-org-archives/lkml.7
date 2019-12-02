Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CCE20748
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0RV9WdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLBJjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:39:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39700 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfLBJjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:39:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id a67so13035144oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mXfbyf/upZZBnp2Na+IfEomlLG1jmss1TGoDx2NxQIQ=;
        b=n0RV9WdTgP/91lc+kF3c1hS7d4WWWrogsPPm8GbAKwgUGZDWfNSMsLHfDSNULUz+/3
         7KStCiTFPukPLmcx2yYjHcXQqugP6b5QxA8oVMlmW0Cehw+qFf3ylvbkYvolLUVxWNv/
         07BNhqp1hWwKembAaXypODfX8FFqZbn4E6tBKgVqkH+VoEYD228Dm1STa3WDKGPmUwcs
         D0aTPlSkrUelU0nVZ5IYRcyr05T2RSO5l+1XfCVDpAyryQ01JM7woVPYBTj8UNKQBLqz
         389KeR/xrNtAkR9L2Wl1nmsOHDMWniIQbX/V2Mr7qbOFc3zQByOW+V7qKf5VIHk+0W6X
         47zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mXfbyf/upZZBnp2Na+IfEomlLG1jmss1TGoDx2NxQIQ=;
        b=jlNWNOsf6ki4D9fz8wbvQFN70vssbCCI9gIeMF+KKH04krOYmFc8GvfqFvliluNlXm
         5qfE98lijZ7k7U8eaTk6B2O+d251++4hIrXZiBBSMJBXtKfpxHh6Ut7lFASLxbPAeEFm
         RPUUO2BrBzRr0ADrun63gUxCQEKdGC+JP8Od8wnsVDbF1xRjBo+uYtDxz77kw6Gn/IPX
         FKpM1EVcp1gqWx/aKAAcNhiJu3EOBOiSLvB7RW38D3b4LiQvU71WrSs/BFAT0Uizvth6
         4z9LTatHmyq+JcD3sHCCy8THoheUHciezLq5BY80Ul4ZGVQd5Au1LhJpifn0TjxdfYOe
         YVPg==
X-Gm-Message-State: APjAAAWu3MAClKI7F6DPY/LBoOHJzCo8DA1IOTfj3QYqoojt3mz1X+Jy
        YocXuH6qkAbnTMRKVBQxZ/BKCFLRRKzXisITDKgY1g==
X-Google-Smtp-Source: APXvYqxqeDMXBkW6jLIS8nwCJHo6GpgPc83/ykr4I2trdcajlzhkcBXRU9wvO8gR1DANEaIYPYPZ3zvJRfHwVzRO5cA=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr23250358oig.172.1575279548664;
 Mon, 02 Dec 2019 01:39:08 -0800 (PST)
MIME-Version: 1.0
References: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org>
 <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com>
 <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com>
 <20191014101938.GB41626@lakrids.cambridge.arm.com> <0101016ec501966f-4b89bcda-49ba-45d3-b226-62538b901b04-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016ec501966f-4b89bcda-49ba-45d3-b226-62538b901b04-000000@us-west-2.amazonses.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 2 Dec 2019 10:38:57 +0100
Message-ID: <CANpmjNPCwB+5oTVZBXojvSGL=8ybomBKFD4HtwFvGmLyuQOVaQ@mail.gmail.com>
Subject: Re: KCSAN Support on ARM64 Kernel
To:     sgrover@codeaurora.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're in the process of upstreaming KCSAN, which will simplify a lot
of things including Arm64 support. So far KCSAN is not yet in
mainline, but I assume when that happens (if things go well, very
soon) it should be trivial to add Arm64 support based on Mark's
prototype.

Thanks,
-- Marco

On Mon, 2 Dec 2019 at 06:07, <sgrover@codeaurora.org> wrote:
>
> Hi All,
>
> Is there any update in Arm64 support of KCSAN.
>
> Regards,
> Sachin Grover
>
> -----Original Message-----
> From: Mark Rutland <mark.rutland@arm.com>
> Sent: Monday, 14 October, 2019 3:50 PM
> To: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>; sgrover@codeaurora.org; kasan-dev=
 <kasan-dev@googlegroups.com>; LKML <linux-kernel@vger.kernel.org>; Paul E.=
 McKenney <paulmck@linux.ibm.com>; Will Deacon <willdeacon@google.com>; And=
rea Parri <parri.andrea@gmail.com>; Alan Stern <stern@rowland.harvard.edu>
> Subject: Re: KCSAN Support on ARM64 Kernel
>
> On Mon, Oct 14, 2019 at 11:09:40AM +0200, Marco Elver wrote:
> > On Mon, 14 Oct 2019 at 10:40, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Mon, Oct 14, 2019 at 7:11 AM <sgrover@codeaurora.org> wrote:
> > > >
> > > > Hi Dmitry,
> > > >
> > > > I am from Qualcomm Linux Security Team, just going through KCSAN
> > > > and found that there was a thread for arm64 support
> > > > (https://lkml.org/lkml/2019/9/20/804).
> > > >
> > > > Can you please tell me if KCSAN is supported on ARM64 now? Can I
> > > > just rebase the KCSAN branch on top of our let=E2=80=99s say androi=
d
> > > > mainline kernel, enable the config and run syzkaller on that for
> > > > finding race conditions?
> > > >
> > > > It would be very helpful if you reply, we want to setup this for
> > > > finding issues on our proprietary modules that are not part of
> > > > kernel mainline.
> > > >
> > > > Regards,
> > > >
> > > > Sachin Grover
> > >
> > > +more people re KCSAN on ARM64
> >
> > KCSAN does not yet have ARM64 support. Once it's upstream, I would
> > expect that Mark's patches (from repo linked in LKML thread) will just
> > cleanly apply to enable ARM64 support.
>
> Once the core kcsan bits are ready, I'll rebase the arm64 patch atop.
> I'm expecting some things to change as part of review, so it'd be great t=
o see that posted ASAP.
>
> For arm64 I'm not expecting major changes (other than those necessary to =
handle the arm64 atomic rework that went in to v5.4-rc1)
>
> FWIW, I was able to run Syzkaller atop of my arm64/kcsan branch, but it's=
 very noisy as it has none of the core fixes.
>
> Thanks,
> Mark.
>
