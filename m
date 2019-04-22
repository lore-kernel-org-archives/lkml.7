Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF88C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398D520896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="DguHjcrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfDVVOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:14:32 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44719 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfDVVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:14:32 -0400
Received: by mail-yw1-f68.google.com with SMTP id j4so818621ywk.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDG1TlGaIw/jGoHer0X2bLXN1IidWL9FPwlKl2mLgYY=;
        b=DguHjcrXVPPtqQsEP9JJDjy8EAznfewC5eSgMz9ldZDNyQfibNIhw0N0Mj1wjNsJQN
         qOhwivwmXrswlWzkTXIHD62GvaM7tazEugTUhpUKioEdq7D8x4/TAFr/pznvMrEqgmAQ
         zOR+2s80C+b3wUJ429eZKhnwo2URBcStcYP5t+18z/rirHYAoGMQwFhF3I0nP61mB7Uw
         g9rrl3qr0K9PzFtODI2WbJpWQZ4ayiVTzysUm/tHOPhU+T95tukSlaySe5oEKPMYm1eb
         8PZgKkHm6RF/tdOuye5GdEOwhOo6dXHMvUTs+7DU9rq5bEigUG4gN3EMii7t8rJlKIQ6
         4f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDG1TlGaIw/jGoHer0X2bLXN1IidWL9FPwlKl2mLgYY=;
        b=o/JDPY1Ncjc3P11wG6qzNO32JlwQf3aecUtpQCgbrA/JLUOgaFhMC2zwV+EaTJQns3
         lDv0fawlHOGtLCxLxOYlepsOAFVlzqggNPExi350gQa+AASNhsHXRLRD/3EnlJZ+iC9e
         F5hJRcaiJLGUBuhhNeliRVyzUm49hzQE/iDe2sk4EwhZrfdgIWYqHfVkTlKsc6ZNIaEq
         RIdQBaSubfGG+5EaWqPYrkgdTVvHhgCNkBovcTKk7YNC79qcgnq8ttZPtgEX7Rmj53hS
         33LMm0tZ3R/zQvEByi0ZRUapS8fQwIiQwDfOK9KmvsMkeidlwnWtkkgZICSZepWHs1XL
         AtdA==
X-Gm-Message-State: APjAAAXgj62LzqxEtfXZr8N7AhIDbXewd8s3sK1rddSdot2Min00ac25
        pe1jcMcrB1zLEFGH28554G1eE+wNCxEmlH5aEs6KmaPmMXGZ9Q==
X-Google-Smtp-Source: APXvYqyhmufg9dd/jQB8ki5yG2y9ch87uLhc6cWH9AhZqn1ROhOGyvTvjwtgIElF3ENZPl0yNdeQeHgQWprz0WcDTaE=
X-Received: by 2002:a81:3ac7:: with SMTP id h190mr17860496ywa.351.1555967670792;
 Mon, 22 Apr 2019 14:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190416174900.GT2217@ZenIV.linux.org.uk> <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-60-viro@ZenIV.linux.org.uk>
In-Reply-To: <20190416175340.21068-60-viro@ZenIV.linux.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 22 Apr 2019 17:14:19 -0400
Message-ID: <CAOg9mSQppnRWPnSg9eAm0NeW3XEm0LZ74Aw651QTBx0Gm1jpQA@mail.gmail.com>
Subject: Re: [RFC PATCH 60/62] orangefs: make use of ->free_inode()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Martin Brandenburg <martin@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al...

I applied your "new inode method: ->free_inode()" and
"orangefs: make use of ->free_inode()" to our pagecache
branch (I hope to get it pulled in the next merge window).

I had to modify your "orangefs: make use of ->free_inode()" a
little, since Martin Brandenburg had already modified orangefs_i_callback
for the pagecache branch. I don't know for sure that my modifications
aren't nonsense :-) but I do know for sure that everything runs
with no xfstests regressions. I'll see what Martin thinks about
my changes...

