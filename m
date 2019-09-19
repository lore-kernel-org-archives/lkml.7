Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEF7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B5021907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568912122;
	bh=5rVjIPHL2cnlL1gfY8saDq0zSQ2lRGBAEHD4oLsuXQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2kSYuJt7bLPtuAOPO8Fdm+cb8IKhTPtJ4ldkdV6OyQf+sVKXFjaUMZa5bZ4Z7q2Mg
	 YeBAXVPQ3bZwXx/rEeX6w9lu9uNkabJP39ZF80Fje1lbn3QYiuz1kdZniFagZAYXy0
	 nxQHUk9E0VieaQ6jmm4KasLDKLKyAwH/9GVkr350=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390687AbfISQzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388051AbfISQzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:55:20 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4DE421928
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568912119;
        bh=5rVjIPHL2cnlL1gfY8saDq0zSQ2lRGBAEHD4oLsuXQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fjoeJ4FZTnG/THhXTEtMWSn8XpndCUl/IjvLFRu3quQ+4snlo6kqL7vxTMUdmvCRT
         XD8n5v5BcKnQt2iKeOJ2avf35XY75Jh95sLZzdJd1fOf+22BFR9WDHj/QrDjG+Xgyh
         rdEvz9EWHvjwEJDWQfKCpc9hqugR0JQsO3ACQpps=
Received: by mail-qk1-f177.google.com with SMTP id u186so4108934qkc.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 09:55:19 -0700 (PDT)
X-Gm-Message-State: APjAAAUGDlU7zzAye4LjfOoheHTzehEO7Ex2ajmp2EFOtm4pR1LX2eLv
        YDCC9dESPoMVaKhpUG/PMay1SBvWuA6XYy6r9w==
X-Google-Smtp-Source: APXvYqyA0BiAMvX3zTZbbq53YgidUsvY1WbDgee1ttXB8Fr0C05ojiHENMNUnVFgowSopR38svpPqH0ezqJzDiyexzg=
X-Received: by 2002:a37:682:: with SMTP id 124mr3783029qkg.393.1568912118989;
 Thu, 19 Sep 2019 09:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190904123032.23263-1-broonie@kernel.org> <ccd81530-2dbd-3c02-ca0a-1085b00663b5@arm.com>
 <CAL_JsqKWEe=+X5AYRJ-_8peTzfrOrRBfFWgk8c6h3TN6f0ZHtA@mail.gmail.com> <3e3a2c8a-b4fc-8af6-39e1-b26160db2c7c@arm.com>
In-Reply-To: <3e3a2c8a-b4fc-8af6-39e1-b26160db2c7c@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Sep 2019 11:55:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKTJE=PURj_CJGXgR+=K=vn6YGfD4FJ6wuwNzvs=fOBQQ@mail.gmail.com>
Message-ID: <CAL_JsqKTJE=PURj_CJGXgR+=K=vn6YGfD4FJ6wuwNzvs=fOBQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
To:     Steven Price <steven.price@arm.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 11:22 AM Steven Price <steven.price@arm.com> wrote:
>
> On 09/09/2019 16:41, Rob Herring wrote:
> > On Fri, Sep 6, 2019 at 4:23 PM Steven Price <steven.price@arm.com> wrote:
> >>
> >> On 04/09/2019 13:30, Mark Brown wrote:
> >>> The panfrost driver requests a supply using regulator_get_optional()
> >>> but both the name of the supply and the usage pattern suggest that it is
> >>> being used for the main power for the device and is not at all optional
> >>> for the device for function, there is no meaningful handling for absent
> >>> supplies.  Such regulators should use the vanilla regulator_get()
> >>> interface, it will ensure that even if a supply is not described in the
> >>> system integration one will be provided in software.
> >>>
> >>> Signed-off-by: Mark Brown <broonie@kernel.org>
> >>
> >> Tested-by: Steven Price <steven.price@arm.com>
> >>
> >> Looks like my approach to this was wrong - so we should also revert the
> >> changes I made previously.
> >>
> >> ----8<----
> >> From fe20f8abcde8444bb41a8f72fb35de943a27ec5c Mon Sep 17 00:00:00 2001
> >> From: Steven Price <steven.price@arm.com>
> >> Date: Fri, 6 Sep 2019 15:20:53 +0100
> >> Subject: [PATCH] drm/panfrost: Revert changes to cope with NULL regulator
> >>
> >> Handling a NULL return from devm_regulator_get_optional() doesn't seem
> >> like the correct way of handling this. Instead revert the changes in
> >> favour of switching to using devm_regulator_get() which will return a
> >> dummy regulator instead.
> >>
> >> Reverts commit 52282163dfa6 ("drm/panfrost: Add missing check for pfdev->regulator")
> >> Reverts commit e21dd290881b ("drm/panfrost: Enable devfreq to work without regulator")
> >
> > Does a straight revert of these 2 patches not work? If it does work,
> > can you do that and send to the list. I don't want my hand slapped
> > again reverting things.
>
> I wasn't sure what was best here - 52282163dfa6 is a bug fix, so
> reverting that followed by e21dd290881b would (re-)introduce a
> regression for that one commit (i.e. not completely bisectable).
> Reverting in the other order would work, but seems a little odd.
> Squashing the reverts seemed the neatest option - but it's not my hand
> at risk... :)
>
> Perhaps it would be best to simply apply Mark's change followed by
> something like the following. That way it's not actually a revert!
> It also avoids (re-)adding the now redundant check in
> panfrost_devfreq_init().
>
> Steve
>
> ---8<----
> From fb2956acdf46ca04095ef11363c136dc94a1ab18 Mon Sep 17 00:00:00 2001
> From: Steven Price <steven.price@arm.com>
> Date: Fri, 6 Sep 2019 15:20:53 +0100
> Subject: [PATCH] drm/panfrost: Remove NULL checks for regulator
>
> devm_regulator_get() is now used to populate pfdev->regulator which
> ensures that this cannot be NULL (a dummy regulator will be returned if
> necessary). So remove the checks in panfrost_devfreq_target().
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Okay, I've gone this route and applied Mark's patch and this one.

Rob
