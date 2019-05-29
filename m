Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49191C07542
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0E021734
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqk/J0AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfE2GXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:23:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40211 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfE2GXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:23:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id q62so1214751ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 23:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1SBl/NhErMiMqrSROQABj44p6n5fylOaEGm2rxHFac=;
        b=oqk/J0AF4QeADPOdicRdeDUwsHkDSXWjWx8dSgJe6kYqicSzaWT6We5F12PmUwMZ65
         LMtry+PPgl9aZ+ehVfQ3aYUPdsUA+0G/0MxVYzVP3GQ7nbyVaWAFtqS14q9Cz/sXTVWw
         WStWmxJlYuL0EZHA9ZLPC+k+8DEk47jsreW/64yj3ouY/mC8ANmDOehvx6T5ccr5eMGf
         1WHWfK+w0dKIuRVlMUYtK5EJTnE70DhNt1doisAzvDA3kA4nYYZdqKIMaavmi3/4P3dM
         OFEXNXqpmonqPRobjHOdNVf7Lw0XFzgEPkX3HUfI1XRrIa4g+PCInqe2zu8U3pN8pT/h
         jBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1SBl/NhErMiMqrSROQABj44p6n5fylOaEGm2rxHFac=;
        b=PO8TvKiU2efYlmnlX2jrnTjQXrYFSr3oWr/wwewQsa6D6AiCWQs+zz7AKv7seKH5tx
         8mcXZkaMyGD26nRlIPL5TUQ/13nqQPUY5ycPSXfttAYZ6R75mtdjSHQ8tK1rzHEsmZ86
         qPSSPG7Vq9kaRaoPXsxwR6IiReElkArLSIVTwSiOI8jcMoPzzlDm89Dg+ILJuN4UIt+6
         Pm6+E26YwHVpFXW0fze0n8dpZKj9yzyJNBzufkh5hwrNxwHYeV51ub/QMenPzUS9BCiB
         a1mX5BIQR4Dkzq/ZqUvyOsF7Y+7GU5N+Xmw+uVnLuriJKuGLp5cJJITX9jy2f1aFI1Lt
         QnQQ==
X-Gm-Message-State: APjAAAWE53w7qh1V2xXDJp7MJbVDNyWcnvLhfAccyITVp33ywzU5Mhef
        MfverR8+trfbM1RqUDJnoD5NDapJwxeH4nuLk7eFwnE7brI=
X-Google-Smtp-Source: APXvYqwIsl1wSDxK9EPcOc6HNZDGzaYIXxohtHwHpz4z0RvbNyq1y2+YZmevdVoB7By354baiJgjeTvrt9wKyS/5rzA=
X-Received: by 2002:a2e:8997:: with SMTP id c23mr1321995lji.94.1559111009909;
 Tue, 28 May 2019 23:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190509020352.14282-1-masneyb@onstation.org> <CACRpkda-7+ggoeMD9=erPX09OWteX0bt+qP60_Yv6=4XLqNDZQ@mail.gmail.com>
 <20190529011705.GA12977@basecamp>
In-Reply-To: <20190529011705.GA12977@basecamp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 May 2019 08:23:17 +0200
Message-ID: <CACRpkdZu5KxKTMqAM5rueWbrXbfPNorOOerezCAA3vgAR6cD5g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/6] ARM: qcom: initial Nexus 5 display support
To:     Brian Masney <masneyb@onstation.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 3:17 AM Brian Masney <masneyb@onstation.org> wrote:

> It's in low speed mode but its usable.

How low speed is that?

> I assume that it's related to the
> vblank events not working properly?

They are only waiting for 50 ms before timing out, I raised it
to 100ms in the -next kernel. I'm still suspicious about this
even though I think you said this was not the problem.

For a command mode panel in LP mode it will nevertheless
be more than 100ms for sure, the update is visible to the
naked eye.

Raise it to 10000 ms or something and see what happens.
drivers/gpu/drm/drm_atomic_helper.c:
 msecs_to_jiffies(50)

Yours,
Linus Walleij
