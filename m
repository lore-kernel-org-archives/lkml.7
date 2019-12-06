Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C17C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796092466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="fk1qCuSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLFGQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 01:16:41 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33648 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLFGQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 01:16:41 -0500
Received: by mail-ed1-f66.google.com with SMTP id l63so4913351ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 22:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aU5igi+hXGEOG2QjkV3GIlWqJAN3Fk8A4HK4+I3f2QM=;
        b=fk1qCuSPIEKRmrNCoOSyQZj7+0A2CtGnQ9degU7je+6lu69n6L5g/5TRM4wuDbJ7gd
         l97vL0uEkTz0Y+rTnfCtmXvC6hF4Qwx5Foj6ph90icCTw6CcdSam2W46RTjWwWcVt1G2
         GwsIFD0gQJmDFEKBJPNCv4dO4FhByExQjZoQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aU5igi+hXGEOG2QjkV3GIlWqJAN3Fk8A4HK4+I3f2QM=;
        b=WLGUGT4MRmerda1XgEjlVCRAd2HBEIUe/J/K0E7Y47iyQI1IEM5/JR9vtc3AsCAcKr
         i2tGEGLjs/dkzZJWOva5p+GvUVawcZZux35RkPAPj2fsm1BFSUOMvBhId0nWe9UGwull
         1PNu9ulkDu3qWL4InQ/stLG82qDeHnpdH01bLNg4xvHKVtUuU09cy8x4uFcb4G4+LW35
         XF17VIcIO+j9Jibf98cMcV9kAlrC4EbZfkcrxrkK3duVKHnfIwGecg0D63Q906DqNda4
         zXd75uyj8WBCvV64/RK5I08ULNtSUIBbWvTWfZ5ZWHGY/1sIoLVkPIWmsm7JubVRIFIE
         SVHQ==
X-Gm-Message-State: APjAAAVvYc0aHSNttL8GU+mQhr/VmWinRj8vM5ig6eY2z0hqQjljpNpY
        Cw5HlChU9RJQlJ/5IDvG324TwvN49HfjAQ8AObd7M9sWamo=
X-Google-Smtp-Source: APXvYqyjiWil2byS3GcEgja3dADVlQBjxrbvyeDpuzEEo9CQ/+ZU7R5Ibo3TWSgf0BFaRBHmF5nJesWNC1Xj9+JCCiM=
X-Received: by 2002:a50:fa06:: with SMTP id b6mr1170960edq.231.1575612999059;
 Thu, 05 Dec 2019 22:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal> <CAG48ez0_CCxO=stFvK=4G4Og=xe9Rtws8PEVy-cSmLqcxfE2Zw@mail.gmail.com>
In-Reply-To: <CAG48ez0_CCxO=stFvK=4G4Og=xe9Rtws8PEVy-cSmLqcxfE2Zw@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 5 Dec 2019 22:16:03 -0800
Message-ID: <CAMp4zn85sz_y8EvXUULVY0a0fAmg91pFkYX5zZSXDz6Q-EiUoA@mail.gmail.com>
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 6:38 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Dec 6, 2019 at 12:44 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > PTRACE_GETFD is a generic ptrace API that allows the tracer to
> > get file descriptors from the traceee.
>
> typo: tracee
>
> > The primary reason to use this syscall is to allow sandboxers to
> > take action on an FD on behalf of the tracee. For example, this
> > can be combined with seccomp's user notification feature to extract
> > a file descriptor and call privileged syscalls, like binding
> > a socket to a privileged port.
> [...]
> > +/* This gets a file descriptor from a running process. It doesn't require the
> > + * process to be stopped.
> > + */
> > +#define PTRACE_GETFD   0x420f
> [...]
> > +static int ptrace_getfd(struct task_struct *child, unsigned long fd)
>
> I'd make the "fd" parameter of this function an "unsigned int", given
> that that's also the argument type of fcheck_files().
>
> > +{
> > +       struct files_struct *files;
> > +       struct file *file;
> > +       int ret = 0;
> > +
> > +       files = get_files_struct(child);
> > +       if (!files)
> > +               return -ENOENT;
> > +
> > +       spin_lock(&files->file_lock);
> > +       file = fcheck_files(files, fd);
> > +       if (!file)
> > +               ret = -EBADF;
> > +       else
> > +               get_file(file);
> > +       spin_unlock(&files->file_lock);
> > +       put_files_struct(files);
> > +
> > +       if (ret)
> > +               goto out;
> > +
> > +       ret = get_unused_fd_flags(0);
>
> You're hardcoding the flags for the fd as 0, which means that there is
> no way for the caller to enable O_CLOEXEC on the fd in a way that is
> race-free against a concurrent execve(). If you can't easily plumb
> through an O_CLOEXEC flag from userspace to here, you should probably
> hardcode O_CLOEXEC here.
>
I thought about making addr used for flags. It seems a little weird, given the
name, but it'll do the job. Alternatively, it could be a point to an
options struct.
If we introduce options, one of the nice things we could add is add the ability
to cleanse the FD of certain information, like cgroups.

> > +       if (ret >= 0)
> > +               fd_install(ret, file);
> > +
> > +       fput(file);
>
> Annoyingly, this isn't how fd_install() works. fd_install() has
> slightly weird semantics and consumes the reference passed to it, so
> this should be:
>
>   if (ret >= 0)
>     fd_install(ret, file);
>   else
>     fput(file);
>
> > +out:
> > +       return ret;
> > +}
