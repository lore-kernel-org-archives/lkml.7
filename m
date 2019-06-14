Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D15EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436472184B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VWM2vYLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfFNUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:32:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35566 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfFNUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so5248375edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KN+MMrJdiVIVfoSWWn55ZRF9gbRyuAu71YCJdRQFpRk=;
        b=VWM2vYLhPQHrafSrDQJFyDSau+89Xxt/kk+glA2qwPxZ29ccExYoJtEyKzVb7qHMSq
         OF07IqqDGmEAfuCzoUagcSNT4jOb7KzHyf8utimEHOAZIrVJ73/igURZAId4d4hwLd/8
         YpNRjV2z2ylXops4uWCelR0CmBXYmQqv0uhJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KN+MMrJdiVIVfoSWWn55ZRF9gbRyuAu71YCJdRQFpRk=;
        b=Piaf3aZcYmddUaWezsZBe83GwOpRuuz7pilk8My+wby6jSvWKbXKCNS4H9BUx0Z7Ul
         1c5exd86gK7MHvc9QMvpIwCBPgoAh1oezl93i2EubqmvYEqfLb5OuVbCgXWwkcWuIVvF
         FIXbzKmhlgc6Rz8YUJ+1yJQjFKK2mq0fzm5V32I7EG2SHCVY65pRaSgfFaB7WDZfLbzA
         F/Zr3svUjNnVXMwgKrqo2wtn4OsCmYa1Rh7KUILOA2GzVAzrV4bweUNzDKJHjO48jdFr
         vTd6wU1csKpPn5mMdQrzhMXo3ua8ZnoD4soBxEPi+ZoVe78tMbmTzMxerxPaDwijye0o
         lKaw==
X-Gm-Message-State: APjAAAULudyRzxvuOE/vamtgYFMlqIDSqAq1cWEoWr2nXjFMlPfD3xpO
        vyxIFvW7jo9G9ndeRstbgXWkxQ==
X-Google-Smtp-Source: APXvYqzs5TtIkPYbwFylQmX4JfL716O72INnTisyVLZpVam1/N8EkPIy/YAYosSNlQ0xCI+3ngip/A==
X-Received: by 2002:a17:906:63c1:: with SMTP id u1mr83393976ejk.173.1560544244991;
        Fri, 14 Jun 2019 13:30:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 17sm1184399edu.21.2019.06.14.13.30.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 13:30:43 -0700 (PDT)
Date:   Fri, 14 Jun 2019 22:30:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     christian.koenig@amd.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, "Anholt, Eric" <eric@anholt.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        lima@lists.freedesktop.org
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
Message-ID: <20190614203040.GE23020@phenom.ffwll.local>
Mail-Followup-To: christian.koenig@amd.com,
        Peter Zijlstra <peterz@infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, "Anholt, Eric" <eric@anholt.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        lima@lists.freedesktop.org
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com>
 <20190614131916.GQ3436@hirez.programming.kicks-ass.net>
 <20190614152242.GC23020@phenom.ffwll.local>
 <094da0f7-a0f0-9ed4-d2da-8c6e6d165380@gmail.com>
 <CAKMK7uFcDCJ9sozny1RqqRATwcK39doZNq+NZekvrzuO63ap-Q@mail.gmail.com>
 <d97212dc-367c-28e9-6961-9b99110a4d2e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d97212dc-367c-28e9-6961-9b99110a4d2e@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 08:51:11PM +0200, Christian König wrote:
> Am 14.06.19 um 20:24 schrieb Daniel Vetter:
> > 
> > On Fri, Jun 14, 2019 at 8:10 PM Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
> > > [SNIP]
> > > WW_MUTEX_LOCK_BEGIN()
> > > 
> > > lock(lru_lock);
> > > 
> > > while (bo = list_first(lru)) {
> > > 	if (kref_get_unless_zero(bo)) {
> > > 		unlock(lru_lock);
> > > 		WW_MUTEX_LOCK(bo->ww_mutex);
> > > 		lock(lru_lock);
> > > 	} else {
> > > 		/* bo is getting freed, steal it from the freeing process
> > > 		 * or just ignore */
> > > 	}
> > > }
> > > unlock(lru_lock)
> > > 
> > > WW_MUTEX_LOCK_END;
> 
> Ah, now I know what you mean. And NO, that approach doesn't work.
> 
> See for the correct ww_mutex dance we need to use the iterator multiple
> times.
> 
> Once to give us the BOs which needs to be locked and another time to give us
> the BOs which needs to be unlocked in case of a contention.
> 
> That won't work with the approach you suggest here.

A right, drat.

Maybe give up on the idea to make this work for ww_mutex in general, and
just for drm_gem_buffer_object? I'm just about to send out a patch series
which makes sure that a lot more drivers set gem_bo.resv correctly (it
will alias with ttm_bo.resv for ttm drivers ofc). Then we could add a
list_head to gem_bo (won't really matter, but not something we can do with
ww_mutex really), so that the unlock walking doesn't need to reuse the
same iterator. That should work I think ...

Also, it would almost cover everything you want to do. For ttm we'd need
to make ttm_bo a subclass of gem_bo (and maybe not initialize that
embedded gem_bo for vmwgfx and shadow bo and driver internal stuff).

Just some ideas, since copypasting the ww_mutex dance into all drivers is
indeed not great.
-Daniel

> 
> Regards,
> Christian.
> 
> > 
> > 
> > Also I think if we allow this we could perhaps use this to implement the
> > modeset macros too.
> > -Daniel
> > 
> > 
> > 
> > 
> > > > This is kinda what we went with for modeset locks with
> > > > DRM_MODESET_LOCK_ALL_BEGIN/END, you can grab more locks in between the
> > > > pair at least. But it's a lot more limited use-cases, maybe too fragile an
> > > > idea for ww_mutex in full generality.
> > > > 
> > > > Not going to type this out because too much w/e mode here already, but I
> > > > can give it a stab next week.
> > > > -Daniel
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
