Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BAFC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E262082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH1Cs147"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLPTJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:09:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37989 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfLPTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:09:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id b8so4187890oiy.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTnNNMq0UJ07kcz2Fk7rdJeEYnMlohI62EX3lC0CNag=;
        b=PH1Cs1476lBFJxF9TgIuqyyDHyrIDvm30PXKolPsWfEUr/vW1AnQCofGq9XDftuuvP
         Px5EYJJivCdMHBkChe0dSyQ8DrnMB3yT1IqzZFWt/nL8rq0yQ+imzgmDeN3YVQ6B0nAB
         sfNrfsIbm/Li3Z8M65KDvznZQ6SPB7LzLY22vEe23a99qM97v6pXAuTNy3i3UzxN4moX
         oL3pfhmgzgPamXqjiybYU7aWJlzk3ku91SFhBaRmViBe+o+N1pmOJrB78MSU4KVD6sNn
         Jiwy/Tm6Dx0vQX8WNeVinBJJHODAQPDtdRqN8sHQ0/B0VG2tEQ0WvpFYaxHD1vyRt5pF
         5Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTnNNMq0UJ07kcz2Fk7rdJeEYnMlohI62EX3lC0CNag=;
        b=QfF9uVd8B7tuom3DPWdzXAg27LUZfMWBDTvpAbG34+C7Y3gllmUXVoxQ/9CouiXO69
         /vGIXowcf3auHT2+7VErfKbGHwZhLYh2EEAL0hZJXNh/aKOO37Yz0BsE2J6P+jqNnSlx
         Jp95eW8AXeX62TbmaSH0tpNV2jl9jdTmCLuitnwHsV3N7A7cRu7V27a+Zys5pcXvGsfK
         U2ASprbED6EH9JeAJAUVNCrPTCozXbwKG6hvQjxi/idpCbcFMGM+PG0KgRlE/76ECD8V
         mMzvpcPjvUq+DKGLPjLdprS2K0XL9i8Fxb5Sit+88/vxTEOXKqgDHSQiAorYtg1ENCen
         pyDQ==
X-Gm-Message-State: APjAAAVDdREby9pvjuSRCAZpglJsfWWiHt1WqA83RFcdINTa2pfeOhOr
        wSwM4mAe6VCl+EdnyBYe5b85D+5ncZClREjWmsAkjA==
X-Google-Smtp-Source: APXvYqzXk2HL81NaDmu7fbkSBg8spKAcJ7ZGEkfJ8YwRlqK9Jtlv6YjUTTM1hF1KjZmYJ+/WKmJ2Kr1KyoGl+cE8UzI=
X-Received: by 2002:a05:6808:8d0:: with SMTP id k16mr375059oij.68.1576523359592;
 Mon, 16 Dec 2019 11:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20191216091220.465626-1-laurent@vivier.eu> <20191216091220.465626-2-laurent@vivier.eu>
In-Reply-To: <20191216091220.465626-2-laurent@vivier.eu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Dec 2019 20:08:52 +0100
Message-ID: <CAG48ez2xNCRmuzpNqYW5R+XMKzW8YiemsPUPgk42KSkSZXmvLg@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Greg Kurz <groug@kaod.org>, Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Henning Schild <henning.schild@siemens.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:12 AM Laurent Vivier <laurent@vivier.eu> wrote:
> This patch allows to have a different binfmt_misc configuration
> for each new user namespace. By default, the binfmt_misc configuration
> is the one of the previous level, but if the binfmt_misc filesystem is
> mounted in the new namespace a new empty binfmt instance is created and
> used in this namespace.
>
> For instance, using "unshare" we can start a chroot of another
> architecture and configure the binfmt_misc interpreter without being root
> to run the binaries in this chroot.

How do you ensure that when userspace is no longer using the user
namespace and mount namespace, the entries and the binfmt_misc
superblock are deleted? As far as I can tell from looking at the code,
at the moment, if I create a user namespace+mount namespace, mount
binfmt_misc in there, register a file format and then let all
processes inside the namespaces exit, the binfmt_misc mount will be
kept alive by the simple_pin_fs() stuff, and the binfmt_misc entries
will also stay in memory.

[...]
> @@ -718,7 +736,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>         if (!inode)
>                 goto out2;
>
> -       err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
> +       ns = binfmt_ns(file_dentry(file)->d_sb->s_user_ns);
> +       err = simple_pin_fs(&bm_fs_type, &ns->bm_mnt,
> +                           &ns->entry_count);

When you call simple_pin_fs() here, the user namespace of `current`
and the user namespace of the superblock are not necessarily related.
So simple_pin_fs() may end up taking a reference on the mountpoint for
a user namespace that has nothing to do with the namespace for which
an entry is being created.

[...]
>  static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>         int err;
> +       struct user_namespace *ns = sb->s_user_ns;
[...]
> +       /* create a new binfmt namespace
> +        * if we are not in the first user namespace
> +        * but the binfmt namespace is the first one
> +        */
> +       if (READ_ONCE(ns->binfmt_ns) == NULL) {

The READ_ONCE() here is unnecessary, right? AFAIK the VFS layer is
going to ensure that bm_fill_super() can't run concurrently for the
same namespace?

> +               struct binfmt_namespace *new_ns;
> +
> +               new_ns = kmalloc(sizeof(struct binfmt_namespace),
> +                                GFP_KERNEL);
> +               if (new_ns == NULL)
> +                       return -ENOMEM;
> +               INIT_LIST_HEAD(&new_ns->entries);
> +               new_ns->enabled = 1;
> +               rwlock_init(&new_ns->entries_lock);
> +               new_ns->bm_mnt = NULL;
> +               new_ns->entry_count = 0;
> +               /* ensure new_ns is completely initialized before sharing it */
> +               smp_wmb();
> +               WRITE_ONCE(ns->binfmt_ns, new_ns);

Nit: This would be a little bit semantically clearer if you used
smp_store_release() instead of smp_wmb()+WRITE_ONCE().

> +       }
> +
>         err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
[...]
> +static void bm_free(struct fs_context *fc)
> +{
> +       if (fc->s_fs_info)
> +               put_user_ns(fc->s_fs_info);
> +}

Silly question: Why the "if"? Can you ever reach this with fc->s_fs_info==NULL?

> +
>  static int bm_get_tree(struct fs_context *fc)
>  {
> -       return get_tree_single(fc, bm_fill_super);
> +       return get_tree_keyed(fc, bm_fill_super, get_user_ns(fc->user_ns));

get_user_ns() increments the refcount of the namespace, but in the
case where a binfmt_misc mount already exists, that refcount is never
dropped, right? That would be a security bug, since an attacker could
overflow the refcount of the user namespace and then trigger a UAF.
(And the refcount hardening won't catch it because user namespaces
still use raw atomics instead of refcount_t.)

[...]
> +#if IS_ENABLED(CONFIG_BINFMT_MISC)

Nit: Isn't this kind of check normally written as "#ifdef"?
