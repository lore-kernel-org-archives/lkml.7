Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26178C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B8F20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DB5y3E48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDZTCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:02:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39308 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDZTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:02:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id q10so3863533ljc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJldgH74OYVpVHq0YO0Wr2lYbPQUQhsJtlxMVOMOX1k=;
        b=DB5y3E48+mMBhMRMX/Uedax8/EckaSwwNGcwyMR5q37OVIccu3Xbd/rxBRxMrjhuR/
         wQUhl+j97m87q1LVeC832SBDtBQqHctWv0YPhva5HodIo6H79r+a2Rp3EFyxj2zsm6Jr
         fqdNPXVx0WWnyZMsgS8u+0JsHwFmWqDVsw+SN16Fr7ozc/rbIacziKuWtcBhKpFNCgWv
         L7dukv0YKcMBF++ViIpbGzqPXnJ26tlssQhwrdHijKPR9/r1b5NOmpdzIOW3Rojvgk/d
         9VpPcnmcVIFLGUwKlsaIb1fu4s3KnAQJfdacC/Bl+4wBmKBP/HRloEsjkx2JNRTZraG4
         v0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJldgH74OYVpVHq0YO0Wr2lYbPQUQhsJtlxMVOMOX1k=;
        b=QuANlc+23as89EEzBiVBQhjJzFSCUWAuQ0SCxfly7lnZ1jIZ80ltMPsdvvMtCRKVqe
         wPK0nmJYtalXmS7OO7UzGfeuDY9482XRLJ7JLxUV6/qY0D6BiMa6K9bKNcIgv0aoc94y
         2wPomcYaf+8lWjbKEL2nuqew1OMmKZZoCK7LHDwWu9nyc1/9MdnbK+UutGVJvM6D/EmI
         Ma8lUjWxgWJkRAwImscmGh0u0SdM3fNchcDaDm5cZSnBnzvurnhUai8xze3dfKotQwK4
         /VjQ1MyFAMR9LtguOFSPW5Rsqp7ZKhHvM24G7C/zstcaa/tQaULFfd+vpm9ocFWeIGlM
         16HA==
X-Gm-Message-State: APjAAAU+YU1Tp/SEU4jI2wkibpRe5vRwx2AlxbK84KOrVk2D0hISPxV8
        9AAJTplAdB8tmu1tmbO5daAXlvklHRY8Te++MasQ
X-Google-Smtp-Source: APXvYqwdc+994bRY501oAqbiUt+/6+ZJzH4e7CUjvZunG0QY7PXqA63pqAtEV42kCZSsqN4j6OXHPnJ7dtFBbOO90MQ=
X-Received: by 2002:a2e:7605:: with SMTP id r5mr4250895ljc.161.1556305359360;
 Fri, 26 Apr 2019 12:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190426182847.25088-1-jlayton@kernel.org> <20190426182847.25088-6-jlayton@kernel.org>
In-Reply-To: <20190426182847.25088-6-jlayton@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Apr 2019 15:02:28 -0400
Message-ID: <CAHC9VhTcXV9vcqEJo0G5AG9Qikb+h3VCAcyKVe=2P7V0yo8gjQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] audit: fix audit_compare_dname_path to take a qstr
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        gregkh@linuxfoundation.org, tj@kernel.org, jack@suse.cz,
        amir73il@gmail.com, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 2:28 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> ...and eliminate its strlen call.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  kernel/audit.h          | 3 ++-
>  kernel/audit_fsnotify.c | 2 +-
>  kernel/audit_watch.c    | 6 +++---
>  kernel/auditfilter.c    | 7 ++++---
>  kernel/auditsc.c        | 7 +++----
>  5 files changed, 13 insertions(+), 12 deletions(-)

