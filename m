Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2B8C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD80207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HTROZ17Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfKYNiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:38:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35336 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKYNiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1oPwCncRA2y31PmdF7i8SD1A/QIZHpVvVM+tOv4nEWY=; b=HTROZ17YQfnk9a3KpJMqKCAhj
        VGwuTT5RUc8NphiI7dy/pQPJUnloOvVbC0qwZGfJi/TLIwiW0JdhYf/iRXS7wG8+Vke9nTs5Lc+cf
        ij6xzfuNNBUpwH64lffDsUM84vlNw2+yqFXKu5idoDbAyb56mvddL/TpeQJpc+M6J4kB3MzscxlB8
        OsVK6aBxDRnbtOjDKu3et7x84STnjbV0LQNxgFiMAhDp6PnvO3YjUFz/gFUp0BHeuk+9eKcHfVvOl
        AVPpvXlz1rx3Ja5V/lmeX8JigyvOYzNCwvkDKXb2QWYe+iTdLaerME3sspRKRiy/1wBfPAQzSfohp
        h3qiwfOgw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:32788)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iZEZ5-0007zq-MC; Mon, 25 Nov 2019 13:38:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iZEZ5-0006iB-3V; Mon, 25 Nov 2019 13:38:07 +0000
Date:   Mon, 25 Nov 2019 13:38:07 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
Message-ID: <20191125133806.GT25745@shell.armlinux.org.uk>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
 <34e32662-c909-9eb3-e561-3274ad0bf3cc@free.fr>
 <20191125125231.GO25745@shell.armlinux.org.uk>
 <45730e3c-efc7-4433-4980-e6aefebdcbff@free.fr>
 <20191125133103.GR25745@shell.armlinux.org.uk>
 <7373182d-753c-a87b-8408-ffe4b7ac341f@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7373182d-753c-a87b-8408-ffe4b7ac341f@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 02:34:35PM +0100, Marc Gonzalez wrote:
> On 25/11/2019 14:31, Russell King - ARM Linux admin wrote:
> 
> > The clk API and CCF are two different things.  I look after the clk API.
> > The CCF is an implementation of the clk API.  Do not introduce clk API
> > code in files that are CCF specific.
> 
> CCF is the acronym for Common Clock Framework?

Yes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
