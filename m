Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92482CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F92720663
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 13:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muXjX6Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfKCNUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 08:20:34 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35997 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfKCNUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 08:20:34 -0500
Received: by mail-qt1-f195.google.com with SMTP id y10so12996407qto.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 05:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvZDTg6KgNl1RRJLKsvptgnVUd3pDUaVxrmsOG02VjE=;
        b=muXjX6EkZezEHv58wqoRy0ZDpqiHE3fYf2yWpgKEtHHZtSeOS67EAC1dFDnPwOBG1p
         su1tdgHJeeFhUPw32pEMm8FshW8CXCSa3TLituQX/LqemUCa7mRUswutyhqTnLtB8gnJ
         YTfbMDoie4ol7c1QHHTlzNJ01UVHaRtcczAGNrWFv3ZDc6wJYhY1h1OIpAmwh3p7L+jg
         LCUrjcQOszBo5RrRpaDTh864H5qHc92SPQi349h5BclEeBBuPnO/uWjY/Eq4uM576jY4
         l8mTHXBXF/bc8hF/hSb+WXSCn2ViBfMS4zybBwXnPfUfbUU8rOeIEO7cknSRmgBVWHHu
         hDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvZDTg6KgNl1RRJLKsvptgnVUd3pDUaVxrmsOG02VjE=;
        b=DYOMDf8jcWLZzU963rh6n7fUUDP5RRtZfCMyhb3h4bc+Sy02vh4LhKCNxZJUvKXzkP
         gyzQCqhHatgT8WDv7FODBs1QK5B4HL3jsXZueQ1LWdQCrEiI53T3k44GCbXTEFM5sQy6
         E404x31C5n8pLfTIKISHBULuNITxIwP8SqfQFVo3gTvMsbniZRVFpCuXwgUYateu2u1W
         zQ9xT5iVn7wgTVdMU35esjju5v+Pm8T3/FMl2MzWJAJy/qtuTzZOqV6RWWFfK+rGJBwk
         rkTS1bs/6J0GHfeXTWIaMGEe5KC/VMQHmmphXuPdmvrS9JiOZwDoe78EpoSB4AS4UXMG
         V6xw==
X-Gm-Message-State: APjAAAWiRcqiPNXvDykdcYt/Ov1z92Qd+MxB62U3MVM01d2EIikR4Cnr
        f4cBwuusGAypqN20UuZT8v7vhtBdj9OpHR71epopxQ==
X-Google-Smtp-Source: APXvYqy0g3Hr5wgbS0e99pI1t0rYFYpkV7KVM+rnH00eH2yx1wUc986D3sOmkMxjtt04cl411iCoHuUNzIFo7+FiCms=
X-Received: by 2002:ac8:4157:: with SMTP id e23mr8391764qtm.158.1572787232201;
 Sun, 03 Nov 2019 05:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20191020173010.GA14744@avx2> <CANpmjNPzkYQjQ1mtJ6-h+6-=igD=GSnN9Sr6B6jpXrH9UJEUxg@mail.gmail.com>
 <20191021183216.GA28801@avx2>
