Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B787C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64EA206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbfIEPvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:51:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732613AbfIEPvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:51:35 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C65588313
        for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2019 15:51:35 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id m25so3808368ioo.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 08:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNe3ddKXkBveWMhw4c4f5b+wfxe2iykrAWeST0j0z4c=;
        b=DRHMgR9wlhCxxvlvtVGECZQ12ub5lB9SSaP8yXHuWUFVa/OecAjmoAyF1RfT8ux5jl
         z4MEZNZ27C15xGtHKE4fD1jBsCABJ4uqPt/ogxMhr12rloXNdyQh8DJ4+PWgq3+XFxb0
         BAe6i9z2dCP4u47K0htWj43kgHj9zZhG3xm1hq493UQaaHxJlNKIh9DWhI50c8HhbiHS
         MXgXy9l0X8q0+A/A8rGZ22IXR6d0w1uMPuzJ5oz5eOTcNt+uq4yn0EGreoo/fxvhbwiu
         re1CK+bKTyokgGHyJiuB2mjzR/H9I8NF+T2FDxsAnp7E+YDXGiriYXAg9vW3LGDEJGwL
         ELjw==
X-Gm-Message-State: APjAAAV/tg0HB26epqp7sv58EdUffLST3STu04l8+HzSM3G9J0+C/4CJ
        lvDNwthUCkaiprrTVl6PgvW45wmzlz+MjuIuY2NInRC08D6IwPiGfz+OKTtsyramw+GDw+DZVQg
        17Rtliz12P6DllAeAIsmetVW9xPqbNEFPzigYJphL
X-Received: by 2002:a5d:9750:: with SMTP id c16mr5160590ioo.260.1567698694749;
        Thu, 05 Sep 2019 08:51:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqziasJ9/F0fMtMAUdtQGxy5l/8SPZ81bDf6U0dhJV+tEsL0k25gm7aG+PD5J9cfxqlr1KkEZZquBbi9oi2tLXY=
X-Received: by 2002:a5d:9750:: with SMTP id c16mr5160555ioo.260.1567698694470;
 Thu, 05 Sep 2019 08:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com> <2215840.qs0dBhReda@kreacher>
In-Reply-To: <2215840.qs0dBhReda@kreacher>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 5 Sep 2019 17:51:23 +0200
Message-ID: <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is there any update on the testing with my patches? On the hardware I
had access to those patches helped, but I can't know if it also helped
on the hardware for which those workarounds where actually added.

On Mon, Aug 19, 2019 at 11:52 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, August 15, 2019 12:47:35 AM CEST Dave Airlie wrote:
> > On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> > >
> > > The original commit message didn't even make sense. AMD _does_ support it and
> > > it works with Nouveau as well.
> > >
> > > Also what was the issue being solved here? No references to any bugs and not
> > > even explaining any issue at all isn't the way we do things.
> > >
> > > And even if it means a muxed design, then the fix is to make it work inside the
> > > driver, not adding some hacky workaround through ACPI tricks.
> > >
> > > And what out of tree drivers do or do not support we don't care one bit anyway.
> > >
> >
> > I think the reverts should be merged via Rafael's tree as the original
> > patches went in via there, and we should get them in asap.
> >
> > Acked-by: Dave Airlie <airlied@redhat.com>
>
> The _OSI strings are to be dropped when all of the needed support is there in
> drivers, so they should go away along with the requisite driver changes.
>

that goes beside the point. firmware level workarounds for GPU driver
issues were pushed without consulting with upstream GPU developers.
That's something which shouldn't have happened in the first place. And
yes, I am personally annoyed by the fact, that people know about
issues, but instead of contacting the proper persons and working on a
proper fix, we end up with stupid firmware level workarounds. I can't
see why we ever would have wanted such workarounds in the first place.

And I would be much happier if the next time something like that comes
up, that the drm mailing list will be contacted as well or somebody
involved.

We could have also just disable the feature inside the driver (and
probably we should have done that a long time ago, so that is
essentially our fault, but still....)

> I'm all for dropping then when that's the case, so please feel free to add ACKs
> from me to the patches in question at that point.
>
> Cheers,
> Rafael
>
>
>
