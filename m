Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0743DC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FD82133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986170;
	bh=dBKRpCb+TdtFesGpn6eSh3quFn1tVcWVH4LK3WLPRRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fVyuVc+ore+NToDRGJ3REpOSFmpNTpvH0Y06ObqvBu4QWdC5GTwagLrVRpnfVWm1e
	 Z2s7DHZ5MtSI9sGXnIi2t3InBbmeZBKjQ/ZliYsI0XmXU9QZRoWQeD1VaRC+/7JvYy
	 coI+PfxUOaFeO58PAMsi69UxxVg2iS3E9gUp3+j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfHPUJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfHPUJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:09:29 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0150321743;
        Fri, 16 Aug 2019 20:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986169;
        bh=dBKRpCb+TdtFesGpn6eSh3quFn1tVcWVH4LK3WLPRRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PtnUD++jqV+GjQkcWEZ+e4I5qc7dX8ApeEQuQ5RPADy3+0Wh1L58LyRxHnp7n/dwG
         u8xxXcJqUYgwBXtQenTqknzJjgAjJzbALa+WLVgp5UxTncf5y2u6uCRcBVekBKOfCJ
         YTNIIy7OjyC8NtM6E+yEKW9/X4yG2fk174HpcGAM=
Received: by mail-qt1-f176.google.com with SMTP id q4so7453070qtp.1;
        Fri, 16 Aug 2019 13:09:28 -0700 (PDT)
X-Gm-Message-State: APjAAAVxOlkUp1fKRdI6HGvsyWId+ozkEsX1/fES1ED732RVxJHzOHhc
        Cv7iA4PYH9UblnBCYRsUOsZ9bFbPH9oQiBKUFg==
X-Google-Smtp-Source: APXvYqwebIs+I5l3D3YNa890IMkRQs6Czk1XXOPRicSteg8JjjQ6x/E6bhhzrgOT4keRPpNwkXj4uLugSyFeEGtAOs8=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr10274315qtc.143.1565986168088;
 Fri, 16 Aug 2019 13:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190816100424.5366-1-wen.he_1@nxp.com>
In-Reply-To: <20190816100424.5366-1-wen.he_1@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 16 Aug 2019 14:09:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLPZ+hCGd=J3MU83saHJJ-yx6k+X0Y7-2ECu5yT8PxF4w@mail.gmail.com>
Message-ID: <CAL_JsqLPZ+hCGd=J3MU83saHJJ-yx6k+X0Y7-2ECu5yT8PxF4w@mail.gmail.com>
Subject: Re: [v3 1/2] dt/bindings: display: Add optional property node for
 Mali DP500
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-devel@linux.nxdi.nxp.com, Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yang-Leo Li <leoyang.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 4:14 AM Wen He <wen.he_1@nxp.com> wrote:
>
> Add optional property node 'arm,malidp-arqos-value' for the Mali DP500.
> This property describe the ARQoS levels of DP500's QoS signaling.
>
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
> change in v3:
>         - correction the describe of the node
>
>  Documentation/devicetree/bindings/display/arm,malidp.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/arm,malidp.txt b/Documentation/devicetree/bindings/display/arm,malidp.txt
> index 2f7870983ef1..1f711d32f235 100644
> --- a/Documentation/devicetree/bindings/display/arm,malidp.txt
> +++ b/Documentation/devicetree/bindings/display/arm,malidp.txt
> @@ -37,6 +37,8 @@ Optional properties:
>      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt)
>      to be used for the framebuffer; if not present, the framebuffer may
>      be located anywhere in memory.
> +  - arm,malidp-arqos-high-level: phandle to describing the ARQoS levels of DP500's
> +    QoS signaling.

The driver is reading a u32... Did you test this?


>
>
>  Example:
> @@ -54,6 +56,7 @@ Example:
>                 clocks = <&oscclk2>, <&fpgaosc0>, <&fpgaosc1>, <&fpgaosc1>;
>                 clock-names = "pxlclk", "mclk", "aclk", "pclk";
>                 arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
> +               arm,malidp-arqos-high-level = <&rqosvalue>;
>                 port {
>                         dp0_output: endpoint {
>                                 remote-endpoint = <&tda998x_2_input>;
> --
> 2.17.1
>
