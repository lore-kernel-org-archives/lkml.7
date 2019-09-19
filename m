Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC28C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91596218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568936382;
	bh=BsCyo6WlUNRef/aXaeSlX5amPNfkRLIZ+5WX/J8GSeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZlmM38qgX66hcCxMOlrRFklC8YdgHDxcRqjcZorSqeY3hIbu9iF+PpeEBVXGRn7i6
	 bqPCY3tLHxCBIdizkGjhyzuTHZaoxitoc12vijbu15fah65wglpqaB2TDEAwToswli
	 ebufkJ5rtE2hvQavCHz3folctLA9HEt3ucod5pSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392814AbfISXjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 19:39:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42252 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391738AbfISXji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:39:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so3612827lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FNGFxL5BLhyvs37aNDD2u4JgDHGO5UPdmdnn3EHqLo=;
        b=SpEy3jPkCRJpYSb59pOS+GuECUW5l5+gVAswRj/iKNkELB5/NunWndHY13iq+Kk6OL
         rQoJupSBfhWOcfEiUrIZsCK/nOELDk9lHhQlXV/dRiocbMOemmpHSrl4qWuBsFz1AzVF
         mfz4fIf2/PIYYKHqLSFmX/7zeaeSOShoOouj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FNGFxL5BLhyvs37aNDD2u4JgDHGO5UPdmdnn3EHqLo=;
        b=XfHvixrpbRj1HaXeJ7koOx1e5WUKElSgSFjbJAOzeJqCbNPQDC3oXgBAuGFzEICFgf
         2Fh7asAxDsxEBKYWDXiHdkDFhdTsd61sMiWAxf0k9TEaXfSB7NQr2GBJVzJfUH3pBcC3
         Z3xCFvinhqnacO5UzFioAdTsv7/zMpk0HPyaZ3HgOI48O0P7lsJFgOJlQhZnrNCnH0h5
         xo3eKKN3oaWuYHyvYYILQZj3aQFkXgxJEgLREaaMqVyTIYKgqivgCAmnA7W3WSRBKT40
         2AatdKywmkcyvW32Xl6rPfilmjwMLHRMPt49o6dxNaQXOUQ19xFMUbC3uXUt9N40Ct3W
         ybpw==
X-Gm-Message-State: APjAAAWqd/pmv9guvsO4dUgv760ZAaZwXYQEVli213qV8iuGnLafsTun
        G4Xm8fmqwSClJQzwnuj9yMxGrj1wIR4=
X-Google-Smtp-Source: APXvYqzJeupI+SnKvwar6RlHJnxPYZxttBrc5h3LYjDAOMEvY9iOHqI3H55h8xO2LtHf7eJlDCRfgA==
X-Received: by 2002:ac2:5483:: with SMTP id t3mr6527034lfk.39.1568936376283;
        Thu, 19 Sep 2019 16:39:36 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id v1sm79512lfa.87.2019.09.19.16.39.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 16:39:35 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id r22so3642450lfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 16:39:35 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr6397849lfc.106.1568936374113;
 Thu, 19 Sep 2019 16:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txTjip6SonSATB-O38TGX9ituQaw+29PnAkNJ960R1z6g@mail.gmail.com>
In-Reply-To: <CAPM=9txTjip6SonSATB-O38TGX9ituQaw+29PnAkNJ960R1z6g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 16:39:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHDrmx+Rj+oJw5V4mfWjpYzpwcJbqY-L-nvsNW_d8e_g@mail.gmail.com>
Message-ID: <CAHk-=wjHDrmx+Rj+oJw5V4mfWjpYzpwcJbqY-L-nvsNW_d8e_g@mail.gmail.com>
Subject: Re: [git pull] drm tree for 5.4-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 12:09 PM Dave Airlie <airlied@gmail.com> wrote:
>
> There are a few merge conflicts across the board, we have a shared
> rerere cache which meant I hadn't noticed them until I avoided the
> cache.
> https://cgit.freedesktop.org/drm/drm/log/?h=drm-5.4-merge
> contains what we've done, none of them are too crazy.

Hmm. My merge isn't identical to that. It's close though. Different
order for one #define which might be just from you and me merging
different directions.

But I also ended up removing the .gem_prime_export initialization to
drm_gem_prime_export, because it's the default if none exists. That's
the left-over from

    3baeeb21983a ("drm/mtk: Drop drm_gem_prime_export/import")

after the import stayed around because it got turned into an actually
non-default one.

I think that both of our merges are right - equivalent but just
slightly different.

But the reason I'm pointing this out is that I also get the feeling
that if it needs that dev->dev_private difference from the default
function in prime_import(), wouldn't it need the same for prime_export
too?

I don't know the code, and I don't know the hardware, but just from a
"pattern matching" angle I just wanted to check whether maybe there's
need for a mtk_drm_gem_prime_export() wrapper that does that same
thing with

        struct mtk_drm_private *private = dev->dev_private;

        .. use private->dev  instead of dev->dev ..

So I'm just asking that somebody that knows that drm/mtk code should
double-check that oddity.

Thanks,
              Linus
