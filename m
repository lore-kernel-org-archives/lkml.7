Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80958CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F179214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NPeUFIBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfKDSaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:30:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33209 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDSa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:30:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id s1so18326928wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=twaj5yyxcDdPGXd17zYXggs1yIoJjp94ssuxTdaG1b4=;
        b=NPeUFIBj9heab4iA/fGSR6J8A6Uny8oEMQbURIVhWq0itWYWJKJyAPHxmW6c3r3wvd
         Lh6dmGjTfnpIapb7Tf39ygHg817Nv3zsF53dY/IKU6o4F75LNrrY1+CV3VfTIn3fEOWw
         DGFfUKYCZgcAswxwTUz0BnzXKloumDEkcTOJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=twaj5yyxcDdPGXd17zYXggs1yIoJjp94ssuxTdaG1b4=;
        b=UM2GFbIM1hlyNwegPR5gJF3r4ZCEmV9Ce7UlAx6OQykPumA0Y2M4l0b6gyRpF6as6t
         hy90+eD992QYUw9VD9VJcRerZZg0RuRHJgRlfWK9fm10y9FNpj2Y0TDmyA/hIuJOpxM2
         x4HD+T8CfTH3ADEQf9MJM363u3aOepRJ1UU4N5JEv8HLizbR3nlaY6ZtdTQODX+8HJx6
         pext7+1WCx/EkT4pJt2fWsoM6x55mIWc68x3CHuhjMWXuAlbFzINY34M2g3OCHsoYt4A
         ab4QJmRDiYF5wMnPHysjjETQPI8yOPg8eFzwJtUY6doSg6Eo9B4+tpTiMjyoe6tvwidp
         XmXQ==
X-Gm-Message-State: APjAAAVO1C99KZF74C1wd8M6vphkYsOBijNC0tQTpmD4sH7AsurDKmUH
        NDWlV5gOW6CRxKkSK2w1rlwBtAwHXxw=
X-Google-Smtp-Source: APXvYqxk41HJP3PPJEHlHzwOpDyEm0dkOeYtuPZJYqFWRsapimpT9MoYoBDqaw8vb+XXjo5nNZB9qg==
X-Received: by 2002:adf:fbc4:: with SMTP id d4mr26510325wrs.265.1572892226034;
        Mon, 04 Nov 2019 10:30:26 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id l14sm19260528wrr.37.2019.11.04.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:30:25 -0800 (PST)
Date:   Mon, 4 Nov 2019 19:30:23 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     Dave Airlie <airlied@gmail.com>, Hillf Danton <hdanton@sina.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Sandeep Patil <sspatil@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [PATCH v14 1/5] dma-buf: Add dma-buf heaps framework
Message-ID: <20191104183023.GT10326@phenom.ffwll.local>
Mail-Followup-To: Brian Starkey <Brian.Starkey@arm.com>,
        Dave Airlie <airlied@gmail.com>, Hillf Danton <hdanton@sina.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Sandeep Patil <sspatil@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>, lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>, "Andrew F. Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-2-john.stultz@linaro.org>
 <20191104102410.66wlyoln5ahlgkem@DESKTOP-E1NTVVP.localdomain>
 <CAPM=9tydXxV-6++HkkA+JX9GPWE1sN_8CGVCVn-Mwfgfzcn=hg@mail.gmail.com>
 <20191104174341.m6hjzog2vibc3ek3@DESKTOP-E1NTVVP.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104174341.m6hjzog2vibc3ek3@DESKTOP-E1NTVVP.localdomain>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 05:43:51PM +0000, Brian Starkey wrote:
> Hi Dave,
> 
> On Tue, Nov 05, 2019 at 02:58:17AM +1000, Dave Airlie wrote:
> > On Mon, 4 Nov 2019 at 20:24, Brian Starkey <Brian.Starkey@arm.com> wrote:
> > >
> > > Hi John,
> > >
> > > On Fri, Nov 01, 2019 at 09:42:34PM +0000, John Stultz wrote:
> > > > From: "Andrew F. Davis" <afd@ti.com>
> > > >
> > > > This framework allows a unified userspace interface for dma-buf
> > > > exporters, allowing userland to allocate specific types of memory
> > > > for use in dma-buf sharing.
> > > >
> > > > Each heap is given its own device node, which a user can allocate
> > > > a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
> > > >
> > > > Additionally should the interface grow in the future, we have a
> > > > DMA_HEAP_IOC_GET_FEATURES ioctl which can return future feature
> > > > flags.
> > >
> > > The userspace patch doesn't use this - and there's no indication of
> > > what it's intended to allow in the future. I missed the discussion
> > > about it, do you have a link?
> > >
> > > I thought the preferred approach was to add the new ioctl only when we
> > > need it, and new userspace on old kernels will get "ENOSYS" to know
> > > that the kernel doesn't support it.
> > 
> > This works once, expand the interface 3 or 4 times with no features
> > ioctl, and you start being hostile to userspace, which feature does
> > ENOSYS mean isn't supported etc.
> 
> Sorry, perhaps I wasn't clear (or I misunderstand what you're saying
> about working only once). I'm not against adding a get_features ioctl,
> I just don't see why we'd add it before we have any features?
> 
> When we gain the first "feature", can't we add the get_features ioctl
> then? For Future SW that knows about Future features, "ENOSYS" will
> always mean "no features". If it doesn't get ENOSYS, then it can use
> the ioctl to find out what features it has.
> 
> Otherwise we're adding an ioctl which doesn't do anything, based on
> the assumption that in the future it _will_ do something... but we
> don't know that that is yet... but we're pretty sure whatever it will
> do can be described with a u64?
> 
> Why not wait until we know what we want it for, and then implement it
> with an interface which we know is appropriate at that time?

Yeah I'm with Brian, adding the get_feature ioctl when we need it.
Otherwise it's going to be broken somehow and we'll immediately ref to
get_features2 :-)
-Daniel

> > Next userspace starts to rely on kernel version, but then someone
> > backports a feature, down the rabbit hole we go.
> > 
> 
> I suppose that adding the feature ioctl later would mean that it might
> be possible to backport a feature without also backporting the ioctl,
> depending on how the patches are split up. I think it would be pretty
> hard to do accidentally though.
> 
> Thanks,
> -Brian
> 
> > Be nice to userspace give them a features ioctl they can use to figure
> > out in advance which of the 4 uapis the kernel supports.
> > 
> > Dave.
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
