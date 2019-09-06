Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D9FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54B220854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B4OSDpdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393699AbfIFNze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:55:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41008 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731037AbfIFNzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:55:33 -0400
Received: by mail-io1-f65.google.com with SMTP id r26so12836698ioh.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcmyyYxsqdiEv0SNbtEtPLVRqtn2jGS9PqXA4dwbE3U=;
        b=B4OSDpddWZe47ugichOkX/imLBvNKswCV0dbKstPAw/+U+9vciLm6xStunfZCickyP
         Ho3A6tqbPWmU/Ws8P02JF3IyY4fVNkq6SEkJ4pKqhntGCsLpsEcOFwtH17Hn6ejrIZWE
         eBWLNXul50+Hjrpq1Th64M8qE4oAdLPO1tk9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcmyyYxsqdiEv0SNbtEtPLVRqtn2jGS9PqXA4dwbE3U=;
        b=AS9mZv8qTaQpaqmI2Spa0MPmAu120W2E73sZujsmpHnIOT3uMnvzP8T+m8x6MN4+uh
         Uo0J+o2wyNegGjZPNi/OtEybA7t3xIzEqhtNxu8yTGECAuHK4wzbsof3/xzSE7FWAIGD
         6sBXxDIftInGR3+PW2gnWxCS4Vck6mmdE4eknJyHyhJLJ6DSiqbwEDKYfOGxWxSB+Mrt
         WDqhdSxjwANS0m8T0kJBqU9dV4XYF1G5hpU5EFwMe9F5XZeoqxMjTn63tQxauuAAXOjp
         l3hOazydH1CgksJTnwXWP+aGB9TGRnhe5EWkjl5/j3qMWyMNH8JHhMvfO66myfiS3Z/M
         n73g==
X-Gm-Message-State: APjAAAU3GXvJMEALbYwbqo8/q3fx1y+oMUsnp8IyMQFHeUEKqZF81GTq
        hNSZR8bsdx8CNI/T6sI9LvYDpDKF+jXo5CyWkvaSwg==
X-Google-Smtp-Source: APXvYqyesOafui7EisCf65he+vGO+0RObENd8TxztxTIE83r8g7dcjMJNn1jevJ3E/uacv0hS5BHmUm7+QCoL/L1zKs=
X-Received: by 2002:a6b:bec6:: with SMTP id o189mr10035532iof.62.1567778132891;
 Fri, 06 Sep 2019 06:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190905194859.16219-1-vgoyal@redhat.com> <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain> <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
 <20190906120817.GA22083@redhat.com>
In-Reply-To: <20190906120817.GA22083@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Sep 2019 15:55:21 +0200
Message-ID: <CAJfpegsL4PLvROr58vtjmyvQu-F17X3xoKCztP2H0fog0xUXhA@mail.gmail.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 2:08 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Sep 06, 2019 at 01:52:41PM +0200, Miklos Szeredi wrote:
> > On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> > > > On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > > > > items and races w.r.t device removal.
> > > > >
> > > > > In this first round of cleanups, I have taken care of most pressing
> > > > > issues.
> > > > >
> > > > > These patches apply on top of following.
> > > > >
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> > > > >
> > > > > I have tested these patches with mount/umount and device removal using
> > > > > qemu monitor. For example.
> > > >
> > > > Is device removal mandatory?  Can't this be made a non-removable
> > > > device?  Is there a good reason why removing the virtio-fs device
> > > > makes sense?
> > >
> > > Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> > > much like removal to work from the beginning.
> >
> > Can you give an example use case?
>
> David Gilbert mentioned this could be useful if daemon stops responding
> or dies. One could remove device. That will fail all future requests
> and allow unmounting filesystem.
>
> Havind said that, current implementation will help in above situation
> only if there are no pending requests. If there are pending requests
> and daemon stops responding, then removal will hang too, as we wait
> for draining the queues.
>
> So at some point of time, we also need some sort of timeout functionality
> where we end requests with error after a timeout.
>
> I feel we should support removing device at some point of time. But its
> not necessarily a must have feature for first round.

If there's no compelling reason to do it in the first round, than I'd
prefer to not do it.   More complexity -> more bugs.

Thanks,
Miklos
