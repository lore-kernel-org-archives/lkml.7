Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F43E2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GR//cp3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEOVn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:43:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33668 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfEOVn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:43:28 -0400
Received: by mail-vs1-f68.google.com with SMTP id y6so975724vsb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kjfknf32vTN6dOCTbKM2s4UhXiubagFxAlST3GyPe/4=;
        b=GR//cp3pkBQCdrHCiA7U78cbGHrhAthjeR/dCjmIIoD5qYQZuteM3NaBSy+HNbvY48
         IvgNM0VAE85ycebNJSfBDPE3hfaZSJCDQ23VFwYM5vosvYKqaPXIMso4VLQPi1wCqPof
         nH2b4nPE7GE05LNfkK8yd9VHThgjZlNPDOpZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kjfknf32vTN6dOCTbKM2s4UhXiubagFxAlST3GyPe/4=;
        b=FQCLMlCfgm3oTe+oUIUDnFYbLA8nvBsF2b2c7WvzMmz0SHSoHHSqGnN17fZyJ7/q5K
         eg9tZm7nK4xlhlXS7FtPGmxVZUnB2/OrFTjpEjTykp1QUFmwok3BRb1q36+g4RKfw/AO
         2CBpE/KcG39suaETPodptnMzFoymY7nTx1HKuokeS2N995fxE11CHvijoKFuHp3FJBA/
         3Rl9vm/4n4kE5IFYb/fURa5aIJ1XJ8KXg+bDh7Jp5yLrHz1Mnat2cp12QWvhYm/k/hQk
         pstKuoHE27yAvXmM+AMtXJgH0WSXqj/AzPh3l1cTMQZ3SkYiyFUNvQv3lqim9cDbqYdM
         UOrw==
X-Gm-Message-State: APjAAAWWiU4+FKGhKXsdzlt7Iu6uPfvsyGlFE1bwQQZP9jfFixqZMWUo
        2Nny7tuUxxsRDxN+r4haqkJqEyF81Rc=
X-Google-Smtp-Source: APXvYqzI0DZNHNqaLf2rdm4kPhWCuuigFMQigCu87CWmWJpCHV4PeMMblAahVFMFkVBLztxDoaM5Tg==
X-Received: by 2002:a67:b904:: with SMTP id q4mr2232958vsn.24.1557956607591;
        Wed, 15 May 2019 14:43:27 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id q63sm1268776vke.2.2019.05.15.14.43.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 14:43:26 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id e2so913631vsc.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:43:26 -0700 (PDT)
X-Received: by 2002:a67:79ca:: with SMTP id u193mr20557958vsc.20.1557956606068;
 Wed, 15 May 2019 14:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190509184415.11592-1-robdclark@gmail.com> <20190509184415.11592-4-robdclark@gmail.com>
In-Reply-To: <20190509184415.11592-4-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 May 2019 14:43:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xa0kAReU7CFvO8QiCRkNxGaQY_JohK+psykqeN9e+QJw@mail.gmail.com>
Message-ID: <CAD=FV=Xa0kAReU7CFvO8QiCRkNxGaQY_JohK+psykqeN9e+QJw@mail.gmail.com>
Subject: Re: [RFC 3/3] arm64: dts: qcom: sdm845-cheza: delete zap-shader
To:     Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 9, 2019 at 12:08 PM Rob Clark <robdclark@gmail.com> wrote:

> From: Rob Clark <robdclark@chromium.org>
>
> This is unused on cheza.  Delete the node to get rid of the reserved-
> memory section, and to avoid the driver from attempting to load a zap
> shader that doesn't exist every time it powers up the GPU.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 2 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-

nit: up to Bjorn / Andy, but personally I'd put cheza and non-cheza
changes in two patches.


>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index 8ccbe246dff4..28c28517b21a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -175,6 +175,8 @@
>  /delete-node/ &venus_mem;
>  /delete-node/ &cdsp_mem;
>  /delete-node/ &cdsp_pas;
> +/delete-node/ &zap_shader;

nit: I'd probably move the delete of the zap shader to a slightly
different place just because the rest of the lines here are deleting
reserved memory regions.

Other than nits this seems OK to me.  Not that I know anything about
the zap shader or why a zap shader wouldn't be appropriate for cheza.

-Doug
