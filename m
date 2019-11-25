Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E2C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1D3207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Pckq8+ZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfKYJEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:04:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37154 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:04:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so16891167wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FCcRXq9rJbMPMfoFuzPFIe7CFg7Q6ZOnAYxFNHJ2YvA=;
        b=Pckq8+ZBX0c5vXqXPdW0trgRD8vqBwKVOHlUk33mbPiLqxw35IH8UR0w3sDEVmDsTK
         755Bektz7Ti/C1L26KE6nGgar7kYjqM5NIUhjtqtXK8VEdSoS9fpd7IMsj2sOvFLvUx2
         qW0Kqn530++EQSW3YQsiWIMTzwIdm6azBwOfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=FCcRXq9rJbMPMfoFuzPFIe7CFg7Q6ZOnAYxFNHJ2YvA=;
        b=UJB0NjCeekW3E2STBSDhzYZrgoYHR8hHGHvPP6UHePT9l0eICSd3ehWgCrk9ZQnZ/W
         hM79uA0Yb6N0iqyBvjrSQKquIZWMyQY8vTq+0Autlb0ctOSm2DeGgQa53J1sM5yMcsTe
         09r+M9+Gaq/6/6BCBt+V7/AB9qyjiqp7zuEX9NmCf8m94cKHK2ejKtkvUzHo7OMnAHSQ
         3i1TuKA9gFiPfd6/QIK0dPIt6vh8/YPUW3nLCtpWW3RTxVsAxRcxIYUU7rlid6b0xDKi
         azVKqjNfVhWO/7M64ilEiZbsEOijkfhlfz02Z+8ZogS8XaxF5V25X2Cs3iyStDYqGAHj
         BpqQ==
X-Gm-Message-State: APjAAAVtyxOurdjLcsNx0jihztmj6Zd1wL4pFp+BlvIroiZeFlofUBKV
        OMfHtdHfKZEmTcUzDcgQSZobuA==
X-Google-Smtp-Source: APXvYqyQrihAxd9KIrI5g1bVfEDvkyJIYOfqMHWXRNrqbbA0K6a2Hi0OFP2QAYHm/PkP+X/BY9gfCw==
X-Received: by 2002:a5d:5227:: with SMTP id i7mr30428764wra.277.1574672670756;
        Mon, 25 Nov 2019 01:04:30 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id 91sm10059586wrm.42.2019.11.25.01.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 01:04:30 -0800 (PST)
Date:   Mon, 25 Nov 2019 10:04:28 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/sun4i: Fix Kconfig indentation
Message-ID: <20191125090428.GD29965@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20191121132924.29485-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121132924.29485-1-krzk@kernel.org>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:29:24PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Queued in drm-misc-next for 5.6, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/sun4i/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index 37e90e42943f..5755f0432e77 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -17,18 +17,18 @@ config DRM_SUN4I
>  if DRM_SUN4I
>  
>  config DRM_SUN4I_HDMI
> -       tristate "Allwinner A10 HDMI Controller Support"
> -       default DRM_SUN4I
> -       help
> +	tristate "Allwinner A10 HDMI Controller Support"
> +	default DRM_SUN4I
> +	help
>  	  Choose this option if you have an Allwinner SoC with an HDMI
>  	  controller.
>  
>  config DRM_SUN4I_HDMI_CEC
> -       bool "Allwinner A10 HDMI CEC Support"
> -       depends on DRM_SUN4I_HDMI
> -       select CEC_CORE
> -       select CEC_PIN
> -       help
> +	bool "Allwinner A10 HDMI CEC Support"
> +	depends on DRM_SUN4I_HDMI
> +	select CEC_CORE
> +	select CEC_PIN
> +	help
>  	  Choose this option if you have an Allwinner SoC with an HDMI
>  	  controller and want to use CEC.
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
