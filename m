Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B6C208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552066440;
	bh=zjhR1qWSwuIo6Rgi2Jb8yZJFmARLoWuZX6/Z1D47Ctk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QoLblKpKEDeynyIVuqUkMb7pc/s7MpL43TET4qZHEHyNvmaLlmeJBSG248XuN2j35
	 bcgBK7rJUdE8vfVBe24gUFp2UYTCdLaJfjWzNOg+NNuWxfERGXzHBZod7h+S0FpAB4
	 StUpJEsG7SIPUU8HJvq0vOmTgeUprCVB7AYujiTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfCHRd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfCHRd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:33:58 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296532147A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552066437;
        bh=zjhR1qWSwuIo6Rgi2Jb8yZJFmARLoWuZX6/Z1D47Ctk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dcNxPBLU4QTFcNVyUo6nfuK6Voatc4xytphDr3PHFi6vyke7BcjM/V3ojbtMVQ9mz
         Eie6w86rtSK4ESnDbHEpcLY/iBPErDnnzXsv9bmt5bT9bVBu6R24Tv9eGWY35HbnE4
         +7NXveZcFfl42Lp6VbWRc/aym4jMCaHgq6+hJ8Ko=
Received: by mail-qt1-f177.google.com with SMTP id o6so22078811qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 09:33:57 -0800 (PST)
X-Gm-Message-State: APjAAAWRSRoyvvO2kjkVlD+KldIM6Un4DPFX2KbDce1WcsziHG528DPN
        AgZsXHDJ8yzI/Ok4yY0VEtwyePcNohSyDM/omA==
X-Google-Smtp-Source: APXvYqw+OAHMBMI5m92gplNjDX7+PI9mdBCFOcgxiEo9PdtrXPYLdpR6RwC7x3B6Wg3RQDUXGiKQvrfQmN86i6HEbKA=
X-Received: by 2002:a0c:91bb:: with SMTP id n56mr16535054qvn.77.1552066436270;
 Fri, 08 Mar 2019 09:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20190308161716.2466-1-eric@anholt.net> <20190308161716.2466-2-eric@anholt.net>
In-Reply-To: <20190308161716.2466-2-eric@anholt.net>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Mar 2019 11:33:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-16kyPiWSC=pEC+JLeeJaDBJahnXqOW3Wni5CJcACsQ@mail.gmail.com>
Message-ID: <CAL_JsqL-16kyPiWSC=pEC+JLeeJaDBJahnXqOW3Wni5CJcACsQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm: Add helpers for locking an array of BO reservations.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 10:17 AM Eric Anholt <eric@anholt.net> wrote:
>
> Now that we have the reservation object in the GEM object, it's easy
> to provide a helper for this common case.  Noticed while reviewing
> panfrost and lima drivers.  This particular version came out of v3d,
> which in turn was a copy from vc4.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/drm_gem.c | 76 +++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_gem.h     |  4 +++
>  2 files changed, 80 insertions(+)

Sweet! I was about to go write this same patch. You are changing the
license from GPL to MIT copying the v3d version, but I guess you have
rights to do that.

FWIW,

Acked-by: Rob Herring <robh@kernel.org>

Rob
