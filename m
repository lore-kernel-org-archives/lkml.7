Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB7EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D38C2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="KYLwnZDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfECRfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:35:03 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34961 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfECRfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:35:02 -0400
Received: by mail-yw1-f66.google.com with SMTP id n188so4921274ywe.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLhJ1ew90W4jh8+82q3Z6uh4FYE+C/yWfqoWkEPsO9M=;
        b=KYLwnZDtmNQtwHK8vp/6sZguYbfwdEZw6ikslzEPXOCnEULYrR8/1xq2P3Px3P10K6
         Go7g7vchlUMPgKd97VDMBBBSV+qYNQpwabqMn3Yi7gX3ob57+cK+yo6IFCi09sNIXNWI
         FXadJdKfQB6AdTe6/ZriLZeGEVGbDD8a8i+wbEDuJMcahrBJYHGekVgGZ/xySwTpr+PL
         vXw6EHC7+FutWlibPTrrkonj0N6xByVMXH6tUm9UiWZOQcBsv4XhlYx+RokELjnamd3G
         PTt73bqL1vJ3EAzsvfX9yZJkGUi6IrkoT0IsL4qugYgzQoDateqRBc2eFOd5Bcmb2VdY
         vKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLhJ1ew90W4jh8+82q3Z6uh4FYE+C/yWfqoWkEPsO9M=;
        b=Nl0+yqb6uhVKd9rg5DRkJ7NRJyI3HAHm2aCkhQe9DyfazH+rNJ1TamsVA5TULjubpQ
         T296vXopcAhlEv/Z6eoIUjcujSfnQQNkGPXmrnoFiwfuFyuMEypIYDPriQFgSNPKOupo
         pV7IwfDoybyPGcwoTXVMG9OeLLCP0pjy0DcUK0qKZYgLN4iCV01x5PHp+Ld3yYrmrqa0
         CyL3Lnz3zpMbihXVPtssoMJ4fwFnpkdQdF8/OaSIlw+NRvpQU6/uok7Kww+bQ/MPJ6R8
         Ad7IYlBpztFGKICVn77SVkba25I+LYniUK/nSQZCPjTbSz6UuDrjSPnQPcwlRNR4gFzj
         wO9w==
X-Gm-Message-State: APjAAAVFiEHvzcz6rv+hKSYDR4pMmKy1csDCfnu+wQxEBCV8Fcdsl0n2
        68VVwrb/BCumjz9wCUkY/e+5clQRJDC5vsT70n6W+2a7
X-Google-Smtp-Source: APXvYqyXV7Wz/t2OKxFYtnigIxoSII2YsfsHyKtRQC8Ov+TgfymINSofuZneEOwWiI64i5DLsvtN52rKXobyrpc5tMk=
X-Received: by 2002:a25:2256:: with SMTP id i83mr8135138ybi.407.1556904900642;
 Fri, 03 May 2019 10:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190503111510.6e866e3b@canb.auug.org.au>
In-Reply-To: <20190503111510.6e866e3b@canb.auug.org.au>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 3 May 2019 13:34:49 -0400
Message-ID: <CAOg9mSSGUiCoeecpdLs-8-TAMkVDubHK5jG87dGseV4gkGRiOQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs tree with the orangefs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Brandenburg <martin@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen...

I noticed the conflict too when I added Al's patch series to the orangefs
tree we have on next. I understood Linus to say he'd fix the conflict the
way you did during the merge window. I guess that means you'll have to
keep fixing it on next until then... I hate causing trouble, let me know if
there's something different I should do to help...

-Mike

On Thu, May 2, 2019 at 9:15 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the vfs tree got a conflict in:
>
>   fs/orangefs/super.c
>
> between commit:
>
>   77becb76042a ("orangefs: implement xattr cache")
>
> from the orangefs tree and commit:
>
>   f276ae0dd6d0 ("orangefs: make use of ->free_inode()")
>
> from the vfs tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc fs/orangefs/super.c
> index 8fa30c13b7ed,3784f7e8b603..000000000000
> --- a/fs/orangefs/super.c
> +++ b/fs/orangefs/super.c
> @@@ -125,20 -124,9 +125,19 @@@ static struct inode *orangefs_alloc_ino
>         return &orangefs_inode->vfs_inode;
>   }
>
> - static void orangefs_i_callback(struct rcu_head *head)
> + static void orangefs_free_inode(struct inode *inode)
>   {
> -       struct inode *inode = container_of(head, struct inode, i_rcu);
>  -      kmem_cache_free(orangefs_inode_cache, ORANGEFS_I(inode));
>  +      struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
>  +      struct orangefs_cached_xattr *cx;
>  +      struct hlist_node *tmp;
>  +      int i;
>  +
>  +      hash_for_each_safe(orangefs_inode->xattr_cache, i, tmp, cx, node) {
>  +              hlist_del(&cx->node);
>  +              kfree(cx);
>  +      }
>  +
>  +      kmem_cache_free(orangefs_inode_cache, orangefs_inode);
>   }
>
>   static void orangefs_destroy_inode(struct inode *inode)
> @@@ -148,17 -136,8 +147,15 @@@
>         gossip_debug(GOSSIP_SUPER_DEBUG,
>                         "%s: deallocated %p destroying inode %pU\n",
>                         __func__, orangefs_inode, get_khandle_from_ino(inode));
> -
> -       call_rcu(&inode->i_rcu, orangefs_i_callback);
>   }
>
>  +static int orangefs_write_inode(struct inode *inode,
>  +                              struct writeback_control *wbc)
>  +{
>  +      gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_write_inode\n");
>  +      return orangefs_inode_setattr(inode);
>  +}
>  +
>   /*
>    * NOTE: information filled in here is typically reflected in the
>    * output of the system command 'df'
> @@@ -316,8 -295,8 +313,9 @@@ void fsid_key_table_finalize(void
>
>   static const struct super_operations orangefs_s_ops = {
>         .alloc_inode = orangefs_alloc_inode,
> +       .free_inode = orangefs_free_inode,
>         .destroy_inode = orangefs_destroy_inode,
>  +      .write_inode = orangefs_write_inode,
>         .drop_inode = generic_delete_inode,
>         .statfs = orangefs_statfs,
>         .remount_fs = orangefs_remount_fs,
