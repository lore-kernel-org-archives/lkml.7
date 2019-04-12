Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD2AC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4143C21872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ut+BU82T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDLOKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:10:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37857 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbfDLOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:10:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so12169497wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=90DhyNOjYKUio3/9dm7oyIW5bfCoyTnkGuxR/xjlLUQ=;
        b=Ut+BU82ToY63AFh0Jd7IVp0QYUoXU6aJ4Jqho2HFukbN68H9nrlT6/uWhys/uEdm9P
         0OeJeAOWj5z4jTcZRBdqYosDVq0aAhb0nJD6k2HCLVVDOG3O8hTl33pidDWNP41+el4z
         CZgzBAAtmKUfThyobUgavdz2MroFuP9chylGrkQvLRAMXcCpZLN7dopM/s5b4pcKKTdI
         xqgmHMq5aqXE9T38aLG7t3KX3FV5tRDXuU2oKtGApG+Gk9crSchMAXHFhknZqQkDhq8Q
         patpTm9UYpR+tzj4k4bPRO/4hQeLsrG2EHTiSXPmEGp8zDYiCXJzyCFOi2EdlMQQa2l/
         RQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=90DhyNOjYKUio3/9dm7oyIW5bfCoyTnkGuxR/xjlLUQ=;
        b=Sh4+9k+1G3vxkiGqTlOtrT+cV0E2s03gY9cJC/+9gyUquPTuBv5Lu4bJpbiKXjDZ3q
         BKqLs5LhdmkbXjP8B++Mup2OuwSLDcHVuvCFEhZHbRXWhnivekbhZgk2Sqj2HNLNXUFu
         81gQr5TAayDIJXgLvxmISyrWViU+mzLBIhHS4ku/Qs0cR+5101PUvBa1SqHAauCMxrYz
         dXNQdXkfWYKGKAcZv62x2ELzdSeR2XbkZCwSO3jlGzN+yS44U9Qdf7FkCBre2bfsfdxc
         WiFxGKZgDwmv91eEhKPYZdILBEO1tFippl9Afxl3y9ueJcakAl+HX2f/LY8agSu/NJ6h
         6OGA==
X-Gm-Message-State: APjAAAVoHLwHVdE3ja1ULXmuKlLF5DZl71hi3uARvJtHoB9mIFNxZMr3
        2L95R0S2cLZ8JvL2F095bIf+iPVEpT7k0LF0EcbKbw==
X-Google-Smtp-Source: APXvYqy5NJ9ngzb1u4JggWfV4gOmQq/6oqsf69m9MuREST1uBrvQU/t0WRYKCnMBeC7HsJ526lrP4r7d0JC3VxMiK7I=
X-Received: by 2002:adf:f98d:: with SMTP id f13mr36647579wrr.98.1555078219540;
 Fri, 12 Apr 2019 07:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org> <20190412065314.GC13373@dhcp22.suse.cz>
In-Reply-To: <20190412065314.GC13373@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 12 Apr 2019 07:10:08 -0700
Message-ID: <CAJuCfpHzfci6ztBA_c5=DUnfaLQJTphj1UfckN_LZ7w9qi4kAw@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:53 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 11-04-19 08:33:13, Matthew Wilcox wrote:
> > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > victim process. The usage of this flag is currently limited to SIGKIL=
L
> > > signal and only to privileged users.
> >
> > What is the downside of doing expedited memory reclaim?  ie why not do =
it
> > every time a process is going to die?
>
> Well, you are tearing down an address space which might be still in use
> because the task not fully dead yeat. So there are two downsides AFAICS.
> Core dumping which will not see the reaped memory so the resulting
> coredump might be incomplete. And unexpected #PF/gup on the reaped
> memory will result in SIGBUS. These are things that we have closed our
> eyes in the oom context because they likely do not matter. If we want to
> use the same technique for other usecases then we have to think how much
> that matter again.
>

Sorry, resending with corrected settings...
After some internal discussions we realized that there is one
additional downside of doing reaping unconditionally. If this async
reaping is done on a more efficient and energy hungrier CPU
irrespective of urgency of the kill it should end up costing more
power overall (I=E2=80=99m referring here to assimetric architectures like =
ARM
big.LITTLE). Obviously quantifying that cost is not easy as it depends
on the usecase and a particular system but it won=E2=80=99t be zero. So I
think we will need some gating condition after all.

> --
> Michal Hocko
> SUSE Labs
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
