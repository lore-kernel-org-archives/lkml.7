Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F00C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4A8208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ly5b2GEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfFYOKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:10:45 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53596 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFYOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5Xb6HOTG+zlag07avcaujeaLqr4XUzU2qm2bd4UiBIg=; b=ly5b2GEF7t8Xid2fwh5tWxjGk
        1OQja7i/iAxqb5Jch4kWE8/ZkrF+DAJTn+Ggt4YEXMH/7CCxwQpHda7CxEd66NnhWlxzjb0GlOBjH
        DUiFvXDZ42Afh1aFUZ08a7mE4pj1q+LubbfcRpx5Y8yhGAyBUu7jcfm3BkOhWaFHBnjUjgHmlNSQ2
        hfwpr9Hkqswc4UswMJfggxQcwLgzkaXYDAdb+enl1jqT/YDeZB1n4e/G0D6k/XIYDhzrXAvmUXWwQ
        +PjW+sQcMipB2X7tQhitGUFkpttqA9qORJ+qbDyLT4isccDyzr9k9nn/t2M4NMRHba4BPmkrckj//
        bGzf7VnUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59992)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hfm9e-00070m-UI; Tue, 25 Jun 2019 15:10:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hfm9Y-0007I8-NO; Tue, 25 Jun 2019 15:10:32 +0100
Date:   Tue, 25 Jun 2019 15:10:32 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Emil Velikov <emil.velikov@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Inki Dae <inki.dae@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        kernel@collabora.com, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
Subject: Re: [PATCH 0/2] Associate ddc adapters with connectors
Message-ID: <20190625141032.5jiy2oekb3olaejd@shell.armlinux.org.uk>
References: <cover.1561452052.git.andrzej.p@collabora.com>
 <20190625100351.52ddptvb2gizaepi@shell.armlinux.org.uk>
 <817ccfba-754c-6a28-8d75-63f70605fd43@collabora.com>
 <20190625133639.GA16031@arch-x1c3>
 <20190625140755.GT12905@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625140755.GT12905@phenom.ffwll.local>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 04:07:55PM +0200, Daniel Vetter wrote:
> Otherwise I like this. Biggest problem I'm seeing here is rolling this out
> everywhere, this is a lot of work. And without widespread adoptions it's
> not terribly useful for userspace.

There will be cases where it's not possible, because the I2C bus is
hidden behind a chip that doesn't give you direct access to the DDC
bus.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
