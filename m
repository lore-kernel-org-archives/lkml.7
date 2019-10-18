Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0716CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C673321D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LJ3VYJOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbfJRQPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:15:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35197 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfJRQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:15:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id 14so8137wmu.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=NiPnnXybYfsCEoSCgSQ6VkI98y5AUTMUbQ2sEfUh8lM=;
        b=LJ3VYJOWqENNeg46QP9EUkyyoZpR3YjGZPsjYq4Ja8jvNdAIgR3+F/71fH0Omf3eJh
         /U0rpku9ScDIwQFscwzHngVX7QNE7yJkRqaMaj80QmZVgYT6mO32dHzZiUy/pSTqPLnL
         QiEOvZJI2dhrgBG+DmnrmZVe6Y+1YZ1rs+XPatSiiubP4xHvauVIk5Q+PQAijWcwsMjn
         JFBZKRyEbymUsXSVNoRfH4xMTuVPgtJ/Too1ONx/p+TYKecOqfRAzFsdy4hxu5UPyTy1
         arvjFs/yI2gXxqOJ5g0MBTcrdLzbDt9o/4ibDY8tLIC9VCuyBapDxMnEoMiVvSNcQ5jS
         ShNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=NiPnnXybYfsCEoSCgSQ6VkI98y5AUTMUbQ2sEfUh8lM=;
        b=fp8VjmA+ajiMJTJadzAHRvrwhoDYaolkyZ+1bo9Ans0NLPq/F8T9OltsZdXaexXm6r
         NhQCRtpBr6PcvMvn6drk+shkkByaVtjXKQMsIU7vw9nYsbGnI90/fhGNmaJQoQFKihLk
         U+9oV7jZjmC0R0CV689YIf+8eHO1jO5JdLGjQXhF6+w5GEZgw75/zR1KOfKCROs9U3Il
         j+QHa4D+ax3J5FWK0wG8a1c4aCrunzKbqoyZVnvNnulfg5wLw5GoDdvQ3kyw0Cw/IcnX
         kAsyIkzo7MvXlf+G7nRDXsupjTXLgbkrCPBHf5VEKL5dhxBKQMui41/ZX7GxTUSkwL6E
         psUQ==
X-Gm-Message-State: APjAAAVHE+IbwodBKpL07krd7wvpeVNKS81Ted6NSZo8C6alA8vkOTfv
        jKoknYPA/reSY+WgONaXZqRgDQ==
X-Google-Smtp-Source: APXvYqwVNEtt08u0F9IheP0GbcIL5/IMCNWStusFtmWS4tmcB8YxFZjDBcaMwAOipydLI72D7t6IGQ==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr8379512wmk.126.1571415332059;
        Fri, 18 Oct 2019 09:15:32 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f6sm3023324wrm.61.2019.10.18.09.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:15:31 -0700 (PDT)
References: <20191018140216.4257-1-narmstrong@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, christianshewitt@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson-g12b-khadas-vim3: add missing frddr_a status property
In-reply-to: <20191018140216.4257-1-narmstrong@baylibre.com>
Date:   Fri, 18 Oct 2019 18:15:30 +0200
Message-ID: <1jbluef2sd.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 18 Oct 2019 at 16:02, Neil Armstrong <narmstrong@baylibre.com> wrote:

> In the process of moving the VIM3 audio nodes to a G12B specific dtsi
> for enabling the SM1 based VIM3L, the frddr_a status = "okay" property
> got dropped.
> This re-enables the frddr_a node to fix audio support.
>
> Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> index 554863429aa6..e2094575f528 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> @@ -152,6 +152,10 @@
>  	clock-latency = <50000>;
>  };
>  
> +&frddr_a {
> +	status = "okay";
> +};
> +
>  &frddr_b {
>  	status = "okay";
>  };

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
