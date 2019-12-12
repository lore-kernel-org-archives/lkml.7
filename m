Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116A7C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6132073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O7qKrYCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfLLQNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:13:35 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60832 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfLLQNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9JV0lxxuv671N8NKDdLe7T2sZ0c3sP/gDG4QJmH6v6I=; b=O7qKrYCh4SxHNiVfo4LTPQ/DO
        U+hCmjmuk4IQ799vwQ5um1611eJpj4PQUb0cYEaKZ3rK4kc+wExWFpX3srZwyNIXinvP6MUDHjboi
        UK8o1uGU/IawIuph3RM1AW/yuZNyJgaLtI79uSPqOe2WyPGOR6JbXnMSuuFCTw1jgLmEWJJ8xYfB3
        WtQgpsG9evG8UM4mL1Zl5IdFe7K+o0h+AmcI9zk/lA1p1RQ8dP3MK0XWOF3K+fsP4Z7uCGyeKif6w
        y2yCqfK/88wBNjaoxW2R44hknsK857fuLorjm86sNhCDC6AWEulFIpsSytQR54FB2g0aBo/vZd4uL
        bOHnjSs4A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:40386)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ifR5f-0007lu-IU; Thu, 12 Dec 2019 16:13:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ifR5c-0006wl-IL; Thu, 12 Dec 2019 16:13:20 +0000
Date:   Thu, 12 Dec 2019 16:13:20 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
Message-ID: <20191212161320.GK25745@shell.armlinux.org.uk>
References: <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
 <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
 <20191212141747.GI25745@shell.armlinux.org.uk>
 <58c27422-e06c-f42e-16ea-baeca3bb9b01@free.fr>
 <20191212144616.GJ25745@shell.armlinux.org.uk>
 <d2595721-b5cb-d268-d6bd-bc794c07aacc@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2595721-b5cb-d268-d6bd-bc794c07aacc@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 04:51:25PM +0100, Marc Gonzalez wrote:
> On 12/12/2019 15:46, Russell King - ARM Linux admin wrote:
> 
> > However, please don't call this __clk_put().
> > git grep __clk_put will tell you why.  Thanks.
> 
> $ git grep __clk_put
> drivers/clk/clk-devres.c:static void __clk_put(struct device *dev, void *data)
> drivers/clk/clk-devres.c:               if (!devm_add(dev, __clk_put, &clk, sizeof(clk)))
> drivers/clk/clk.c:void __clk_put(struct clk *clk)
> drivers/clk/clk.h:void __clk_put(struct clk *clk);
> drivers/clk/clk.h:static inline void __clk_put(struct clk *clk) { }
> drivers/clk/clkdev.c:   __clk_put(clk);
> 
> I see. I will s/__clk_put/my_clk_put/ in my proposal.
> 
> Out of curiosity...
> 
> $ git grep __clk_put v2.6.29-rc1
> v2.6.29-rc1:arch/arm/common/clkdev.c:   __clk_put(clk);
> v2.6.29-rc1:arch/arm/mach-ep93xx/include/mach/clkdev.h:#define __clk_put(clk) do { } while (0)
> v2.6.29-rc1:arch/arm/mach-integrator/include/mach/clkdev.h:static inline void __clk_put(struct clk *clk)
> v2.6.29-rc1:arch/arm/mach-pxa/include/mach/clkdev.h:#define __clk_put(clk) do { } while (0)
> v2.6.29-rc1:arch/arm/mach-realview/include/mach/clkdev.h:#define __clk_put(clk) do { } while (0)
> v2.6.29-rc1:arch/arm/mach-versatile/include/mach/clkdev.h:#define __clk_put(clk) do { } while (0)
> 
> Genesis seems to be 0318e693d3a56
> 
> The clkdev API expected platforms to export a __clk_put method?

Along with __clk_get(), these were the interfaces from the cross-
platform clkdev code to the clk API implementation specific code.
__clk_get() no longer exists as its uses were eliminated, but
__clk_put() remains.

It's quite logical if you read the patch which your above commit ID
references.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
