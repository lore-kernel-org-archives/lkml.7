Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09BDC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6454621019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551677911;
	bh=g7AHdyOzT/zu/ZiJT1tf4ulU/osU03BVGW6r8HW1WMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CaO3pZXdQoVdQrqG+8h9lXQLKc+rBkwOzImBqGnAF+9bs7RfxAor2S4PXMDEq5u15
	 zCtu1DcnlBTVkXN5Kq7zCIyHcZBj2dXIyIffcvP8e8a9bRUoJa0x6vTfUf9iOJZ9Hf
	 EVs78wiSh0rjBMmUXHj4ZJqJ6xVqe8DihiKP10u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfCDFi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfCDFi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:38:29 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7747620815;
        Mon,  4 Mar 2019 05:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551677908;
        bh=g7AHdyOzT/zu/ZiJT1tf4ulU/osU03BVGW6r8HW1WMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHq1wItZ2IcNUbI2+Dn4y51A2o+v5TX84QIIskJyEnT/EWfRNd4KLq7LI4TcVtDWI
         IsBAr0tJbLL7rb14rPi2pO6RgaznJpRt5qBaFX3makMfC09M8een7JdjM1ZIj8K2n5
         2hv873k7oaLKvUfjhF1cRFQYINuVJgUqoKWKsRdk=
Date:   Mon, 4 Mar 2019 13:37:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kgene@kernel.org, krzk@kernel.org,
        linux-samsung-soc@vger.kernel.org, michal.simek@xilinx.com,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        dinguyen@kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linus.walleij@linaro.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        openbmc@lists.ozlabs.org, xuwei5@hisilicon.com,
        maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, horms@verge.net.au, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        wang.yi59@zte.com.cn, Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 05/15] ARM: imx51: fix a leaked reference by
 addingmissing of_node_put
Message-ID: <20190304053714.GZ26041@dragon>
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
 <1551430616-42014-5-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551430616-42014-5-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:56:46PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-imx/mach-imx51.c:64:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 57, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>

Applied, thanks.
