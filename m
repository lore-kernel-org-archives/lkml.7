Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C29C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA492173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvJJRqlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDKTKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:10:18 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44310 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:10:18 -0400
Received: by mail-yw1-f68.google.com with SMTP id c4so2460948ywa.11;
        Thu, 11 Apr 2019 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIDckLiltYDcAqtD0HdaiLDO1YUEtUpvOMw2jV8P4T4=;
        b=bvJJRqlICExDYIkH9laDnU1NBMms+ceObQep+r0UN6JbLROFuUIYZWPUDoMjmfV/J3
         /aD4O9aAYsrjEn4ToTAxj/8H699+rfFqywgxGcFQZ1kiDa8FpR6HsSc6ILdMZnV/rvY3
         wu+04Bv4ZVTM//nBmyf2F7yoWaz75+bayO/TXO3by7j7COES38Eq/kMzt541yeTZE5fD
         R52sl6TVR78SUPCOAJeeacoXJbL4esuUZsRPSA+ClcN9DXBuJmtqEd0P2kLGwWgyPMSE
         p3ILilBtTQmXgRQuInNLs7ZBwWNEgf0KKmMoXV0RN86zZaeuBrZgpFZIvVhuD6iFdPBd
         1iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIDckLiltYDcAqtD0HdaiLDO1YUEtUpvOMw2jV8P4T4=;
        b=PIolskqt49ZdovvIass7TvYY/Z4YKVLGxIJmLNE6S8KL61o1GyrOKykQMqWbGtGR1L
         yKsgqH9n7frKux54WbJ+GSLIzfmO3sv/pbWnvY8r+WnvVSOvE5LspqyEYwALIUWw1y0d
         sSGIzfq1OKeQuYfPYHlZnMPjqLzJUII79fmwLCd94V4kjKtL9EulF0iXf+I6bY6WbUr4
         AO1xw2Ty5uZ7fKId+yHAIk1dq0EdFxqNTABTfYuyCGk5Jky+/SnchI8Uk85l+rmGG664
         RAJfErUed4pMZXxbj/o5RSKIVOTtD3vZ679+HhsZgwh28uSM5kcnomeSWcegSp+V+RvV
         H+mQ==
X-Gm-Message-State: APjAAAULMJsTgJibvyHejYhig0hcymlqWfRW/bGTMVXY1DkbwZi0nMp/
        qCyvJmglx9f30FZVx1mOkCAhuBqosHBOzLVli8w=
X-Google-Smtp-Source: APXvYqwCeFF0nVtAmvRx/e/dSIglFPF4qQ/HD6gGt5d2mNGR+bCN7VEO4mGgal9G7Om4ylyjxqZlIN4CQT0PLrq6jUw=
X-Received: by 2002:a81:2f88:: with SMTP id v130mr41137924ywv.7.1555009817099;
 Thu, 11 Apr 2019 12:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190404105255.12189-1-amir73il@gmail.com> <20190404184448.GC2217@ZenIV.linux.org.uk>
 <20190404184944.GD2217@ZenIV.linux.org.uk> <20190404190506.GE2217@ZenIV.linux.org.uk>
 <CAOQ4uxjuLTTA3Ywfv6kgC6x97bYXa5qbdTePKxo5-YYTdwDQ7A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjuLTTA3Ywfv6kgC6x97bYXa5qbdTePKxo5-YYTdwDQ7A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 11 Apr 2019 22:10:06 +0300
Message-ID: <CAOQ4uxgjDEoseHM-6WgaTV72EvahJSjfiK9xfytC34Yj3yGVDQ@mail.gmail.com>
Subject: Re: [PATCH v2] acct: fix possible deadlock in acct_pin_kill
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 10:33 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Apr 4, 2019 at 10:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> ...
> > OK, so...  My first reaction had been complete BS.  However, the
> > same goes for your analysis - it's not an ordering problem at all.
> > What happens is that we are replacing file->path.mnt with a clone
> > and we want the write count contribution (file is opened for write)
> > to be transferred.  That's it.  We do *NOT* want any kind of
> > freeze protection for the duration of switchover.
> >
> > IOW, the solution is to switch to __mnt_{want,drop}_write() for that
> > switchover; we don't want to mess with freeze protection at all.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> Cool. That works for me.
> Thanks for setting this straight.
>
> You may add:
> Tested-by: Amir Goldstein <amir73il@gmail.com>
> Reported-by: syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com
>
> Thanks,
> Amir.
>
> > ---
> > diff --git a/fs/internal.h b/fs/internal.h
> > index 6a8b71643af4..2e7362837a6e 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -89,9 +89,7 @@ extern int sb_prepare_remount_readonly(struct super_block *);
> >
> >  extern void __init mnt_init(void);
> >
> > -extern int __mnt_want_write(struct vfsmount *);
> >  extern int __mnt_want_write_file(struct file *);
> > -extern void __mnt_drop_write(struct vfsmount *);
> >  extern void __mnt_drop_write_file(struct file *);
> >
> >  /*
> > diff --git a/include/linux/mount.h b/include/linux/mount.h
> > index 9197ddbf35fb..bf8cc4108b8f 100644
> > --- a/include/linux/mount.h
> > +++ b/include/linux/mount.h
> > @@ -87,6 +87,8 @@ extern bool mnt_may_suid(struct vfsmount *mnt);
> >
> >  struct path;
> >  extern struct vfsmount *clone_private_mount(const struct path *path);
> > +extern int __mnt_want_write(struct vfsmount *);
> > +extern void __mnt_drop_write(struct vfsmount *);
> >

Al,

One minor nit.

If you place these function declarations by their definition order
above their wrappers, it would be nicer + patch should apply
cleanly to stable v4.4+. As it is, it applies with a minor conflict.

Just a suggestion.

Thanks,
Amir.
