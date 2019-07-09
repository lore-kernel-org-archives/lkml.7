Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA554C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16502173C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi5Qyysv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGIF34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:29:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36833 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfGIF3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:29:55 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so24917999iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 22:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekTBrm84eDXWp2v27vp/vaf2aZ34u1Aceu1+v4AGHdQ=;
        b=bi5Qyysv+BTUf6UfpIP1DBNvpEfxu1eIX6ZN3ZtCABgoI3gVIc9Ab6nbbW7wMIp9+v
         NrhtR0tF4ki2WZZSh2W7XrGRwvXyWHbRvMBA1uI9u9Ii5NX91Uk3PEvFxiX45AL1ay6I
         z2Cvk3ksOY48Fa3QlisSHncdSRaJfsaKkzFb84oyBTRnv7YXSLZwK7ikVQIh3U7aiRWG
         JFRisGdvze06cdteG8b1YUE3eWYC70EQMeZSrnecXX2eG0/jZo6MOcBbv2VmLbL/Q7di
         1mw5UqYdTPloGP1qsP2UPsQcnDJ7YQvQz0DMrGZwB5KvfaTyuSx4Cswh+tQrHXuhwJa0
         LVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekTBrm84eDXWp2v27vp/vaf2aZ34u1Aceu1+v4AGHdQ=;
        b=N+Kwu6vvTxd+sk6HXMTPkNGFKETQJE6A8BrLYUG4mS/4f8r4AIKzcKFfmCgT7Pclzx
         OEc49Dk1lXZbvVqNRjk6vtcMGC8BWHc5Bb34Bn0y+7/L14f6Bj3mVWl5QKQQP6SnvOh5
         5p6S0cEta5jlo/8dfbHbsq/x9ms7+d20HB8iF7wB34yOB9+V1aQukUis9+TrPGexmZ+M
         nkXFn6lO2FlZ8WZbvDDuIGVAd2KsefOfvzR5nDzy7xBLZnBA6vf7aCr+4i90MtYGbTnq
         J5m0dfWWK+MkVXaFrzCKMQmabHEs9b47w9x1r25/tjit6wSJ9aYBDM8g4Kwxu13HKwiQ
         DyxQ==
X-Gm-Message-State: APjAAAVfRk5G1m413M9ujh4JAmVzGIkkFqRV5cTbFdcP/FEM4H4RIvAp
        h6V9PfiMQj0i3KlQhAW4rosgqP3SVXlWgGR5iSE=
X-Google-Smtp-Source: APXvYqwlS6XUTtj022vlunepvujabK/y+bpHegMJ9IVb5gwkEqD17jg6eAVvZb3eDYVISpiQtcZhOGdsmj+f1PHg5V0=
X-Received: by 2002:a02:9004:: with SMTP id w4mr26522994jaf.111.1562650194327;
 Mon, 08 Jul 2019 22:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
 <d6f628ffdeb9c7863da722a8f6ef2949e57bb360.1557824379.git.christophe.leroy@c-s.fr>
 <87y318d2th.fsf@linux.ibm.com> <CAOSf1CG-oxpSDsAPw8xHV5367MrMn2Ty_yDpPY9TvA6wMrMZHA@mail.gmail.com>
 <c0461069-8ef8-cb56-6807-71cc79793ac4@linux.ibm.com>
In-Reply-To: <c0461069-8ef8-cb56-6807-71cc79793ac4@linux.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 9 Jul 2019 15:29:43 +1000
Message-ID: <CAOSf1CHYdUXOrxrnEgnF0QXWJ3At=x_70FOhr-9nyuXcgsYk3Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc/64: reuse PPC32 static inline flush_dcache_range()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 12:52 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 7/9/19 7:50 AM, Oliver O'Halloran wrote:
> > On Tue, Jul 9, 2019 at 12:22 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> >>
> >>> *snip*
> >>> +     if (IS_ENABLED(CONFIG_PPC64))
> >>> +             isync();
> >>>   }
> >>
> >>
> >> Was checking with Michael about why we need that extra isync. Michael
> >> pointed this came via
> >>
> >> https://github.com/mpe/linux-fullhistory/commit/faa5ee3743ff9b6df9f9a03600e34fdae596cfb2#diff-67c7ffa8e420c7d4206cae4a9e888e14
> >>
> >> for 970 which doesn't have coherent icache. So possibly isync there is
> >> to flush the prefetch instructions? But even so we would need an icbi
> >> there before that isync.
> >
> > I don't think it's that, there's some magic in flush_icache_range() to
> > handle dropping prefetched instructions on 970.
> >
> >> So overall wondering why we need that extra barriers there.
> >
> > I think the isync is needed there because the architecture only
> > requires sync to provide ordering. A sync alone doesn't guarantee the
> > dcbfs have actually completed so the isync is necessary to ensure the
> > flushed cache lines are back in memory. That said, as far as I know
> > all the IBM book3s chips from power4 onwards will wait for pending
> > dcbfs when they hit a sync, but that might change in the future.
> >
>
> ISA doesn't list that as the sequence. Only place where isync was
> mentioned was w.r.t  icbi where want to discards the prefetch.

doesn't list that as the sequence for what?

> > If it's a problem we could add a cpu-feature section around the isync
> > to no-op it in the common case. However, when I had a look with perf
> > it always showed that the sync was the hotspot so I don't think it'll
> > help much.
> >
>
> What about the preceding barriers (sync; isync;) before dcbf? Why are
> they needed?

Dunno, the sync might just be to ensure ordering between prior stores
and the dcbf.

>
> -aneesh
