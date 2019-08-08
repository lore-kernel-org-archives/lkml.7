Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7187C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F9321874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H0rFW5uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfHHMDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:03:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37673 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfHHMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:03:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so90540779eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjkixiaAxxiFzy53lT4YCqiUuJ/UBCWwzzeoMnM6RlY=;
        b=H0rFW5uZXHZS+RuXNwstBwPPPpRfFQon8ZE5XaQ+FNEGeGJN8mlmawD5YnvL7fL33i
         ewcwGDEBgMQDYZGlhdtrhwb/0YSj6gE7jkmCebU8HJB7XL6fAR8IcyDLN0tjsyXn+zLy
         6dbY4z5KvcQibmXPwl+FLgWKftHbHboPAn3WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mjkixiaAxxiFzy53lT4YCqiUuJ/UBCWwzzeoMnM6RlY=;
        b=exAu0R6gev6Rzc9H7Ea9zf3LQT+lN0ysEaYvoTgPgSkVOu7wo30pUIZPKmKF8F7+K9
         d6QM+NDVy8FLiexaBhIGaklt7lyu5/kHHhON1/kByWKHKq3fTo2nYAUKNoeCOQVXZnNt
         GTKm7HSR1ts6WdqH0mZ53UgOXF1N2RP71u7Hm1mjRM4TPX3oKgzAQ+NZ7W4PpPJ0g6db
         0+RXtt9aDabC96kRe1KX3XNQ7d+CHjJC15CLdtHkTd4cXnYcKe7bAj8IJcEGIYIkgefI
         aGkM/j0hEvrpiBXByshIc/8hHk+Flfaakd2OK1DMOGq8dPtPlSKs92hFyODu4Og8FDnc
         dg2g==
X-Gm-Message-State: APjAAAX0JimzV7DWitNxVMO8JZVtDRM7H7fLkwXfwmOez/V3OfD9tm7H
        /lggFxk/FOntYoc3OcsL24Xxsw==
X-Google-Smtp-Source: APXvYqzS2rW0Qbp+LlSlJ+X0OO40h6QF5T89vsZiuJ9G7cPdSUcDvRNM2I/k5rBAMmDHONeBm2xZJw==
X-Received: by 2002:a17:906:d201:: with SMTP id w1mr4872515ejz.303.1565265780504;
        Thu, 08 Aug 2019 05:03:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y48sm308925edc.66.2019.08.08.05.02.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 05:02:59 -0700 (PDT)
Date:   Thu, 8 Aug 2019 14:02:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] ttm: turn ttm_bo_device.vma_manager into a pointer
Message-ID: <20190808120252.GO7444@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190808093702.29512-1-kraxel@redhat.com>
 <20190808093702.29512-3-kraxel@redhat.com>
 <2a90c899-19eb-5be2-3eda-f20efd31aa29@amd.com>
 <20190808103521.u6ggltj4ftns77je@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808103521.u6ggltj4ftns77je@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:35:21PM +0200, Gerd Hoffmann wrote:
> On Thu, Aug 08, 2019 at 09:48:49AM +0000, Koenig, Christian wrote:
> > Am 08.08.19 um 11:36 schrieb Gerd Hoffmann:
> > > Rename the embedded struct vma_offset_manager, it is named _vma_manager
> > > now.  ttm_bo_device.vma_manager is a pointer now, pointing to the
> > > embedded ttm_bo_device._vma_manager by default.
> > >
> > > Add ttm_bo_device_init_with_vma_manager() function which allows to
> > > initialize ttm with a different vma manager.
> > 
> > Can't we go down the route of completely removing the vma_manager from 
> > TTM? ttm_bo_mmap() would get the BO as parameter instead.
> 
> It surely makes sense to target that.  This patch can be a first step
> into that direction.  It allows gem and ttm to use the same
> vma_offset_manager (see patch #3), which in turn makes various gem
> functions work on ttm objects (see patch #4 for vram helpers).

+1 on cleaning this up for good, at least long-term ...

> > That would also make the verify_access callback completely superfluous 
> > and looks like a good step into the right direction of de-midlayering.
> 
> Hmm, right, noticed that too while working on another patch series.
> Guess I'll try to merge those two and see where I end up ...

... but if it gets too invasive I'd vote for incremental changes. Even if
we completely rip out the vma/mmap lookup stuff from ttm, we still need to
keep a copy somewhere for vmwgfx. Or would the evil plan be the vmwgfx
would use the gem mmap helpers too?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
