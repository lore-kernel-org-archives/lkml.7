Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFBCCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC4A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkFiQMFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392406AbfJWPAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:00:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43796 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390185AbfJWPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:00:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5so5486405ply.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+w72TNzpRjbI10b0jitVHs/ZztNdVqny0Vx93sBfHk=;
        b=LkFiQMFlNCbmBcSny+BOcbJp4l+Y7hxmhJpwbh+oZKj4dclcUmkgKvgYT/+UYb+gC2
         gyHdiiQA0zgCVq5edOVaCswUbLLDVp5XxK7S64xHl5B14kzfNFd1rQGeDZSDltZr/3Wu
         JUlYM9V7bShYYsBBni9hVzN4el8+a0sJvdIGSmvxXXC+hQroujJZ3Ku4IzspLg14V4pP
         rO5w9PLppQQ6gwzqvOxY2udruUJiYhNLNVz1w2QSMCchaEg4Q1G6HlbIZru6HKxG+aS9
         CXqkZ33YbTEGVGVz3EaMmpMU7IxVFS79ScHmIC/CAFsX2auB9k4I7uGZczMJuJ1biDdh
         KMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+w72TNzpRjbI10b0jitVHs/ZztNdVqny0Vx93sBfHk=;
        b=I6m3H1nviA1on3o8Hi0I/iltj+UZ0z+rtmChRl4DGLaCAphKd/AfxRrDIBnfLe1N3K
         yN0mFdxvGjwlT9pOb8HmVJmjViS/y1JxbjNDk+3kBYycBstfI2wBkKnPm8JBAt3a7VxQ
         XcROUhbKRYwnVKEZyoc2bq6MT5XdzkSFRB4TTHZLiolPmeB4KTD1LSkOU3vo37/mCZgV
         /M9JA7jwyLetHbyAfZGtcZvVZKWCVy0shdYb84S5KMehulo3zi3xddupKvMrv+7ertUB
         RbftjxXzwuiF1+JVzPcTYmpiD7DLZ4DRbC4NoPwfsNUB7eOZgmE0ZBiQOernch+CLKVU
         UbDg==
X-Gm-Message-State: APjAAAWFuasUZwDEtAJlp+n5VKa9VP8j1mmMuvIe2FYTymDR8f0I2aB4
        UUq6hUfV2PUYAJbVYyHMjiVrmNcwUBFJXGvCVSXHcg==
X-Google-Smtp-Source: APXvYqzT4S2F+jsQrBIZuP+l7T+33RUZhHDDMRCf+924fdyQ7ByNNyi84Cz1xTdKu0cUzV3k5+G7LjvdIr/BATafnwk=
X-Received: by 2002:a17:902:9002:: with SMTP id a2mr10495952plp.147.1571842817724;
 Wed, 23 Oct 2019 08:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571762488.git.andreyknvl@google.com> <26e088ae3ebcaa30afe957aeabaa9f0c653df7d0.1571762488.git.andreyknvl@google.com>
 <CACT4Y+YntxT+cpESOBvbg+h=g-84ECJwQrFg7LM5tbq_zaMd3A@mail.gmail.com>
 <CAAeHK+yUTZc+BrGDvvTQD4O0hsDzhp0V6GGFdtnmE6U4yWabKw@mail.gmail.com> <CACT4Y+b+RTYjUyB1h0SYjEq8vmOZas3ByjeJqVU1LrjxpRKy2Q@mail.gmail.com>
