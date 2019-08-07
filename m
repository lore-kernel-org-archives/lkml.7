Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E89C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF34E218FE
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iYQBlMMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfHGLk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:40:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36030 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfHGLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:40:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id r6so102918341oti.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u29YZUSF8gmWkdHKDYGSBVYcnPuAF9Z+Z15UNCjQBh4=;
        b=iYQBlMMi7h2rWOIbCa0SK9ioKSJCm+YmQyXG61XP56+485S8fAX4FvlL+H942DNVYo
         DFZRw8kyejuPYyd2V5djtNNKwvVPvKGQjeeAhrgYj6dzyDVPHjUgX0lfnIe/7ijxi8o3
         8Ju0JeK7qHlU6SrPbsgwEaMYQxJHv7xQGIGa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u29YZUSF8gmWkdHKDYGSBVYcnPuAF9Z+Z15UNCjQBh4=;
        b=TnyX38xCQCuwBkY86uf8JCFEt5+AKjawIp2aM2W5cSMqMyl9nrCpErOlsjkgpl0b+D
         Ng7+/01Kx2qGWoXXKBI+fFQ5KebNaFNSQbwE8OQyuUZha3w7S+0WPFQS1w5sW60h8C1T
         wcSHQ5vnIBHm8v6hiCWI9dLQlI6wMUZNhRagP5+/V37o4XIqfMiBLZTa96h40Nn8ZRBm
         sevmLsLBLvXLc0YSit1zHawVjhimXHY4kOWtEsaipaYro3hwy5Twd5SBTCdELyMOexi5
         Kty5wVRjS6JiNf46g959LF0bj8B2Uv0RWP1cz29tKg2gXEQT6QwKOHpb4/42mk9AKGtT
         3lAw==
X-Gm-Message-State: APjAAAWJKtR3m3Ck2Mena6SZsdYg+6G5llP8GQy1pgLogM1M3Pv3VBmA
        xEwEQdBiy05k1Bv+fl18pg8nQhl459roQz4RuVRsnc0Rz5mppg==
X-Google-Smtp-Source: APXvYqxT2XiKla161CdG5VV7N+Sxvaq+Mpb5UevTVHAAluDye0YEIyY1lAlxhgJ2u3t8QW3N9fXzNTi1uwKXFob7AjY=
X-Received: by 2002:a05:6808:118:: with SMTP id b24mr5059229oie.128.1565178027368;
 Wed, 07 Aug 2019 04:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190806133454.8254-1-kraxel@redhat.com> <20190806133454.8254-2-kraxel@redhat.com>
 <20190806135426.GA7444@phenom.ffwll.local> <20190807072654.arqvx37p4yxhegcu@sirius.home.kraxel.org>
 <CAKMK7uFyKd71w4H8nFk=WPSHL3KMwQ6kLwAMXTd_TAkrkJ++KQ@mail.gmail.com> <20190807103649.aedmac63eop6ktlk@sirius.home.kraxel.org>
In-Reply-To: <20190807103649.aedmac63eop6ktlk@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 7 Aug 2019 13:40:15 +0200
Message-ID: <CAKMK7uHNXjSsuUTkxzVbeDNP4ESFBObHZe6xxJYEHE1-QyKqhQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: add gem ttm helpers
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 12:36 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > Same for this, you're just upcasting to ttm_bo and then downcasting to
> > > > gem_bo again ... I think just a series to roll out the existing gem
> > > > helpers everywhere should work?
> > >
> > > I don't think so.  drm_gem_dumb_map_offset() calls
> > > drm_gem_create_mmap_offset(), which I think is not correct for ttm
> > > objects because ttm_bo_init() handles vma_node initialization.
> >
> > More code to unify first? This should work exactly the same way for
> > all gem based drivers I think ... Only tricky bit is making sure
> > vmwgfx keeps working correctly.
>
> Yea.  Unifying on the gem way of doing things isn't going to work very
> well.  We would have to keep the current way of doing things in the ttm
> code, wrapped into "if (ttm_bo_uses_embedded_gem_object()) { ... }", to
> not break vmwgfx.
>
> So adding gem ttm helpers (where gem+ttm drivers can opt-in) looked like
> the better way of handling this to me ...

Ok I looked again, and your ttm version seems to exactly match
drm_gem_dumb_map_offset(), which we almost called
drm_gem_map_offset(). And could do that again by undoing that revert.
So I'm not seeing how a generic version for this stuff here wouldn't
also work for ttm ... Ofc if vmwgfx does something else they can keep
their own specific dumb map_offset implementation.

What am I missing?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
