Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719D9C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7AD20815
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ADcl5dL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKYJEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:04:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40936 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:04:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id 4so13625044wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TvuH8l9EzqCh6w89WPpuHfczuxrSA4KxqFlFxqfV2Vg=;
        b=ADcl5dL63j8YxIKYJXlZwaPs0RKp9DO7wjV/o2NWZjYmbsCU9i+r7F/I57mHpBrjRW
         KLsRMDFkbdMlWHf2lMPDOls3hQTT4Fop28L9O3CNZpULMsFOHN9r+NEMSl8S+kgI8JxO
         y54KSGHAM/fM5USepihb7iRhIHMaANxba3cTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TvuH8l9EzqCh6w89WPpuHfczuxrSA4KxqFlFxqfV2Vg=;
        b=kbCSeUy1Gv/sXGxtgotyYqMBckRtNkalym/yudOTlmA8tb1K6fNamw/0jAZhk445QI
         aHiLjR3U/9B5djsYvtIWfo/8YgS9AY/HdpAy9BD9YdvRYPRdkUsE0rGc1uVRRTkwZ6x8
         1V2rFq19u1KUO/f2c6YRKl/YkeUppOwiHmNvj8f4nlVOnNs82QuCB1LWtRkp2k+61zur
         XjHbwANAiHwIS5e7fG5d0HZNhXB5bKQAgaamAsyObL8iDJ9zyYbJr5Eo1Z2bQhLc2qaI
         ZukUXymshBWKT8DEz0n7U3hW1w0bjfb4jM74nnQvMJFBw/boqbTY6UWrSildrAVCxyHS
         5BHg==
X-Gm-Message-State: APjAAAUZ17HOvU6+rz6M8x+qqvIb8Z5Aul8Fj7KZJwiRxBlZA9rGYN2I
        n0WWXgdV98QIIm7ZV7LHN7c2M3yqO6U=
X-Google-Smtp-Source: APXvYqwsTKxRds7w/Vwas8Sm4n8Ch850R9kaOYWXGPAfYeWytHb2qi4KaE5RZDdYutqWLL8tmS0xpQ==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr27703663wrw.208.1574672651417;
        Mon, 25 Nov 2019 01:04:11 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id g8sm7676020wmk.23.2019.11.25.01.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 01:04:10 -0800 (PST)
Date:   Mon, 25 Nov 2019 10:04:09 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vc4: Fix Kconfig indentation
Message-ID: <20191125090409.GC29965@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20191121132919.29430-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121132919.29430-1-krzk@kernel.org>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:29:19PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Queued in drm-misc-next for 5.6, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/vc4/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
> index 7c2317efd5b7..118e8a426b1a 100644
> --- a/drivers/gpu/drm/vc4/Kconfig
> +++ b/drivers/gpu/drm/vc4/Kconfig
> @@ -22,9 +22,9 @@ config DRM_VC4
>  	  our display setup.
>  
>  config DRM_VC4_HDMI_CEC
> -       bool "Broadcom VC4 HDMI CEC Support"
> -       depends on DRM_VC4
> -       select CEC_CORE
> -       help
> +	bool "Broadcom VC4 HDMI CEC Support"
> +	depends on DRM_VC4
> +	select CEC_CORE
> +	help
>  	  Choose this option if you have a Broadcom VC4 GPU
>  	  and want to use CEC.
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
