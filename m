Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6412C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801AF218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfCUKdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:33:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40405 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfCUKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:33:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so5962413qts.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 03:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGt7wnb0MYHpXiWNM7es/Xx++DTZIMYOZKJImn5VExg=;
        b=ZvOzThkhsUsc41vWhQ2aUsNThNVXxkTmeIsoGca4v0tc8AzVKKaXdMJdaceKYQsH5d
         YAG9n1Zh3h5qr0E2rwD/zJFywsMQj1FEBspFb4BgkC/LYHH7szO3k1qZLX2L6/QdYDo7
         ivB0u2bVo9yZeVU3i5Fgt68MJ1cZ7jjL8r1J7KcN+hoS1Fao8oifbRyUG1cZmU9GpqcI
         g3ZLeIkmJH1cVqyaBD9Q8o8gTgkmE94LzdOsbKn66db+HjZRwKq/L71Q66ZRe3nfUztc
         zwTwj/ceSBorKNloKOMDmnBBmpmPLDZJtDbuxGzJaTpUCBJLInxzV8dGO5LakDCBMFTq
         Rl4g==
X-Gm-Message-State: APjAAAUoRGDFsCOaqCd/fgze0OjECu5cfoCnD4CSyBjCBCnnQxl9QCfZ
        R1QMWHCTuAn31apONNVNsGQywcHJrFPj7V4nCEM=
X-Google-Smtp-Source: APXvYqxaZELz5PXyx8dKV50pEDVnuZ0CMsED6QrAws9OZGX2nSnnbVr+QZhUMHGL7//mFljxuwLGF/+U3lRk1hX/Ay0=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr2357112qve.149.1553164431110;
 Thu, 21 Mar 2019 03:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20150115173132.GA7486@mcrowe.com> <20190321104726.3c570c41e5757611a13c23ca@gmail.com>
In-Reply-To: <20190321104726.3c570c41e5757611a13c23ca@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Mar 2019 11:33:33 +0100
Message-ID: <CAK8P3a1gkG6U3zCytY2Ax-DQvExXqG8Z6eGde4W6D7JLa=YwGg@mail.gmail.com>
Subject: Re: kmsg: lseek errors confuse glibc's dprintf
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Mike Crowe <mac@mcrowe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kay Sievers <kay@vrfy.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:47 AM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
>
> Hello Mike and all,
>
> On Thu, 15 Jan 2015 17:31:32 +0000
> Mike Crowe <mac@mcrowe.com> wrote:
>
> > glibc's dprintf implementation does not work correctly with /dev/kmsg file
> > descriptors because glibc treats receiving EBADF and EINVAL from lseek when
> > trying to determine the current file position as errors. See
> > https://sourceware.org/bugzilla/show_bug.cgi?id=17830
>
> we need to conclude on this issue. This is a real bug which is ignored
> for 4 years now. Mike, would you like to re-send a formal patch?
> I can do it as well, preserving a link to your original patch/report.
> In case you'd like to post it yourself, I can be a tester and/or
> provide a reproducer.

The patch needs to be rebased because of the changed file
location. I would also suggest adding a "Cc: stable@kernel.org"
tag so it will get backported into stable kernels.

> > >>From what I can tell prior to Kay Sievers printk record commit
> > e11fea92e13fb91c50bacca799a6131c81929986, calling lseek(fd, 0, SEEK_CUR)
> > with such a file descriptor would not return an error.
> >
> > Prior to Kay's change, Arnd Bergmann's commit
> > 6038f373a3dc1f1c26496e60b6c40b164716f07e seemed to go to some lengths to
> > preserve the successful return code rather than returning (the perhaps more
> > logical) -ESPIPE.
> >
> > glibc is happy with either a successful return or -ESPIPE.
> >
> > For maximum compatibility it seems that success should be returned but
> > given Kay's new seek interface perhaps this isn't helpful.
> >
> > This patch ensures that such a seek succeeds:
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 02d6b6d..b3ff6f0 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -693,7 +693,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> >       loff_t ret = 0;
> >
> >       if (!user)
> > -             return -EBADF;
> > +             return (whence == SEEK_CUR) ? 0 : -EBADF;
> >       if (offset)
> >               return -ESPIPE;
> >
> > @@ -718,6 +718,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> >               user->idx = log_next_idx;
> >               user->seq = log_next_seq;
> >               break;
> > +     case SEEK_CUR:
> > +             /* For compatibility with userspace requesting the
> > +              * current file position. */
> > +             ret = 0;
> > +             break;
> >       default:
> >               ret = -EINVAL;
> >       }
> >
> > (although it could be argued that the !user case should return -ESPIPE
> > rather than EBADF since the file descriptor _is_ valid.)

I don't think the !user case can ever be hit, I would just leave that
to return -BADF and not touch it.

> > @@ -718,6 +718,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> >               user->idx = log_next_idx;
> >               user->seq = log_next_seq;
> >               break;
> > +     case SEEK_CUR:
> > +             /* For compatibility with userspace expecting SEEK_CUR
> > +              * to not yield EINVAL. */
> > +             ret = -ESPIPE;
> > +             break;
> >       default:
> >               ret = -EINVAL;
> >       }
> >
> > Either makes dprintf work, but is either the right solution?

I'd vote for -ESPIPE, for consistency with the offset!=0 case, but
etiher one is fine with me here.

       Arnd
