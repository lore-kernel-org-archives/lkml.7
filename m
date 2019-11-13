Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB29C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 04:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432602245A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 04:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573620665;
	bh=2HR5j4jMQZ8XywHpceKqovMUe9E/Z2E3JHrn6nNK8II=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VjBBPVcY1D3paRs+cTVHiOOa6Ry2Vvzn08W82O5/m0wPA4WfaT2ij/C+Y51PpTWef
	 MpuCUGXk7WHv858AhdW1eggVUBWkXevbzmKQ16ffXwCmZzhBUbkzj/PbKntPbMPDBg
	 dOBQGImdZsORffqt6BCaVi3Q+X/zqztL/5MzhMJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKMEvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 23:51:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfKMEvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 23:51:04 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75ACE22466
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 04:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573620662;
        bh=2HR5j4jMQZ8XywHpceKqovMUe9E/Z2E3JHrn6nNK8II=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qu4dJD0Ni66AsrNrH/eEIXfa/16KZ7RZrotDsF6X9hceXsuaWXcl7wuQ7T/rYDBxl
         By7fSfDHWoWWQjnnO2PrLJWTvVfX3Y7TIuLKwVqfS7WLH2H6jyIEh/Y6m1lih/jDGM
         5Q5PY9YsYEMdHRvMYPLKPdGpB2dHJgQuoGNdPIJE=
Received: by mail-wm1-f49.google.com with SMTP id z26so478290wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 20:51:02 -0800 (PST)
X-Gm-Message-State: APjAAAW5ZX7fOs3WleYpRa/etw0YibZSoc9ntZ+SjfRUb8qgM/iO0ASV
        KM5WLyrfG+m6oW7T4Lh+kgWUPUbMBkvFSctOcTohIw==
X-Google-Smtp-Source: APXvYqyc3oSgne3bep9Xp7B6mSwi2GF2tpFX9qEMJeGOYHuljwIi7kxpBBiOH4SJj7M2bzS/5n2f9qM3lSkXb7O7bOk=
X-Received: by 2002:a1c:16:: with SMTP id 22mr943595wma.0.1573620660911; Tue,
 12 Nov 2019 20:51:00 -0800 (PST)
MIME-Version: 1.0
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com> <20191112232239.yevpeemgxz4wy32b@wittgenstein>
In-Reply-To: <20191112232239.yevpeemgxz4wy32b@wittgenstein>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 20:50:50 -0800
X-Gmail-Original-Message-ID: <CALCETrUEQMdugz1t6HfK5MvDq_kOw13yuF+98euqVJgZ4WR1VA@mail.gmail.com>
Message-ID: <CALCETrUEQMdugz1t6HfK5MvDq_kOw13yuF+98euqVJgZ4WR1VA@mail.gmail.com>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 3:22 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> [Cc+ linux-api@vger.kernel.org]
>
> since that's potentially relevant to quite a few people.
>
> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
> > Several items in /proc/sys need not be accessible to unprivileged
> > tasks. Let the system administrator change the permissions, but only
> > to more restrictive modes than what the sysctl tables allow.
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> > ---
> >  fs/proc/proc_sysctl.c | 41 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index d80989b6c344..88c4ca7d2782 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
> > mask)
> >         if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
> >                 return -EACCES;
> >
> > +       error = generic_permission(inode, mask);
> > +       if (error)
> > +               return error;
> > +
> >         head = grab_header(inode);
> >         if (IS_ERR(head))
> >                 return PTR_ERR(head);
> > @@ -837,9 +841,35 @@ static int proc_sys_setattr(struct dentry *dentry,
> > struct iattr *attr)
> >         struct inode *inode = d_inode(dentry);
> >         int error;
> >
> > -       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
> > +       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
> >                 return -EPERM;

Supporting at least ATTR_GID would make this much more useful.

> >
> > +       if (attr->ia_valid & ATTR_MODE) {
> > +               struct ctl_table_header *head = grab_header(inode);
> > +               struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> > +               umode_t max_mode = 0777; /* Only these bits may change */
> > +
> > +               if (IS_ERR(head))
> > +                       return PTR_ERR(head);
> > +
> > +               if (!table) /* global root - r-xr-xr-x */
> > +                       max_mode &= ~0222;
> > +               else /*
> > +                     * Don't allow permissions to become less
> > +                     * restrictive than the sysctl table entry
> > +                     */
> > +                       max_mode &= table->mode;

Style nit: please put braces around multi-line if and else branches,
even if they're only multi-line because of comments.

> > +
> > +               sysctl_head_finish(head);
> > +
> > +               /* Execute bits only allowed for directories */
> > +               if (!S_ISDIR(inode->i_mode))
> > +                       max_mode &= ~0111;

Why is this needed?
