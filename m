Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A85EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206FD2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ckd119AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfCEJze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:55:34 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41118 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B4wdFcvaQS9jQ+A96f4iwiWLIVrRdXxvFqFNs+W8ziA=; b=Ckd119AEXAaocwB1e1eYphnMi
        FeX6nPYqK/kOiCtUOoy1uHwB63/BD5ZCx/amoMcFoJkbu4tugwe/vHyBEcyEy//3fITVthW+v/f68
        R3TS8hZT/7tsQ/SKTadOcemkA+jONlRdnHwIJacWd8zRw13qfVubvadHfClbxRzt01nUuXidg77wf
        WEvk0UwP4kWjYdb9LsGHxWtfS0nZlscINv//lhVigNKxU2pRjmzcJMzMPTCFXc3z1VrgB6BAexzFt
        zJPc98WB5ghjkAF5f60OEXoF1xWFYEQYw3mlXwPDOpZMiwO6Llt+hqM+l26APzDzkVBox9Kk+8t2G
        pl5YdglNQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54940)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h16nB-0000Mp-VA; Tue, 05 Mar 2019 09:55:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h16mv-00035r-Sh; Tue, 05 Mar 2019 09:55:05 +0000
Date:   Tue, 5 Mar 2019 09:55:05 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        avifishman70@gmail.com, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Xu Wei <xuwei5@hisilicon.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>, wang.yi59@zte.com.cn
Subject: Re: [PATCH 01/15] ARM: actions: fix a leaked reference by
 addingmissing of_node_put
Message-ID: <20190305095505.znposuv6avjtbfwf@shell.armlinux.org.uk>
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
 <20190301155523.GA1915@Mani-XPS-13-9360>
 <CACRpkdb=E9_rm4_7DQV3dS5uOs1gozxEwN9MtWr0tTwmjcYe=A@mail.gmail.com>
 <20190304144829.GA5265@Mani-XPS-13-9360>
 <CACRpkda+8QZnaT-YoeccQGjg78y9-E-JoWBr3LJs62T03H4wQw@mail.gmail.com>
 <CAOZjjhnDYHkWCd-zDqkFpg5FPoj-UxxNwVxfbg6QEahiASm10w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZjjhnDYHkWCd-zDqkFpg5FPoj-UxxNwVxfbg6QEahiASm10w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 07:21:19AM +0530, Manivannan Sadhasivam wrote:
> On Tue, 5 Mar, 2019, 4:08 AM Linus Walleij <linus.walleij@linaro.org wrote:
> 
> > On Mon, Mar 4, 2019 at 3:48 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > On Mon, Mar 04, 2019 at 01:29:33PM +0100, Linus Walleij wrote:
> > > > On Fri, Mar 1, 2019 at 4:55 PM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > Hi Wen,
> > > > >
> > > > > On Fri, Mar 01, 2019 at 04:56:42PM +0800, Wen Yang wrote:
> > > > > > The call to of_get_next_child returns a node pointer with refcount
> > > > > > incremented thus it must be explicitly decremented after the last
> > > > > > usage.
> > > > > >
> > > > > > Detected by coccinelle with the following warnings:
> > > > > > ./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing
> > of_node_put; acquired a node pointer with refcount incremented on line 103,
> > but without a corresponding object release within this function.
> > > > > > ./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing
> > of_node_put; acquired a node pointer with refcount incremented on line 115,
> > but without a corresponding object release within this function.
> > > > > > ./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing
> > of_node_put; acquired a node pointer with refcount incremented on line 128,
> > but without a corresponding object release within this function.
> > > > > >
> > > > >
> > > > > We have a floating patch for this:
> > > > > https://www.spinics.net/lists/arm-kernel/msg694544.html
> > > > >
> > > > > Andreas: Can you please take a second look at the patchset submitted
> > by Linus
> > > > > Walleij and Russel for simplifying the Actions startup code?
> > > >
> > > > Andreas wrote a version of simplifying secondary startup in the
> > > > same spirit as Russell's patches, and it's merged and all
> > > > is fine I think.
> > > >
> > >
> > > Oops. I think I missed that! Can you please point me to that patch? And
> > how it
> > > got merged? I did the PR for actions stuff this time and haven't
> > included any
> > > mach-actions patches.
> >
> > I just did git log arch/arm/mach-actions but I think it came in quite some
> > time
> > ago, not last merge window:
> >
> > But you see:
> > commit 6c2eb3e76fb84e2eb46d484f71fab469c0d9532c
> > "ARM: owl: smp: Drop owl_secondary_boot()"
> > commit bad29933fef76fb6ee577f4a0b6d145c1f52f663
> > "ARM: owl: smp: Use __pa_symbol()"
> > commit 18cfd9429d8a82c49add8f3ca9d366599bfcac45
> > "ARM: owl: smp: Drop bogus holding pen"
> >
> > platsmp.c looks just fine these days. Except for what Wei's patch is
> > fixing,
> > of_node_put().
> >
> 
> Nope. platsmp.c still requires some cleanup like removing the redundant
> bootlock and pen_release flag as pointed out by Russel. Andreas just
> replied to your cleanup patches but there was no follow up since that. So,
> I guess we can just apply Russell's patches and this patch once Andreas is
> fine with it (it looks good to me though).

No.  My patches are in my tree queued for this merge window.  They
are part of a series that can not be broken up and merged separately
because all the per-platform patches need to be merged before the final
patch "ARM: smp: remove arch-provided "pen_release"" otherwise the
platforms break.  I thought that was already explained.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
