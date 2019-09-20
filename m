Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC48C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA0C206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYxfejZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393119AbfITALX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 20:11:23 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:46672 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391048AbfITALX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 20:11:23 -0400
Received: by mail-lj1-f172.google.com with SMTP id e17so5281925ljf.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QirEQc5qlamFBqqvxkVBnRarU/sj3bjs59u63W/8Eg=;
        b=LYxfejZOKW0piBxjokV7xP7MYnIEo2xpdVM8iwR8MuqG5goR+tjWkPo9hmpeR9rgPA
         VGl6j/WtDdCFJhjGvMYx1BO7MZ/BPNJQPD+GeQ0mnlxtL1p/2lR8UlhRdy9IwgC+rvny
         LcFHaYuW83/7yAlmN38bnVXUOUGbxKeVIcfAg9pQyRel3d7pUp+K6mTtDDpqdyPuqffC
         gQAVcwoQGGIOl97lImxNESJOUklXk/nPITTQ1CED+EqDxBZEIdNOKJ6wpJrV69XtieAV
         U4pBWv0YOWYzYUc0t+gipYOgNuAW+QJGDXa5u7kBcAmSUhYi0OEAo6lhLxoNyGuBBhBv
         Glhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QirEQc5qlamFBqqvxkVBnRarU/sj3bjs59u63W/8Eg=;
        b=KI49cUIPEpUOf83azrhnV5auTCGnO5LN7YLQtfR7cDE56MmZxtEoU1FGfLIhLpKG+J
         5QN2zV41/WaufWFmgQQa0+I8UOHs9EVS4JzBB3ejhZGYnkaABC3HqAm31xTBk8fN5FfO
         eUJQuIbb19XdYWggaOAL3Xk4J6Qf3M6qRsb87hBY4njIcf6Ub1PgB9kzNPlNVok633mg
         XQDK+9X21G+tsSytix46I1Jk+sWI9dslwmuXMkA7OTVJnPfeR2dYRXTjrYQ5Ltan9t/r
         Iy5P1XMGKtnWSoEwONR/vwqnaVF+UlB8Ij87MzlkGN6ngya+0q6BY8MBNr+UaGrDgQZ9
         Xx7g==
X-Gm-Message-State: APjAAAXTfiimTA7rNyg5PW4I3HUmi8GSjGC44jMovI2hIM/Zg5NJAMXb
        nSJt08qutGAUbGo2kpyF4ZZLv0Mh/5KQQvWtYcw=
X-Google-Smtp-Source: APXvYqwySQBYWwyYZO8gF/0MYjFDLzMMeCGJIZyA0GeH0w63lVsIG0gF26wesF4EguvkavYeQxrt2HdHGcNDRXhw8FE=
X-Received: by 2002:a2e:9708:: with SMTP id r8mr6797597lji.58.1568938281104;
 Thu, 19 Sep 2019 17:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txTjip6SonSATB-O38TGX9ituQaw+29PnAkNJ960R1z6g@mail.gmail.com>
 <CAHk-=wjHDrmx+Rj+oJw5V4mfWjpYzpwcJbqY-L-nvsNW_d8e_g@mail.gmail.com>
In-Reply-To: <CAHk-=wjHDrmx+Rj+oJw5V4mfWjpYzpwcJbqY-L-nvsNW_d8e_g@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 20 Sep 2019 10:11:09 +1000
Message-ID: <CAPM=9tzLFenqZQo_NQqKd5xPQ5g-5WY+JxTotL7AHk_+6S89ow@mail.gmail.com>
Subject: Re: [git pull] drm tree for 5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexandre Courbot <acourbot@chromium.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm. My merge isn't identical to that. It's close though. Different
> order for one #define which might be just from you and me merging
> different directions.
>
> But I also ended up removing the .gem_prime_export initialization to
> drm_gem_prime_export, because it's the default if none exists. That's
> the left-over from
>
>     3baeeb21983a ("drm/mtk: Drop drm_gem_prime_export/import")
>
> after the import stayed around because it got turned into an actually
> non-default one.
>
> I think that both of our merges are right - equivalent but just
> slightly different.
>
> But the reason I'm pointing this out is that I also get the feeling
> that if it needs that dev->dev_private difference from the default
> function in prime_import(), wouldn't it need the same for prime_export
> too?
>
> I don't know the code, and I don't know the hardware, but just from a
> "pattern matching" angle I just wanted to check whether maybe there's
> need for a mtk_drm_gem_prime_export() wrapper that does that same
> thing with
>
>         struct mtk_drm_private *private = dev->dev_private;
>
>         .. use private->dev  instead of dev->dev ..
>
> So I'm just asking that somebody that knows that drm/mtk code should
> double-check that oddity.

I've cc'ed Alexandre who wrote the import half of this code to look into it.

I've looked at the other results and it all seems fine to me.

Dave.
