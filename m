Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BEDC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 14:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD6B2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 14:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hAvg9nPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfJLOvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 10:51:10 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49694 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfJLOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 10:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i7ymtaLygujOhFiwo49zTSZEZCPO8tXMCxgm0pezR2s=; b=hAvg9nPu2TVljuKMUkImPU848
        LYXKSc76ODWTf61OC3gEkLC78aatum3ybVVU8UwTIdPN/0OoN4AHS8myPuk9IlyoA0ONtbIuLffYH
        TKAxmS9pHWSonD4ibSHmHg5zTTw+M89y+HMnIm0qhXxp5rskKWXVwQvGArKNNOR+CTSbXXcUdqNjO
        Sm8ZZ7M4WWPRwpF6Zd4qm/wdoAFZHbzcbYVZmuZL86O9h7HWqTgO6Xcs5Xz6Ifhqmp/i1aJQa5TMe
        eKaP264pFtnQp0/v0Gy7lZgUdO4HCspF2l8dXCYIpCtaygpSirK57vtDQodvFGHRiq3RhEwFCDKfY
        qpmqKj2/A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54848)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iJIjS-0003Hc-3D; Sat, 12 Oct 2019 15:50:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iJIjP-0002DS-Bo; Sat, 12 Oct 2019 15:50:55 +0100
Date:   Sat, 12 Oct 2019 15:50:55 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chunrong Guo <chunrong.guo@nxp.com>
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
Message-ID: <20191012145055.GO25745@shell.armlinux.org.uk>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org>
 <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
 <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
 <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
 <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck>
 <20191011103342.GL25745@shell.armlinux.org.uk>
 <CAK8P3a1ADTc0woWWNjpeqYEtgb=snj264P4QNWOj7ZRMDv8WNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1ADTc0woWWNjpeqYEtgb=snj264P4QNWOj7ZRMDv8WNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 12:47:45AM +0200, Arnd Bergmann wrote:
> On Fri, Oct 11, 2019 at 12:33 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > 32-bit ARM experience is that telco class users really like big
> > endian.
> 
> Right, basically anyone with a large code base migrated over from a
> big-endian MIPS or PowerPC legacy that found it cheaper to change
> the rest of the world than to fix their own code.

I think you need to step off your soap box!  Big endian isn't going
away, and it likely has nothing to do with code bases.  Just look at
networking and telco protocols.  Everything in that world tends to
be big endian.  BE is what is understood in that world, and there's
little we can do to change it.

Demanding that they switch to LE is tantamount to you demanding that
their entire world change - it ain't going to happen.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
