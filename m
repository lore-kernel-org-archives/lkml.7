Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537BAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CBE20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014439;
	bh=oyqeBNdpgNKbH6q+l+o7pwgrY//SkJ8CZPSkWYwrJOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0AymmPRQe/G6dZiZg37kPKTdCPyjmAeL9idbJX3NO67v2ly7WxUrM76vtJNkArrzM
	 xBS1/391AifDpwoBeYOakd9MyJhHpZYv80uUJ+syDtCBQkXS5Ba//GCR3dlycbdg7V
	 i55gZs6Sket08QfDZ4z9c2FEuqX8ftZylIWOos1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCaGka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:40:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35357 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCaGk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:40:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id p19so2940630plo.2;
        Sat, 30 Mar 2019 23:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gyVTZ1PkbobqjcKxa3+GkPj//34KKTZhu8/15Zm/dJI=;
        b=HJK4IXH8iD0ROcOS2h4KFsPIHvoMc8umhY4oHMEL8EJf4ohMDaP3YPX1aF2cQ5WnHA
         PPnNhDHC6OBnDOAdZOnviOgvcD4LVK3OVvZz938CKs94IpYO0xdX+63EHtftjwCfrn/N
         MkmSyHUnA7M9+VxwyWT1CtMwHgDL19LqB61ezEdA4sEUP7fJ+XWR45lvTb9KzgOuIdqM
         lClz2TAr16Wp3BZoi90+heuG9GYn3SB4YJjD80vlebgPFne1rkPWWD4JxyjuAmsCS0K2
         06/QJaS1/3Cv4Z8a8BY9Mojw382ugsEVqm0WQqKbXQRKe4Ek5uFN4ndr7C73YJT7efkc
         b55g==
X-Gm-Message-State: APjAAAXXB4YJzSWAGgN3DgXoDV5uruxma7PX57CL/AWdMynf+fg7n4cT
        IDAdNonFDWI7KsEhqv4gVuLeLj7SFA==
X-Google-Smtp-Source: APXvYqx3vnn7NYGkPVv+gCcn4vQ1asfhLQuOQU06fUnG8zxikzEIX43j/85iEIXVvS2phfDDujia8g==
X-Received: by 2002:a17:902:864a:: with SMTP id y10mr58263982plt.76.1554014428444;
        Sat, 30 Mar 2019 23:40:28 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id 13sm8170123pfi.172.2019.03.30.23.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:40:27 -0700 (PDT)
Date:   Sun, 31 Mar 2019 01:40:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: meson: Add drive-strength
 property
Message-ID: <20190330212830.GA28281@bogus>
References: <20190314163725.7918-1-jbrunet@baylibre.com>
 <20190314163725.7918-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314163725.7918-2-jbrunet@baylibre.com>
X-Mutt-References: <20190314163725.7918-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 05:37:24PM +0100, Jerome Brunet wrote:
> From: Guillaume La Roque <glaroque@baylibre.com>
> 
> Add optional drive-strength property
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> index a47dd990a8d3..4e3d5a27c91c 100644
> --- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> @@ -51,6 +51,9 @@ Configuration nodes support the generic properties "bias-disable",
>  "bias-pull-up" and "bias-pull-down", described in file
>  pinctrl-bindings.txt
>  
> +Optional properties :
> + - drive-strength: Drive strength for the specified pins in uA.

The standard definition says this is in mA.

> +
>  === Example ===
>  
>  	pinctrl: pinctrl@c1109880 {
> -- 
> 2.20.1
> 

