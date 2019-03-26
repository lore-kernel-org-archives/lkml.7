Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7A6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545C320857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poochiereds-net.20150623.gappssmtp.com header.i=@poochiereds-net.20150623.gappssmtp.com header.b="gke/Twgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfCZKll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:41:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42483 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZKlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:41:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id x61so4621388edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDthmkeOr4vGkpJrbQSz9Z+BEbXFb8ELBhBxp7/lZDY=;
        b=gke/Twgzw1nfJHyBwDCvhTtV5TF9nGiuavLmLgH1oPYcOC4/RtezO9OeTWv1LyKLdd
         tHYyvDLiudLauj89yJdppuz7Q4TuFcLCKzzSfVYkwOljOgOiExoptpVZ7JWF2I6PkxdO
         WdFnUjbtEQmxReswUx6MLOjWl0hrvye4HYUPul2thCAfsih9pWSMr9KPoCqv7nUJ83j2
         uOjJG8ImMO/Wd1e9VX39CBCrFUhMCQQQL9Vv8xrntyx4Mtclyu1v4G4dqXUcuNI4sQV+
         Ds4RaLVy/9I533bp0AehPB1yrAYKAVbFTbw4R/A8bzb0L1LWaI1h+dKib3lvDLvvgLwJ
         Inwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDthmkeOr4vGkpJrbQSz9Z+BEbXFb8ELBhBxp7/lZDY=;
        b=rivUiJzjHggderc9H/xcR3Blvk3BIvymdKt+pltrUqO+aHhU6/bi3kUsdGfxAtj0Ts
         BE0/OB1xVOOpY5ch2sqwkK1CmptJ0mTCuao15EU7C7K98lLSvkU+cTCzw1rI/UBoS5z2
         tzqsgAxDzbfv16TN8yhR4X2+WnrX/xrMf/2qlhsVbyD8EFhW7uyaK9ttfpGzi2V4/36F
         Sx1dvIG/HNHezN8BiJXk/487szEXPgYA7jY1YkuCHvvPCfw6amXC9zW6tpVeYB5Ly5SS
         NG4s/MRgWjXCCV78/fF4QGqGWHZT0F6LwWUXB10niIHy/NsLiUogk+d4yNpn7gBabdXy
         GJZQ==
X-Gm-Message-State: APjAAAUkYWgjTsmBrj1pUzLav6flFeugA6UA7aZOlBJNQRyPd6XZHKd5
        txFnNgrYjgRxlxHAHd2rKJVLL4luwFyoQBnw5QeSlA==
X-Google-Smtp-Source: APXvYqzGNrM8034l9dOsI86FTN6adPprlcKi+HQbhenKhX1QljF5rql3IFG+PGZELhEXhCLn+pLAYPbYY2tRJCgfToY=
X-Received: by 2002:a50:b6f2:: with SMTP id f47mr20327881ede.240.1553596898704;
 Tue, 26 Mar 2019 03:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com> <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk> <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk> <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
 <20190325233731.GS2217@ZenIV.linux.org.uk> <20190326013858.GU2217@ZenIV.linux.org.uk>
In-Reply-To: <20190326013858.GU2217@ZenIV.linux.org.uk>
From:   Jeff Layton <jlayton@poochiereds.net>
Date:   Tue, 26 Mar 2019 06:41:25 -0400
Message-ID: <CAOhYWNLVMrG_ddvddrbjpAgYKuY+sPtdBk5ja6HFmW2qOeUENA@mail.gmail.com>
Subject: Re: ceph: fix use-after-free on symlink traversal
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 9:39 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> free the symlink body after the same RCU delay we have for freeing the
> struct inode itself, so that traversal during RCU pathwalk wouldn't step
> into freed memory.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index e3346628efe2..2d61ddda9bf5 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -524,6 +524,7 @@ static void ceph_i_callback(struct rcu_head *head)
>         struct inode *inode = container_of(head, struct inode, i_rcu);
>         struct ceph_inode_info *ci = ceph_inode(inode);
>
> +       kfree(ci->i_symlink);
>         kmem_cache_free(ceph_inode_cachep, ci);
>  }
>
> @@ -566,7 +567,6 @@ void ceph_destroy_inode(struct inode *inode)
>                 }
>         }
>
> -       kfree(ci->i_symlink);
>         while ((n = rb_first(&ci->i_fragtree)) != NULL) {
>                 frag = rb_entry(n, struct ceph_inode_frag, node);
>                 rb_erase(n, &ci->i_fragtree);


Reviewed-by: Jeff Layton <jlayton@kernel.org>