orangefs_destroy_inode is pretty much a no-op now, so I guess
we'll get rid of it...

Acked-by: Mike Marshall <hubcap@omnibond.com>

Thanks...

-Mike


[root@vm1 linux]# git diff HEAD^ fs/orangefs/super.c
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 8fa30c13b7ed..f82ac9373443 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -125,20 +125,18 @@ static struct inode *orangefs_alloc_inode(struct
super_block *sb)
        return &orangefs_inode->vfs_inode;
 }

-static void orangefs_i_callback(struct rcu_head *head)
+static void orangefs_free_inode(struct inode *inode)
 {
-       struct inode *inode = container_of(head, struct inode, i_rcu);
-       struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
        struct orangefs_cached_xattr *cx;
        struct hlist_node *tmp;
        int i;

-       hash_for_each_safe(orangefs_inode->xattr_cache, i, tmp, cx, node) {
+       hash_for_each_safe(ORANGEFS_I(inode)->xattr_cache, i, tmp, cx, node) {
                hlist_del(&cx->node);
                kfree(cx);
        }

-       kmem_cache_free(orangefs_inode_cache, orangefs_inode);
+       kmem_cache_free(orangefs_inode_cache, ORANGEFS_I(inode));
 }

 static void orangefs_destroy_inode(struct inode *inode)
@@ -148,8 +146,6 @@ static void orangefs_destroy_inode(struct inode *inode)
        gossip_debug(GOSSIP_SUPER_DEBUG,
                        "%s: deallocated %p destroying inode %pU\n",
                        __func__, orangefs_inode, get_khandle_from_ino(inode));
-
-       call_rcu(&inode->i_rcu, orangefs_i_callback);
 }

 static int orangefs_write_inode(struct inode *inode,
@@ -316,6 +312,7 @@ void fsid_key_table_finalize(void)

 static const struct super_operations orangefs_s_ops = {
        .alloc_inode = orangefs_alloc_inode,
+       .free_inode = orangefs_free_inode,
        .destroy_inode = orangefs_destroy_inode,
        .write_inode = orangefs_write_inode,
        .drop_inode = generic_delete_inode,

On Tue, Apr 16, 2019 at 1:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/orangefs/super.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
> index dfaee90d30bd..3784f7e8b603 100644
> --- a/fs/orangefs/super.c
> +++ b/fs/orangefs/super.c
> @@ -124,11 +124,9 @@ static struct inode *orangefs_alloc_inode(struct super_block *sb)
>         return &orangefs_inode->vfs_inode;
>  }
>
> -static void orangefs_i_callback(struct rcu_head *head)
> +static void orangefs_free_inode(struct inode *inode)
>  {
> -       struct inode *inode = container_of(head, struct inode, i_rcu);
> -       struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
> -       kmem_cache_free(orangefs_inode_cache, orangefs_inode);
> +       kmem_cache_free(orangefs_inode_cache, ORANGEFS_I(inode));
>  }
>
>  static void orangefs_destroy_inode(struct inode *inode)
> @@ -138,8 +136,6 @@ static void orangefs_destroy_inode(struct inode *inode)
>         gossip_debug(GOSSIP_SUPER_DEBUG,
>                         "%s: deallocated %p destroying inode %pU\n",
>                         __func__, orangefs_inode, get_khandle_from_ino(inode));
> -
> -       call_rcu(&inode->i_rcu, orangefs_i_callback);
>  }
>
>  /*
> @@ -299,6 +295,7 @@ void fsid_key_table_finalize(void)
>
>  static const struct super_operations orangefs_s_ops = {
>         .alloc_inode = orangefs_alloc_inode,
> +       .free_inode = orangefs_free_inode,
>         .destroy_inode = orangefs_destroy_inode,
>         .drop_inode = generic_delete_inode,
>         .statfs = orangefs_statfs,
> --
> 2.11.0
>
