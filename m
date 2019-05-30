Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BADC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08B82396B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE3WGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 18:06:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfE3WF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:05:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EA57214DD36E9;
        Thu, 30 May 2019 15:05:58 -0700 (PDT)
Date:   Thu, 30 May 2019 15:05:58 -0700 (PDT)
Message-Id: <20190530.150558.1424400488308311629.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     pablo@netfilter.org, f.fainelli@gmail.com, jiri@mellanox.com,
        jakub.kicinski@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, antoine.tenart@bootlin.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net] ethtool: Check for vlan etype or vlan tci when
 parsing flow_rule
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190530140840.741-1-maxime.chevallier@bootlin.com>
References: <20190530140840.741-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 May 2019 15:05:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Thu, 30 May 2019 16:08:40 +0200

> When parsing an ethtool flow spec to build a flow_rule, the code checks
> if both the vlan etype and the vlan tci are specified by the user to add
> a FLOW_DISSECTOR_KEY_VLAN match.
> 
> However, when the user only specified a vlan etype or a vlan tci, this
> check silently ignores these parameters.
> 
> For example, the following rule :
> 
> ethtool -N eth0 flow-type udp4 vlan 0x0010 action -1 loc 0
> 
> will result in no error being issued, but the equivalent rule will be
> created and passed to the NIC driver :
> 
> ethtool -N eth0 flow-type udp4 action -1 loc 0
> 
> In the end, neither the NIC driver using the rule nor the end user have
> a way to know that these keys were dropped along the way, or that
> incorrect parameters were entered.
> 
> This kind of check should be left to either the driver, or the ethtool
> flow spec layer.
> 
> This commit makes so that ethtool parameters are forwarded as-is to the
> NIC driver.
> 
> Since none of the users of ethtool_rx_flow_rule_create are using the
> VLAN dissector, I don't think this qualifies as a regression.
> 
> Fixes: eca4205f9ec3 ("ethtool: add ethtool_rx_flow_spec to flow_rule structure translator")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied, thank you.
