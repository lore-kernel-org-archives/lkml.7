Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1C6C49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05129218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406085AbfIIVH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 17:07:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43901 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfIIVH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 17:07:57 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1i7Qt9-0000hO-DU
        for linux-kernel@vger.kernel.org; Mon, 09 Sep 2019 21:07:55 +0000
Received: by mail-io1-f72.google.com with SMTP id o3so19935508iom.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 14:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LH+uWheH+pNq+IGQq8MSCBunzHNQ2Gt4vqh/uMjSZaM=;
        b=NZK4hAPch5Rqe9IeJ9QXsJL0LhBphT++R08aNGf/S3TulYkDvVM/hOp3O9xtFj0uJJ
         MA2VKLTk1riOa6gzIaooCVGuns+ewUnc82KVFQioqpDdpVfDr8bQTEZ9E2oSIKRW5d+R
         MrAqOtzYTqLQL9ab3bGi4dKJ91fSUC3DjI4//aiTbYI0tAwXs6XP6BHLIKfdG+Oa5IJ4
         BhQTOsTpBo/fGtJFauk2dj62rzxed9y8MXEuHreNbUCMWWlRCBC0zOw22COTCK1XO50r
         6+4viafbiwRSFI8xhtRpV0L24mxnZuqmfOcDB0T1EoYk/YEpErY+bch0LYJ4w3besg3y
         EMEg==
X-Gm-Message-State: APjAAAVZpiynga5355cifR93bzO5khveRoXiGbREHn2Jp8s7vBschrFM
        rnGSt7aOb+//8Z/wsgW9fLH8j17rCqxFduKNSlBTQ5i8pMFgXeCtb+EhpNfzkiaHpQku4soRW77
        i6VHD/XD/4EFEq4ESmkvD7Kyp1zBQojKxLZ3dFaj599HLyNzZqbLjKKb70Q==
X-Received: by 2002:a6b:c903:: with SMTP id z3mr16805274iof.204.1568063274537;
        Mon, 09 Sep 2019 14:07:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxKNWzQ0qeqd46TPzcljhuQDj1lX4oa7QzaJ3YBpbWvIApG/65YcNAjmq5SCNk2sgQ90kAmSPWN8hgTzP4YqYw=
X-Received: by 2002:a6b:c903:: with SMTP id z3mr16805248iof.204.1568063274320;
 Mon, 09 Sep 2019 14:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <2215840.qs0dBhReda@kreacher>
 <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com> <5228680.jBuKzensJx@kreacher>
In-Reply-To: <5228680.jBuKzensJx@kreacher>
From:   Alex Hung <alex.hung@canonical.com>
Date:   Mon, 9 Sep 2019 22:07:42 +0100
Message-ID: <CAJ=jquaLthK556Lqk-zc3GCOus90HoGs66tA=d9a1aju7iNpPw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Karol Herbst <kherbst@redhat.com>, Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 5:26 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, September 5, 2019 5:51:23 PM CEST Karol Herbst wrote:
> > is there any update on the testing with my patches? On the hardware I
> > had access to those patches helped, but I can't know if it also helped
> > on the hardware for which those workarounds where actually added.
>
> Alex Hung and Mario need to answer this question I think.

Sorry for taking a long time. I don't have full testing results yet
but we found at least a regression occurred with _OSI string removed -
it is not on nVidia hardware but on AMD PX one.

I will try to collect and share more details.

>
> > On Mon, Aug 19, 2019 at 11:52 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Thursday, August 15, 2019 12:47:35 AM CEST Dave Airlie wrote:
> > > > On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> > > > >
> > > > > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> > > > >
> > > > > The original commit message didn't even make sense. AMD _does_ support it and
> > > > > it works with Nouveau as well.
> > > > >
> > > > > Also what was the issue being solved here? No references to any bugs and not
> > > > > even explaining any issue at all isn't the way we do things.
> > > > >
> > > > > And even if it means a muxed design, then the fix is to make it work inside the
> > > > > driver, not adding some hacky workaround through ACPI tricks.
> > > > >
> > > > > And what out of tree drivers do or do not support we don't care one bit anyway.
> > > > >
> > > >
> > > > I think the reverts should be merged via Rafael's tree as the original
> > > > patches went in via there, and we should get them in asap.
> > > >
> > > > Acked-by: Dave Airlie <airlied@redhat.com>
> > >
> > > The _OSI strings are to be dropped when all of the needed support is there in
> > > drivers, so they should go away along with the requisite driver changes.
> > >
> >
> > that goes beside the point. firmware level workarounds for GPU driver
> > issues were pushed without consulting with upstream GPU developers.
> > That's something which shouldn't have happened in the first place. And
> > yes, I am personally annoyed by the fact, that people know about
> > issues, but instead of contacting the proper persons and working on a
> > proper fix, we end up with stupid firmware level workarounds. I can't
> > see why we ever would have wanted such workarounds in the first place.
> >
> > And I would be much happier if the next time something like that comes
> > up, that the drm mailing list will be contacted as well or somebody
> > involved.
> >
> > We could have also just disable the feature inside the driver (and
> > probably we should have done that a long time ago, so that is
> > essentially our fault, but still....)
> >
> > > I'm all for dropping then when that's the case, so please feel free to add ACKs
> > > from me to the patches in question at that point.
> > >
> > > Cheers,
> > > Rafael
> > >
> > >
> > >
> >
>
>
>
>


-- 
Cheers,
Alex Hung
