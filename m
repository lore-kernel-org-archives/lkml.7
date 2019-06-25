Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0540FC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C960B20644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OZ27eyAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfFYKRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:17:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50018 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFYKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LzpNVlJKLYzDBWmjft6hb5Lt+w3/1+2+74j5WYoUB5s=; b=OZ27eyAkJKiN5LjA4Mdnw/TaE
        0OSrfP1o5lxTgZZdykcVUq8nEnHcHsj/WlBBnLQKHmGkhu6q0jBVBjFFfAkUboDzBgBa0GAuux22m
        cMlmi8YLB7JVvil+PyiKYH4fiL2FVmMJ1GcPdNAZz1xP9i/ZoUtm6r7/18V2weMVRoaw0eXQgjV4/
        5xsYmluSNKbWCGk1wQpKqwKIi1NTjuJmAwMTonHsoLWk1rWe89Z8IvXSgHlynSHKbs4203ft0h7rv
        DD77iMGbUVY505jGcN1UFV0Ba9p3j6H7WLeR73xcWqtu8kG2mUrSFnq0ctSpcPpbvDAddzgFDvVHF
        uyCJ2qYLg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:58980)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hfiVX-0005kN-9C; Tue, 25 Jun 2019 11:16:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hfiVT-00078Y-Io; Tue, 25 Jun 2019 11:16:55 +0100
Date:   Tue, 25 Jun 2019 11:16:55 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [PATCH 0/2] Associate ddc adapters with connectors
Message-ID: <20190625101655.n246vbwtupb4eoyz@shell.armlinux.org.uk>
References: <cover.1561452052.git.andrzej.p@collabora.com>
 <20190625100351.52ddptvb2gizaepi@shell.armlinux.org.uk>
 <817ccfba-754c-6a28-8d75-63f70605fd43@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <817ccfba-754c-6a28-8d75-63f70605fd43@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:14:27PM +0200, Andrzej Pietrasiewicz wrote:
> Hi Russell,
> 
> W dniu 25.06.2019 o 12:03, Russell King - ARM Linux admin pisze:
> > On Tue, Jun 25, 2019 at 11:46:34AM +0200, Andrzej Pietrasiewicz wrote:
> > > It is difficult for a user to know which of the i2c adapters is for which
> > > drm connector. This series addresses this problem.
> > > 
> > > The idea is to have a symbolic link in connector's sysfs directory, e.g.:
> > > 
> > > ls -l /sys/class/drm/card0-HDMI-A-1/i2c-2
> > > lrwxrwxrwx 1 root root 0 Jun 24 10:42 /sys/class/drm/card0-HDMI-A-1/i2c-2 \
> > > 	-> ../../../../soc/13880000.i2c/i2c-2
> > 
> > Don't you want the symlink name to be "i2c" or something fixed, rather
> > than the name of the i2c adapter?  Otherwise, you seem to be encumbering
> > userspace with searching the directory to try and find the symlink.
> > 
> 
> Thank you for your comment. So you imagine something on the lines of:
> 
> lrwxrwxrwx 1 root root 0 Jun 24 10:42 /sys/class/drm/card0-HDMI-A-1/ddc \
>  	-> ../../../../soc/13880000.i2c/i2c-2
> 
> ?

Exactly.

> This makes sense to me, I will send a v2.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
