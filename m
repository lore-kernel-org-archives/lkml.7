Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBDBC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5699215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oq9m6q3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfFYKED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:04:03 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49824 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFYKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4yfZs4/ThCrYgiLeGh1TAYd7N0nWcLtcO65UGF7jKL8=; b=oq9m6q3Kox2FooWO0Am5oLHJe
        PMDVQvjbOGmV6+EYXqlzy8VtHHsxUohQbJxIq+DHgSBclpN7gExON5bgBKujZ0sI7rvjDkU3UY887
        OZDcLMu3WE6t4afKI08sesNCKe0LUFC6/t47IwTf/2iuKdIKA9jsDU3wcomZnjvha2ol8p+haHlU7
        /dT8CmadCWsevk94t4cKTN5Zr1GANzIWDzJ97URuA3SdVn8l4nBr+SNmDzMByaxdVJ4dFbxrwOyek
        WojKMosB8ZZmGVBTZPB9jxzmH0f4OtSpeFO44AohUYXHvUsxQC5adtmJbSPGXnZ2eKLbzdwb0Vflr
        Oo6B1aEiA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:58978)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hfiIw-0005g7-K5; Tue, 25 Jun 2019 11:03:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hfiIq-00077V-3W; Tue, 25 Jun 2019 11:03:52 +0100
Date:   Tue, 25 Jun 2019 11:03:52 +0100
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
Message-ID: <20190625100351.52ddptvb2gizaepi@shell.armlinux.org.uk>
References: <cover.1561452052.git.andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561452052.git.andrzej.p@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:46:34AM +0200, Andrzej Pietrasiewicz wrote:
> It is difficult for a user to know which of the i2c adapters is for which
> drm connector. This series addresses this problem.
> 
> The idea is to have a symbolic link in connector's sysfs directory, e.g.:
> 
> ls -l /sys/class/drm/card0-HDMI-A-1/i2c-2
> lrwxrwxrwx 1 root root 0 Jun 24 10:42 /sys/class/drm/card0-HDMI-A-1/i2c-2 \
> 	-> ../../../../soc/13880000.i2c/i2c-2

Don't you want the symlink name to be "i2c" or something fixed, rather
than the name of the i2c adapter?  Otherwise, you seem to be encumbering
userspace with searching the directory to try and find the symlink.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
