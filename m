Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0471BC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7172082C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbfIIQSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:18:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387912AbfIIQSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:18:21 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82FB83B3C0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 16:18:21 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id y189so1526770qkb.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 09:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xd5J0j1O8RM23sIIIj9h2xCJg8OqHfg7OWxpv2iexsc=;
        b=pT6+oEDOenTuPDZ67JZcNml5/NR6xR3d5wsBBwyeRZTaaHEHpuWsYhh6HZ2vJUKPBF
         XpWfHwqezM7nIx/NXNWXPyqE3FP+vnSm0E9ZAqscYnwHX1EgPEpioWMtq9nR/e3QlM+x
         Esdr6ndZ2euHlkQFkT+FjSfzum1gqGco2pAvUH2V2IEAbhtsuqQ3alTEkiBycjm+4eE/
         Uxgx3vjA7230WNxnuDVKns1okTlpzORcek+ibGo89izYVuQQk5r+n8MFLUw4L3EjaL1L
         hG4TFaLJ2T9yWqmDL+fDED2NS4a5lZx5evo2+A1DSCIqvQcPGWBOBmSfePFhwpxz2GGh
         hs1Q==
X-Gm-Message-State: APjAAAURtWRrb9Tp1Efk1/Yq9KQlvcjuMAr9BSfzareC2T93gl9iwD2Z
        cWmCKS/gjjftgC7p6PitzfiqIbYnVP6HVIfRp6UygPzY9KA5QJoL09cdqfirLkwhxVm0ehtCffm
        x6FtCfWe3C+/6ORnWzhDHzUMq
X-Received: by 2002:aed:316d:: with SMTP id 100mr442783qtg.20.1568045900871;
        Mon, 09 Sep 2019 09:18:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxvZ3BxEyb3pt+fbqjr5qKBJvhxJopIJiuMLcQ+RPNA0muqjQbM1NQBmU9ZKN8evHR3WQQZoA==
X-Received: by 2002:aed:316d:: with SMTP id 100mr442761qtg.20.1568045900648;
        Mon, 09 Sep 2019 09:18:20 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
        by smtp.gmail.com with ESMTPSA id c14sm8927771qta.80.2019.09.09.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 09:18:19 -0700 (PDT)
Date:   Mon, 9 Sep 2019 12:18:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     piaojun <piaojun@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 00/18] virtiofs: Fix various races and
 cleanups round 1
Message-ID: <20190909121604-mutt-send-email-mst@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
 <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
 <866a1469-2c4b-59ce-cf3f-32f65e861b99@huawei.com>
 <20190909161455.GG20875@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909161455.GG20875@stefanha-x1.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:14:55PM +0200, Stefan Hajnoczi wrote:
> On Sun, Sep 08, 2019 at 07:53:55PM +0800, piaojun wrote:
> > 
> > 
> > On 2019/9/6 19:52, Miklos Szeredi wrote:
> > > On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >>
> > >> On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> > >>> On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >>>>
> > >>>> Hi,
> > >>>>
> > >>>> Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > >>>> items and races w.r.t device removal.
> > >>>>
> > >>>> In this first round of cleanups, I have taken care of most pressing
> > >>>> issues.
> > >>>>
> > >>>> These patches apply on top of following.
> > >>>>
> > >>>> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> > >>>>
> > >>>> I have tested these patches with mount/umount and device removal using
> > >>>> qemu monitor. For example.
> > >>>
> > >>> Is device removal mandatory?  Can't this be made a non-removable
> > >>> device?  Is there a good reason why removing the virtio-fs device
> > >>> makes sense?
> > >>
> > >> Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> > >> much like removal to work from the beginning.
> > > 
> > > Can you give an example use case?
> > 
> > I think VirtFS migration need hot plugging, or it may cause QEMU crash
> > or some problems.
> 
> Live migration is currently unsupported.  Hot unplugging the virtio-fs
> device would allow the guest to live migrate successfully, so it's a
> useful feature to work around the missing live migration support.
> 
> Is this what you mean?
> 
> Stefan

Exactly. That's what I also said. To add to that, hotplug can not be
negotiated, so it's not a feature we can easily add down the road if old
guests crash on unplug. Thus a driver that does not support unplug
should not claim to support removal.

-- 
MST
