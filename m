Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E4CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7305820830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/h/kNCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEFHIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:08:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44361 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEFHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:08:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so6510182lfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ckxUK0EUtxo/rY9pVfkfhX61lQYjZP3T6ZijSk+Xis=;
        b=r/h/kNCyuv2LvDzVu1yxK2Pm9OQBmhjtYxX3feYYLTgvRpNmfmIv3nnqgAboDR0p0E
         B2Rw1gnv2ZURIXNuRQtBE/9IZ3ViUqrugMcI+kGblYdzsYaPm1H471eRPgzRnX+xdBDu
         dbCZroaZtjew5vv0xcxC4b0ofWDB8YT8OA6yQCUyyI+jdhtx76GNqhTsAip/WQ7mLI3X
         baWB6qrwoWrac+JVW+frSKfR3417U0+pNBq7bU1IjZ0+PDbrWX/PyUh1cMCj1Ma6g/eF
         aQXzDs+MTOJeL6OShLSE/c2sKBInacUOLjcAGdio5C2LJU3cxx3RIlsh+Su4juviTVcf
         6z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ckxUK0EUtxo/rY9pVfkfhX61lQYjZP3T6ZijSk+Xis=;
        b=DqTxWTbK+hVjC7IfR0/IjF8dYVWO2Qk2SiE5KQpd3KUYshXSCcHtJj9JfITnUrDFnF
         ud22wnUJVeOkqXRm2HYHPKICl6PCwvC3oHu2XBCDHKuQWfBJYfwtKc4rFx/QXl+o70Nx
         1E+xafMasN81q44Nx8zVKvlwx3rQ8AM/7sZnKbdWz+fiEtCNZFVr/eRCBVjcvctWrmPz
         xObh2byTIkUcWF3A2Vk8FzP1Ss0SHCzShQ0Mj4355fnfw3fz8GbeaLK2zxW3jN39IFYX
         HnsilxTdcJN4d+h5FrTpXYM6D7/nIIj4c799u0DReykQOPKJWabHYnA1Vq2wpmRIgur9
         QCHw==
X-Gm-Message-State: APjAAAUg76equnGOTxETaCHZbGryI39EuFJ8cY/aU327ZCeMMM7Tublc
        DItbfVbFT1I0DLXssyRxjaIMMKzq1nYRtSm5QyqiLm+U
X-Google-Smtp-Source: APXvYqzCc/OSjn4pYKPp9j7dsjoSNEmMF6+y2Uv/KDTK9i/yRnI7v8HdczB/oMXqR5l+25NY5pgqs0RUm+/PLM5ihP0=
X-Received: by 2002:ac2:5381:: with SMTP id g1mr11913523lfh.130.1557126532214;
 Mon, 06 May 2019 00:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190505130413.32253-1-masneyb@onstation.org> <20190505130413.32253-6-masneyb@onstation.org>
In-Reply-To: <20190505130413.32253-6-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 May 2019 09:08:40 +0200
Message-ID: <CACRpkdZ608b7+mh8Ln9N7EdGQmu2YNdZqRzoYjwfZXtcWqFE5g@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] ARM: dts: qcom: msm8974-hammerhead: add support
 for backlight
To:     Brian Masney <masneyb@onstation.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 5, 2019 at 3:04 PM Brian Masney <masneyb@onstation.org> wrote:

> Add necessary device tree nodes for the main LCD backlight.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> This requires this series that I submitted to the LED / backlight
> subsystem:
> https://lore.kernel.org/lkml/20190424092505.6578-1-masneyb@onstation.org/
> It's received 3 {Reviewed,Acked}-Bys, and has no outstanding change
> requests, so I expect it'll be merged soon.

If the DT bindings are ACKed and reviewed we can merge DTS
files using it IMO.

Yours,
Linus Walleij