In-Reply-To: <20191021183216.GA28801@avx2>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 3 Nov 2019 14:20:20 +0100
Message-ID: <CACT4Y+Y2JzAZ5OJg-5Ng3ArcGD3xyjNqgg2x4QnJLoc03znbLA@mail.gmail.com>
Subject: Re: [PATCH] proc: fix inode uid/gid writeback race
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 8:32 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Mon, Oct 21, 2019 at 11:24:27AM +0200, Marco Elver wrote:
> > On Sun, 20 Oct 2019 at 19:30, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > (euid, egid) pair is snapshotted correctly from task under RCU,
> > > but writeback to inode can be done in any order.
> > >
> > > Fix by doing writeback under inode->i_lock where necessary
> > > (/proc/* , /proc/*/fd/* , /proc/*/map_files/* revalidate).
> > >
> > > Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > ---
> >
> > Thanks!
> >
> > This certainly fixes the problem of inconsistent uid/gid pair due to
> > racing writebacks, as well as the data-race. If that is the only
> > purpose of this patch, then from what I see this is fine:
> >
> > Acked-by: Marco Elver <elver@google.com>
> >
> > However, there is probably still a more fundamental problem as outlined below.
> >
> > >  fs/proc/base.c     |   25 +++++++++++++++++++++++--
> > >  fs/proc/fd.c       |    2 +-
> > >  fs/proc/internal.h |    2 ++
> > >  3 files changed, 26 insertions(+), 3 deletions(-)
> > >
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -1743,6 +1743,25 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
> > >         *rgid = gid;
> > >  }
> > >
> > > +/* use if inode is live */
> > > +void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
> > > +                             struct inode *inode)
> > > +{
> > > +       kuid_t uid;
> > > +       kgid_t gid;
> > > +
> > > +       task_dump_owner(task, mode, &uid, &gid);
> > > +       /*
> > > +        * There is no atomic "change all credentials at once" system call,
> > > +        * guaranteeing more than _some_ snapshot from "struct cred" ends up
> > > +        * in inode is not possible.
> > > +        */
> > > +       spin_lock(&inode->i_lock);
> > > +       inode->i_uid = uid;
> > > +       inode->i_gid = gid;
> > > +       spin_unlock(&inode->i_lock);
> >
> > 2 tasks can still race here, and the inconsistent scenario I outlined in
> > https://lore.kernel.org/linux-fsdevel/000000000000328b2905951a7667@google.com/
> > could still happen I think (although extremely unlikely). Mainly,
> > causality may still be violated -- but I may be wrong as I don't know
> > the rest of the code (so please be critical of my suggestion).
> >
> > The problem is that if 2 threads race here, one has snapshotted old
> > uid/gid, and the other the new uid/gid. Then it is still possible for
> > the old uid/gid to be written back after new uid/gid, which would
> > result in this bad scenario:
> >
> > === TASK 1 ===
> > | seteuid(1000);
> > | seteuid(0);
> > | stat("/proc/<pid-of-task-1>", &fstat);
> > | assert(fstat.st_uid == 0);  // fails
> > === TASK 2 ===
> > | stat("/proc/<pid-of-task-1>", ...);
> >
> > AFAIK it's not something that can easily be fixed without some
> > timestamp on the uid/gid pair (timestamp updated after setuid/seteuid
> > etc) obtained in the RCU reader critical section. Then in this
> > critical section, uid/gid should only be written if the current pair
> > in inode is older according to snapshot timestamp.
>
> This probably requires bloating "struct cred" with generation number.
> I'm not sure what to do other than cc our credential overlords.

Just in case, this bug can lead to bad observable behavior, e.g.
bypassing LSM checks (apparmor) and this patch does not fix the
underlying problem. For details see:
https://groups.google.com/d/msg/syzkaller-bugs/mzwiXt4ml68/GuAUQrWtBQAJ


> > > +}
> > > +
> > >  struct inode *proc_pid_make_inode(struct super_block * sb,
> > >                                   struct task_struct *task, umode_t mode)
> > >  {
> > > @@ -1769,6 +1788,7 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
> > >         if (!ei->pid)
> > >                 goto out_unlock;
> > >
> > > +       /* fresh inode -- no races */
> > >         task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> > >         security_task_to_inode(task, inode);
> > >
> > > @@ -1802,6 +1822,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
> > >                          */
> > >                         return -ENOENT;
> > >                 }
> > > +               /* "struct kstat" is thread local, atomic snapshot is enough */
> > >                 task_dump_owner(task, inode->i_mode, &stat->uid, &stat->gid);
> > >         }
> > >         rcu_read_unlock();
> > > @@ -1815,7 +1836,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
> > >   */
> > >  void pid_update_inode(struct task_struct *task, struct inode *inode)
> > >  {
> > > -       task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
> > > +       task_dump_owner_to_inode(task, inode->i_mode, inode);
> > >
> > >         inode->i_mode &= ~(S_ISUID | S_ISGID);
> > >         security_task_to_inode(task, inode);
> > > @@ -1990,7 +2011,7 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
> > >         mmput(mm);
> > >
> > >         if (exact_vma_exists) {
> > > -               task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> > > +               task_dump_owner_to_inode(task, 0, inode);
> > >
> > >                 security_task_to_inode(task, inode);
> > >                 status = 1;
> > > --- a/fs/proc/fd.c
> > > +++ b/fs/proc/fd.c
> > > @@ -101,7 +101,7 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
> > >  static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
> > >                                 fmode_t f_mode)
> > >  {
> > > -       task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> > > +       task_dump_owner_to_inode(task, 0, inode);
> > >
> > >         if (S_ISLNK(inode->i_mode)) {
> > >                 unsigned i_mode = S_IFLNK;
> > > --- a/fs/proc/internal.h
> > > +++ b/fs/proc/internal.h
> > > @@ -123,6 +123,8 @@ static inline struct task_struct *get_proc_task(const struct inode *inode)
> > >
> > >  void task_dump_owner(struct task_struct *task, umode_t mode,
> > >                      kuid_t *ruid, kgid_t *rgid);
> > > +void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
> > > +                             struct inode *inode);
> > >
> > >  unsigned name_to_int(const struct qstr *qstr);
> > >  /*
