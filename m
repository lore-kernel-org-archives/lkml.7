Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F6AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D59216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vA2XXEIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfHAIoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:44:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41655 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfHAIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:44:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id 62so44741732lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApaNlouSMx8uBbHDq5VJnFAAQcHTQjPYGjRXW3aemyY=;
        b=vA2XXEIzAYm5CKmotczEq6u56vcPMSfU6SQ5r/RIFSOmWcaN1evlWsJWLH5SMntRQe
         yowbGs+sPWuyH9wBiFmtYoKxRNLRd1xWHLV2pouaFBYyZdG/FazpVXMOcP53vTOsnuF/
         I55H4RtKKCcXDXqPHHUEocLPVuGOmvmXazPUp0jJr99PLP29EBVHo+cNW8V+tB/eMRmF
         oZKL3W6SbElPMWp2PyTqnfQXykWViJ11jtkvf8t7kFotqAFZR1ODt1pM6ykyZhXbKW2r
         TsOTySbx6HXX5+TtL6vYpIw/jFZl8X/fTkdG4cJiGvYw+8ER+bbHaMNDX6TgFKyLGQsn
         4rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApaNlouSMx8uBbHDq5VJnFAAQcHTQjPYGjRXW3aemyY=;
        b=RRyayQBJJylSWFfPVPWIxM839KiVliLlZs+St0FEs4O0h4352KttKx6QvHM8SwCRrv
         VuQSm3VZGXX3m9B9XGN2VBBCEHNcTj3uCvAH2Y7/V5IRHb2Zu7n+1/M2RflY8ZOEgGrH
         n0bDt8SqCIoR3V1Y6Q2F1AYWzlU61qE6Fw/qeIKc6hir0B/Wq7GmyHeoEMYapRmnUWrF
         t0wqUy+MtxxiTONkNlmQ02gbYJ7k5k4bqzs3kYPrYlJ6RzHpornbZtFA2NOtyZ1X9i34
         uf4tjxSFHhmXzQ6g/7/9cD59xyL/To27i3Cy756dwmxgLL4zvLxs+29T0lYR/raeq+bs
         XtCQ==
X-Gm-Message-State: APjAAAXGFayQDk0xR6/ZQQYyvg9r9kKa3Mgz5rYa7ZW4zK4Y7DI5MN4z
        caGMPL4e+wmPAJ2TiiexyN/gGU1YeOcifzQWadX0bA==
X-Google-Smtp-Source: APXvYqwiPimAOKH35mc/iLJ4mkQBFGo7Fu8tx06pdbdue2EpML8TleV/2fqQ3x2CF8Rqg/xGPDEjUwi/0w3JXhg1D0w=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr60290264lfu.141.1564649074865;
 Thu, 01 Aug 2019 01:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190712153722.3d1498be@endymion> <20190712155744.0771967c@endymion>
In-Reply-To: <20190712155744.0771967c@endymion>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Aug 2019 10:44:23 +0200
Message-ID: <CACRpkdb_UAMc=KKgjvVXD1xGnQLusfc9JC-av0mUSTjC83GRmA@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: ixp4xx: Hide auto-selected drivers
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Krzysztof Halasa <khalasa@piap.pl>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 3:57 PM Jean Delvare <jdelvare@suse.de> wrote:

> The 2 IXP4xx SOC drivers qmgr and npe are selected automatically when
> needed so they do not need to be presented to the user.
>
> Furthermore these helper drivers are specific to the IXP4xx arch so
> hide them completely on other architectures so as to not clutter the
> config file.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
> Note: Ultimately all I want is that non-ixp4xx users are not asked
> about IXP4XX_QMGR and IXP4XX_NPE. If there is another preferred option
> to achieve the same, that would work with me too, just let me know.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This is the right thing to do, sorry for not doing it like this to begin
with. I'll queue it in my ixp4xx tree.

Yours,
Linus Walleij
