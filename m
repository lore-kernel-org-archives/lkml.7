Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032ABC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DA522BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0efhXeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfGZVKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:10:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39396 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfGZVKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:10:30 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so107644775ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnFsEo54QQCUj7cKXF+4BGmh5A92hzW17n6M7jlYUc0=;
        b=J0efhXeSqIUk7WkBdOyv4VzzdnTeBgFVPjWAZe5wML9pAmd1SbqhR4oq66HWtOqUJU
         2712cWU2K32JLLUedtqpPz+8xMM2Wa+pMNGDyxeOs8f35KCXzq5SXBgjpc+JFQyskZVp
         A2y98FWuywv+ypUeMd0Dk5/2FbSSTdv/vkv2PxAB1Dp/djLa6qRapUKsRhQhbNVJGMUx
         HTgThLjpxOdu+6GthZrTfiIUagwZ0b/SKUru19GOCcdaAK/nLgXfJFZbzq92JvIXidX5
         RJj4OpOG5GuTmNCqpQ9h0UkJGotM2gtIPpBiX88lkuV03qQ98felCFHcPBBA2Nm+gi1Z
         59zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnFsEo54QQCUj7cKXF+4BGmh5A92hzW17n6M7jlYUc0=;
        b=Uff+5qBI+24vUu1+IbJPZ2Y8oO/DwDw8KkyFkGSFUlZCnWWWJTLqGyh4TPLeh5Wy4T
         752v5RXwak1G77dZwmyFXzJFpMq4xukpSomgoTf2p6h5tS8UX8W50ysa5mbWwKfVQQIv
         CvNm0F8QmWtgr+uTZL4p+BM82FgUWCK7VwOwxSvBDllZivB75ov5RsYrDMtJHxWrgJDS
         GRedJWOy0clqVLIAn00O086c7T95Qeh5HlbgPVBShsQ2Hwg4FceIAj9XDxwTbvIVbaej
         wm3Kjz6GFiPVIVOgIhdup0rtY45nJSgD3mYafa4Tujps0SaBP9My38BNgebiDyPX6T93
         nXGw==
X-Gm-Message-State: APjAAAU8wxnW0+Aey1QDZSQB3cMey1XZvohkec0W4JG4/WB8/Fpyy288
        eu2tnDhKuNZO35vdMs+OdU6Bw8MJYQbY9HLWE5I=
X-Google-Smtp-Source: APXvYqwCY2wDc1hmXYnJZNoj6DLIuQys/RphK6WMSWlX/M3S6waa0t3YkBmQ3MMP1SIV4lt841KTJFqYoFyiTmFdjjA=
X-Received: by 2002:a05:6602:2256:: with SMTP id o22mr3863805ioo.95.1564175429170;
 Fri, 26 Jul 2019 14:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190726210137.23395-1-willy@infradead.org>
In-Reply-To: <20190726210137.23395-1-willy@infradead.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 26 Jul 2019 14:10:18 -0700
Message-ID: <CAKgT0UcMND12oZ1869howDjcbvRj+KwabaMuRk8bmLZPWbJWcg@mail.gmail.com>
Subject: Re: [PATCH] mm: Make kvfree safe to call
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Henriques <lhenriques@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cmaiolino@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 2:01 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Since vfree() can sleep, calling kvfree() from contexts where sleeping
> is not permitted (eg holding a spinlock) is a bit of a lottery whether
> it'll work.  Introduce kvfree_safe() for situations where we know we can
> sleep, but make kvfree() safe by default.
>
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Luis Henriques <lhenriques@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

So you say you are adding kvfree_safe() in the patch description, but
it looks like you are introducing kvfree_fast() below. Did something
change and the patch description wasn't updated, or is this just the
wrong description for this patch?

> ---
>  mm/util.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/mm/util.c b/mm/util.c
> index bab284d69c8c..992f0332dced 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -470,6 +470,28 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  }
>  EXPORT_SYMBOL(kvmalloc_node);
>
> +/**
> + * kvfree_fast() - Free memory.
> + * @addr: Pointer to allocated memory.
> + *
> + * kvfree_fast frees memory allocated by any of vmalloc(), kmalloc() or
> + * kvmalloc().  It is slightly more efficient to use kfree() or vfree() if
> + * you are certain that you know which one to use.
> + *
> + * Context: Either preemptible task context or not-NMI interrupt.  Must not
> + * hold a spinlock as it can sleep.
> + */
> +void kvfree_fast(const void *addr)
> +{
> +       might_sleep();
> +
> +       if (is_vmalloc_addr(addr))
> +               vfree(addr);
> +       else
> +               kfree(addr);
> +}
> +EXPORT_SYMBOL(kvfree_fast);
> +
>  /**
>   * kvfree() - Free memory.
>   * @addr: Pointer to allocated memory.
> @@ -478,12 +500,12 @@ EXPORT_SYMBOL(kvmalloc_node);
>   * It is slightly more efficient to use kfree() or vfree() if you are certain
>   * that you know which one to use.
>   *
> - * Context: Either preemptible task context or not-NMI interrupt.
> + * Context: Any context except NMI.
>   */
>  void kvfree(const void *addr)
>  {
>         if (is_vmalloc_addr(addr))
> -               vfree(addr);
> +               vfree_atomic(addr);
>         else
>                 kfree(addr);
>  }
> --
> 2.20.1
>
