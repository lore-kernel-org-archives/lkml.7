Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3E2C47418
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EAF23447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkbtOt20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfKMQAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:00:49 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39665 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfKMQAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:00:48 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so2224567oif.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcxXz/hy0yD4Dv/1aRup6B2d7cDG6vSzxW491ZecOnY=;
        b=IkbtOt20hldM/bTM0mBSZl/lLqhj4os3wESjTi8qxWbG3L81gb5wKmTMIXPKKUGmJK
         NNgkdbCScyvuJFDjMLFTdTsvkPUUGcyzZ5LAzlR2NI2iYw2KbA09cuEKLSaSZnMVrGzx
         T/YO7QC4Q2XXwU+K6ElpD1LWMIflls/i19bT4v7D7mepGI1+BVABmGM/KFIb2HiMtf5V
         VYGFnpcXMIBPgH3YGcbfVQit3z9aHZRd4455Xrn65g5X4mtB9J+a1ARi8O63tOSrydOc
         tHE82uxnEeOpFrB7WM55hx/eR9Pz/5VeIDKJUAxwkdw3FHvbSEgMaabxRtI1ejn6g6H6
         cNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcxXz/hy0yD4Dv/1aRup6B2d7cDG6vSzxW491ZecOnY=;
        b=Q35ctvdus2FCvBlrqEnBgnCVR7CvmfvgLIHJB5lpE3LBVmv7si9Y4bkE19gph49Cc4
         xzgDx2OM7KA+DmvAZOTseS5THvV2KGiEFFWeYtPJsNbRXC2WA1gOnQky1KgBbO1Jo1Up
         ZW3bzvSy2beOCN4xIQADDky74KkNRjxSu5ybGV7iQg25nkZsnyzdB0u4HOypFycU6Sd3
         drWmvNM647sbCZvmM2RU2ga1XZVXktWxqJ8S34bAGsN/SQ8t5ScYqt7Se+G+SbP9fW5w
         Ldb0b4k0CZzA41ChUH+F08uK1pxRzrZpK845YMk8b7c+yJBj/YDL95vp2I1t3zS4vl6Z
         eC+Q==
X-Gm-Message-State: APjAAAWX/MIkWF8se1XdTyF88F5eyQRA9Afg3O09TtgvRRb0wTbEcDIm
        1QjYX5lQEjphDEdSU/9KEWhQsuh22+OOAWXDFxe6JA==
X-Google-Smtp-Source: APXvYqx6LdgXxfOfErKByXfyOGZGi4ldWQzJ/kKriqc83ob1MBYgGQ3TZUA+L19NJgdsNKPAT47WF1DzoyGAlam7mec=
X-Received: by 2002:aca:ccd1:: with SMTP id c200mr4406127oig.157.1573660845922;
 Wed, 13 Nov 2019 08:00:45 -0800 (PST)
MIME-Version: 1.0
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com> <20191112232239.yevpeemgxz4wy32b@wittgenstein>
In-Reply-To: <20191112232239.yevpeemgxz4wy32b@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 13 Nov 2019 17:00:19 +0100
Message-ID: <CAG48ez0j_7NyCyvGn8U8NS2p=CQQb=me-5KTa7k5E6xpHJphaA@mail.gmail.com>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:22 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
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

In kernel/ucount.c, the ->permissions handler set_permissions() grants
access based on whether the caller has CAP_SYS_RESOURCE. And in
net/sysctl_net.c, the handler net_ctl_permissions() grants access
based on whether the caller has CAP_NET_ADMIN. This added check is
going to break those, right?
