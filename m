Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4A5C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53C02089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568043708;
	bh=fM4JbSVJbGXAjoftVI6cCaz2ZaDS1dmEdNr69EQNLl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nZRY305Xz5lsZWR/BdhkKCFnS7ucmf912fv9y99bP8NaBQldHowCZvR8Ez0q2iVO7
	 YUShuUNZ3Btzzb+RZTPWvSi5GMFS30PpIOvDPQnx6Ket2K9/1YlljhnTp/NxqZlvjz
	 6ZmbJ1X9pIp5EacbpR51ugJlMYQ0/AZvf+C+iSZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbfIIPlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfIIPlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:41:46 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 142F32089F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568043706;
        bh=fM4JbSVJbGXAjoftVI6cCaz2ZaDS1dmEdNr69EQNLl4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QHv+pIF0WkKCXPobKnhnm+m3bLWKtzErPwv9PJb/Q9LP2fL+MarhCoXM/uwRzAUgE
         zD+eK2DD1rxsaNWmHnvUfoa5cFmfJWNWBmNP1TCG6ZGdM/k7ePwCma0B3v0gMbRo3c
         IiRiUAseAivRcmSGGSDHZgXCSbLvGJdZVJ35g0d0=
Received: by mail-qt1-f169.google.com with SMTP id n7so16682551qtb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 08:41:46 -0700 (PDT)
X-Gm-Message-State: APjAAAWGr5Tgcq4VV3o6gS9SFxuToDK4WLYVfkQn10JukFidlKZt04P+
        zbithCOEmr4C0hYGWicduHRkwqPbeWPwBuUGXQ==
X-Google-Smtp-Source: APXvYqz141Z8J3amoWSNvEnWBMcRo8P2gwc1042x2UJzSiJd8NyLDaEMcfylKvyhtyaKCZweTwgZC/eZ9i/0FZ1Xa0s=
X-Received: by 2002:ac8:4a05:: with SMTP id x5mr12045321qtq.110.1568043705274;
 Mon, 09 Sep 2019 08:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190904123032.23263-1-broonie@kernel.org> <ccd81530-2dbd-3c02-ca0a-1085b00663b5@arm.com>
In-Reply-To: <ccd81530-2dbd-3c02-ca0a-1085b00663b5@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Sep 2019 16:41:32 +0100
X-Gmail-Original-Message-ID: <CAL_JsqKWEe=+X5AYRJ-_8peTzfrOrRBfFWgk8c6h3TN6f0ZHtA@mail.gmail.com>
Message-ID: <CAL_JsqKWEe=+X5AYRJ-_8peTzfrOrRBfFWgk8c6h3TN6f0ZHtA@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 4:23 PM Steven Price <steven.price@arm.com> wrote:
>
> On 04/09/2019 13:30, Mark Brown wrote:
> > The panfrost driver requests a supply using regulator_get_optional()
> > but both the name of the supply and the usage pattern suggest that it is
> > being used for the main power for the device and is not at all optional
> > for the device for function, there is no meaningful handling for absent
> > supplies.  Such regulators should use the vanilla regulator_get()
> > interface, it will ensure that even if a supply is not described in the
> > system integration one will be provided in software.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
>
> Tested-by: Steven Price <steven.price@arm.com>
>
> Looks like my approach to this was wrong - so we should also revert the
> changes I made previously.
>
> ----8<----
> From fe20f8abcde8444bb41a8f72fb35de943a27ec5c Mon Sep 17 00:00:00 2001
> From: Steven Price <steven.price@arm.com>
> Date: Fri, 6 Sep 2019 15:20:53 +0100
> Subject: [PATCH] drm/panfrost: Revert changes to cope with NULL regulator
>
> Handling a NULL return from devm_regulator_get_optional() doesn't seem
> like the correct way of handling this. Instead revert the changes in
> favour of switching to using devm_regulator_get() which will return a
> dummy regulator instead.
>
> Reverts commit 52282163dfa6 ("drm/panfrost: Add missing check for pfdev->regulator")
> Reverts commit e21dd290881b ("drm/panfrost: Enable devfreq to work without regulator")

Does a straight revert of these 2 patches not work? If it does work,
can you do that and send to the list. I don't want my hand slapped
again reverting things.

Rob
