Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98288C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F38C206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hHCmvgss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfC2PZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:25:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37637 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfC2PZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:25:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id v21so2380487edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+j5naJzagBKSIXO+iRAU1SvHT15/V9v3CCeSklqZro=;
        b=hHCmvgssBKZI7QiJW4Bv393LztSKSKiNhVwJT8at/sOv6hxu/9TmfGKM3jQrQ2ppHD
         bYz2GDQsDd872Br/7jP/G+kVB/ggPoEra0lHSgBcj7IsD2nA+zgdOcXCfmDK/9tgeVU6
         8ui6bb7RBc1wiabwKVsnpEdbiCnyUVrCMunHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=n+j5naJzagBKSIXO+iRAU1SvHT15/V9v3CCeSklqZro=;
        b=dIoS4Zr4bqHQ8i9IKz2NLsTAWqXSsC6Pm5/KhFV058Ft5mnhlWiPXW7DTrr0nIsvpp
         i0neZnwX1kf2AyXoyw3HT26kgNRUWIqckJKi0P/LSpSAofOvAHGj5aVV0FbwYlD/+33D
         vrRU44x3Z0yRvDCn+Knxgn9hR4Bmf4FpyHLwhBo7AT5GoFzlypb8a8NM9qEBn4+iBok/
         9SzMt3/cP+mhROJjGHwWWAa8zICl/UPbEG477Z51TyRwHFSVArv1Duyg1GJ3hckS1zji
         6ZJJO8MURPzdRWy0G6O+ZePLTyJiGw8VosQ0X4HjUkE3rpcH2gX/2cWsz5zuj6FEMoIy
         6J+w==
X-Gm-Message-State: APjAAAWWEefHVTcbJZhz8r/srmf0+Q5HBmP9O0U/JqakXSYR8IsCG8tP
        1Lr9KOH/1gjBDEVhnUwmVtVHWfNYMSM=
X-Google-Smtp-Source: APXvYqzpnKp5ybbQfwrU7HDB+6NrpGcZDETt4QZvnLqk65gPppCBrQU3cGPzfcf90Ap9WyXm9eG2tA==
X-Received: by 2002:a17:906:a945:: with SMTP id hh5mr5238211ejb.108.1553873105860;
        Fri, 29 Mar 2019 08:25:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k3sm715519edi.65.2019.03.29.08.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 08:25:04 -0700 (PDT)
Date:   Fri, 29 Mar 2019 16:25:02 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Daniel Stone <daniel@fooishbar.org>, Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
Message-ID: <20190329152502.GO2665@phenom.ffwll.local>
Mail-Followup-To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Daniel Stone <daniel@fooishbar.org>, Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com>
 <20190320154809.14823-2-paul.kocialkowski@bootlin.com>
 <87zhpph4c2.fsf@anholt.net>
 <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
 <20190328185307.GZ2665@phenom.ffwll.local>
 <CAPj87rMmW_7Kiy==ZxvvmHXhQLWC+F=uxed442HpMMZr=MwjRA@mail.gmail.com>
 <5ed7c5f361bca47d3f9771f9ed27e28e2fccb179.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed7c5f361bca47d3f9771f9ed27e28e2fccb179.camel@bootlin.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 04:02:23PM +0100, Paul Kocialkowski wrote:
> Hi,
> 
> On Fri, 2019-03-29 at 09:09 +0000, Daniel Stone wrote:
> > Hi,
> > 
> > On Thu, 28 Mar 2019 at 18:53, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Thu, Mar 21, 2019 at 04:27:06PM +0100, Paul Kocialkowski wrote:
> > > > I don't see other options either, and using firstclose/lastopen feels
> > > > overall more readable in the driver code.
> > > > 
> > > > I'm not sure there is such a big overhead associated with allocating
> > > > the binner BO (it seems that the current implementation tries to alloc
> > > > until the specific memory constraints for the buffer are met, so
> > > > perhaps that can take time). But if there is, I suppose it's best to
> > > > have that when starting up rather than delaying the first render
> > > > operation.
> > > 
> > > I'm not entirely buying the "we don't need this for fbcon only" argument -
> > > there's plenty of dumb kms clients too (boot splash and whatever else
> > > there might be). If you don't want to keep this around I think allocating
> > > on first non-dumb bo allocation and dropping it when the last such fd
> > > closes sounds like a much better idea. Needs a bit more state, you need to
> > > track per drm_file whether you've already allocated a non-dumb bo, and a
> > > drm_device refcount, but that's not much. Firstopen feels like the wrong
> > > thing.
> > > 
> > > Another option would be first_renderopen or something like that, except
> > > you can also render on the legacy node and I'm not sure how much there's a
> > > demand for this in other drivers. In the end you have open/close
> > > callbacks, you can do all the driver specific things you want to do in
> > > there.
> > 
> > I'd like to avoid doing it in open where possible, since that hurts
> > device enumeration from userspace.
> 
> I've noticed the same issue with firstopen, where our buffer is
> allocated/liberated a couple of times during enumeration, before the
> final open that stays alive during use.
> 
> I'm not sure what is preferable between that and allocating when the
> GPU is first used. Slowing down the first GPU operation with the
> allocation does not sound too great either and it feels like the buffer
> should have been allocated earlier.
> 
> To me, it feels I think it's better to have delays due to allocation at
> enumeration / startup rather than later on, but I might be missing some
> elements to have a clear idea.
> 
> What do you think?

We'll have the delay somewhere on driver load. Better to have it only once
(when the driver starts using gem for real), than a bunch of time, at
least once while enumerating and then once more while actually
initializing. I think if you allocat this on first non-dumb gem_create,
and on first command submission (just so evil userspace can't screw up the
hw too badly), that should be perfectly fine.

Only way to avoid that is to allocate at driver load and pin it, but
that's what we're trying to avoid here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
