Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D35C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5653021721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438382AbfFLRKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:10:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38398 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFLRKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:10:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 12C1915279670;
        Wed, 12 Jun 2019 10:10:34 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:10:33 -0700 (PDT)
Message-Id: <20190612.101033.1275036348342275988.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     pablo@netfilter.org, f.fainelli@gmail.com, jiri@mellanox.com,
        jakub.kicinski@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, antoine.tenart@bootlin.com,
        thomas.petazzoni@bootlin.com, mirq-linux@rere.qmqm.pl,
        toshiaki.makita1@gmail.com
Subject: Re: [PATCH net v2] net: ethtool: Allow matching on vlan DEI bit
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190612151838.7455-1-maxime.chevallier@bootlin.com>
References: <20190612151838.7455-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Jun 2019 10:10:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 12 Jun 2019 17:18:38 +0200

> Using ethtool, users can specify a classification action matching on the
> full vlan tag, which includes the DEI bit (also previously called CFI).
> 
> However, when converting the ethool_flow_spec to a flow_rule, we use
> dissector keys to represent the matching patterns.
> 
> Since the vlan dissector key doesn't include the DEI bit, this
> information was silently discarded when translating the ethtool
> flow spec in to a flow_rule.
> 
> This commit adds the DEI bit into the vlan dissector key, and allows
> propagating the information to the driver when parsing the ethtool flow
> spec.
> 
> Fixes: eca4205f9ec3 ("ethtool: add ethtool_rx_flow_spec to flow_rule structure translator")
> Reported-by: Micha©© Miros©©aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V1 -> V2: Use "DEI" instead of the old name "CFI", as suggested by Toshiaki.
>           Perform endianness swap on the constant, sothat it's done at
> 	  build-time, as suggested by Jakub.

Applied and queued up for -stable, thanks.
