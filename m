Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940EFC48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1E920673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ielkvWlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfFUPt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:49:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44204 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFUPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:49:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so10688207edr.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=urFcwKCOqXsZhsF5Qjs/RceQdsW1nEHCAXTfADLNqxU=;
        b=ielkvWlTL0ttOEF6UkQ2aRv8QOg5eo2l1cwqbFchmDdczzyt1yp6/+Bk4VEkLiQH8o
         U5WipBNtan5McZWNxE98M/PsPKEocjgjUhOp0NmFqET9YqV46O1NzStnGng8buN3F1Lt
         JB8mZ+PmxSllHtucPLQj838mqAuDs6n4NKpA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=urFcwKCOqXsZhsF5Qjs/RceQdsW1nEHCAXTfADLNqxU=;
        b=pHoYSHUs6Seu78I95PeRgtDf5w6uM8ddCPTLd0M/Vd9lodBDBD5wBAmWoVfGY4LM0V
         lHQTYMA7VVp4LwaCuqLnwMsB9Zmr4k3+/MkoUWfyL6JXJtQrHyU5+sUXI/DQ26zwNuFZ
         VwXcaNxbQ6AUWPwINYpmoOI2WTjn14PcsABbeSlEqWg/kxs9l4XDoKLaWebMzyGxJguE
         eN+02cJr0to0NTnZ7ohxlzBxXQau5oDdyjGnxw2Zr5OoFdHRDL/1INj52Ku0RzJyi4Nr
         TkMKRj74TPdhsx/9AW67x3/wwcKBxUIWXtFqU1s0+sUZr0TbJfD2Ca5DnhzUlh22/3e7
         5BIw==
X-Gm-Message-State: APjAAAXt9JiYM2Qjy8DkvoP7wnYBelqA9VDr8Yy+gtG/BBoqLaHMQb2C
        VVxooifomX/utmxjUg7NZmSQcQ7fS74=
X-Google-Smtp-Source: APXvYqz5U9SAoGOPhwyuOMIVZmwVpEK1glb2QXE2/hXQ0Pcs/rm8eZCcsNfwYVlJyv50y+baFiVliw==
X-Received: by 2002:a05:6402:1801:: with SMTP id g1mr54351512edy.262.1561132165340;
        Fri, 21 Jun 2019 08:49:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f36sm930355ede.47.2019.06.21.08.49.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 08:49:24 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:49:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>
Subject: Re: linux-next: Fixes tags need some work in the drm-fixes tree
Message-ID: <20190621154917.GG12905@phenom.ffwll.local>
Mail-Followup-To: Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>
References: <20190621214125.6fb68eee@canb.auug.org.au>
 <1561121145.3149.7.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561121145.3149.7.camel@pengutronix.de>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 02:45:45PM +0200, Philipp Zabel wrote:
> On Fri, 2019-06-21 at 21:41 +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > In commit
> > 
> >   912bbf7e9ca4 ("gpu: ipu-v3: image-convert: Fix image downsize coefficients")
> > 
> > Fixes tag
> > 
> >   Fixes: 70b9b6b3bcb21 ("gpu: ipu-v3: image-convert: calculate per-tile
> > 
> > has these problem(s):
> > 
> >   - Please don't split Fixes tags across more than one line
> > 
> > In commit
> > 
> >   bca4d70cf1b8 ("gpu: ipu-v3: image-convert: Fix input bytesperline for packed formats")
> > 
> > Fixes tag
> > 
> >   Fixes: d966e23d61a2c ("gpu: ipu-v3: image-convert: fix bytesperline
> > 
> > has these problem(s):
> > 
> >   - Please don't split Fixes tags across more than one line
> > 
> > In commit
> > 
> >   ff391ecd65a1 ("gpu: ipu-v3: image-convert: Fix input bytesperline width/height align")
> > 
> > Fixes tag
> > 
> >   Fixes: d966e23d61a2c ("gpu: ipu-v3: image-convert: fix bytesperline
> > 
> > has these problem(s):
> > 
> >   - Please don't split Fixes tags across more than one line
> > 
> 
> I was under the impression that dim would have found those, but I only
> just realized that "dim checkpatch" doesn't actually do any additional
> checks beyond scripts/checkpatch.pl. Fixes tags are checked only as a
> part of "dim push". I wonder if this could be changed [1].
> 
> [1] https://gitlab.freedesktop.org/drm/maintainer-tools/merge_requests/5

Officially we don't yet take pull requests (could try to change that, but
last time around it got nacked by Jani). Can you pls submit to dim-tools@
as patch?

Also, would be nice to run all the same checks we run at dim push time,
not just checking for Fixes tags.
-Daniel

> 
> regards
> Philipp
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
