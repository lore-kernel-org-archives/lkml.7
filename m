Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208A5C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C64205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYKXcx42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfEGGiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:38:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32876 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfEGGiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:38:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so1790347pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wWtp0jnKgCQgvYHJQP0mFqZsKhLPzrO6V1C+32VkFts=;
        b=nYKXcx42aO3MAUePdnRAiJ9/V6lyE5FcjpoFwRX8BMynr8FAmMbfC31a5SOnBmTMYP
         PDkho2ZE0OpqizZTZUU7EyGn8V0iipQwESQo4HxtxQ7G04peOASIu+JmnHkxsalwxihD
         t8100G13Dr1QASK8RXQZ6b1UPHUqUH7B0sGBvVx4lnLoBF4qJrqT82Vvq4l9JrXfOuOa
         dzbCOI2t7m1lobnq2FyseXkvsLCqlfRfWiOepvom8swe/loDKYzz/akLUeb7Xhd6kzaJ
         aeYYMcnnJr0om+4NUfgNIKz0ffecitJ+H4aEMnNgDyknUm5GS122n6ls93W6MCAw+KGj
         U2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wWtp0jnKgCQgvYHJQP0mFqZsKhLPzrO6V1C+32VkFts=;
        b=fBFhxFKRRDNQVLzhsVFp9wFQ72ULHyjy+3jOsN8IBFXSElwL8SDT5Nskmff60z+oGY
         olMwZ/XHF7alMNhRqxoTW/szGdobDcp8Zo0frfuksWmFIV0fRJZjnvPZ/Gdv1e9uASW0
         /vJvIjoUNLQlLtcV6l3LSZVTJUV1UQFG5I1rgrReardk5NOftJYt1WCjA4R7gi2gSPe+
         UtLCxRxfFoihxaZGJPtXphDLHhnFLKbNMjEWkHrTmkbRdIhp3hibww5sYKlMnjKVzrPc
         R4ERdeEUYDXh5IvhQOFa0iNGR0zOqRDiGicFokin2LEKjoPasFRS0Z7cRjr2FvGTFkwS
         yuew==
X-Gm-Message-State: APjAAAXDaAG1BCStmEyBmUgjUeMooGNMjuSZvbklg6vBxeVwGfT1AOKx
        lypnj3gifLmkBXr8tEV9FQIaVdgjeoc=
X-Google-Smtp-Source: APXvYqwY91xBBVJv/756Xx6HEZCctbmrzp1jJLE/1sryCLnIM8LwzomLH62O4ev8IQJQJLg+ufVU8g==
X-Received: by 2002:a62:6842:: with SMTP id d63mr39964616pfc.9.1557211130015;
        Mon, 06 May 2019 23:38:50 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f2sm18843390pgc.30.2019.05.06.23.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 23:38:49 -0700 (PDT)
Date:   Mon, 6 May 2019 23:39:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robdclark@gmail.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH RFC 4/6] ARM: dts: msm8974: add display support
Message-ID: <20190507063902.GA2085@tuxbook-pro>
References: <20190505130413.32253-1-masneyb@onstation.org>
 <20190505130413.32253-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505130413.32253-5-masneyb@onstation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 05 May 06:04 PDT 2019, Brian Masney wrote:
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
[..]
> +			dsi0: dsi@fd922800 {
> +				status = "disabled";
> +
> +				compatible = "qcom,mdss-dsi-ctrl";
> +				reg = <0xfd922800 0x1f8>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
> +				                  <&mmcc PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&dsi_phy0 0>,
> +				                         <&dsi_phy0 1>;
> +
> +				clocks = <&mmcc MDSS_MDP_CLK>,
> +				         <&mmcc MDSS_AHB_CLK>,
> +				         <&mmcc MDSS_AXI_CLK>,
> +				         <&mmcc MDSS_BYTE0_CLK>,
> +				         <&mmcc MDSS_PCLK0_CLK>,
> +				         <&mmcc MDSS_ESC0_CLK>,
> +				         <&mmcc MMSS_MISC_AHB_CLK>;
> +				clock-names = "mdp_core",
> +				              "iface",
> +				              "bus",
> +				              "byte",
> +				              "pixel",
> +				              "core",
> +				              "core_mmss";

Unless I enable MMSS_MMSSNOC_AXI_CLK and MMSS_S0_AXI_CLK I get some
underrun error from DSI. You don't see anything like this?

(These clocks are controlled by msm_bus downstream and should be driven
by interconnect upstream)


Apart from this, I think this looks nice. Happy to see the progress.

Regards,
Bjorn
