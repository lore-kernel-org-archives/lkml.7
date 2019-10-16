Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630EDECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BE62168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VvfuWund"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391641AbfJPI1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:27:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40781 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfJPI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:27:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so20603204edm.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIVVy6cMJGB/802PPmCv+d212rxtmpqIPcdcqOUFqaw=;
        b=VvfuWundF+ym1IvwwPUppv/LB2L6Z21+F3nWhnuESRQu/dDkWkWnxN0HOvt5o37maW
         N782ZuvA6/DkOtFY9J/AVKwZM2Nn7izbDjEItH/mnqH72fr1AqBGLm+iAvRBRvnsyG1Y
         Nx9XjRhpxAQnyGW6SpPO85uINTa/rxfc30qNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIVVy6cMJGB/802PPmCv+d212rxtmpqIPcdcqOUFqaw=;
        b=b9Ji4OaixAwD+Va8zXJnODvMzFheOkr2VraJ8UQoumHzzQA5osDU/gEjA4MSRRAX6U
         NyRy2tRAFMhKKkJLiiTSTL/vSG1+kDwGn0XhLyDEMvbZJKOZ82xjm0jvG8bfyNV6OrHl
         aEZtJ8LuGSjjy2EF2EqErd3l0T2ZeiIUfw+VWf9TvzTOoJ5zOeUa8DolXLJIXROVwLLM
         n3KvH3LWiKen91G8AFNkn1EHkTlHuhUwMUAdjNuU1p5nUg9i8uDljl/gw5yCTuJYZdTQ
         1YwulrGPuuVz9nTQ3NigQ4t9WY9TxqzqxmLrtBHRdMsfvt7HXgWq2cpp4ip+5645UR8e
         shYw==
X-Gm-Message-State: APjAAAXA5qJDznWElumszFid8mY+ljzUcas+AXM5/A5YHRtyQZgzDhg9
        aFxnYETf3u+KU3K0xC9cyFd9Hg0kfOJMiA==
X-Google-Smtp-Source: APXvYqxFvDr7mVQsdorw/55N1/wh/6iIYXaR/QN7jEm+5HrrZMs9Lr1EwNVHHtyq31VZzS815PN7hQ==
X-Received: by 2002:a05:6402:12ca:: with SMTP id k10mr37852431edx.91.1571214439353;
        Wed, 16 Oct 2019 01:27:19 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id f26sm4044510edb.55.2019.10.16.01.27.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 01:27:18 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id j11so26954482wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:27:16 -0700 (PDT)
X-Received: by 2002:adf:f3c9:: with SMTP id g9mr1541264wrp.7.1571214436369;
 Wed, 16 Oct 2019 01:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190912094121.228435-1-tfiga@chromium.org> <20190917132305.GV3958@phenom.ffwll.local>
 <CAAFQd5ADmObo1yVnFGaWDU=DHF+tex3tWJxTZLkxv=EdGNNM7A@mail.gmail.com>
 <20191008100328.GN16989@phenom.ffwll.local> <CAAFQd5CR2YhyNoSv7=nUhPQ7Nap6n36DrtsCfqS+-iWydAqbNA@mail.gmail.com>
 <20191008150435.GO16989@phenom.ffwll.local> <CAAFQd5DhKn_2uSA=1JDSj0H98aT8X9UjxWaTBwZCDfOC7YR5Sg@mail.gmail.com>
 <20191016061201.iinqjcw6trx5qztq@sirius.home.kraxel.org>
In-Reply-To: <20191016061201.iinqjcw6trx5qztq@sirius.home.kraxel.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 16 Oct 2019 17:27:04 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B2KRJ4hKuh2rwYvgY+FLzAR-ZqNthz9XrsaPm3v3Rsnw@mail.gmail.com>
Message-ID: <CAAFQd5B2KRJ4hKuh2rwYvgY+FLzAR-ZqNthz9XrsaPm3v3Rsnw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stevensd@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Zach Reizner <zachr@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 3:12 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > up later when given a buffer index. But we would still need to make
> > the DMA-buf itself importable. For virtio-gpu I guess that would mean
> > returning an sg_table backed by the shadow buffer pages.
>
> The virtio-gpu driver in drm-misc-next supports dma-buf exports.

Good to know, thanks.

Best regards,
Tomasz
