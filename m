Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40D22075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qIv8qN6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfCDNpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:45:40 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45735 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfCDNpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZkJsQMa37i0+gZtz4rq4RCQr08pWxEa3n1iwoFozQEI=; b=qIv8qN6UmrwHs2+bFkLZTf9lda
        rj8hJvwq68HsRg8Qf/qimrbUdyCStxZG4ARIfV/fEu2pkqS9ZUgbt1MCDL7Jw4mYC+QWDNsu+oqbR
        UHCCsXaUM8ZuHwuGPXZVFHOn5nLRZKTYeEnvmoTcGHDyybPxitrGMqN8JbbqDkFkM0g0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h0nuH-0003co-Bw; Mon, 04 Mar 2019 14:45:25 +0100
Date:   Mon, 4 Mar 2019 14:45:25 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        Per Noergaard Christensen <pnc@deif.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: dsa: mv88e6xxx: support single chip sw_addr
 offset
Message-ID: <20190304134525.GC26378@lunn.ch>
References: <20190304125933.5653-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304125933.5653-1-rasmus.villemoes@prevas.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 12:59:42PM +0000, Rasmus Villemoes wrote:
> From: Per Noergaard Christensen <pnc@deif.com>
> 
> The 88e6250 does not support multi-chip addressing. However, one can
> still have two of them on the same mdio bus, since the device only
> uses 16 of the 32 possible addresses, either addresses 0x00-0x0F or
> 0x10-0x1F depending on the ADDR4 pin at reset [since ADDR4 is
> internally pulled high, the latter is the default].
> 
> In order to prepare for supporting the 88e6250, change
> mv88e6xxx_smi_init and the single_chip_{read,write} functions to allow
> and honour a non-zero sw_addr in single chip mode. Since this only
> changes the behaviour in the sw_addr!=0 && !chip->info->multi_chip
> case from returning -EINVAL, it should not break existing setups.

Hi Rasmus

We have the nice abstraction of mv88e6xxx_smi_multi_chip_ops and
mv88e6xxx_smi_single_chip_ops. I think we should extend this
abstraction and implement mv88e6xxx_smi_dual_chip_ops. Also, add a
chip->info->dual_chip flag, so we know when it can be used.

	Andrew
