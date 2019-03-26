Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D540C2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtlyFWbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfCZLhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:37:24 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54164 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:37:24 -0400
Received: by mail-it1-f195.google.com with SMTP id y204so4686510itf.3;
        Tue, 26 Mar 2019 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nYa4+fsAkS74VZ5Qo0Tv1Q6m3DqdUqGN/BlWyh7nRU=;
        b=PtlyFWbLH3NBoTRHkSphldFDn2wLd1/r34ELBH42ynSowQ/asQw8pdyPAhqrq/LYsO
         L/I2A7Zjjc34MiUBGSczOMrJrI8AUTnaxOPAfmW5L0q0UePoiYOcQ4/ds2HHcm5bdbVM
         TorpoxQyxLA0COidcQ+127YgLiSVQ2F17wGinnAq3PunU///gLVW1O023dTe13raL7YZ
         TOZn8Fl4aqpGqM8Wi/00Ya2H1f/K+tYh0+pOA4DA5iTa9s7crNFWZlhUxMZNmk8iEbQ7
         crr3/pLotmCtDu5sPVncuYO+dC7k+4lkAg+PYgImEQ25/hrSytu5u96Nz1Z+GBpgtIt8
         kuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nYa4+fsAkS74VZ5Qo0Tv1Q6m3DqdUqGN/BlWyh7nRU=;
        b=eapWfyqmvJNQOSO1GzZ2H6tEDUIqB48G7++Jv42Ox/CAT696grhfLbbcqsqNLiwwMw
         KePBGrjio79qF8c9iuu5Lgvh1imnDFbmBUmlm9xswMG4/XZ2DJUq+vYd1/VIqC8wpwuK
         9n7Jbm5CTTRWnsIulRI/XLRFsu0emPwbcs/iMuAuVvHCpZEsCN9zZBg523q33FFRUDhJ
         V5xkHWXeN/hCTjNIB3gvLt1q9anHvDICAKZ37U1a3rT8cocQ+M+IbOOriehGH0J52xUU
         YKSXvrlnJH9/O0W+ZTNnWBbxE7uxoJGL2Q1vDFFGDdTUTWDUrYUs5tCyQ/db9RK7rlJm
         tXKg==
X-Gm-Message-State: APjAAAU/m9y/FXF0iYM6F2voug42YGqCtxmf0c7hlKoG04NMwLRsgblh
        EIhRXB5bY4IfxRV5DfoEJkdXooz+QhMiatSyTKkfjWk1
X-Google-Smtp-Source: APXvYqwiOjGDlD23o50/F+pST+/SbKPXoFZu4qbf/29d6lUPNsGV/aWPJl58CEboNda974CnIsotSw4x3SMk9A/6MaA=
X-Received: by 2002:a24:56c2:: with SMTP id o185mr14653142itb.57.1553600243291;
 Tue, 26 Mar 2019 04:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com> <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk> <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk> <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
 <20190325233731.GS2217@ZenIV.linux.org.uk> <20190326013858.GU2217@ZenIV.linux.org.uk>
In-Reply-To: <20190326013858.GU2217@ZenIV.linux.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 26 Mar 2019 12:38:40 +0100
Message-ID: <CAOi1vP_n5OxtEDHs-+YLGf+AMDt9_WrnGPf8T6eBzfwGjSkjAQ@mail.gmail.com>
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

On Tue, Mar 26, 2019 at 2:39 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
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

Al, I see you directed this patch at Linus instead of ceph-devel.
I can pick it up for -rc3 as I have an important libceph fix pending
anyway.  Let me know if you want me to handle it.

Thanks,

                Ilya
