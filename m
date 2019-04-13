Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56879C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4A42073F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VjNi4zx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfDMPGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:06:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60230 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbfDMPGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8yX98j75bFt2RG8ZLLAXhu+8ncDqKwQ1Y1++xVxmf5E=; b=VjNi4zx/o/x0i9ePO1URHm4bhN
        XwybHztXBWY9U9DyiqiWOqFyEys6Mh6Bn/peYRoQeOGI64EEuYPMrY/46DGOok3tzEonIEu+YhVSo
        O4s/sSoHhL3B+t8u+VWnI46H2569/DtULBu+Ph7PcqYWJuTPVuPeRrZRI7Uc9gh5zjp4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFKDl-0004hu-Q2; Sat, 13 Apr 2019 17:05:33 +0200
Date:   Sat, 13 Apr 2019 17:05:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 06/24] net: dsa: Call driver's setup callback
 after setting up its switchdev notifier
Message-ID: <20190413150533.GA17901@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-7-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-7-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 04:28:04AM +0300, Vladimir Oltean wrote:
> This allows the driver to perform some manipulations of its own during
> setup, using generic switchdev calls. Having the notifiers registered at
> setup time is important because otherwise any switchdev transaction
> emitted during this time would be ignored (dispatched to an empty call
> chain).
> 
> One current usage scenario is for the driver to request DSA to set up
> 802.1Q based switch tagging for its ports.
> 
> There is no danger for the driver setup code to start racing now with
> switchdev events emitted from the network stack (such as bridge core)
> even if the notifier is registered earlier. This is because the network
> stack needs a net_device as a vehicle to perform switchdev operations,
> and the slave net_devices are registered later than the core driver
> setup anyway (ds->ops->setup in dsa_switch_setup vs dsa_port_setup).
> 
> Luckily DSA doesn't need a net_device to carry out switchdev callbacks,
> and therefore drivers shouldn't assume either that net_devices are
> available at the time their switchdev callbacks get invoked.

Hi Vladimir

Thanks for adding this explanation to the commit message.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
