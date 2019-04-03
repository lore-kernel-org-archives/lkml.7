Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6AFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C45D2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554281636;
	bh=mLG0lFWWjuKHDuct7jHz9VAnVZUUC3f8aoUl7zoG47M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hZvlMplq+bdQAdpLD33izkAYsOYstVzIE+sk4yFk52sUaeumIfUpuuzPm26XxUN5y
	 LFI7jGLedrEw6WxRPFY113IOPSX6BF+LQErhLxw5Z/srEMQTVMDGSH4zaPrS1PPxUm
	 6e3bnwlNIsFLSgnsUGL2dt82jc7HpYy5XLF9WGo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDCIxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfDCIxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:53:54 -0400
Received: from X250 (unknown [147.50.13.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65562148E;
        Wed,  3 Apr 2019 08:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554281633;
        bh=mLG0lFWWjuKHDuct7jHz9VAnVZUUC3f8aoUl7zoG47M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alRQgUO8F0xOQ9JTu62Yy0H5gUxwcfM8eHM2KcNRMSCxtfo7j2oMyJ3PKEhS5BO/A
         M/JaebO8Y5dTSErLq0YTnR9cRnw7CYKTa1/zYM5D/5H8Byf058a1XjU9txQm1iLLYM
         Xk5eSIhZoKgE4qZSPEi/6OVqAlPGJp8gH7XG7LaI=
Date:   Wed, 3 Apr 2019 15:53:40 +0700
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V9 1/4] dt-bindings: watchdog: add i.MX system controller
 watchdog
Message-ID: <20190403085339.GA7932@X250>
References: <1553134884-1720-1-git-send-email-Anson.Huang@nxp.com>
 <1553134884-1720-2-git-send-email-Anson.Huang@nxp.com>
 <20190325203727.GA27661@bogus>
 <DB3PR0402MB39161467D49348DC550CA28AF55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39161467D49348DC550CA28AF55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 07:44:21AM +0000, Anson Huang wrote:
> Hi, Guenter/Shawn
> 	Since DT has been acked, would you pick up this patch series if no additional comments?
> 

Applied patch #3 and #4, thanks.
