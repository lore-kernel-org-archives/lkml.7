Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D473C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4700F2606C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOfp6xAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfE3FVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 01:21:37 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45258 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3FVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 01:21:37 -0400
Received: by mail-ua1-f68.google.com with SMTP id n7so1995723uap.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 22:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8Kqu9XhDk4eyHxJOCvnDVEeURLn9nIM7WXDv7rJ8RQ=;
        b=nOfp6xAb07c7fhTyEPViJQwkSTSfmWU/+klmqnkI9vWOtbvMhwszY6GFh6ufjBdu7g
         lpAq4QP0/Cufz4WaULPfWsua/GesqDG2HDvXk+NuUgfQhTvzxOdjgBniDIDnyRqY+4fc
         An+1RHMH7FDXq/dua0p+KM1Wew9m4jHnfDye9QEjShQPodvTTw4FEv0fxvn2El8x5kYE
         u7wJAhoUmz/cK93kAVTxiCQyxdHucxSw2pHYN8eV3W/n4u9DHZgjW8VbNnVhqIJV20Tq
         LXlRJ1w0Pc3GwDkob5jfDxszTaaQka77OPeVhsoOcZ8gO8m8HX1jb2INfcKGvedR7Q4R
         6U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8Kqu9XhDk4eyHxJOCvnDVEeURLn9nIM7WXDv7rJ8RQ=;
        b=aHTLdNLI23rNYSBbW7bAFj8YpnjvMyCYb34FXjmhcHuhKoEKXlI/yH5J/uSKhFcg+A
         bdjKaOZlUbqwUq0Nb/fGwfVctc3WZrfacFQmtTUg/NmDoxoOBgd8vXFcnA5TkE+MFf+G
         uUWI0RHHa0ZqOGjiQrybREIMZ9m0dZiI1IRmVGYGS+4AI6VsT29g1Ut3aabwsfGIp3wn
         qVsLt7vLg3F7XEpmbyt5g2FfutRkA7Sab3erF43aJYymeSy480Eoj8opPjbaZFv7QN6G
         whp6+UY1ORvDcxf1fvD/KfAwqDYww1y8MzL2fxRprw7qQ6PcxqAw/7u1l93+qUxHhI5Z
         4N0g==
X-Gm-Message-State: APjAAAUNF2s9ExcGqL6xVedUKR3xh95iB+tP5u34K+TghWZ9SS1qIvmE
        Kuj0scs5mQPTKZHtjhL3WNI7zMpbs1trhVRcMcw=
X-Google-Smtp-Source: APXvYqyBATh4neWGs74AqOJks4aL5K6flzPg8l6Xjw6Lgiu2KpqI9R909KkBWb43GnuU+RKAbdUiztE2zTdgEAImfno=
X-Received: by 2002:a9f:3241:: with SMTP id y1mr886824uad.107.1559193696177;
 Wed, 29 May 2019 22:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com> <20190529194852.GA23461@bombadil.infradead.org>
In-Reply-To: <20190529194852.GA23461@bombadil.infradead.org>
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
Date:   Thu, 30 May 2019 13:21:23 +0800
Message-ID: <CAFbcbMAKOSjZzCumK3iGxBGL1Bjf+Qx==87F8A9xPBy5msj+Dw@mail.gmail.com>
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in kmalloc_slab()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, i think your suggestion is ok.
in my previous method is easy to understand for spectre  logic,
but your suggestion is more sense to use of array_index_nospec.



On Thu, May 30, 2019 at 3:48 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, May 29, 2019 at 08:37:28PM +0800, Dianzhang Chen wrote:
> > The `size` in kmalloc_slab() is indirectly controlled by userspace via syscall: poll(defined in fs/select.c), hence leading to a potential exploitation of the Spectre variant 1 vulnerability.
> > The `size` can be controlled from: poll -> do_sys_poll -> kmalloc -> __kmalloc -> kmalloc_slab.
> >
> > Fix this by sanitizing `size` before using it to index size_index.
>
> I think it makes more sense to sanitize size in size_index_elem(),
> don't you?
>
>  static inline unsigned int size_index_elem(unsigned int bytes)
>  {
> -       return (bytes - 1) / 8;
> +       return array_index_nospec((bytes - 1) / 8, ARRAY_SIZE(size_index));
>  }
>
> (untested)
