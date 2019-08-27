Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90248C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E092186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eD60P4gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfH0VHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:07:23 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44996 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfH0VHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4hoDFeBBZSTSJHVR0wNL11+v5DVaTl/jtF0wjfl4NCU=; b=eD60P4gLOy3/3eTm9dcokjeoY
        bq4UILtFjH6ADIwUW8ytqD8EOyeEisr+itgK6jpSf9rWltAtUR3J5kaJu+7IBSuCzTD0Yu2lUpFDo
        +tR549c5HiuH7QG7w82gOWwgYk/BSsS/vNrhvpvtY9CDGn4Eu7W3CUBcC5xLLjnnak8XpLoU0Sz6P
        Z53zHAQ4qQ0wRJ1wqxPfBNfHKpO9oQVa/3RSk2sH38cRX59ajsRr+zRmb0K9ibC521V2rgHbZNB3U
        RXvpl0WbTOWZQzU7SaPJSQALvmr+LZ6vByrQCzeYdzaEDAo9jxq5/+SdxIUeWqCG4WRRhJ3pfNKaz
        pEj5rDhRQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55350)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i2igQ-0006kX-Q5; Tue, 27 Aug 2019 22:07:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i2igL-00062p-Mt; Tue, 27 Aug 2019 22:07:13 +0100
Date:   Tue, 27 Aug 2019 22:07:13 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregory.clement@free-electrons.com" 
        <gregory.clement@free-electrons.com>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "patches@armlinux.org.uk" <patches@armlinux.org.uk>
Subject: Re: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Message-ID: <20190827210713.GO13294@shell.armlinux.org.uk>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
 <20190712034904.5747-2-chris.packham@alliedtelesis.co.nz>
 <20190823104621.GY13294@shell.armlinux.org.uk>
 <20190823105020.GZ13294@shell.armlinux.org.uk>
 <836653f04f526333e8dbd45361329731f8dfe2ea.camel@alliedtelesis.co.nz>
 <20190827091336.GI13294@shell.armlinux.org.uk>
 <b1e2e5b325b3c4453e2ed63c17e1e11d6b24f099.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e2e5b325b3c4453e2ed63c17e1e11d6b24f099.camel@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 08:56:05PM +0000, Chris Packham wrote:
> On Tue, 2019-08-27 at 10:13 +0100, Russell King - ARM Linux admin
> wrote:
> > Just send the single patch to the patch tracker - having it against
> > 5.3-rc is fine (I don't think anything has changed for a long time
> > with that file.)
> 
> Done 
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8902/1
> 
> I'm still not entirely sure what to put for the KernelVersion tag. In
> hindsight think I misinterpreted your comment above and set it to 5.3rc
> (where you meant a series based on 5.3-rcX should apply cleanly). It
> probably should have been next or master because it's way past the
> merge window for 5.3.

Think about it as "which kernel version was _this_ patch generated
against" - it's a guide for me to know which kernel version it
should be applied to.  The nearest Linus release (rc or final) is
generally sufficient.

If it doesn't apply to my current base, then I might check out that
version, apply it there, and then merge it in, resolving any
conflicts during the merge.

It started off with a different purpose: when we had the older
development system, such as the 2.x series kernels, we would have
even x being the current stable kernels, and concurrently we'd
also have x+1 as the development series.  When someone sent me a
patch back then, it was important to know which kernel series it
was meant for.

I decided not to get rid of it because it provides useful
information when patches don't apply, and gives more options
than me just discarding the patch with a comment saying it
doesn't apply.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