This looks fine to me.  I'm guessing you are planning on this going in
with the other patches, but if you want me to pull this single patch
into audit/next let me know.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 958d5b8fc1b3..8c581fd38050 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -231,7 +231,8 @@ extern int audit_comparator(const u32 left, const u32 op, const u32 right);
>  extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
>  extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
>  extern int parent_len(const char *path);
> -extern int audit_compare_dname_path(const char *dname, const char *path, int plen);
> +extern int audit_compare_dname_path(const struct qstr *dname, const char *path,
> +                                   int plen);
>  extern struct sk_buff *audit_make_reply(int seq, int type, int done, int multi,
>                                         const void *payload, int size);
>  extern void                audit_panic(const char *message);
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index 6def7f426ba6..af281e965d24 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -188,7 +188,7 @@ static int audit_mark_handle_event(struct fsnotify_group *group,
>         }
>
>         if (mask & (FS_CREATE|FS_MOVED_TO|FS_DELETE|FS_MOVED_FROM)) {
> -               if (audit_compare_dname_path(dname->name, audit_mark->path,
> +               if (audit_compare_dname_path(dname, audit_mark->path,
>                                              AUDIT_NAME_FULL))
>                         return 0;
>                 audit_update_mark(audit_mark, inode);
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 3c12fd5b680e..b50c574223fa 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -255,7 +255,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
>
>  /* Update inode info in audit rules based on filesystem event. */
>  static void audit_update_watch(struct audit_parent *parent,
> -                              const char *dname, dev_t dev,
> +                              const struct qstr *dname, dev_t dev,
>                                unsigned long ino, unsigned invalidating)
>  {
>         struct audit_watch *owatch, *nwatch, *nextw;
> @@ -507,9 +507,9 @@ static int audit_watch_handle_event(struct fsnotify_group *group,
>         }
>
>         if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
> -               audit_update_watch(parent, dname->name, inode->i_sb->s_dev, inode->i_ino, 0);
> +               audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
>         else if (mask & (FS_DELETE|FS_MOVED_FROM))
> -               audit_update_watch(parent, dname->name, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
> +               audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
>         else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
>                 audit_remove_parent_watches(parent);
>
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 63f8b3f26fab..6f585b48f4ef 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1290,12 +1290,13 @@ int parent_len(const char *path)
>   * @parentlen: length of the parent if known. Passing in AUDIT_NAME_FULL
>   *             here indicates that we must compute this value.
>   */
> -int audit_compare_dname_path(const char *dname, const char *path, int parentlen)
> +int audit_compare_dname_path(const struct qstr *dname, const char *path,
> +                            int parentlen)
>  {
>         int dlen, pathlen;
>         const char *p;
>
> -       dlen = strlen(dname);
> +       dlen = dname->len;
>         pathlen = strlen(path);
>         if (pathlen < dlen)
>                 return 1;
> @@ -1306,7 +1307,7 @@ int audit_compare_dname_path(const char *dname, const char *path, int parentlen)
>
>         p = path + parentlen;
>
> -       return strncmp(p, dname, dlen);
> +       return strncmp(p, dname->name, dlen);
>  }
>
>  int audit_filter(int msgtype, unsigned int listtype)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d1eab1d4a930..05e06b766af1 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2045,7 +2045,6 @@ void __audit_inode_child(struct inode *parent,
>  {
>         struct audit_context *context = audit_context();
>         struct inode *inode = d_backing_inode(dentry);
> -       const char *dname = dentry->d_name.name;
>         struct audit_names *n, *found_parent = NULL, *found_child = NULL;
>         struct audit_entry *e;
>         struct list_head *list = &audit_filter_list[AUDIT_FILTER_FS];
> @@ -2083,7 +2082,7 @@ void __audit_inode_child(struct inode *parent,
>                         continue;
>
>                 if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
> -                   !audit_compare_dname_path(dname,
> +                   !audit_compare_dname_path(&dentry->d_name,
>                                               n->name->name, n->name_len)) {
>                         if (n->type == AUDIT_TYPE_UNKNOWN)
>                                 n->type = AUDIT_TYPE_PARENT;
> @@ -2099,8 +2098,8 @@ void __audit_inode_child(struct inode *parent,
>                     (n->type != type && n->type != AUDIT_TYPE_UNKNOWN))
>                         continue;
>
> -               if (!strcmp(dname, n->name->name) ||
> -                   !audit_compare_dname_path(dname, n->name->name,
> +               if (!strcmp(dentry->d_name.name, n->name->name) ||
> +                   !audit_compare_dname_path(&dentry->d_name, n->name->name,
>                                                 found_parent ?
>                                                 found_parent->name_len :
>                                                 AUDIT_NAME_FULL)) {
> --
> 2.20.1
>


-- 
paul moore
www.paul-moore.com
