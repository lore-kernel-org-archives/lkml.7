Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C73C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B13218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfB1XRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:17:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40394 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1XRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:17:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1DB1914C2136B;
        Thu, 28 Feb 2019 15:16:59 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:16:56 -0800 (PST)
Message-Id: <20190228.151656.907037082987778102.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        vivien.didelot@gmail.com, linux-arm-kernel@lists.infradead.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: power serdes on/off for 10G
 interfaces on 6390X
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190228211433.14211-1-maxime.chevallier@bootlin.com>
References: <20190228211433.14211-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Feb 2019 15:16:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Thu, 28 Feb 2019 22:14:33 +0100

> Upon setting the cmode on 6390 and 6390X, the associated serdes
> interfaces must be powered off/on.
> 
> Both 6390X and 6390 share code to do so, but it currently uses the 6390
> specific helper mv88e6390_serdes_power() to disable and enable the
> serdes interface.
> 
> This call will fail silently on 6390X when trying so set a 10G interface
> such as XAUI or RXAUI, since mv88e6390_serdes_power() internally grabs
> the lane number based on modes supported by the 6390, and returns 0 when
> getting -ENODEV as a lane number.
> 
> Using mv88e6390x_serdes_power() should be safe here, since we explicitly
> rule-out all ports but the 9 and 10, and because modes supported by 6390
> ports 9 and 10 are a subset of those supported on 6390X.
> 
> This was tested on 6390X using RXAUI mode.
> 
> Fixes: 364e9d7776a3 ("net: dsa: mv88e6xxx: Power on/off SERDES on cmode change")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied and queued up for -stable.
