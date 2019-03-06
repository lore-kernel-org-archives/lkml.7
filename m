Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62263C10F09
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3356D2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551841155;
	bh=osM66By3LY4Eke2CyQeQ2vwup2tO7woBRnpW5XQ+K/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=thkRfu8evGmXL9WCgXXuA+HlrrqMUg+ZBskDdruoxvYRgyiT8iG9eIoW8EjDcsTZm
	 yNHWTUpgJ3fp9XLyEl/9BZu82TXfF/01S+IaIfJKA7QDtZygrV97k3hEYdnFa2tTJh
	 ihrkyezNu1z+T8g2C2vMD+UN+ndLENAC4YfqebVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfCFC7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:59:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCFC7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:59:13 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0379220675;
        Wed,  6 Mar 2019 02:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551841152;
        bh=osM66By3LY4Eke2CyQeQ2vwup2tO7woBRnpW5XQ+K/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHW/YBNjUJHMy0n7XmcZ3BzmhBu00WykSe7gH6MTiJK8jjeL+QXK+MH6hNig5hr9j
         P2G8Yqn26KoBa0j6cgryJI0rAaMgEXzVRko+zP42MM8s9rjiqh/U/icEYFV5t5d9xk
         Io9v0MOMkkW7Zdl2+As8y8GvJolFz22oglqqXxbU=
Date:   Wed, 6 Mar 2019 10:58:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 05/15] ARM: imx51: fix a leaked reference by adding
 missing of_node_put
Message-ID: <20190306025803.GG26041@dragon>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <1551785646-46173-5-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551785646-46173-5-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 07:33:56PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-imx/mach-imx51.c:64:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 57, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v2->v1: add a missing space between "adding" and "missing"

I fixed it against v1 which I applied on my branch.

Shawn
