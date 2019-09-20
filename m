Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2C4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909C220665
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SWhpw9n8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392880AbfITGMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:12:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32953 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389579AbfITGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:12:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id e18so839838oii.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 23:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lESsRT7Y742o9lu/7K8TiQ3yA1m0tsPUb2vMEBOJDG8=;
        b=SWhpw9n8wEag72+Bq3xU93j3s9vQ6N+riAK0leJCeHMgOch5nmKmhvSYL+Jhn/1kEw
         KJSE9g3m+BQTRg9EdWIxwrt7Ttz8c5mq8dKO5z38wG6ZChbw3wXHBBrL58n81xrLGhv9
         ni7fxymhsN7XJxvNm1dEqL8+FvlXzAjIzLixU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lESsRT7Y742o9lu/7K8TiQ3yA1m0tsPUb2vMEBOJDG8=;
        b=ochDFb7Su5mIIHX25YBMzAvyIbbLYB3brtnfzOsE6WQS36Xa4SLLFUmiHMlHh4Ktej
         AGrbo82irCJ17Isl7ot1WbP34U4KrzjutKQ1pDLqNwjXiT8dEbYmVMLT2mNsOX3zDQ3Y
         7afRWsDVi1FQ2vI3vojkSn/LPmSnoFZDFRswWfd1WV567pRgaBxiTL4m1g1BbYiGb64J
         CacIR8ZvrF61qehDCxx84zaaabTEns40XATrlMQn44i+c/KnutJ5rTnXKWkkOwMog/yF
         65LLi4zwNyYhW4T8yESpMHf4BCGDF2ZBjuKFnbFJVMsNorGCWPEyxuT3WHPYK7VYS1YT
         JLSQ==
X-Gm-Message-State: APjAAAV8yH2jX/XrMlhAt1fp6e/SlDq8l3mQEkjzEMr0qBO08R7nj1ZQ
        s7plIngbBxCx2tssL5/ajzwbUaPzxrmyCvyZj263zKV2
X-Google-Smtp-Source: APXvYqzTN7JfI+nPor6h/gdDsP+sD4veOVaMUBxGoFMVBtbAM50YvC2eEmGFl6vAWO8whxDaCQl6kvwaPAt6JU9IQDs=
X-Received: by 2002:aca:d841:: with SMTP id p62mr1636407oig.128.1568959961655;
 Thu, 19 Sep 2019 23:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txTjip6SonSATB-O38TGX9ituQaw+29PnAkNJ960R1z6g@mail.gmail.com>
 <CAHk-=wjHDrmx+Rj+oJw5V4mfWjpYzpwcJbqY-L-nvsNW_d8e_g@mail.gmail.com> <CAPM=9tzLFenqZQo_NQqKd5xPQ5g-5WY+JxTotL7AHk_+6S89ow@mail.gmail.com>
In-Reply-To: <CAPM=9tzLFenqZQo_NQqKd5xPQ5g-5WY+JxTotL7AHk_+6S89ow@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 20 Sep 2019 08:12:29 +0200
Message-ID: <CAKMK7uHdNgL2hKdGqKeht2n2An4jemhrr2Jpn0JYpHbop67GpA@mail.gmail.com>
Subject: Re: [git pull] drm tree for 5.4-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 2:11 AM Dave Airlie <airlied@gmail.com> wrote:
> > Hmm. My merge isn't identical to that. It's close though. Different
> > order for one #define which might be just from you and me merging
> > different directions.
> >
> > But I also ended up removing the .gem_prime_export initialization to
> > drm_gem_prime_export, because it's the default if none exists. That's
> > the left-over from
> >
> >     3baeeb21983a ("drm/mtk: Drop drm_gem_prime_export/import")
> >
> > after the import stayed around because it got turned into an actually
> > non-default one.
> >
> > I think that both of our merges are right - equivalent but just
> > slightly different.
> >
> > But the reason I'm pointing this out is that I also get the feeling
> > that if it needs that dev->dev_private difference from the default
> > function in prime_import(), wouldn't it need the same for prime_export
> > too?
> >
> > I don't know the code, and I don't know the hardware, but just from a
> > "pattern matching" angle I just wanted to check whether maybe there's
> > need for a mtk_drm_gem_prime_export() wrapper that does that same
> > thing with
> >
> >         struct mtk_drm_private *private = dev->dev_private;
> >
> >         .. use private->dev  instead of dev->dev ..
> >
> > So I'm just asking that somebody that knows that drm/mtk code should
> > double-check that oddity.
>
> I've cc'ed Alexandre who wrote the import half of this code to look into it.
>
> I've looked at the other results and it all seems fine to me.

(pre-coffee, but let's hope the brain is awake enough)

This asymmetry in prime import/export is somewhat common for devices
with funky dma requirements/setup in the dt/soc world.

- on export we need to use the "official" struct device, so that when
we re-import (i.e. userspace just shared a buffer across process
through fd-passing, not across device-drivers) the common helpers
realize "ah this is ours, let me just grab the underlying buffer
object", instead of creating a full new buffer object handle like it
does for a real import of a dma-buf from a different device driver.
Because having 2 buffer object handles pointing at the same underlying
buffer objects tends to not go well.

- on import otoh we need to pass the struct device we actually need
for dma (which for reasons that I don't fully grok isn't the same, I
got it explained once by dt/soc folks and forgot again why exactly),
so that dma_map_sg and friends dtrt.

So that part should be all fine.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
