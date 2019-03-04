Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0002206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sZK88eKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfCDO5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:57:16 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45844 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfCDO5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=n4linaU+uDO7QNRj5tUU6AY16NLLKMqeRHdXePGlAp8=; b=sZK88eKFrVgcXFF9q7ytCJwywR
        G10FTLf5D5Y1ckCnvAslQeam5DFLoE0wk4q9vjIDHGfyA1JU6YAHux9/l+fXwgP7YyoOkjtH1VuaV
        Y3gaE3thHFl+M8oRkHBx4SMfb2/ogz5WT7SkNm0MwZHV1cdtHxNJdT0G6MLmhx5AOxz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h0p1i-0004ll-K4; Mon, 04 Mar 2019 15:57:10 +0100
Date:   Mon, 4 Mar 2019 15:57:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Zhangshaokun <zhangshaokun@hisilicon.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH -next] net: dsa: mv88e6xxx: Fix build warning when
 CONFIG_NET_DSA_LEGACY is n
Message-ID: <20190304145710.GA17097@lunn.ch>
References: <1551703381-52115-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190304132617.GB26378@lunn.ch>
 <bc528808-2ad5-90ae-4bc0-afa47a7c4f42@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc528808-2ad5-90ae-4bc0-afa47a7c4f42@hisilicon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:16:08PM +0800, Zhangshaokun wrote:
> Hi Andrew,
> 
> On 2019/3/4 21:26, Andrew Lunn wrote:
> > On Mon, Mar 04, 2019 at 08:43:01PM +0800, Shaokun Zhang wrote:
> >> When CONFIG_NET_DSA_LEGACY is n, there is a GCC bulid warning:
> >> drivers/net/dsa/mv88e6xxx/chip.c:4623:13: warning: ‘mv88e6xxx_ports_cmode_init’ defined but not used [-Wunused-function]
> >> static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
> >> Let's fix it.
> > 
> > Hi Shaokun, Heiner
> > 
> > Although this fixes the warning, i suspect there i something wrong
> > with the original patch adding mv88e6390x_port_set_cmode(). It should
> > also be used without CONFIG_NET_DSA_LEGACY.
> 
> I checked the commit-id 2a93c1a3651f ("net: dsa: Allow compiling out legacy support") by Florian.
> Do you mean that CONFIG_NET_DSA_LEGACY shall be removed completely? :-)

No, i suspect mv88e6390x_ports_cmode_init() is being called from the
wrong place, or needs to be called from a second location.

[Goes and looks at the code]

Yes, it should also be called in mv88e6xxx_probe(). I would call it
just after the call to mv88e6xxx_detect(), so that it is the same as
in mv88e6xxx_drv_probe().

There are two ways DSA drivers can be probed. The legacy way, which is
optional, and is slowly getting removed, and the current way. Heiner
is new to DSA and probably missed that, and only handled the legacy
probe method. I also missed checking when i reviewed to patch :-(

   Andrew



