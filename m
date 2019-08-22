Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54193C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBBD21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2YBLfaiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392759AbfHVUI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:08:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52874 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731461AbfHVUIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ouh1hyA4cnUUtU66BbaszA14lgEbgI+hW7TPxZskfjA=; b=2YBLfaiSJjF9YvxwEJ63tFNfLf
        NgaAM1cajy0G+MKXV0ek0VyWAA2A2jdYFKagzeAznZj+f1uhGOamR9xPHUmjNRKRI4NEn774Y6oog
        pQlCVkQA/uY9HkHC7rtBXUbBi13ZDESxVdM4S/9OOKhAMjzpFLWZeDaaKqoJ3UxH5oH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i0tNZ-0007Bu-Ol; Thu, 22 Aug 2019 22:08:17 +0200
Date:   Thu, 22 Aug 2019 22:08:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        davem@davemloft.net, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, allan.nielsen@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH 1/3] net: Add HW_BRIDGE offload feature
Message-ID: <20190822200817.GD21295@lunn.ch>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
 <1566500850-6247-2-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566500850-6247-2-git-send-email-horatiu.vultur@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Determin if the SW bridge can be offloaded to HW. Return true if all
> + * the interfaces of the bridge have the feature NETIF_F_HW_SWITCHDEV set
> + * and have the same netdev_ops.
> + */

Hi Horatiu

Why do you need these restrictions. The HW bridge should be able to
learn that a destination MAC address can be reached via the SW
bridge. The software bridge can then forward it out the correct
interface.

Or are you saying your hardware cannot learn from frames which come
from the CPU?

	Andrew
