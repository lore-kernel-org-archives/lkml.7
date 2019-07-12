Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DDC742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2BC2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Eyr0dtWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGLK5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:57:54 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50878 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfGLK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u9dynlJ3OM9MALiJSBcSG7FKkftfyq54pHYRnzPQTFA=; b=Eyr0dtWhsmlK2Q6BhgmXpUOL/
        qymgs31El0emqh8IFE4WI3vF53WCcBAaX6vLcGPJDEh30I33KI7G6wSoN0u+M/D/BCSA1udbJvErH
        nIDPBlSdgUpnsnRPshqdgvBlwZh+rqeIGCWGpUc+DhpBYN0jaKp9LJpI4PlEv5yRZ/CSfY7Z8HyYq
        tBBBAz5DaPhve6iZyWd/UAkz7y6uKCCXVnCCXr3uYXQZrhzPLLkpOn95j/IOhrviJVxEXV07j5CsA
        RFU80czsdSVH3CRpvfIGSrY4m2mqkYq99uWagRqbIE8jqCXlSABqwIIgCGdgiZ7x8M2xRsZ2I9Q0c
        8ZwvU8lPQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59462)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hltFN-0001Mc-4Y; Fri, 12 Jul 2019 11:57:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hltFJ-0005c2-Nx; Fri, 12 Jul 2019 11:57:45 +0100
Date:   Fri, 12 Jul 2019 11:57:45 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        dianders@chromium.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, tzungbi@chromium.org,
        Jaroslav Kysela <perex@perex.cz>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>, dgreid@chromium.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/5] ASoC: hdmi-codec: Add an op to set callback
 function for plug event
Message-ID: <20190712105745.xr7jxc626lwoaajx@shell.armlinux.org.uk>
References: <20190712100443.221322-1-cychiang@chromium.org>
 <20190712100443.221322-2-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712100443.221322-2-cychiang@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 06:04:39PM +0800, Cheng-Yi Chiang wrote:
> Add an op in hdmi_codec_ops so codec driver can register callback
> function to handle plug event.
> 
> Driver in DRM can use this callback function to report connector status.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  include/sound/hdmi-codec.h    | 16 +++++++++++++
>  sound/soc/codecs/hdmi-codec.c | 45 +++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 7fea496f1f34..9a8661680256 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -47,6 +47,9 @@ struct hdmi_codec_params {
>  	int channels;
>  };
>  
> +typedef void (*hdmi_codec_plugged_cb)(struct device *dev,
> +				      bool plugged);
> +

I'd like to pose a question for people to think about.

Firstly, typedefs are generally shunned in the kernel.  However, for
these cases it seems to make sense.

However, should the "pointer"-ness be part of the typedef or not?  To
see what I mean, consider:

	typedef void (*hdmi_foo)(void);

	int register_foo(hdmi_foo foo);

vs

	typedef void hdmi_foo(void);

	int register_foo(hdmi_foo *foo);

which is more in keeping with how we code non-typedef'd code - it's
obvious that foo is a pointer while reading the code.

It seems to me that the latter better matches what is in the kernel's
coding style, which states:

  In general, a pointer, or a struct that has elements that can
  reasonably be directly accessed should **never** be a typedef.

or maybe Documentation/process/coding-style.rst needs updating?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
