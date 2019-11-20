Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC61D20878
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gH/voLgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfKTQfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:35:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54994 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfKTQfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:35:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id z26so258954wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4fUPFIHSdVdO2uzRzyZ9JTr48DiWdw9H1oGUMfBPlq8=;
        b=gH/voLgqjfiTk2viiTaiNAjT1Ol4SHo9Jnz2I2LuyQqAiTMzaJcB0CncoVMdVYXwbz
         wjKhv0+TdFvu/Rx3liHLQ1aELDti2HmnkrQ1XU1kR0WSLbMUWOLoQDOFg8xNxMA3YfyF
         2goF2o0ukq8/MtqsPm3rxOMSkNNyoxIpiVWiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=4fUPFIHSdVdO2uzRzyZ9JTr48DiWdw9H1oGUMfBPlq8=;
        b=SCuzTtNBUDjpFMuMlhEGTOIuYJUZjAomXXv4z0mympIrbkVSuJdZupmHmYHWQnqdXP
         60MWdt1xd+Ldi/06R94b942NslUQnFLZaBWEJgK3qy8VTQFjB+EesHoY+oUuz3jr5HM8
         khrUtzOaEPwj1bsJKpn4FjgD0gS7heSbbQeT6wHK9gCJmB3SpaZ0MkKLdQs0tcMrbPF/
         QGnSmykw4izj66b4QDsECVbM9vaBBalwDfGK4FQ3he5I57uGMV9O7CHKv4TeBdmU5n2g
         h9YlQuwrX92KbxY4SWkeKwrDXNEJi9GWe7XZVqC8e4F3QZXPPNtDE67vSQK5cy33egkt
         Xl4w==
X-Gm-Message-State: APjAAAXK7kXrPCD2zSWMpv126IsQPRp0A98LPm8HcdF9vbegpO0ML/WZ
        PJhLr6jXF0Ay2xu7GZLbRv8HyGeZpT4=
X-Google-Smtp-Source: APXvYqw9vT20MMT3HUF7KxV6D/s8Y8R+aQrytDgCSBT5FL/Oh1YNqHNOkq72AWFQBYVLeAyoflJbBQ==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr4288117wmj.159.1574267749238;
        Wed, 20 Nov 2019 08:35:49 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id l4sm6956811wme.4.2019.11.20.08.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:35:48 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:35:46 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] vga: Fix Kconfig indentation
Message-ID: <20191120163546.GL30416@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20191120133327.6519-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133327.6519-1-krzk@kernel.org>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:33:27PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Queued for 5.6 in drm-misc, thanks for your patch.
-Daniel
> ---
>  drivers/gpu/vga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
> index c8c770b05ed9..1ad4c4ef0b5e 100644
> --- a/drivers/gpu/vga/Kconfig
> +++ b/drivers/gpu/vga/Kconfig
> @@ -28,6 +28,6 @@ config VGA_SWITCHEROO
>  	help
>  	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
>  	  to switch between them. This adds support for dynamic switching when
> -          X isn't running and delayed switching until the next logoff. This
> +	  X isn't running and delayed switching until the next logoff. This
>  	  feature is called hybrid graphics, ATI PowerXpress, and Nvidia
>  	  HybridPower.
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
