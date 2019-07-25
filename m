Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CA322BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="haHYgkOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390689AbfGYNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:49:05 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37260 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389122AbfGYNtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H0ZKN/xiAYk5rM8gIrU23+VdBgNzjstbqxwwwf4PbeQ=; b=haHYgkOBZXJJSqCrQTIJ59lEEO
        bumcqeE7dUat8vbB+7ZQssdvoPOengB4IwPhuD9JGWdl1zifSlLSPSmu6aCF/dS7tzIoCoKEOmpic
        Z1LeNDqp28N3BdFj1o51T70nT0ij+LUVDsD28iN14fDZqF746yownUFn02ltB/kvT8ck=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hqe71-0006Li-Qz; Thu, 25 Jul 2019 15:48:51 +0200
Date:   Thu, 25 Jul 2019 15:48:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>,
        Arthur Marris <arthurm@cadence.com>,
        Steven Ho <stevenh@cadence.com>,
        Milind Parab <mparab@cadence.com>
Subject: Re: [PATCH v6 0/5] net: macb: cover letter
Message-ID: <20190725134851.GF21952@lunn.ch>
References: <1562769391-31803-1-git-send-email-pthombar@cadence.com>
 <20190718151310.GE25635@lunn.ch>
 <CO2PR07MB246961335F7D401785377765C1C10@CO2PR07MB2469.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR07MB246961335F7D401785377765C1C10@CO2PR07MB2469.namprd07.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 01:27:58PM +0000, Parshuram Raju Thombare wrote:
> Hi Andrew,
> 
> >One thing which was never clear is how you are testing the features you are
> >adding. Please could you describe your test setup and how each new feature
> >is tested using that hardware. I'm particularly interested in what C45 device
> >are you using? But i expect Russell would like to know more about SFP
> >modules you are using. Do you have any which require 1000BaseX,
> >2500BaseX, or provide copper 1G?
> 
> Sorry for late reply.
> Here is a little more information on our setup used for testing C45 patch with a view to
> try clarify a few points. 
> Regarding the MDIO communication channel that our controller supports - We have tested
> MDIO transfers through Clause 22, but none of our local PHY's support Clause 45 so our hardware
> team have created an example Clause 45 slave device for us to add support to the driver.

O.K.

Given Russells reply, i suggest you submit the MDIO Clause 45 patch,
and throw all the other patches away.

    Andrew
