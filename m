Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17D0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B48520880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gDi7sxor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfDOPnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:43:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42187 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:43:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id x61so15097894edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iLYihP302CGl8iTQsNLBRNlcVyDiev3EggGLEBc+/gI=;
        b=gDi7sxorGTkR2q9v33CbnX2EyIeoqv+LqksDSF6JPHC7OrQx7RojkMUqKKAzzStKoH
         5VxTpx6LXWI7J1OhDfyFeuDPvNwbz57GmTGiXzfCvgbu2j6WPYmctQdB3s7iIXuVn8vU
         KiGgjd4B+4a4EooYFiZZyhOtr254TTx9+J6NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=iLYihP302CGl8iTQsNLBRNlcVyDiev3EggGLEBc+/gI=;
        b=qqqMRhIfzgru/57IBrbW0ieSnlcgx8gYdWkGl9/f4fGaEGLBLELnhPoleyZ1qTeIej
         hVW7tPnpRgVxkWEJEl/CgwBmAmJHpOTLKxuUkuKuTK9QJq2HU9/zIQn/23OJSXH4GpsA
         Cbxdy5n2J9k2+5pI1PeaipR5e48EzGrqKFV0uyydAEv+oOaeawddRLHdbVQig1ILsSly
         3xbgJKgmf13M8kCN6NFLZs1uvqaswDHYlys1g6go9zU7SsTTKmrb+FNPbpK2jLtB8d8k
         Qhrr+fQsxr+2RRZY35J5xz8oBEw6oqJNIvE3RIHrzxncwylrIqgCI6RA2GKXO+QC7kCz
         W+oQ==
X-Gm-Message-State: APjAAAWYUkEZJiBnddmUxRsq1N+p+ntmdKZbd9D9B5Heor8VfbuzvNCg
        IB93Ljfn+OVbDdtfgOGc02wVBA==
X-Google-Smtp-Source: APXvYqwSzqhsGy+qrknAlCrRdFnySI5FKubXKvL9RIrrOZs+p/TXDcooSzr8qHvsdtMiYEa1h8R6dg==
X-Received: by 2002:a50:95ed:: with SMTP id x42mr9082352eda.92.1555342993199;
        Mon, 15 Apr 2019 08:43:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z3sm7749660eja.32.2019.04.15.08.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:43:12 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:43:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Joel Stanley <joel@jms.id.au>
Cc:     David Airlie <airlied@linux.ie>, Andrew Jeffery <andrew@aj.id.au>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] drm: aspeed: Clean up Kconfig options
Message-ID: <20190415154310.GA2665@phenom.ffwll.local>
Mail-Followup-To: Joel Stanley <joel@jms.id.au>,
        David Airlie <airlied@linux.ie>, Andrew Jeffery <andrew@aj.id.au>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20190405081117.27339-1-joel@jms.id.au>
 <20190415093012.GX2665@phenom.ffwll.local>
 <CACPK8XcT4Z-9mbqc0obteWKOoLYke+gR4Hd0rZ-C=g0NgSNd0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcT4Z-9mbqc0obteWKOoLYke+gR4Hd0rZ-C=g0NgSNd0A@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 06:41:48PM +0800, Joel Stanley wrote:
> On Mon., 15 Apr. 2019, 17:32 Daniel Vetter, <daniel@ffwll.ch> wrote:
> 
> > On Fri, Apr 05, 2019 at 06:41:17PM +1030, Joel Stanley wrote:
> > > The GFX IP is inside of the ASPEED BMC SoC so there is little use
> > > enabling it on a kernel that does not support ASPEED.
> > >
> > > When building with COMPILE_TEST the architecture many not have CMA
> > > support, so to avoid breaking the build we only select these options if
> > > the architecture supports the contiguous allocator.
> > >
> > > I suspect the DRM_PANEL came from a cut/paste error.
> > >
> > > Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Iirc you have commit rights, right?
> >
> 
> Can you please apply this one for me? I'm traveling and don't have my keys
> with me.

Ok, since it's holding up linux-next testing I've applied, in general it's
ok to just wait until you're back I think.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
