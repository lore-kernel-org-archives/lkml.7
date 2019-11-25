Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477CCC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C22D207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fiQ9YBB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfKYNh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:37:59 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35322 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKYNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iVO+CFyKdAbmAXju99HzrtWINdnWqXd4ouQqZQnSQvc=; b=fiQ9YBB/hSo8uJJBQ0xbyC0SJ
        4SjorX4fJ+YbzhLDrCpbu8fQMbxPc7P8HJ855cFcnJeJG4mRyHha8NFB2UO6WROLIvmdBIkKAcVm0
        ml0JebgN+rS+UqdjhIJGYIFh+1uAJnIO1HBusMt0+B8TJuvE0ZkhHcSxYzkkWp344lAsF/1gnHTGD
        Al26t+QS3P2wMVJZ7kJqIhnVtOdX9W0glwxpkIOXI32qaBZLFgMFZAJz1CxS4uSm91EiGz4+pgYFx
        69buvLxxLLtdrTeAVYEP06S3dBOO04wzNcO+aQMoboi7JpCn+DaXPWC5PQKzurNT1UM7aohsSrbZi
        Pf6nPTUvQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:32786)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iZEYr-0007zV-2p; Mon, 25 Nov 2019 13:37:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iZEYq-0006i3-72; Mon, 25 Nov 2019 13:37:52 +0000
Date:   Mon, 25 Nov 2019 13:37:52 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
Message-ID: <20191125133752.GS25745@shell.armlinux.org.uk>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
 <34e32662-c909-9eb3-e561-3274ad0bf3cc@free.fr>
 <20191125125530.GP25745@shell.armlinux.org.uk>
 <c7414301-da0d-cd4d-237d-34277f5ee1d2@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7414301-da0d-cd4d-237d-34277f5ee1d2@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 02:10:21PM +0100, Marc Gonzalez wrote:
> On 25/11/2019 13:55, Russell King - ARM Linux admin wrote:
> 
> > It's also worth reading https://lore.kernel.org/patchwork/patch/755667/
> > and considering whether you really are using the clk_prepare() and
> > clk_enable() APIs correctly.  Wanting these devm functions suggests
> > you aren't...
> 
> In that older thread, you wrote:
> 
> > If you take the view that trying to keep clocks disabled is a good way
> > to save power, then you'd have the clk_prepare() or maybe
> > clk_prepare_enable() in your run-time PM resume handler, or maybe even
> > deeper in the driver... the original design goal of the clk API was to
> > allow power saving and clock control.
> > 
> > With that in mind, getting and enabling the clock together in the
> > probe function didn't make sense.
> > 
> > I feel that aspect has been somewhat lost, and people now regard much
> > of the clk API as a bit of a probe-time nuisance.
> 
> In the few drivers I've written, I call clk_prepare_enable() at probe.

Right, so the clocks are enabled as soon as the device is probed,
in other words at boot time. It remains enabled for as long as the
device is bound to its driver, whether or not the device is actually
being used. Every switching edge causes heat to be generated. Every
switching edge causes energy to be wasted.

That's fine if you have an infinite energy supply. That hasn't been
discovered yet.

Given the prevalence of technology, don't you think we should be
doing as much as we possibly can to reduce the energy consumption
of the devices we use? It may be peanuts per device, but at scale
it all adds up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
