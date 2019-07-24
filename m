Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45D2C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC5B2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563985637;
	bh=tuE9J2EOne+NslRdzdQJ0TtHE1sB+k105tq6JIxLUdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d1WmtVhbiDtQi2x14R2LKvdUUEsiWhIfQZaafcvUDCHG2vEBDNzJcoL5Y/pIuspyW
	 VUWU5m+hVvI+QBG9UPO3OUP1T9O6L3ckUK5+Pb6qVeyuh6YsxMHLe4yOEtsWaIR6Al
	 uBHOnLiBvOnrWscGxqHig9gayvXqk1UIGE64Y15U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfGXQ1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfGXQ1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:27:16 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2D221951
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563985635;
        bh=tuE9J2EOne+NslRdzdQJ0TtHE1sB+k105tq6JIxLUdw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zb8X/OpEv0xafmvlDz/057Tig2SM1IPeZsqvFMuvKLB4cEtdmqEqNvO5nbrYEVZzJ
         3gY1mfPUAFiKPkJ/XUpxrXDJQxFyzdDtgw3JseH4vuCcv+LnFoevL85+ZBHdbvQFEY
         aX+ejwSEfgue3WJ/NpLIzGCL00hcP/HrxuQpbKT0=
Received: by mail-qt1-f182.google.com with SMTP id w17so1759212qto.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:27:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUg+DPQpWXNmQ7mSpz0C33/xkb/crza9juLi9Y9K7W0nMkRK+Ih
        /JHd7llLyLxcd4XPisSLK8C6oPKVmLXQZ72+5g==
X-Google-Smtp-Source: APXvYqwptXe/uTWee4NuZzm9CGkPpdvwocUmqOtUgHcd5yCy2ZnFI0mL/snhlDQY3I9nBEg8FUdR7pOActwPyf6Od68=
X-Received: by 2002:a0c:8a43:: with SMTP id 3mr61365918qvu.138.1563985634625;
 Wed, 24 Jul 2019 09:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190724105626.53552-1-steven.price@arm.com>
In-Reply-To: <20190724105626.53552-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Jul 2019 10:27:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLkxKe=feVQDb3VXqOnA7fvDBEKWgLf2suOHhNLnR704Q@mail.gmail.com>
Message-ID: <CAL_JsqLkxKe=feVQDb3VXqOnA7fvDBEKWgLf2suOHhNLnR704Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Export all GPU feature registers
To:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Alyssa's Collabora email.

On Wed, Jul 24, 2019 at 4:56 AM Steven Price <steven.price@arm.com> wrote:
>
> Midgard/Bifrost GPUs have a bunch of feature registers providing details
> of what the hardware supports. Panfrost already reads these, this patch
> exports them all to user space so that the jobs created by the user space
> driver can be tuned for the particular hardware implementation.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 38 +++++++++++++++++++--
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    |  2 ++
>  include/uapi/drm/panfrost_drm.h            | 39 ++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 3 deletions(-)

LGTM. I'll give it a bit more time to see if there are any comments
before I apply it.

Rob
