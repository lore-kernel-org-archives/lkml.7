Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30062206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOP2T+ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCMPm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:42:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40701 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:42:27 -0400
Received: by mail-it1-f195.google.com with SMTP id l139so3582676ita.5;
        Wed, 13 Mar 2019 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gbce3mO7EF4ApW3jOBZBSKXuQvUZQZ/OTJRqEwSz6h0=;
        b=gOP2T+oxMd9BdHTRdnPkkLotYboApdopkGjgKdI6hpxfQBm061k+2clvVcy1ZfG7mH
         lk6Zk167HyfzZoyrjHBL9YlI+8LAk8+Jlm7xEbMP+ifsxZxEkB5H64Pv4TRKPrILGGhs
         Tlj24bQ5BYKYuoTnxbK9EN/gvz+XTrnSMNQn5ImI5Z/PPUEnT8+jbHMtOQGTX/haGMLa
         aqI6+WTOdAUaWm23zMQXcCio7FsRxn1GU6rX2E3/ya+RMVP4rpmbDZCR5cEkl8S8h7Fx
         FhGvIBhArC44vWq6Fp7+BpZj+ZmsSYK6tqxWFoGLcyvRB2IpQ+K3U+wrMmaVgJm7pwHq
         VRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gbce3mO7EF4ApW3jOBZBSKXuQvUZQZ/OTJRqEwSz6h0=;
        b=r7+OwPs0II91D5/r440qxGshUEB/byqeC7118guTYk1FMkiHgYljstMfO9ciCgx+nB
         OEkxbbiHYkg3Z6pCybSQfnGm6S2UcGxMB45cgGMAaA85e/6Th7G3Qjz7Iw97o+2UlrkR
         KdF9k86/V6EJLVjUWEhan1LWQ7+SMJoBAXhTbNYsZK8mW2idqGsomuEY+QWR5N+c5UEW
         jEgEsU32fP614KxllHn8LCFYSc0rO+iw/dYbny6fTQaZ6Y6vqAjJaIXrFGcr0C7KC0KN
         YDfSytIRV66PS+8BNtsZc/zF5Nz2guc6F/GsjSJ8GZ+1c8CWdRVR32M2PDCBSBBYDExF
         cg9Q==
X-Gm-Message-State: APjAAAXLAZRhsKOFRlAI1rLRZoNND2GYHgZt6zJcyg7nVYITsPRwx2Ix
        tZlkdROBtJ20l/aFzi6PQDoz0hxccGffB68JgCg=
X-Google-Smtp-Source: APXvYqynBiQVbnuX0rHyagT9uqePafkq2kn9Z8zNYwTUOCkuI+3iQuENUYUKUEhJfLcUreY+PVYEKE8OOmJXKN+VhQc=
X-Received: by 2002:a05:660c:b44:: with SMTP id m4mr2067467itl.132.1552491746821;
 Wed, 13 Mar 2019 08:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org> <1552414422-9568-5-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1552414422-9568-5-git-send-email-jcrouse@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 13 Mar 2019 11:42:14 -0400
Message-ID: <CAF6AEGt74Hs+VMgMOMAyFw9FGk5mrY2NU07JUh=OKSOhj-h6CA@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v1 4/4] arm64: dts: sdm845: Add zap shader
 region for GPU
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 2:14 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Some Adreno GPU targets require a special zap shader to bring the GPU
> out of secure mode. Define a region to allocate and store the zap
> shader.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index fed7a29..526456d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -100,6 +100,11 @@
>                         no-map;
>                 };
>
> +               zap_shader_region: memory@8c415000 {
> +                       reg = <0 0x8c415000 0 0x2000>;
> +                       no-map;
> +               };
> +
>                 mpss_region: memory@8e000000 {
>                         reg = <0 0x8e000000 0 0x7800000>;
>                         no-map;
> @@ -109,6 +114,8 @@
>                         reg = <0 0x96500000 0 0x200000>;
>                         no-map;
>                 };
> +
> +

I guess we don't really need this hunk..

other than that, the series lgtm

BR,
-R

>         };
>
>         cpus {
> @@ -1514,6 +1521,10 @@
>
>                         qcom,gmu = <&gmu>;
>
> +                       zap-shader {
> +                               memory-region = <&zap_shader_region>;
> +                       };
> +
>                         gpu_opp_table: opp-table {
>                                 compatible = "operating-points-v2";
>
> --
> 2.7.4
>
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
