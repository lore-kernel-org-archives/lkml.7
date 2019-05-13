Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21AAC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4E52085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UosvtbuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEMVlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:41:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37924 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEMVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:41:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so755106wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ml5e5SvV7EOXRrwnyGezErXhiPZR2O3UcJlBIK9a7mo=;
        b=UosvtbuZOLfQWGbKAQSLNFzjqFu3HvMBi5n+MqvZEiZslVZprGN96XE7HylDEqUC3r
         zoypEsCeENepF6lXHlmeXeZjlgQW4x0nXWC9YSFOuVB0jU1Zyw6D63GOiOogO0TOjqtz
         2MQ8cls6nIG+Qs/TsdmbKKaOTp0IaYsGZYQPx1M60qG4eyUJN1Bg4nAChBB0qrhv7wsw
         EQhm9P4A6fGQ0Xrb4+FFDjWuCM6u7RB6RYEjPyHBHk6sRDf3uFEugFKqGIFenMV9GKRS
         D/I1WM9P3h7Pq62/A+StGZuE06uqmrNlh0fY6CQLdV5DQlf/P11WFdTHFCqybRqPOaOw
         386g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ml5e5SvV7EOXRrwnyGezErXhiPZR2O3UcJlBIK9a7mo=;
        b=Ulla8MRvGR04KDVhKElNUBAXhHrDUsXzn9FSI76CFc9q2IBbPCTv8t+toJRaFPOM3Q
         j9b7Xmyq0Xh51kb2EzX+8qozQUms4gIxsjnFf9RQW8vg43QiJJfHpiwMKmvqAKerNFhf
         qI2Mg56kconJah0vpOWVpLSQV1DFvMirTwZlBKEEaJhW/Ltzzox1Ut9V1vvObZnfJ33T
         N6nOEsHGDYl+NX5RBAfqhwjtVdkW+uoV7m+aZLYvE1wdPJBtI85pBSbcK3OdHYoBJwAh
         g20ciUPRkd+FgUg0+EliowdGbUyQL0BuZf5YCAFk5Q6BEzGG+nV5eiTlD5+LDp/TEcCP
         dQ9A==
X-Gm-Message-State: APjAAAWTC07UtousUFkkljDBdTvp96xzbJplKOAJ6jV5rSDGoqpEdaDz
        eW6kz3VoCMc5KWdTZ+9JtQdggaVuZX2ZcjL6NQ8=
X-Google-Smtp-Source: APXvYqzni/E4Dhvw7yCFu+XIF07MLzzgBIFhXwcHPfbgbZQhGJijxeMMpKzr+DBWZG8wOsVvfiuS0fKSfYBvgleclrc=
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr8053477wmk.103.1557783670098;
 Mon, 13 May 2019 14:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190510032144.15060-1-yuehaibing@huawei.com>
In-Reply-To: <20190510032144.15060-1-yuehaibing@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 13 May 2019 23:40:58 +0200
Message-ID: <CAFLxGvz4awNWpnb_hFxwpYy4X_w6Z6+aLqUZ5Zxu6fJKXsbJ9A@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Fix build error without CONFIG_UBIFS_FS_XATTR
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 5:22 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix gcc build error while CONFIG_UBIFS_FS_XATTR
> is not set
>
> fs/ubifs/dir.o: In function `ubifs_unlink':
> dir.c:(.text+0x260): undefined reference to `ubifs_purge_xattrs'
> fs/ubifs/dir.o: In function `do_rename':
> dir.c:(.text+0x1edc): undefined reference to `ubifs_purge_xattrs'
> fs/ubifs/dir.o: In function `ubifs_rmdir':
> dir.c:(.text+0x2638): undefined reference to `ubifs_purge_xattrs'
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 9ca2d7326444 ("ubifs: Limit number of xattrs per inode")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/ubifs/ubifs.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index 379b9f7..fd7f399 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -2015,13 +2015,17 @@ int ubifs_xattr_set(struct inode *host, const char *name, const void *value,
>                     size_t size, int flags, bool check_lock);
>  ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
>                         size_t size);
> -int ubifs_purge_xattrs(struct inode *host);
>
>  #ifdef CONFIG_UBIFS_FS_XATTR
>  void ubifs_evict_xattr_inode(struct ubifs_info *c, ino_t xattr_inum);
> +int ubifs_purge_xattrs(struct inode *host);
>  #else
>  static inline void ubifs_evict_xattr_inode(struct ubifs_info *c,
>                                            ino_t xattr_inum) { }
> +static inline int ubifs_purge_xattrs(struct inode *host)
> +{
> +       return 0;
> +}
>  #endif
>
>  #ifdef CONFIG_UBIFS_FS_SECURITY
> --

Applied.

-- 
Thanks,
//richard
