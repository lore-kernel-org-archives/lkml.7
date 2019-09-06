Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61561C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5A8206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393817AbfIFN5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393536AbfIFN5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:57:35 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 784492D7E1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 13:57:35 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id o34so6315853qtf.22
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 06:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tvOYoeurVEmYtOK8IHP/SsbTbDLRv0QLwd4LI9xguBI=;
        b=cwhA/AWL6f0dUHyalAFvRjalqjmYqPb73pqfW5PKNLiEWsD7PiBwbbsx+pJi+1DK+o
         yIlQN66peni2dp4/CvsWmTQh0TSjEX10R3GC99HzJD4KmapofIhP/1t6UJ3misAGELk3
         TLV/3BOioKAXYil5uMdWeHT9za6DQKrXVau/HxksdH/MxIiJkb1pzQRfOXZEFFGAxNsy
         OMShgOMrDZyL9Sfek+iHGmZHuaVOVpC6zGjCWxCgsqK9WcrlOPe4k435hPbCB5wiNOsZ
         pV15L/zjLb6qYZIrCZbYmcELUQoZ1NtWxPG7CqE+zOXl+3V/JYW2/p8melV+FeKYkXyC
         QOAw==
X-Gm-Message-State: APjAAAX/+3R6cUy3/6UvOxUasiGlJTG0Hx25eJaomVfEsJQIoTiZAHlZ
        uEc1chKGm7vlm8qzpVYrdjYUYNO1QvstN+pm+NzwHTtpnvxyo4h84247wxj3luApj2GtlxsK/SM
        5TJAv0RTlvXcvzJS2xt2IOgj1
X-Received: by 2002:ac8:1793:: with SMTP id o19mr9128627qtj.64.1567778254724;
        Fri, 06 Sep 2019 06:57:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZc49QnyXzg0nyuLIbTlHLkfvD93+v8Ae4jU42P20db23h2fLY0IYcXZVIrHdUZq3he+/hHw==
X-Received: by 2002:ac8:1793:: with SMTP id o19mr9128572qtj.64.1567778253776;
        Fri, 06 Sep 2019 06:57:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id b16sm3231741qtk.65.2019.09.06.06.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 06:57:33 -0700 (PDT)
Date:   Fri, 6 Sep 2019 09:57:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Message-ID: <20190906095428-mutt-send-email-mst@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
 <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
 <20190906120817.GA22083@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906120817.GA22083@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 08:08:17AM -0400, Vivek Goyal wrote:
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
> 
> Thanks
> Vivek

Without removal how do we stop guest poking at some files if we want to?

I guess we could invent a special event to block accesses,
but unplug will just do it.

blk and scsi support removal out of box, if this is supposed
to be a drop in replacement then I think yes, you want this
support.

-- 
MST
