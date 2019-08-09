Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D974C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6652184E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565342231;
	bh=iCwSBaFSrhA+3xI7pt6j7vr1dV0x/b9m0YaE7bBEmiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SISHcT6aysacB8OBAw2JbVrZ/V3yELY5WNKK8rqcfVwOQxbCJzzaTxTShWcpUN2ff
	 BtsN7a/q0TFh1NQqo878BDjCiE9uJu7Jzsgnnoyu4OfRCO3hGtLgjdkmV+3dHZK6Nr
	 mXh9P7EAAB36nVhMCDQjfJyNli7Hd/pBOPzdm61w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406124AbfHIJRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfHIJRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:17:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F9921743;
        Fri,  9 Aug 2019 09:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565342228;
        bh=iCwSBaFSrhA+3xI7pt6j7vr1dV0x/b9m0YaE7bBEmiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3aMkzQZyHXmK3y7x0EgKM/jLva+WnTVoJtAno+shZMBuATwEVyz5Ghwx6KVNHyRB
         kxKiAyDuDDdfgyIDHU26X/seVyS3NoMtcGVY9npfINnxLttPzH5ap9DhcYhBku+BhB
         U6KfwoNEmivrp0BMjMUrMatHUECod1tOWkkVeHJA=
Date:   Fri, 9 Aug 2019 07:38:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/22] usb: omap: avoid mach/*.h headers
Message-ID: <20190809053813.GA29036@kroah.com>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-11-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808212234.2213262-11-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:22:19PM +0200, Arnd Bergmann wrote:
> The omap usb drivers still rely on mach/*.h headers that
> are explicitly or implicitly included, but all the required
> definitions are now in include/linux/soc/ti/, so use those
> instead and allow compile-testing on other architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/gadget/udc/Kconfig     | 2 +-
>  drivers/usb/gadget/udc/omap_udc.c  | 2 ++
>  drivers/usb/host/Kconfig           | 2 +-
>  drivers/usb/host/ohci-omap.c       | 7 +++----
>  drivers/usb/phy/Kconfig            | 3 ++-
>  drivers/usb/phy/phy-isp1301-omap.c | 4 ++--
>  6 files changed, 11 insertions(+), 9 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
