Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE8FC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AB321994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S58mOK6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfGZWxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:53:30 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:32784 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGZWxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:53:30 -0400
Received: by mail-yw1-f67.google.com with SMTP id l124so20868318ywd.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8/4TDGoTP0YJOmmNh1QY5sjP7utSN3T4GKeg0uRKkI=;
        b=S58mOK6kmyfjaqk1fnTJ++/++kcxrVvJPN9KcacKz65Ijo+9nbPY62HM1CffSp86Gu
         /dPN5MfoF9x3qzmvRf4i/6AryZbuh86DENdsSJKo1zLveUuyHt3BmI5KngT42emGLpRg
         LfE5/fDELYjpJFgZ6/3aEWoIOYp7eIVl/VMYJO3P6dhqng+w41uZfFsmu2hMSxMur74E
         cjujptrMLPPTtmOt4Ya3Uv+rKDOFMywYfHOEFwqVFz7D2oHaFLDQNzYLJ324mImcBbId
         h3rDRv/vOKwwLN7nnncz9jasy9fPT3hIXPkkvg9QeXHJnJnt2ZVEQ6gEW6zaDfc0rSja
         EY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8/4TDGoTP0YJOmmNh1QY5sjP7utSN3T4GKeg0uRKkI=;
        b=mu/Dr/xDseszRRSSvzuOV4bWp/p1QyGargMAjGaDQsQEhMtSUza/6VkE7y5y2wOnc+
         pqnvVf9UTCPcYhJasy6H0TUMqBfKnMPVVf94lQ5RcaLrHypj9EOTaOoba4nHj8MzBhh4
         yD0v8p4AzOIBTDpW3jlvdfWQ8GtSjujRu51UN7NA/SqtZa7DlzIRnVg6vYbe83F+FniF
         36+QvgwBpqgM5RbgOstIiRKKupd4SmGQOZkaa/k3Hx313NtNHm867SrvyKbijJwTylyl
         1WbdctPTQ1X2IIBd8+Kv0HIcOo1QrLqRv8WQI1S2U4TAGAz3qDmkosTphQxOQhGZie0S
         DfCg==
X-Gm-Message-State: APjAAAVIhtfWwIZmWBQ74Vl0S9tMZ4Dh4BsHlGEf+CrPk7iWJ1uLTnUf
        pfr0fG6lq/MTptmwyapPNtDhTvJU1X3BbeArbHdwDQ==
X-Google-Smtp-Source: APXvYqzNhimbC8mzTJcKYV0Wi6pTpAOpfQ/Ahx7/RLFgCd5sUCIjXXqqjCww0QbPgslVApm1LWoPGyUTAhbML+xsfXs=
X-Received: by 2002:a81:19c6:: with SMTP id 189mr57026739ywz.296.1564181608700;
 Fri, 26 Jul 2019 15:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190726224810.79660-1-henryburns@google.com>
In-Reply-To: <20190726224810.79660-1-henryburns@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 26 Jul 2019 15:53:17 -0700
Message-ID: <CALvZod7Q_86F=aH6zP0TRFZ_6N5e2oFnjoSTPv=mcAdi0HEg3A@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Fix z3fold_destroy_pool() ordering
To:     Henry Burns <henryburns@google.com>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Adams <jwadams@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
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
> If there is work queued on pool->compact_workqueue when it is called,
> z3fold_destroy_pool() will do:
>
>    z3fold_destroy_pool()
>      destroy_workqueue(pool->release_wq)
>      destroy_workqueue(pool->compact_wq)
>        drain_workqueue(pool->compact_wq)
>          do_compact_page(zhdr)
>            kref_put(&zhdr->refcount)
>              __release_z3fold_page(zhdr, ...)
>                queue_work_on(pool->release_wq, &pool->work) *BOOM*
>
> So compact_wq needs to be destroyed before release_wq.
>
> Fixes: 5d03a6613957 ("mm/z3fold.c: use kref to prevent page free/compact race")
>
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> Cc: <stable@vger.kernel.org>
> ---
>  mm/z3fold.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 1a029a7432ee..43de92f52961 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -818,8 +818,15 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
>  {
>         kmem_cache_destroy(pool->c_handle);
>         z3fold_unregister_migration(pool);
> -       destroy_workqueue(pool->release_wq);
> +
> +       /*
> +        * We need to destroy pool->compact_wq before pool->release_wq,
> +        * as any pending work on pool->compact_wq will call
> +        * queue_work(pool->release_wq, &pool->work).
> +        */
> +
>         destroy_workqueue(pool->compact_wq);
> +       destroy_workqueue(pool->release_wq);
>         kfree(pool);
>  }
>
> --
> 2.22.0.709.g102302147b-goog
>