In-Reply-To: <CACT4Y+b+RTYjUyB1h0SYjEq8vmOZas3ByjeJqVU1LrjxpRKy2Q@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 23 Oct 2019 17:00:06 +0200
Message-ID: <CAAeHK+x-dihJ5+Zb1JBNaL5VK1zB87BR5kPX2B=q+FyVW+WHnw@mail.gmail.com>
Subject: Re: [PATCH 3/3] vhost, kcov: collect coverage from vhost_worker
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 3:50 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Oct 23, 2019 at 3:35 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Wed, Oct 23, 2019 at 10:36 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Tue, Oct 22, 2019 at 6:46 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > >
> > > > This patch adds kcov_remote_start()/kcov_remote_stop() annotations to the
> > > > vhost_worker() function, which is responsible for processing vhost works.
> > > > Since vhost_worker() threads are spawned per vhost device instance
> > > > the common kcov handle is used for kcov_remote_start()/stop() annotations
> > > > (see Documentation/dev-tools/kcov.rst for details). As the result kcov can
> > > > now be used to collect coverage from vhost worker threads.
> > > >
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > ---
> > > >  drivers/vhost/vhost.c | 6 ++++++
> > > >  drivers/vhost/vhost.h | 1 +
> > > >  2 files changed, 7 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index 36ca2cf419bf..a5a557c4b67f 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -30,6 +30,7 @@
> > > >  #include <linux/sched/signal.h>
> > > >  #include <linux/interval_tree_generic.h>
> > > >  #include <linux/nospec.h>
> > > > +#include <linux/kcov.h>
> > > >
> > > >  #include "vhost.h"
> > > >
> > > > @@ -357,7 +358,9 @@ static int vhost_worker(void *data)
> > > >                 llist_for_each_entry_safe(work, work_next, node, node) {
> > > >                         clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > > >                         __set_current_state(TASK_RUNNING);
> > > > +                       kcov_remote_start(dev->kcov_handle);
> > > >                         work->fn(work);
> > > > +                       kcov_remote_stop();
> > > >                         if (need_resched())
> > > >                                 schedule();
> > > >                 }
> > > > @@ -546,6 +549,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > >
> > > >         /* No owner, become one */
> > > >         dev->mm = get_task_mm(current);
> > > > +       dev->kcov_handle = current->kcov_handle;
> > >
> > > kcov_handle is not present in task_struct if !CONFIG_KCOV
> > >
> > > Also this does not use KCOV_SUBSYSTEM_COMMON.
> > > We discussed something along the following lines:
> > >
> > > u64 kcov_remote_handle(u64 subsys, u64 id)
> > > {
> > >   WARN_ON(subsys or id has wrong bits set).
> >
> > Hm, we can't have warnings in kcov_remote_handle() that is exposed in
> > uapi headers. What we can do is return 0 (invalid handle) if subsys/id
> > have incorrect bits set. And then we can either have another
> > kcov_remote_handle() internally (with a different name though) that
> > has a warning, or have warning in kcov_remote_start(). WDYT?
>
> I would probably add the warning to kcov_remote_start(). This avoids
> the need for another function and will catch a wrong ID if caller
> generated it by some other means.
> And then ioctls should also detect bad handles passed in and return
> EINVAL. Then we will cover errors for both kernel and user programs.

OK, will do in v2.

>
> >
> > >   return ...;
> > > }
> > >
> > > kcov_remote_handle(KCOV_SUBSYSTEM_USB, bus);
> > > kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, current->kcov_handle);

I'll add internal kcov_remote_handle_common() and
kcov_remote_handle_usb() helpers to simplify kcov hooks in usb/vhost
code though.

> > >
> > >
> > > >         worker = kthread_create(vhost_worker, dev, "vhost-%d", current->pid);
> > > >         if (IS_ERR(worker)) {
> > > >                 err = PTR_ERR(worker);
> > > > @@ -571,6 +575,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > >         if (dev->mm)
> > > >                 mmput(dev->mm);
> > > >         dev->mm = NULL;
> > > > +       dev->kcov_handle = 0;
> > > >  err_mm:
> > > >         return err;
> > > >  }
> > > > @@ -682,6 +687,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > >         if (dev->worker) {
> > > >                 kthread_stop(dev->worker);
> > > >                 dev->worker = NULL;
> > > > +               dev->kcov_handle = 0;
> > > >         }
> > > >         if (dev->mm)
> > > >                 mmput(dev->mm);
> > > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > > index e9ed2722b633..a123fd70847e 100644
> > > > --- a/drivers/vhost/vhost.h
> > > > +++ b/drivers/vhost/vhost.h
> > > > @@ -173,6 +173,7 @@ struct vhost_dev {
> > > >         int iov_limit;
> > > >         int weight;
> > > >         int byte_weight;
> > > > +       u64 kcov_handle;
> > > >  };
> > > >
> > > >  bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
> > > > --
> > > > 2.23.0.866.gb869b98d4c-goog
> > > >
