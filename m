Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ADBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F002084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kLAme1O9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfJYV2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:28:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39781 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfJYV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:28:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id v138so2548579oif.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cm2HTCulL3+3TyuWZ4gSGdlFpdZ/BSdgV5mzZa148g=;
        b=kLAme1O9gdFMJve3eoPfNLgWL2/91n8kyzoKWqMViy5htHCxkGgCe9W47TYTkTC3ou
         +HAXh57e1evdu3sotQqgo0q3TlgdkbNn984DOTnVlOuJweMX6IbPzhL5Ah9GrZGpzL96
         YHj8vdyc3tUjecrGpVpWnabQ8BMpnYJbtIMnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cm2HTCulL3+3TyuWZ4gSGdlFpdZ/BSdgV5mzZa148g=;
        b=PPx5HVVel3HIj6FI6RngvZmIbRnwFU11x6zdFwGYctkJNwqjdjGC/XsCDQ9wtIRAHz
         YdZ/ik2DqjyROutfh+joqAsqbhxChQGxuRQD3iFWrMx5+kcAad8bDuH9cx5vdVI9uQ7V
         wpg/7wfqtuj/CiKZX/MLjrjxIRmGD5X5X5oAXV3NlipsP+VexwjEw87euMG7MHive1sS
         WDTYihaetSUafMMa4WrOP9Sf+pNOKBt54FLPdWTbEAYWrUi4ZHr4oFuSzm4gtCtYjU9t
         4279LFbnsEOKtxSRmcWtKdl1bFke1dW9WgBbCkaCzltx4BFEGWYGg7dkhBgqL1kbNbxP
         jXeA==
X-Gm-Message-State: APjAAAXWnYsmfPXXnMGHMBb1D5XDS03nllVpnOKLplX8cZWlVklMkDfg
        8QpCbuFXVWiCSEGabNgHdGRaJx4Csg4=
X-Google-Smtp-Source: APXvYqyEcdDt2a+DWQ/Owru87Smc6qNYhhJC70tF9UItr1jC5VVpgvKR2Vq4LEGF/+5k+khZiViJRQ==
X-Received: by 2002:aca:cf43:: with SMTP id f64mr4729823oig.147.1572038915873;
        Fri, 25 Oct 2019 14:28:35 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id q9sm1099575otc.53.2019.10.25.14.28.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 14:28:34 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id y5so3060433ilb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:28:34 -0700 (PDT)
X-Received: by 2002:a92:1e03:: with SMTP id e3mr7172098ile.168.1572038914174;
 Fri, 25 Oct 2019 14:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191025212106.2657-1-robdclark@gmail.com>
In-Reply-To: <20191025212106.2657-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Oct 2019 14:28:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VqNpttUXQZ7KUd1ahsDrxST9BVoy9NXCM+xhQb9aRb1A@mail.gmail.com>
Message-ID: <CAD=FV=VqNpttUXQZ7KUd1ahsDrxST9BVoy9NXCM+xhQb9aRb1A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-cheza: delete zap-shader
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 25, 2019 at 2:23 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> This is unused on cheza.  Delete the node to get ride of the reserved-
> memory section, and to avoid the driver from attempting to load a zap
> shader that doesn't exist every time it powers up the GPU.
>
> (This also avoids a massive amount of dmesg spam about missing zap fw.)

optional nit: maybe when this is applied Bjorn / Andy can put in the
actual error message to make this easier to find if anyone is seeing
this problem.  Specifically:

  msm ae00000.mdss: [drm:adreno_request_fw] *ERROR* failed to load
qcom/a630_zap.mdt: -2
  adreno 5000000.gpu: [drm:adreno_zap_shader_load] *ERROR* Unable to
load a630_zap.mdt


> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 2 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

I probably would have put it in two patches (one for sdm845.dtsi and
one for cheza) but that's more because I'm obsessive-compulsive than
for any real reason.  ;-)  In any case:

Fixes: 3fdeaee951aa ("arm64: dts: sdm845: Add zap shader region for GPU")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
