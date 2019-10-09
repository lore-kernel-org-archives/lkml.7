Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7721AC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7A9218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570646410;
	bh=8o0+psPQu+dHLhbRePPNEI9DR53wq1TiTjYc/TmUhGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G8VHaU1fmdPhfSTsQDX11zBlHYlvMFWpGboKpWyOvYer7NMI4N7Wm/SFJ0gSx8Vp7
	 co65WWZA7JFzBvpb2FjGSldOtyt05lhJ8Q6ZXwqAFSmnQencGth05Tr8KCDrS2X2K2
	 P4iqBjB5Mw3Lj3czwZKQLTEizG9+pFtQb3l6ttzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfJISkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJISkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:40:08 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3FBE2196E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570646408;
        bh=8o0+psPQu+dHLhbRePPNEI9DR53wq1TiTjYc/TmUhGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PXoZY3QrmfXXWoixQQUlinJxedaW6vhLUNsOt5bD4bLovyzf+korqpIZ3ctULYOJ+
         J6lxkPcUauSZcD4Of7yVUlw3iWJkyq1Ldbu8bfyAADoTOZKL3cjM/yHcXxvYd6q+CN
         CJSS3RAgBIEgHCEI/CBZdj9kNaLqnGY8/B96NnzA=
Received: by mail-qk1-f174.google.com with SMTP id u186so3167501qkc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 11:40:07 -0700 (PDT)
X-Gm-Message-State: APjAAAWKdde/V23w+hLYzO90/K0woVmy8T6hUt0Q8CF/c02g8zeyP741
        6U6YQwo9ECLPBTmIgZS31MO7o+ZJiJDAYg3zzA==
X-Google-Smtp-Source: APXvYqzzFH9/rMGrjPgxmK5Bg3/VLC9u1edS3prMtCOcJjCWPVn96XPxUCyl2jOEHU4qWqQ6JkbAVDHAbuo+a1f74PA=
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr5211513qkl.152.1570646406928;
 Wed, 09 Oct 2019 11:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191009094456.9704-1-steven.price@arm.com>
In-Reply-To: <20191009094456.9704-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Oct 2019 13:39:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKjvuhw_fWVyfptbgP-_Q6R44i6y+pg8FojO4BujDmxnA@mail.gmail.com>
Message-ID: <CAL_JsqKjvuhw_fWVyfptbgP-_Q6R44i6y+pg8FojO4BujDmxnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panfrost: Handle resetting on timeout better
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 4:45 AM Steven Price <steven.price@arm.com> wrote:
>
> Panfrost uses multiple schedulers (one for each slot, so 2 in reality),
> and on a timeout has to stop all the schedulers to safely perform a
> reset. However more than one scheduler can trigger a timeout at the same
> time. This race condition results in jobs being freed while they are
> still in use.
>
> When stopping other slots use cancel_delayed_work_sync() to ensure that
> any timeout started for that slot has completed. Also use
> mutex_trylock() to obtain reset_lock. This means that only one thread
> attempts the reset, the other threads will simply complete without doing
> anything (the first thread will wait for this in the call to
> cancel_delayed_work_sync()).
>
> While we're here and since the function is already dependent on
> sched_job not being NULL, let's remove the unnecessary checks.
>
> Fixes: aa20236784ab ("drm/panfrost: Prevent concurrent resets")
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> v2:
>  * Added fixes and tested-by tags
>  * Moved cleanup of panfrost_core_dump() comment to separate patch
>
>  drivers/gpu/drm/panfrost/panfrost_job.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Both patches applied.

Rob
