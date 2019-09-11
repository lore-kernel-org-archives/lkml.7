Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2510EC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA572207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDzKMYbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfIKOeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:34:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35051 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfIKOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:33:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id t6so9527512otp.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7i1vpQoaz28lri8m0dOi8OheZbdU0yuzI5V0oHg1wI=;
        b=gDzKMYbkL2/UIIox7n9fF8nxWK0jM/5rkqz+fvqtwhYarL9SJ44xQDt/t33K9VIBEz
         jgma1b2JT6MCkvA0jq5vblNABt13d0t0hpoaNHGhp46fUzdNphFV7DuD9Irsfl5iZf5F
         N3iTDI+gdue+yMu/CcQS7GF3+BL+vSupn4EgCbSi3eDwA1NmuIkGDIaZuVFiiZmGHHug
         A/9VMetPrhM4Bt0fyJhBYs+lCgN3BySKPbFTvicbTfJNgb8UsyU06kLNd8iKBvxJjcJn
         FWdbzt+L12PE1Eybea/kLOR1QtScPArTMBAlAae8QsT7wa+GA4E9hYfy11OCPBdFZxTA
         T1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7i1vpQoaz28lri8m0dOi8OheZbdU0yuzI5V0oHg1wI=;
        b=bGFKnLbwuKaDzMizTFk65SNc8NWesYQ9UzkKL1sKu2X0nRZieerWQUq/oipt5yGpKP
         f/8dtecmv4edW38/p5i3vXA/1lMxXAenp1BCMk9qhAy6YZvGMirMJkfYuq4qG+xXpEk6
         msKvlxmmj2iD+u89XYQZ1THTcBXvV5EFmWWI1yqehYbFSJXg0PBxpY087fxzlcS1e7MS
         pz5PpYA58bGhYvZqt4M+Cad78LyeATxGpGdzOfnFAL/a21XHlc7p2MjjPBdRhf45Z9C3
         P2zK5+pw6iZ0K6twxV/8AX3yR0bqllK7Mxi4PFUU9/6iMULOcK1kvyuyeJNPlAvPmGHT
         L1iw==
X-Gm-Message-State: APjAAAVQt3LqCmq9itksQs2MAqSndOZH1XkUbph0wwsu02/gNgmcpmR7
        gQ47ZBIPraN6r9kl22HwBD3pwSNbT2heSPacGyo=
X-Google-Smtp-Source: APXvYqx7hau3v+uUL+g+yMLToPsiUNB+5jnulxOrqfaNC3BhfhcsFq7YjuvJLUpWsz1nZ/u3gZ7F7QhT4t5YSD7DVws=
X-Received: by 2002:a9d:1ec:: with SMTP id e99mr25446946ote.173.1568212438718;
 Wed, 11 Sep 2019 07:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190910012652.3723-1-lpf.vector@gmail.com> <20190910012652.3723-5-lpf.vector@gmail.com>
 <23cb75f5-4a05-5901-2085-8aeabc78c100@suse.cz>
In-Reply-To: <23cb75f5-4a05-5901-2085-8aeabc78c100@suse.cz>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Wed, 11 Sep 2019 22:33:46 +0800
Message-ID: <CAD7_sbHZuy4VZJ1KrF6TXmihfxi91Fo0OJMjuET4dpk-F7g6jA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm, slab_common: Make the loop for initializing
 KMALLOC_DMA start from 1
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 6:26 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 9/10/19 3:26 AM, Pengfei Li wrote:
> > KMALLOC_DMA will be initialized only if KMALLOC_NORMAL with
> > the same index exists.
> >
> > And kmalloc_caches[KMALLOC_NORMAL][0] is always NULL.
> >
> > Therefore, the loop that initializes KMALLOC_DMA should start
> > at 1 instead of 0, which will reduce 1 meaningless attempt.
>
> IMHO the saving of one iteration isn't worth making the code more
> subtle. KMALLOC_SHIFT_LOW would be nice, but that would skip 1 + 2 which
> are special.
>

Yes, I agree with you.
This really makes the code more subtle.

> Since you're doing these cleanups, have you considered reordering
> kmalloc_info, size_index, kmalloc_index() etc so that sizes 96 and 192
> are ordered naturally between 64, 128 and 256? That should remove
> various special casing such as in create_kmalloc_caches(). I can't
> guarantee it will be possible without breaking e.g. constant folding
> optimizations etc., but seems to me it should be feasible. (There are
> definitely more places to change than those I listed.)
>

In the past two days, I am working on what you suggested.

So far, I have completed the coding work, but I need some time to make
sure there are no bugs and verify the impact on performance.

I will send v4 soon.

Thank you for your review and suggestions.

--
Pengfei

> > Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
> > ---
> >   mm/slab_common.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index af45b5278fdc..c81fc7dc2946 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1236,7 +1236,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
> >       slab_state = UP;
> >
> >   #ifdef CONFIG_ZONE_DMA
> > -     for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
> > +     for (i = 1; i <= KMALLOC_SHIFT_HIGH; i++) {
> >               struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
> >
> >               if (s) {
> >
>
