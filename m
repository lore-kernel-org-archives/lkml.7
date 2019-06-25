Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB70C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6739B2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfFYNi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:38:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbfFYNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:38:57 -0400
Received: from arch-x1c3 (unknown [IPv6:2a00:5f00:102:0:9665:9cff:feee:aa4d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: evelikov)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 706A9260D5B;
        Tue, 25 Jun 2019 14:38:56 +0100 (BST)
Date:   Tue, 25 Jun 2019 14:36:39 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org,
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
Message-ID: <20190625133639.GA16031@arch-x1c3>
References: <cover.1561452052.git.andrzej.p@collabora.com>
 <20190625100351.52ddptvb2gizaepi@shell.armlinux.org.uk>
 <817ccfba-754c-6a28-8d75-63f70605fd43@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <817ccfba-754c-6a28-8d75-63f70605fd43@collabora.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/25, Andrzej Pietrasiewicz wrote:
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
> 
Fwiw my Intel machine lists a number of i2c devices:
/sys/class/drm/card0-DP-1/i2c-6
/sys/class/drm/card0-DP-2/i2c-7
/sys/class/drm/card0-eDP-1/i2c-5

Note: I haven't looked _if_ they relate to ones you're proposing here.

One thing worth mentioning is, the ones I've seen are not symlinks to
another sysfs entries. And there aren't any i2c nodes in /dev ...

Just a random food for thought :-)

HTH
Emil




