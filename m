Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C653EC04AAE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A037206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDlv+7ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfEFHEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:04:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41693 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfEFHEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:04:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so10089090lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iNnmod9ZKYpePclbWo4PT7+A86yCjlpOu7Z5K0IfDaI=;
        b=pDlv+7ag2wt+konKcf3YjvXQ6Rx8/AkKeXQxV1jX2Yytl40iicDeBaiJDqbX1JNyQr
         dmy65YjhxAUORD4wvQCuMlzacDMJ3Gv3BOZ4wyPiCHxJbsVE8p+pIhpKg9KPEeiIYfut
         2t/qiJZs/QJWX8oAuj9XOnR3mE1OMSi+mDyfHECpsTb6MaNv3Q53YK0yef+Z487Kpx4i
         HHgX3CBx/h482EqJqKDZNPhTMgzEvMbtTfQRCY1ChPdtS4DaHFcNfq/y9M8Rgoyah0Hq
         ikkFaNXi8C43tOIs5Gm1aGBA/Ad71E3g0vMbVmm3JB1k+Gvlnx1hAAonb082ZSfAbS3f
         OLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iNnmod9ZKYpePclbWo4PT7+A86yCjlpOu7Z5K0IfDaI=;
        b=V9B9JZsGMLac/YA4Aqg2SwNADh7mLo5ugUzHppeCe2AAllA5UEg3Oe50ah7YCqR+5z
         1kolIBfdEfiPanEilv2fwOcop7kTex3mFS7JXH8GOySQmZaRoGD8FINcNRyO5RJpXLzA
         /YfxxxhGiZaci1WKhbMhU4RxJGydeH3YzC8h0yd+92SCV+xKtYx0BlX1AksFx5LbgE9O
         mU/Sxm860FOjVqnM1aaLoXxj7pD8rODfoGHj/un/3FwXg410i38E26GDCjra7uQDrdAR
         IkqQa++m9e7LpnOtm1YMzKHJzP4JFXIq7mtr1U158x/EekaxJQLpzsP4HCfrayAxxPd5
         sfvQ==
X-Gm-Message-State: APjAAAVTaMnyL3xPlo0+k35t3TQJn1sp3hCwftVdjx+pxD5EiMYcJSh5
        eOcPlFiKghCWO2r5MjfP66J2T53jjyhGexhawXDPQw==
X-Google-Smtp-Source: APXvYqwpSJLl8gV6pdZU4YYHl94me2CBN5IMcXEz3u0oBYWdfeT0XTVNkb2FrbRHhDYCHk2DkNUzwnMuw0PYb0iLxEY=
X-Received: by 2002:a2e:8e93:: with SMTP id z19mr9427670ljk.159.1557126286550;
 Mon, 06 May 2019 00:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190505130413.32253-1-masneyb@onstation.org> <20190505130413.32253-4-masneyb@onstation.org>
In-Reply-To: <20190505130413.32253-4-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 May 2019 09:04:35 +0200
Message-ID: <CACRpkdZFK9EGptXbtowUMai6M-jdh6OSTU2=X9A-N3R7hcvXiQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/6] ARM: qcom_defconfig: add display-related options
To:     Brian Masney <masneyb@onstation.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 5, 2019 at 3:04 PM Brian Masney <masneyb@onstation.org> wrote:

> Add the CMA (Contiguous Memory Allocator) for the MSM DRM driver, the
> simple panel, and the TI LM3630A driver in order to support the display
> on the LG Nexus 5 (hammerhead) phone.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> The panel and backlight are currently compiled into the kernel, but will
> be moved to be modules once the display is fully working in a later
> verison of this patch series.

I don't see why we would want to do that, the FB console is
traditionally (x86) good to alwa=C3=BDs get up, as serial console
might not always be available. For example for people
who can't solder special cables but still want to boot a
custom ROM on their Nexus. So I'd say keep it like this.

Yours,
Linus Walleij
