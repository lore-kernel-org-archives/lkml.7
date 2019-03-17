Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF119C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CBC2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kM5urz8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCQSit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:38:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56588 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfCQSis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3azTNjLvn8tI3968njaxr88S68w3ApnnMdVgrSTgqcI=; b=kM5urz8Ce6YLER/N9aEWnD9SFx
        DbXp+wmOEHjr5yHK50dVoY9n6zbsouxAo1Tp7LZLUtZwn89gRY5PuQGFEkWezmoeSOKhhFunbXawy
        69je3YlsAi1udPpGsuV0OERNI7QjHS/qZBAQezW9syHMHJ4N3FACQ1nDGWbfbg+PxOKM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h5agF-0006zb-Mj; Sun, 17 Mar 2019 19:38:43 +0100
Date:   Sun, 17 Mar 2019 19:38:43 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jose Abreu <jose.abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [PATCH net] net: phy: Don't assume loopback is supported
Message-ID: <20190317183843.GE22226@lunn.ch>
References: <eeea080649153eefafef8ff93274733fe8f25b01.1552559796.git.joabreu@synopsys.com>
 <19c8d2b3-bffe-b3b2-6e91-e878f89e5247@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c8d2b3-bffe-b3b2-6e91-e878f89e5247@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 03:48:41PM -0700, Florian Fainelli wrote:
> On 3/14/19 3:37 AM, Jose Abreu wrote:
> > Some PHYs may not support loopback mode so we need to check if register
> > is read-only.
> > 
> 
> In that case it may be appropriate to have a specific PHY driver that
> implements a set_loopback() method returning -EOPNOTSUPP instead of
> changing the generic PHY implementation.

Hi Jose

Since Heiner says this is a mandatory feature, we should not really
penalise conformant PHYs just because there is one broken PHY.

Please handle this in the PHY driver, by implementing the set_loopback
call.

	Andrew
