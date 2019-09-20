Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE8CC4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D6E20882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ku69JyrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407691AbfITF02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 01:26:28 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:33344 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390510AbfITF02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 01:26:28 -0400
Received: by mail-oi1-f177.google.com with SMTP id e18so767713oii.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 22:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BR3Y1sgQYvbq1M6HSpy9hDVNEXYdCpLTznu5wS7Li8=;
        b=ku69JyrMeh8u3IrHeMU7R0MsT10T22vF/fLLImEdozDQhdkk09sEWKMt4sKEhb7SxV
         EvrMV/pJtPhtWWEG7TmuGpc7wwjh2BTGsxvbu0zVjINbtNV+w9f3ubwnAx/l312mPGPR
         vsiIaIvw/VtiCTqFi43+jTujFXSSI/syBwWOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BR3Y1sgQYvbq1M6HSpy9hDVNEXYdCpLTznu5wS7Li8=;
        b=KrF0T3+rKXYQJWnwGZCyo6cv6I9jQIfWM2NXWtGQK67SNpMef5QKkwlDy3RscBNcRG
         WCMA5A6J7NvMtpjHHilXkDIlA3egp8+hs1HjR8JGrAk/02aprZLhnHiocEK1gRM/inct
         NOvrGqqreFw4GVxgGIWUvIFF3dm/PvHGXjqFJtOKVvAa+JjHPFGKK3XT8X/D2v1Su+Sn
         4DSjRDuwoheIGiwT/9HIk+Xc38YulQ60tTPi3pgYH2dL87gxWH3shEUZ+AC753RYHvad
         xm8nEbIRPQc4cmpKNmS/NSk2ZidDpGnxtbQpkOnNGb5E2i1s46+RV9s6ULpTz40cYbmr
         OIqw==
X-Gm-Message-State: APjAAAXoHqYk6FBbQJ9L4SxcTQu4E0g/DPdFtBT0j+YznvEoW2JBB2ES
        sjjjl5/6NFzXO2UQ8+e/gT1sQqKLRhw=
X-Google-Smtp-Source: APXvYqxREJx3Cu5PyFDy0DvtPbYaFygMINgovgOQtaYNKDTzVYssbd3m/CGUlw8IGNGGtSpDsnP0eg==
X-Received: by 2002:aca:4c54:: with SMTP id z81mr1446300oia.0.1568957185475;
        Thu, 19 Sep 2019 22:26:25 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id n39sm403494ota.33.2019.09.19.22.26.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 22:26:24 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id m19so3357929otp.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 22:26:24 -0700 (PDT)
X-Received: by 2002:a9d:4615:: with SMTP id y21mr2930384ote.97.1568957183906;
 Thu, 19 Sep 2019 22:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txTjip6SonSATB-O38TGX9ituQaw+29PnAkNJ960R1z6g@mail.gmail.com>
 <CAHk-=wjHDrmx+Rj+oJw5V4mfWjpYzpwcJbqY-L-nvsNW_d8e_g@mail.gmail.com> <CAPM=9tzLFenqZQo_NQqKd5xPQ5g-5WY+JxTotL7AHk_+6S89ow@mail.gmail.com>
In-Reply-To: <CAPM=9tzLFenqZQo_NQqKd5xPQ5g-5WY+JxTotL7AHk_+6S89ow@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 20 Sep 2019 14:26:12 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUhuk93Hm5Ba_HqcW9nRF0tGbEv28eLeh7pXRZZ8swV+w@mail.gmail.com>
Message-ID: <CAPBb6MUhuk93Hm5Ba_HqcW9nRF0tGbEv28eLeh7pXRZZ8swV+w@mail.gmail.com>
Subject: Re: [git pull] drm tree for 5.4-rc1
To:     Dave Airlie <airlied@gmail.com>, CK Hu <ck.hu@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 9:11 AM Dave Airlie <airlied@gmail.com> wrote:
>
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

I am not super familiar with this driver either so I may have
overlooked this. Using dev->dev_private was to make sure that the
imported buffers would be mapped contiguously in the device's address
space, so I am not sure whether we need to do something in the case of
export.

Added CK and Tomasz who may have a more informed opinion on this.
