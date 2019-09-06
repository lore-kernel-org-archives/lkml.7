Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF17CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF6A206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="M6kMLhhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391214AbfIFLwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:52:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40310 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfIFLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:52:53 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so12022970iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4lqVL9E8teUhvToTgEeuMgi3bTyCtYt4jpvCxfm54Q=;
        b=M6kMLhhrR1rSwxoyoRq92O56PaUv4DjhHtEi23Zna8X3y6GiVStVcgzJOPeB9P6X1d
         DdVtzL1OUc3LB71I/dqAOxlGGmrNQpZB504ocPjGN3JGQcl6Ax9TqTmWb1ESVc1DoXwK
         B46n8m+4HwmtG0XpBl9stwF9MkxMcUuN6wozQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4lqVL9E8teUhvToTgEeuMgi3bTyCtYt4jpvCxfm54Q=;
        b=tWjTir8Xd5uZgCxw7Cjode+vgxkGI61RZiuODVVhbiYSVl51Lq5qY7q33LwaPdRLLh
         yi9fIxbU5uLDo508qCIpT+7X5dgVYpUWpWpNDdPoVFKu3CQc3XFwHJVmX45NIKbyXWwI
         zunoEF2hNB5ceUVHi7c2oCU97gx7eliDl/xHXJ5cppkuwFuoxOqdefjsmwpgDZ6rKg/5
         qMBmNQIq/fYqvKMt5XN6UCLHlmRcsuR2Zf0rBwUPOFikUxN24wk8OGrWE/FyVPcXTuof
         uhwFA4nsrQckg4cxezy1D0Il3EasU3AuyFxbVLovMWyMlFO6hAOCk1JC6IPi+kbwBdWH
         rP6w==
X-Gm-Message-State: APjAAAUKo6xh11BAmuOZj2pmsCv1qWyebrnuk/J8/2rZXJJKY+BidNhj
        LlA1PsF5C/BPhDZFblsdOotTwW2bzJeIa/ptQN94PQ==
X-Google-Smtp-Source: APXvYqzDqDUnTf7efWqCw8eAeZPl2HmDPoN7CDauAbzjCHdo6rqOXrTSpwAa3PZ379dVg7Ek5PStHiGrSfwEhZLZgpo=
X-Received: by 2002:a5e:d70b:: with SMTP id v11mr701415iom.252.1567770772377;
 Fri, 06 Sep 2019 04:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190905194859.16219-1-vgoyal@redhat.com> <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
In-Reply-To: <20190906103613.GH5900@stefanha-x1.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Sep 2019 13:52:41 +0200
Message-ID: <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> > On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > > items and races w.r.t device removal.
> > >
> > > In this first round of cleanups, I have taken care of most pressing
> > > issues.
> > >
> > > These patches apply on top of following.
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> > >
> > > I have tested these patches with mount/umount and device removal using
> > > qemu monitor. For example.
> >
> > Is device removal mandatory?  Can't this be made a non-removable
> > device?  Is there a good reason why removing the virtio-fs device
> > makes sense?
>
> Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> much like removal to work from the beginning.

Can you give an example use case?

Thanks,
Miklos
