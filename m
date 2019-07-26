Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AAFC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A49522BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmprGLF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfGZXVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:21:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43600 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfGZXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:21:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so14616657qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 16:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ds6Pn84xnJTs59aQRjsfc8MfNMObGqVIqTNdYf6jDF8=;
        b=pmprGLF2LW0+Sp8wpilnKxyQ9fpy3RtVaI/uwKChRR6jU8kYntVB/SBwjs2iJ/Ef8t
         AgoaxKSIaFJe7S7BnUBMzaU5bXb26v3v8TOCHBgGl7orVWxAEikEx7zs9FYVRZ2Kuhq4
         LSTUWhQCKjMaQS5eEZ+BcJitwk4cPKvlrXSZDX1iHbS8B0nL0AA6pOZy4QXcTcQMysE5
         AythhYvQwGo01Exhcg+nMLtnS5XdBJBKrjciS0HpJOZvZWTfMOeSAbBRtlq3DFoVJ+4G
         xBuI0RwArlsSejlPmK0YyqwlQDzixITgfEA6xxl4awy3u7kqIvjgYTSSMEYLmZZ99w5Y
         y/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ds6Pn84xnJTs59aQRjsfc8MfNMObGqVIqTNdYf6jDF8=;
        b=GJLtpmIqKPKqXf8yiU6g5bEzUfUZ4q7HA1AB7P9RdOzbg7ZlMNe+a4DncyvVfO4cSo
         FEeE7Glxkdj7IKavPaQQuRpRewDMPG3+pexVR6rTJUTq6xDZz1U5sxGLdoghUjv71X8V
         p8vomGDOyXZjsl3wCNJT0g9o9lt0biz1oG8jBrlYvppWJiQspSO60LvJkDcNUblfeqkz
         osGhDQHYDKTL9ShW7vBJOrnimBsr1g4D25F+Hvpp7LNrDh2a2fXf/5dbcgPoJMLb/+lA
         ff64sPu2+v7SZcx5c2SQ1GzRzsRp2/diu1tAB3MkpEqUXxv5TqOI9N7dhCS+YeuWlhHs
         OQQg==
X-Gm-Message-State: APjAAAWrAmXyiQsUKtC1oc/RK3acLF+ih2d7RRaSLGqFLdjfxuhelMio
        xKsBx26rQv2N8JsirkxGWityxdlBwz4l4GRAG/Io
X-Google-Smtp-Source: APXvYqxKsvOaZxq1HqBf7Rf4YiQTcQkrpQGtj9XSIYZVHNSOdDHelqirkEJK9WTuzvgEgdBC2jX6zOfxq5cVBDabxl8=
X-Received: by 2002:a37:9ac9:: with SMTP id c192mr65323076qke.30.1564183268223;
 Fri, 26 Jul 2019 16:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190726224810.79660-1-henryburns@google.com> <20190726224810.79660-2-henryburns@google.com>
In-Reply-To: <20190726224810.79660-2-henryburns@google.com>
From:   Jonathan Adams <jwadams@google.com>
Date:   Fri, 26 Jul 2019 16:20:32 -0700
Message-ID: <CA+VK+GPC+akF0qGrKFivtNneweEfdC9uEx=QgmztB4M_xvMeKQ@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Fix z3fold_destroy_pool() race condition
To:     Henry Burns <henryburns@google.com>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 3:48 PM Henry Burns <henryburns@google.com> wrote:
>
> The constraint from the zpool use of z3fold_destroy_pool() is there are no
> outstanding handles to memory (so no active allocations), but it is possible
> for there to be outstanding work on either of the two wqs in the pool.
>
> Calling z3fold_deregister_migration() before the workqueues are drained
> means that there can be allocated pages referencing a freed inode,
> causing any thread in compaction to be able to trip over the bad
> pointer in PageMovable().
>
> Fixes: 1f862989b04a ("mm/z3fold.c: support page migration")
>
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Jonathan Adams <jwadams@google.com>

> Cc: <stable@vger.kernel.org>
> ---
>  mm/z3fold.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 43de92f52961..ed19d98c9dcd 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -817,16 +817,19 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
>  static void z3fold_destroy_pool(struct z3fold_pool *pool)
>  {
>         kmem_cache_destroy(pool->c_handle);
> -       z3fold_unregister_migration(pool);
>
>         /*
>          * We need to destroy pool->compact_wq before pool->release_wq,
>          * as any pending work on pool->compact_wq will call
>          * queue_work(pool->release_wq, &pool->work).
> +        *
> +        * There are still outstanding pages until both workqueues are drained,
> +        * so we cannot unregister migration until then.
>          */
>
>         destroy_workqueue(pool->compact_wq);
>         destroy_workqueue(pool->release_wq);
> +       z3fold_unregister_migration(pool);
>         kfree(pool);
>  }
>
> --
> 2.22.0.709.g102302147b-goog
>
