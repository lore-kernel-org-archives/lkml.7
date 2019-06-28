Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ABCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9428208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vny6Hmz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfF1Msn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:48:43 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46832 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1Msn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FmEpqg75x9unomlBsmRDCIgN/BXip3W5+lKSjz4bVP4=; b=vny6Hmz++O86J7C/jOObNx8wv
        gT8hGXMkuDdfOhOxiQq+6p5nb2tr+8x3N+IfnhHkl+G8cmU9Oc00lLtxYe5hW6gfnMr5joV+ld0ui
        HHLz/FZN8TS3ZiJt4VIZfotY/RKDdvxtVW9Rn1Q07bKsyO1LoI3udIcViapcoNXL5oWnepVE0HdGr
        +IRMb3d3hDwKokzPYyahmHJPZuqWAzQXeB0awpFb7+2ne33dEH0CDNohugDnFX9ERMX4bDRZoQ2Qb
        e3ncggQxDTkCgmfd1VHTELBJKWkV0I82iPmgj3hGM4Fq4Sc67EoMNu1wKqfhcM/maFKfrLbTAbPjr
        M9O9U6OdA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59200)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hgqIu-0000oG-LM; Fri, 28 Jun 2019 13:48:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hgqIq-0001WC-7c; Fri, 28 Jun 2019 13:48:32 +0100
Date:   Fri, 28 Jun 2019 13:48:32 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/armada: fix debugfs link error
Message-ID: <20190628124832.cedpoabfiqgjhtkq@shell.armlinux.org.uk>
References: <20190628103359.2516007-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628103359.2516007-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 12:33:40PM +0200, Arnd Bergmann wrote:
> Debugfs can be disabled at compile time, causing a link error
> with the newly restructured code:
> 
> drivers/gpu/drm/armada/armada_crtc.o: In function `armada_drm_crtc_late_register':
> armada_crtc.c:(.text+0x974): undefined reference to `armada_drm_crtc_debugfs_init'
> 
> Make the code into the debugfs init function conditional.

Thanks Arnd, mind if I roll this into the original commit?

> Fixes: 05ec8bd524ba ("drm/armada: redo CRTC debugfs files")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/armada/armada_crtc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
> index e3a5964d8a65..03d3fd00fe00 100644
> --- a/drivers/gpu/drm/armada/armada_crtc.c
> +++ b/drivers/gpu/drm/armada/armada_crtc.c
> @@ -773,7 +773,9 @@ static void armada_drm_crtc_destroy(struct drm_crtc *crtc)
>  
>  static int armada_drm_crtc_late_register(struct drm_crtc *crtc)
>  {
> -	armada_drm_crtc_debugfs_init(drm_to_armada_crtc(crtc));
> +	if (IS_ENABLED(CONFIG_DEBUG_FS))
> +		armada_drm_crtc_debugfs_init(drm_to_armada_crtc(crtc));
> +
>  	return 0;
>  }
>  
> -- 
> 2.20.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
