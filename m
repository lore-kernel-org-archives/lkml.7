Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE90DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A192133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sUp4PNm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfFNNWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:22:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfFNNV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BLef20GVw4MoTfiVzpLfCs64UYHDEIOk/MMjB+e9V0s=; b=sUp4PNm0UlGY6gGWIuw3RPxmUV
        Adb3VTZgQSN7aSag0MwXLaRvK0LiJeN7csWmb4E+CvX+R6KS0yOUwTAp70G9/HUhNmKEe5qZRyhaU
        xa/jKBkVbLf+pt2xlw+t4sbbscFf+9nFYhJvBTxSHD6dxs943UC9blcGOrKqFI2UuvD+O5HlLx0K7
        aPysM441FvEEEdCbsYthyqVghB9SFas4CbTIU9jVMHgyj+8SrqD2rCtbSYK/FBZPsY0ufzAUdrBZX
        wG6ydnj3Sj2jWTTA2TyVZ+oshoU9pSw4MjsMDNAgnPaOG0w2UrwRsZ2HsTHh8IHQND00uHzCM+WiP
        DwmBRIww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbm9T-0007v7-MV; Fri, 14 Jun 2019 13:21:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDD2E2013F73E; Fri, 14 Jun 2019 15:21:53 +0200 (CEST)
Date:   Fri, 14 Jun 2019 15:21:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     christian.koenig@amd.com
Cc:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, thellstrom@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, lima@lists.freedesktop.org
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
Message-ID: <20190614132153.GR3436@hirez.programming.kicks-ass.net>
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com>
 <20190614125940.GP3436@hirez.programming.kicks-ass.net>
 <6f2084ae-61d5-8cb9-c975-901456eed7e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f2084ae-61d5-8cb9-c975-901456eed7e3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 03:06:10PM +0200, Christian König wrote:
> Am 14.06.19 um 14:59 schrieb Peter Zijlstra:
> > +#define ww_mutex_lock_for_each(loop, pos, contended, ret, intr, ctx)   \
> > +       for (contended = ERR_PTR(-ENOENT); ({                           \
> > +               __label__ relock, next;                                 \
> > +               ret = -ENOENT;                                          \
> > +               if (contended == ERR_PTR(-ENOENT))                      \
> > +                       contended = NULL;                               \
> > +               else if (contended == ERR_PTR(-EDEADLK))                \
> > +                       contended = (pos);                              \
> > +               else                                                    \
> > +                       goto next;                                      \
> > +               loop {                                                  \
> > +                       if (contended == (pos)) {                       \
> > +                               contended = NULL;                       \
> > +                               continue;                               \
> > +                       }                                               \
> > +relock:                                                                        \
> > +                       ret = !(intr) ? ww_mutex_lock(pos, ctx) :       \
> > +                               ww_mutex_lock_interruptible(pos, ctx);  \
> > +                       if (ret == -EDEADLK) {                          \
> > +                               ww_mutex_unlock_for_each(loop, pos,     \
> > +                                                        contended);    \
> > +                               contended = ERR_PTR(-EDEADLK);          \
> > +                               goto relock;                            \
> > 
> > while relock here continues where it left of and doesn't restart @loop.
> > Or am I reading this monstrosity the wrong way?
> 
> contended = ERR_PTR(-EDEADLK) makes sure that the whole loop is restarted
> after retrying to acquire the lock.
> 
> See the "if" above "loop".

ARGH, the loop inside the loop... Yeah, maybe, brain hurts.
