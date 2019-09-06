Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D33C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB3020842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="D8NKd9TC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405344AbfIFOL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:11:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35098 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbfIFOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:11:57 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so12296029ion.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBrCjYtRGeVIUf2uLSTOH0TDA2MoR8rPeuh7/xAFTR0=;
        b=D8NKd9TCn22gOEparD+Yox0KHsyQgK83HVi1CC9EJZQdPch0kcHtUx4zj7P8NpF/OS
         zCzx9pK1dKiJTSV2mz7k6BO/L+ksrPGFNTj5hZt06SUmQldGLNyn5Dhhawjgd/4vg9Ui
         HMKiDmpE2BlM+KCNO/wxa0ToSer60dlO7IHuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBrCjYtRGeVIUf2uLSTOH0TDA2MoR8rPeuh7/xAFTR0=;
        b=aDoykVSVkDjUCeGb84HhbwHaD/t8rJrzOhnhJLKmsFxM+XpalD4St44gDLTln/CGew
         Ax5rslqdqMqmj8F/lzBxQ6yAn1e31eOaOkyjfc0x057EJieBkbYZGJaEJVWTV6WqZz1U
         S6fG2VLqNmmkNXnD6Kmy4EnvexIqmdqUlwwp4mQp9vNb3SOh7dGV76D8HBd2SGmeMSCQ
         N0/SkCqpCMtdRfjUWYXN5egbZo2hCQ57P2LfbX+HINEntZkLhoyPJyU8k41GbA/7G7rR
         Ag8xy+osSIcsE3yXMGYSPv/7wRhquFc4N3LFADA5ffve0YrnzKHjdlfdp0v4Yz5tlk2O
         hf4A==
X-Gm-Message-State: APjAAAURkZnVN9vSC2+fxTpV3gDylTtjzuBRAdv555T3OeSA7d939siB
        5GmkZzu2nUAkQsOH2ejbl5gi02hXiR6q/fiyJtjRsQ==
X-Google-Smtp-Source: APXvYqw9XPVFgMeA50NX5PrAZrea7f9JWjzF81vZOSd6e/ea0AGiUxSpomKHznhtwCibV6Gj2msNWBLLb2AYx/Q+15s=
X-Received: by 2002:a6b:5d18:: with SMTP id r24mr10503356iob.285.1567779116257;
 Fri, 06 Sep 2019 07:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190905194859.16219-1-vgoyal@redhat.com> <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain> <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
 <20190906120817.GA22083@redhat.com> <20190906095428-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190906095428-mutt-send-email-mst@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Sep 2019 16:11:45 +0200
Message-ID: <CAJfpeguVvwRCi7+23W2qA+KHeoaYaR7uKsX+JykC3HK00uGSNQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 3:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Sep 06, 2019 at 08:08:17AM -0400, Vivek Goyal wrote:
> > On Fri, Sep 06, 2019 at 01:52:41PM +0200, Miklos Szeredi wrote:
> > > On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > >
> > > > On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> > > > > On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > > > > > items and races w.r.t device removal.
> > > > > >
> > > > > > In this first round of cleanups, I have taken care of most pressing
> > > > > > issues.
> > > > > >
> > > > > > These patches apply on top of following.
> > > > > >
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> > > > > >
> > > > > > I have tested these patches with mount/umount and device removal using
> > > > > > qemu monitor. For example.
> > > > >
> > > > > Is device removal mandatory?  Can't this be made a non-removable
> > > > > device?  Is there a good reason why removing the virtio-fs device
> > > > > makes sense?
> > > >
> > > > Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> > > > much like removal to work from the beginning.
> > >
> > > Can you give an example use case?
> >
> > David Gilbert mentioned this could be useful if daemon stops responding
> > or dies. One could remove device. That will fail all future requests
> > and allow unmounting filesystem.
> >
> > Havind said that, current implementation will help in above situation
> > only if there are no pending requests. If there are pending requests
> > and daemon stops responding, then removal will hang too, as we wait
> > for draining the queues.
> >
> > So at some point of time, we also need some sort of timeout functionality
> > where we end requests with error after a timeout.
> >
> > I feel we should support removing device at some point of time. But its
> > not necessarily a must have feature for first round.
> >
> > Thanks
> > Vivek
>
> Without removal how do we stop guest poking at some files if we want to?
>
> I guess we could invent a special event to block accesses,
> but unplug will just do it.
>
> blk and scsi support removal out of box, if this is supposed
> to be a drop in replacement then I think yes, you want this
> support.

This is not a drop in replacement for blk and scsi transports.  More
for virtio-9p.  Does that have anything similar?

If we get a request for this feature, then yes, what you are saying
makes sense.   But that hasn't happened yet, so I think this can wait.

Thanks,
Miklos
