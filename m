Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A1BC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B99322BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEGHfnb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfGZXUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:20:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36146 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfGZXUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:20:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so54308197qtc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuNOArHZs/CiCRyKyjlclGYC7Ncl5iJJmT+ESUl6jAA=;
        b=kEGHfnb+ky7mAtpgS94T1BlDhXrjAF9XMpWdm7fL5wWt0lI7aJD3/bimEU3aictx5/
         /FVoxvjWSJOsaau/ArFWCvjl3UvCYt0UKuqbV3FAYijG3r3NaxbYAKdIv1U91mIBuOWl
         kovT+dhR3I24/oGuwK8rnhXVMwHQc2af+OjHNTY8E16Znr5UlJcLtWNs1/2WObenCUL6
         0XF23LaWT12L30puEcM9OgpjsfeZcqTR9sQGgi8O0ELN4Rr38CxkxB+JwiB78TG4CrBN
         8pld23xKRXm20Xxzwcz/LE4LBTuO3cSd5KZ05jAqnl4jlavcMrtBsfAUmwQu1m8TlvJn
         qLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuNOArHZs/CiCRyKyjlclGYC7Ncl5iJJmT+ESUl6jAA=;
        b=JJ9hM3pTKsnc8fu5sAhGALSg1NB+mY+gglgiWIu1JeAUtl8DUjZVFMN5iXmKLmtVyI
         FtyzI+JIzVYcBz/HdxKCeKd7UQieIeBlYLRaC3uwePtpYKDxM2VxQL4Go1/oMDCj/nZV
         Q94pQNc4Wbe8ZCdou3tWReT/OPosieuRMbd+GJ1iza1Cq0fpTxQYAwOAu3RnVnJTAKTG
         kvJp+Fzb1HYFncfNmpCB9PV/FkOQPooBZy9vl6EqFsB4FayOgY00ubpHh/cXsBfzLQCN
         2z4MGI/mgcFBE8MCQLNruSWqbJJtfEWHJ8dAzNsUZS7r0lcveFyXl4HbbTgi4EYa9Tgm
         aayA==
X-Gm-Message-State: APjAAAXJDRpHGdtl3Tdn8d9yVx6WSvXRnOK/pU/onCiI3MzJoNFyAoto
        sTqCIkDe6R91U3AuBKIrSv29NcSeru/VKVpRmmO1
X-Google-Smtp-Source: APXvYqz0xh0QBYyY/zS/kJUsfUUaNRgWxOlmqjlpIVRroO/0xl0eD/u8MIKEBwL+baTN5sYIunTa2DIgnA074DTtHAM=
X-Received: by 2002:a0c:b12b:: with SMTP id q40mr71961348qvc.0.1564183221451;
 Fri, 26 Jul 2019 16:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190726224810.79660-1-henryburns@google.com>
In-Reply-To: <20190726224810.79660-1-henryburns@google.com>
From:   Jonathan Adams <jwadams@google.com>
Date:   Fri, 26 Jul 2019 16:19:45 -0700
Message-ID: <CA+VK+GM4AXrmZtv_narEU6pHO+NGrTc74iSSUNNbutZySfXjRw@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Fix z3fold_destroy_pool() ordering
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

Reviewed-by: Jonathan Adams <jwadams@google.com>

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
