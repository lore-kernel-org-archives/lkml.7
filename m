Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15701C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F0C2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P83wjgV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKZWgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:36:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45550 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKZWgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:36:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so15425228lfa.12;
        Tue, 26 Nov 2019 14:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wxy80mBAQVfVNiFRLzfL2dvJVYM/W7L9tB9zzxf4iug=;
        b=P83wjgV5BZ79VZm2l5j3cMsBq8T9cIcd/ftrEAfOGQYgsbzP75wXa973rMk7459uXO
         gjYLXtWxnZDZ3/i/awe3KDzga77Ve5ig8MvVwW2sPkFael3RDxd/RL/NvR62NjV03+wq
         dzyKRgBPPSkd/LdcFkNnlJK7sNoppUQZfrL/4nuNc9nwXD4jiEb4yOKtZH2WzUKBZ1EK
         AE3H1BlN7SPVNskMNWOMrXq2bYgkE8SMQiGNWU4nomZ0bwaUVWF2v4xKRPeC71feUDvs
         6AJh051Ctva3V5hTRD9KcpR2JLSK+XJM3U1lp6X4B5pO+rWUV3EjdAe4qwRIqfSJBxI/
         HR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wxy80mBAQVfVNiFRLzfL2dvJVYM/W7L9tB9zzxf4iug=;
        b=cHn6cI7nc3Q4DmmM8uh9wTEgeD9PbSnFGic512W/n+YS8Lz+RWwlycqgCjq+H284JE
         V9yD4LUmxEMZdyTqM3Y5NPTRHjTld+CAL6AHQrf/HD2o6ZrD1JmZq8CiobJpEBAZPiUc
         vcINfTPoPgRPe5762FjNZOoaWB1lHeUjVpe+T0bg3bf9NEhBxVgQI9ZYb0DEx9YNyapp
         lUdQGuZqMnEzMrwufSY/ESO3SvTjhsdbmivPwn2QNrkAc1ulQg/OWgLkOos50yPef8h/
         4ZMyWQc6KE8kJRPLVxJZLaMnFmgGsWNYW+sD0n6YYSic2CGSOm4uBE0I7926aasuQ3gN
         MwiQ==
X-Gm-Message-State: APjAAAWe3UaLdxDPG5LknG/KfuUS7Be+DJNcuUPSC0y8PGuU02t5igay
        0OjqHrIlSMhnTDRCsE3lbdYU2q+IQVxFrzsV8L0I7f/Y
X-Google-Smtp-Source: APXvYqxN/GAR29dK9DHptHMLVgGfyUiHMxYz2YPesHjuMPjZoZCc/lHe4X7vDMZ4GtXvwD/lM5oU02+bx/5X2J2a8hY=
X-Received: by 2002:ac2:46f7:: with SMTP id q23mr25607116lfo.68.1574807796845;
 Tue, 26 Nov 2019 14:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20191121234125.28032-1-sj38.park@gmail.com> <20191126222144.GW2889@paulmck-ThinkPad-P72>
In-Reply-To: <20191126222144.GW2889@paulmck-ThinkPad-P72>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 26 Nov 2019 23:36:10 +0100
Message-ID: <CAEjAshpBEyzh-=s9rPw7+yAbZLZfv5-XaG=-TCEn1G5yaQmHbQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] docs: Update ko_KR translations
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 11:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Nov 22, 2019 at 12:41:18AM +0100, SeongJae Park wrote:
> > This patchset contains updates of Korean translation documents and a fix
> > of original document.
> >
> > First 4 patches update the Korean translation of memory-barriers.txt.
> > Fifth patch fixes a broken section reference in the original
> > memory-barriers.txt.
> >
> > Sixth and seventh patches update the Korean translation of howto.rst.
>
> The sixth and seventh probably have some other more natural path,
> but I queued them.  Any chance of a Reviewed-by from one of our other
> Korean-language kernel hackers?

Thanks, Paul.  I asked a review to my Korean ex-colleague.  Will update the
results, soon!


Thanks,
SeongJae Park

>
>                                                         Thanx, Paul
>
> > *** BLURB HERE ***
> >
> > SeongJae Park (7):
> >   docs/memory-barriers.txt/kokr: Rewrite "KERNEL I/O BARRIER EFFECTS"
> >     section
> >   Documentation/kokr: Kill all references to mmiowb()
> >   docs/memory-barriers.txt/kokr: Fix style, spacing and grammar in I/O
> >     section
> >   docs/memory-barriers.txt/kokr: Update I/O section to be clearer about
> >     CPU vs thread
> >   docs/memory-barriers.txt: Remove remaining references to mmiowb()
> >   Documentation/translation: Use Korean for Korean translation title
> >   Documentation/process/howto/kokr: Update for 4.x -> 5.x versioning
> >
> >  Documentation/memory-barriers.txt             |  11 +-
> >  Documentation/translations/ko_KR/howto.rst    |  56 +++--
> >  Documentation/translations/ko_KR/index.rst    |   4 +-
> >  .../translations/ko_KR/memory-barriers.txt    | 227 +++++++-----------
> >  4 files changed, 119 insertions(+), 179 deletions(-)
> >
> > --
> > 2.17.2
> >
