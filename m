Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A51C76190
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0392086D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHjHeqS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfG0CeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 22:34:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45870 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfG0CeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:34:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so18768814otq.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 19:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zpeooSg+LQdXjAAfVsZypK0AbbwUv4Ep7JcxnLVryiU=;
        b=UHjHeqS7q3gd26VS+n85HRyE9GOmIkDj019sXmy+muPSPCkqtq0YR8IcQgl8cJ4hYh
         godJNDBFKBHweclH/CH0P/D5qASWANJ0mqOdL5sYy1fv5cyO4Q+qoy4jgV4iwaNf26z1
         GlPDN12bhXuKuwwbSuvZhFvA9CXrNiu5xbewuMkdR/h1QxDZGThP5h6SHnC0f0hCRpps
         0yD+tHlvgZGsyozrCivNsYxNvWhoJgskpBq7CKkgcvRzmjawYe7keGroLiy5N+I7fdx4
         rM06nkLvvder5FuVPEhTB9KVPQju/81EUxqLUTNK6DEN788mGPfeK2605he49s83yTBK
         8Lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zpeooSg+LQdXjAAfVsZypK0AbbwUv4Ep7JcxnLVryiU=;
        b=Kzz9DScLd7bkisA/G8pbiW3h6T9NDG9heawsJEb+QyYbSEQ62mdB9Zz/EDTHAc7x0G
         7wd6jJH/6iioDf/l6isUaUxrMiuLUoLxOMOus/57/bJ5UMRf6Yd34XTcg4fxr2863+T9
         GVOGl8o4D6JgYi7arUC6ND+2WqQCsjcN8ZzKeVw8KisD0sU/xczhoEokQ5KeU0pAYC96
         Rea8a5ue7mZmPp2T6jWsLlTQ6Ph/1COZGtPt/p2c3wVxts1RYdTk890wF8b2Ib2bfStw
         H+OL0sDpwpXJtPs0LR/m+SjMTgfSI02q6dg0LxRcVdu+NbUOQ80Q7nhVBR2pVUD5c3vt
         ZGqg==
X-Gm-Message-State: APjAAAVDgj+CqqJMqAcfh6eQkKr9/K2aeyHXtdx/JGip2mQRiy2cFLdB
        ZOWerGI+FMSwqZiXPh52nuxs7TijQasTiqttR4o=
X-Google-Smtp-Source: APXvYqydHwrWeTu/eNQDqkwJCphABHgrjGj9nCOmuE1P5OcqkhTB8TU7YiJxThnnIeQncQm5jAV9GD4uGTuOsp7E0lE=
X-Received: by 2002:a05:6830:2098:: with SMTP id y24mr29902120otq.173.1564194856659;
 Fri, 26 Jul 2019 19:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190725184253.21160-1-lpf.vector@gmail.com> <20190725184253.21160-3-lpf.vector@gmail.com>
 <ac59714d-74d6-820c-37ea-5bf62cfc33a8@rasmusvillemoes.dk>
In-Reply-To: <ac59714d-74d6-820c-37ea-5bf62cfc33a8@rasmusvillemoes.dk>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Sat, 27 Jul 2019 10:34:04 +0800
Message-ID: <CAD7_sbHTzPrQGEA259HU__-G7dvV_dZ-f3WavPavp-0WQzB4aA@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm/page_alloc: use unsigned int for "order" in __rmqueue_fallback()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        Qian Cai <cai@lca.pw>, aryabinin@virtuozzo.com,
        osalvador@suse.de, rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 5:36 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 25/07/2019 20.42, Pengfei Li wrote:
> > Because "order" will never be negative in __rmqueue_fallback(),
> > so just make "order" unsigned int.
> > And modify trace_mm_page_alloc_extfrag() accordingly.
> >
>
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 75c18f4fd66a..1432cbcd87cd 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2631,8 +2631,8 @@ static bool unreserve_highatomic_pageblock(const =
struct alloc_context *ac,
> >   * condition simpler.
> >   */
> >  static __always_inline bool
> > -__rmqueue_fallback(struct zone *zone, int order, int start_migratetype=
,
> > -                                             unsigned int alloc_flags)
> > +__rmqueue_fallback(struct zone *zone, unsigned int order,
> > +             int start_migratetype, unsigned int alloc_flags)
> >  {
>
> Please read the last paragraph of the comment above this function, run
> git blame to figure out when that was introduced, and then read the full
> commit description.

Thanks for your comments.

I have read the commit info of commit b002529d2563 ("mm/page_alloc.c:
eliminate unsigned confusion in __rmqueue_fallback").

And I looked at the discussion at https://lkml.org/lkml/2017/6/21/684 in de=
tail.

> Here be dragons. At the very least, this patch is
> wrong in that it makes that comment inaccurate.

I wonder if you noticed the commit 6bb154504f8b ("mm, page_alloc: spread
allocations across zones before introducing fragmentation").

Commit 6bb154504f8b introduces a local variable min_order in
__rmqueue_fallback().

And you can see

        for (current_order =3D MAX_ORDER - 1; current_order >=3D min_order;
                                --current_order) {

The =E2=80=9Ccurrent_order=E2=80=9D and "min_order"  are int, so here is ok=
.

Since __rmqueue_fallback() is only called by __rmqueue() and "order" is uns=
igned
int in __rmqueue(), then I think that making "order" is also unsigned
int is good.

Maybe I should also modify the comments here?

>
> Rasmus

Thank you again for your review.

--
Pengfei
