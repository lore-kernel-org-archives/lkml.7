Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A50C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43B520828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ju+ibQGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfH0JNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:13:51 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36048 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0JNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4FZW6WpHVkghAQyfLmfyvtAtB0km+7CvKkK8paBRUnQ=; b=ju+ibQGosYVXbnQwwniWtU4Yp
        0aVH7H+p9liw4K108OWpO6QcPYzxpix3Hcf1wcqaXgCte5xhe6jgLLmOUBVMdh/dHK/OTIZNvpZ09
        H3KRlVUGA7QW1PLEXlY4l1FzF2dOpviRC4bODDpzzyJd+9BHkDsZERAAJ3fEs36lwX8TSZFMjDv7w
        HEVRVzUVsoOWMuKspApzHVghJVBdbP4Ywsp8l8hLpRs9LQ6GkwTUt7gLRxXhEMDEiyoAPhlOjiuDg
        vDqCLSvIyKIhQyvs4V8++WVrPAYzwZUwCrI1Mu0LQ6+rwcA2nEGG4ssqk2wCh/BwJrH1YI4diQXid
        HSbh4dMuA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55136)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i2XXq-0003S4-CF; Tue, 27 Aug 2019 10:13:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i2XXk-0005dX-F0; Tue, 27 Aug 2019 10:13:36 +0100
Date:   Tue, 27 Aug 2019 10:13:36 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "gregory.clement@free-electrons.com" 
        <gregory.clement@free-electrons.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "patches@armlinux.org.uk" <patches@armlinux.org.uk>
Subject: Re: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Message-ID: <20190827091336.GI13294@shell.armlinux.org.uk>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
 <20190712034904.5747-2-chris.packham@alliedtelesis.co.nz>
 <20190823104621.GY13294@shell.armlinux.org.uk>
 <20190823105020.GZ13294@shell.armlinux.org.uk>
 <836653f04f526333e8dbd45361329731f8dfe2ea.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <836653f04f526333e8dbd45361329731f8dfe2ea.camel@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 12:46:44AM +0000, Chris Packham wrote:
> Hi Russell,
> 
> On Fri, 2019-08-23 at 11:50 +0100, Russell King - ARM Linux admin
> wrote:
> > On Fri, Aug 23, 2019 at 11:46:21AM +0100, Russell King - ARM Linux
> > admin wrote:
> > > I can't apply this series - this file does not exist in my tree,
> > > and
> > > from what git tells me, it never has existed.  Maybe it's in
> > > someone
> > > elses tree?
> > 
> > I think the file is in my tree, just as arch/arm/mm/cache-aurora-l2.h
> > which is where it has been since it was originally submitted in 2012.
> 
> Sorry there is a missing patch that moves it next to the
> hardware/cache-*.h. I can send the missing patch or I can re-send the
> whole series. If I do send the whole series do you want me to rebase it
> against a particular tag/tree?

Just send the single patch to the patch tracker - having it against
5.3-rc is fine (I don't think anything has changed for a long time
with that file.)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
