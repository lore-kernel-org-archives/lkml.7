Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA3DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465322083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5znePB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfCLQaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:30:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52260 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:30:34 -0400
Received: by mail-it1-f196.google.com with SMTP id g17so5411119ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFIgb7ff40bY7X5nCfm1fQ0F0XRSiXuRUY1WM002qKY=;
        b=E5znePB79i74DcKgLsllHPgGhvqjM0gOF4kFLD8MvTx2/Yj/eoJjkbmRIwZn19hxWV
         B1tqrtS6wR2Q2Zf204TnhiPNjFwxt6EwMG9183F7yndUc5gnk6k+cx5U7Pd6qRY129Va
         TLMdBlwoLlh+tP4+XEJDUlVOSCzBeAji3lHjxHyRb/SjGntgWto15u/HkCc4jElmUwig
         6DD4sI02ppjm6/oYWSoPePMZd2idcjanXxYZrnoUOIMvINWmn+EDxqxPBjWpp4zNzwQZ
         rNCZ/czKwMyHZet1/q/sOHI9/6wB7R38ch0bLmAurM4ibuFVyKKiLciTERIBIx+pmxbD
         H2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFIgb7ff40bY7X5nCfm1fQ0F0XRSiXuRUY1WM002qKY=;
        b=VfGRAXK0eNqlBACgEnIlTBUZ2b/SUy2rzaAxNQYu6htlsiGhO9v4sU4+eROFLyTt1H
         whlTeS79g82uwh9mcHh+uFuIrCrz7ZEb/ii/1ihFJka3dpWOzOlimBLCI8yiuJa94D3Q
         w7RFf05VM3iLFoe651FSCuQDLv0Aupfo7h/8z3gx7UmlUOEa/yuOpPjMJ0icSbJu6azQ
         ufngpKt+pVW8fC3N3QHFAxQx6VDM1lEWEgXHPO6t5j07HR0uP34L8uPLErcu8QqoSA1O
         16rI8TIsSceGsB8WDIW6TGXya4A2Znf3PwENGDHiOHL88kYklBvZLdxB1+JYXZ5U/Zct
         LV1g==
X-Gm-Message-State: APjAAAUk71n/ulbu7j2VKMwrI69qD6kwnhlIgP+gXokXcFWjOqbzPIGm
        +CEbCwTJD0NrIT69FAvE8iPyMmgGhyubpIXQSuU=
X-Google-Smtp-Source: APXvYqzzRRoLQ/iwtSYDaVnzcrtwVXuwp5QgcZHgye+aPx74hyJiluyLSnlXGdUbEJVyyXkuGfMBiHN27U1sgRs1Bts=
X-Received: by 2002:a24:c043:: with SMTP id u64mr2567877itf.59.1552408233779;
 Tue, 12 Mar 2019 09:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
 <1551501538-4092-2-git-send-email-laoar.shao@gmail.com> <20190312161803.GC5721@dhcp22.suse.cz>
In-Reply-To: <20190312161803.GC5721@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 Mar 2019 00:29:57 +0800
Message-ID: <CALOAHbBR119mzbkkQ5fmGQ5Bqxu2O4EFgq89gVRXqXN+USzDEA@mail.gmail.com>
Subject: Re: [PATCH] mm: compaction: some tracepoints should be defined only
 when CONFIG_COMPACTION is set
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:18 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sat 02-03-19 12:38:58, Yafang Shao wrote:
> > Only mm_compaction_isolate_{free, migrate}pages may be used when
> > CONFIG_COMPACTION is not set.
> > All others are used only when CONFIG_COMPACTION is set.
>
> Why is this an improvement?
>

After this change, if CONFIG_COMPACTION is not set, the tracepoints
that only work when CONFIG_COMPACTION is set will not be exposed to
the usespace.
Without this change, they will always be expose in debugfs no matter
CONFIG_COMPACTION is set or not.

That's an improvement.

> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/trace/events/compaction.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
> > index 6074eff..3e42078 100644
> > --- a/include/trace/events/compaction.h
> > +++ b/include/trace/events/compaction.h
> > @@ -64,6 +64,7 @@
> >       TP_ARGS(start_pfn, end_pfn, nr_scanned, nr_taken)
> >  );
> >
> > +#ifdef CONFIG_COMPACTION
> >  TRACE_EVENT(mm_compaction_migratepages,
> >
> >       TP_PROTO(unsigned long nr_all,
> > @@ -132,7 +133,6 @@
> >               __entry->sync ? "sync" : "async")
> >  );
> >
> > -#ifdef CONFIG_COMPACTION
> >  TRACE_EVENT(mm_compaction_end,
> >       TP_PROTO(unsigned long zone_start, unsigned long migrate_pfn,
> >               unsigned long free_pfn, unsigned long zone_end, bool sync,
> > @@ -166,7 +166,6 @@
> >               __entry->sync ? "sync" : "async",
> >               __print_symbolic(__entry->status, COMPACTION_STATUS))
> >  );
> > -#endif
> >
> >  TRACE_EVENT(mm_compaction_try_to_compact_pages,
> >
> > @@ -195,7 +194,6 @@
> >               __entry->prio)
> >  );
> >
> > -#ifdef CONFIG_COMPACTION
> >  DECLARE_EVENT_CLASS(mm_compaction_suitable_template,
> >
> >       TP_PROTO(struct zone *zone,
> > @@ -296,7 +294,6 @@
> >
> >       TP_ARGS(zone, order)
> >  );
> > -#endif
> >
> >  TRACE_EVENT(mm_compaction_kcompactd_sleep,
> >
> > @@ -352,6 +349,7 @@
> >
> >       TP_ARGS(nid, order, classzone_idx)
> >  );
> > +#endif
> >
> >  #endif /* _TRACE_COMPACTION_H */
> >
> > --
> > 1.8.3.1
> >
>
> --
> Michal Hocko
> SUSE Labs
