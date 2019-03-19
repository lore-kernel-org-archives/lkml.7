Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F10C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC48420850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GunllQ7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfCSD2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:28:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44079 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSD2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:28:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id w5so12284007qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uGz0+YUaGv2kdErV9VGt6dk/XyAvxE/PNRxwmvJSl4=;
        b=GunllQ7E2KCYzEeGnCp8Y/6LedFEmhCEWYIfEYfz1HF31CH9UeiTHfciY1lOGNXyFS
         Xqf/50wYYoJuNog55efQn8myb7vzTTWQIjI5MvbOnsKV/DYO6pmuWktf6Sdj4iKY4BxS
         LqnysBFPPC60Sx0EiNTD3rXyD6wIF7g3hgE3kK+5Mu2swKX7LQbYdNacFLOIcTQUugTE
         GesrVJ1rnQPeO8PkSN1V3pF/Ocvu2s+lD1HkwhfGA8oPTsmnzbwUqZOewxDOukjGJIT7
         T0sarnhL2JkErAsLi1uydh9Wvjlf2ksgWdQKwNi9kgX2169LywPiHGx9lrLWa0bN9aqd
         IpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uGz0+YUaGv2kdErV9VGt6dk/XyAvxE/PNRxwmvJSl4=;
        b=eA+iLxfAyZt3H6C4+bC6z9WN5a3/tzRgF4R2C9I0ODIkfD3LW9rLsdd9NulqApbYXF
         1VHvHGeGJi1/CUEjtRfF9+pK699hVJH67H6RPfeKQNEVLQ7AX5C9XA458hPCzGRAixOi
         TfmUYLuj2WV/VjxgB4izQwHDcNaTpd6Oe6JlY7uAvtss9al5XQ280ADcx5vwDvpsQ6zA
         NjYF8tBz/pieWHJjJVd5Y6LIJDoE4zAR678QrQ925EgrmLTuDvfhKGDaZ99zRadg1oWk
         7MC17oskbHpBtyxZPVN41N8shS0YNRvDTPv0BZ1v+I1hB+EVFVRta5eH+rqpeIRjXYXr
         Wr9A==
X-Gm-Message-State: APjAAAXiNuNmTzKx0OAmgHvZ0U/C5quvO/kLSAPxwkaESKXMgNT6b1rd
        RrgIiFl76fR1KU2imey2g7huBshmyqaQw79YQXg=
X-Google-Smtp-Source: APXvYqyXGRMOERKJkhHOtR1nR7spXavpMGWY4dixSs//kmyAf83UbhbBpJuWe1uAiygKVDwBusU/lq3guvszCdAPmVs=
X-Received: by 2002:ac8:27a6:: with SMTP id w35mr194257qtw.157.1552966093088;
 Mon, 18 Mar 2019 20:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190318085733.3143-1-duyuyang@gmail.com> <20190318085733.3143-2-duyuyang@gmail.com>
 <494746a793619dd9b43fb152de811a6e7de77cce.camel@perches.com>
In-Reply-To: <494746a793619dd9b43fb152de811a6e7de77cce.camel@perches.com>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Tue, 19 Mar 2019 11:28:01 +0800
Message-ID: <CAHttsrZAtfNuk80R=m3E--z6O6RCTNSbBN35+PPAHN2UgDYzog@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] locking/lockdep: Change all print_*() return
 type to void
To:     Joe Perches <joe@perches.com>
Cc:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On Mon, 18 Mar 2019 at 17:45, Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2019-03-18 at 16:57 +0800, Yuyang Du wrote:
> > Since none of the print_*() function's return value is necessary, change
> > their return type to void. No functional change.
> >
> > In cases where an invariable return value is used, this change slightly
> > improves readability, i.e.:
> []
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> []
> > @@ -1430,23 +1430,20 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
> []
> > -static void
> > -print_circular_lock_scenario(struct held_lock *src,
> > -                          struct held_lock *tgt,
> > -                          struct lock_list *prt)
> > +static void print_circular_lock_scenario(struct held_lock *src,
> > +                                      struct held_lock *tgt,
> > +                                      struct lock_list *prt)
>
> trivia:
>
> This style change seems superfluous as many
> other existing functions use the previous style.

Those "many other" are kind of bizarre already in the context of that
file IMHO. So the change went to great lengths in #05 :)
