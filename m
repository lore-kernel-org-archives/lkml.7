Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231FAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48A52073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bfIvQYOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfDOJSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:18:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33983 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOJSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:18:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id a6so2775338edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ynQtq/6aBUoTAipkeDKcQtf7kKsME/OPz6dQg69/ZqA=;
        b=bfIvQYOsMuRfY7e2nyCsEZp366cC8dWDkDaYDWjxwzxadojySJtksZwssf/48Lk7uf
         GUHPNRX/ujNQ1QYwPiFyrGwtJaU7VpLIjhP0kl/W9R9YUMRSfK4Gyd8c0Ab6ecPHf9bw
         kywY6l2dmW2fER/dievAMG/iLNhDovtkvEkX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ynQtq/6aBUoTAipkeDKcQtf7kKsME/OPz6dQg69/ZqA=;
        b=JJ0Df8x4ZcjXgD5uKPydg1/KP5gP0q7mdsQ/AAt3NteZEYb/9WSB9KMFFm+/BY5/i4
         UJClh8flBsk4EWlEnDiCjVPyuue8OC9eDkwurmIciyoHIXzDU06ZU2Mqb+Qn//wkzgio
         fejNqb+x8GoqmXFUbdP5sQxe9tivtAvpn56p491Ms2MIKfxSAy5SLNrbPW9zo11sbUY5
         nrrVtvEuth8QV+clFNyLvR0WY5q/ZzrOSmnzVY2cqMl61z8/rcltkh/15M+FRuevAdoJ
         8l7NvnxHJfKzRuFdSXcDMPG21KGrr+GRVI+SELbsxL5pinbU5kO6NiOcbO7NrR6/36X6
         Nx0w==
X-Gm-Message-State: APjAAAV4iu1g+tIrMm2Axe9mCuXuRMlFhqbMg5n9gMjj+wetQkw89H11
        3SRcqllLI0JnCGtfYdFsEf61jg==
X-Google-Smtp-Source: APXvYqz4bP4buv8PrROHVBzhkpiDUy0i+0wCAHiCT1WKRbo3mf5xVcBaqcpM2rq8dc8Va+iUasniiA==
X-Received: by 2002:aa7:ca07:: with SMTP id y7mr14132059eds.149.1555319920740;
        Mon, 15 Apr 2019 02:18:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b2sm2635652eds.15.2019.04.15.02.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 02:18:39 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:18:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Steven Price <steven.price@arm.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        iommu@lists.linux-foundation.org,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Message-ID: <20190415091837.GV2665@phenom.ffwll.local>
Mail-Followup-To: Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, iommu@lists.linux-foundation.org,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
 <20190405161632.GA9160@rosenzweig.io>
 <34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:42:33PM +0100, Steven Price wrote:
> On 05/04/2019 17:16, Alyssa Rosenzweig wrote:
> > acronym once ever and have it as a "??"), I'm not sure how to respond to
> > that... We don't know how to allocate memory for the GPU-internal data
> > structures (the tiler heap, for instance, but also a few others I've
> > just named "misc_0" and "scratchpad" -- guessing one of those is for
> > "TLS"). With kbase, I took the worst-case strategy of allocating
> > gigantic chunks on startup with tiny commit counts and GROW_ON_GPF set.
> > With the new driver, well, our memory consumption is scary since
> > implementing GROW_ON_GPF in an upstream-friendly way is a bit more work
> > and isn't expected to hit the 5.2 window.
> 
> Yes GROW_ON_GPF is pretty much required for the tiler heap - it's not
> (reasonably) possible to determine how big it should be. The Arm user
> space driver does the same approach (tiny commit count, but allow it to
> grow).

Jumping in here with a drive through comment ...

Growing gem bo and dma-buf is going to be endless amounts of fun, since we
hard-coded that their size is invariant.

I think the only reasonable way to implement this is if you allocate a
really huge bo, map it, but only put the pages in on faulting. Or when
really evil userspace tries to export it. Actually changing the underlying
buffer size is not going to work I think.

Note: I didn't read kbase, so might be totally wrong in how GROW_ON_GPF
works.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
