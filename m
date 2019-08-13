Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C43C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C132B2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvJtcx90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfHMEma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:42:30 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43845 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMEma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:42:30 -0400
Received: by mail-vs1-f68.google.com with SMTP id s5so1250967vsi.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 21:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaW9Qx+88VWTx+9b9qhNUZnDUtPuKjG0s1mMU8Nis6c=;
        b=lvJtcx90FAaGPEu/XW+0vvu8TV1NTazPK5Iq69mb8iVFc4+umjAsRxSE5hH0wGEy/H
         hHuZdHg5i2ZwVSNje4zoKdBZ11PKnY5CZ3y/vR4z8g0sdiuQvKboOdszeql702ttQ115
         cxTriffFWVhKumvp9sct7baljQnsIxxKZzzQHAYVDoqZW8eA7WkH1kdeb4ccHRIJaiJt
         IxoEhlY65n+Q5Psat2W/qyZIcq90sf+tBwpwZ7UCOGbawDOMbxovmufh4K14W2h4qQmt
         CdJxG9Hy79mzZCx92pEe+LtgfvrS7JJEmcAzy9ibUM1T2Jeo+RYjmWzTttz2Ur7EWirM
         eV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaW9Qx+88VWTx+9b9qhNUZnDUtPuKjG0s1mMU8Nis6c=;
        b=P0Cqg9TJZb55kfwjuCbD4EKZyX/ciZp4OkIh5znSnIXzpE2ycAjoNT5WVZ0/2AgYXK
         9FxsQ8F/kOj1l0v5B7rak7MJ0M9QFxwmNiIvFl9dDnmdFSnZC5SMte9rcVXWTWQzS/5q
         ox7O4lvwJcNy/0u53X4udTsqMx4l7NgVxRYnrikQL1icuWNFHN5MsNa8rTz9regZRc2I
         UTibFiMV0pA6i3Mq2Il30najJh6zxcWG1G9pSAXH5AwUjgim6MJ9ik9J66FeY25J57Mr
         c1vX98G/ZzpRpKhbZ+u++gLdCS3sOsG48241k0kuCK8srk/uJrk0l1A4dzoEJ0+DvU2M
         hWYg==
X-Gm-Message-State: APjAAAWQTbvRIpgAcieaMo/NL0S9J5/Wql33cDWZJq3D1rE2ZwvL1TjY
        Cac55XieM0VRR/6YlGbuHrMlk2W4Om08ZjIq/dk=
X-Google-Smtp-Source: APXvYqydG587D1UEKxjvorzxLvwYX0Xd1Mk7ivJDE3O8H78MedLZXKwQIoRBK+0DRz176mBDQw+KrpvYEzOBVrd7qac=
X-Received: by 2002:a67:f9d9:: with SMTP id c25mr2875459vsq.76.1565671348875;
 Mon, 12 Aug 2019 21:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190807234709.6076-1-lyude@redhat.com>
In-Reply-To: <20190807234709.6076-1-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Tue, 13 Aug 2019 14:42:17 +1000
Message-ID: <CACAvsv760Jtzubm2faimEY1z1tfNPBcsOJg6Ns0wL8W-9fxRXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/nouveau: CRTC Runtime PM ref tracking fixes
To:     Lyude Paul <lyude@redhat.com>
Cc:     ML nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 at 09:47, Lyude Paul <lyude@redhat.com> wrote:
>
> Just some runtime PM fixes for some much less noticeable runtime PM ref
> tracking issues that I got reminded of when fixing some unrelated issues
> with nouveau.
>
> Changes since v1:
> * Don't fix CRTC RPM code in dispnv04, because it's not actually doing
>   anything in the first place. Just get rid of it. - imirkin
>
> Lyude Paul (2):
>   drm/nouveau/dispnv04: Remove runtime PM
>   drm/nouveau/dispnv50: Fix runtime PM ref tracking for non-blocking
>     modesets
>
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c | 51 +------------------------
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 38 +++++++++---------
>  drivers/gpu/drm/nouveau/nouveau_drv.h   |  3 --
>  3 files changed, 18 insertions(+), 74 deletions(-)
For the series:  Acked-by: Ben Skeggs <bskeggs@redhat.com>

>
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
