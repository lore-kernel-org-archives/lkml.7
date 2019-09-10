Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E749C4740C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F652084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJvhTiFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390738AbfIJA7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 20:59:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32860 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfIJA7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 20:59:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id g25so14350015otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 17:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsXKhS0XQfiMyJ7mpn68yj+pi0x2EB9djLY2PKEnIvE=;
        b=NJvhTiFVojZBMKp/UMfPBAcdGNpXPqcLf0l+uBgrLnIMN5Lb/QdwFjIZfVicukwWFB
         0BE0Y+Sg6WKACTgNtrnrQa/X3VChC2oACDmCmxD459s/W+xYAeus4fF5TZyW2b0UMzo3
         AokqCH7lHtfOqpzhG6lNtzaLHCY+vqKQTvaoID9hJcP42QZU0b49qjMFU27/HD1prwuN
         cF9l/F7lbMEB3j4/Sp9MMP2j0UrdTfhf/mVzkC5EKEfd48ApkUwlyu7MEfr14ZNnUh1f
         9GCjnUzgAi4/Zb6Bp8NLgbDeBtmQF/6zTxqr/uZo7U8A+ABkluT8xBMZRSwUuYwMeKSF
         BuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsXKhS0XQfiMyJ7mpn68yj+pi0x2EB9djLY2PKEnIvE=;
        b=q5LMzZ3zr7529z3wITwxQH0wPuX3oPKRoOyTze1STotju9QmtSGbjBer+/aVBzMeam
         Ra1uHcI6IpP3CmI5YvEiyqW/srYURPDuM/pzcP/rOy2dfjMaFKBvp8uihFZMvoMNQZ3j
         6c5V6e/9CfaQXmdNbpCtswe3MkH7+CE+Dyr7ljQnvkm7+uARW07uXGhC9yKcW9ZMTBL7
         n40ElPbw6qm/VeHA5BQ5Fm1jR95YrrgHxnRfLfdf0hSStCyHF1CZHHrWunJARJnxwIX4
         YRJLRl31ZeI26GB+bPvbpEEaIo+1NaiTtDDvsjQKYbpGlaEOQeUaKaJeau6RbDb5/8nu
         Wu3Q==
X-Gm-Message-State: APjAAAXdDLr6au2aK/z26DivGBfvxpryx3AMpelDMBbZ7+Hikt2X6le/
        vz40XXLP9QMoOGhnqO/fcZN8ee4pj9975+4FXEc=
X-Google-Smtp-Source: APXvYqzetzA+5LWgRCKMkAjNsWaMh6dQ5gbCFWCKiX+78NvMpP5hbC/YDfDw36hEGtXaINoGd7V4K3G55Mw6saIcHwk=
X-Received: by 2002:a9d:1ec:: with SMTP id e99mr17314668ote.173.1568077171489;
 Mon, 09 Sep 2019 17:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190909170715.32545-1-lpf.vector@gmail.com> <20190909170715.32545-4-lpf.vector@gmail.com>
 <20190909195955.GA2181@tower.dhcp.thefacebook.com>
In-Reply-To: <20190909195955.GA2181@tower.dhcp.thefacebook.com>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Tue, 10 Sep 2019 08:59:20 +0800
Message-ID: <CAD7_sbHgfNB-rYQ=uOGL14Pmf8VgChbnwh804r8LT_o73iH4Hg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm, slab_common: Make 'type' is enum kmalloc_cache_type
To:     Roman Gushchin <guro@fb.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 4:00 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Sep 10, 2019 at 01:07:14AM +0800, Pengfei Li wrote:
>
> Hi Pengfei!
>
> > The 'type' of the function new_kmalloc_cache should be
> > enum kmalloc_cache_type instead of int, so correct it.
>
> I think you mean type of the 'i' variable, not the type of
> new_kmalloc_cache() function. Also the name of the patch is
> misleading. How about
> mm, slab_common: use enum kmalloc_cache_type to iterate over kmalloc caches ?
> Or something like this.
>

Ok, this name is really better :)

> The rest of the series looks good to me.
>
> Please, feel free to use
> Acked-by: Roman Gushchin <guro@fb.com>
> for patches [1-3] in the series after fixing this commit message and
> restoring __initconst.
>

Thanks!

> Patch [4] needs some additional clarifications, IMO.
>

I will add more clarification in v3.

> Thank you!
>
> >
> > Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
>
>
> > ---
> >  mm/slab_common.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index cae27210e4c3..d64a64660f86 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1192,7 +1192,7 @@ void __init setup_kmalloc_cache_index_table(void)
> >  }
> >
> >  static void __init
> > -new_kmalloc_cache(int idx, int type, slab_flags_t flags)
> > +new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> >  {
> >       if (type == KMALLOC_RECLAIM)
> >               flags |= SLAB_RECLAIM_ACCOUNT;
> > @@ -1210,7 +1210,8 @@ new_kmalloc_cache(int idx, int type, slab_flags_t flags)
> >   */
> >  void __init create_kmalloc_caches(slab_flags_t flags)
> >  {
> > -     int i, type;
> > +     int i;
> > +     enum kmalloc_cache_type type;
> >
> >       for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
> >               for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
> > --
> > 2.21.0
> >
> >
