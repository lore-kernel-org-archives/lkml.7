Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147CC218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YLM1WEhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbfB1Qhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:37:48 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41973 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfB1Qhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uiqvDFGtN9RwTvkyIEUdFVUcB+fx0YHdTkh64l2PEQI=; b=YLM1WEhexJ0Zy9dpL/NuqEZL4Z
        aWvAW1/N3qTmr5tL/zXrM5VivapG+mll0KCmYmaTM00m7HYMm348prM6FPuIzYwMIOEeny51KPDL1
        eqUD8iq/oEFGjwOyFFNeOY5/KaJWWOpcqkjfBGZRyEid6JzP/iF2RAClNDduIFhQY+B0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gzOgb-0004Ee-6H; Thu, 28 Feb 2019 17:37:29 +0100
Date:   Thu, 28 Feb 2019 17:37:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: e1000e: add MAC address kernel cmd line parameter
Message-ID: <20190228163729.GB17912@lunn.ch>
References: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
 <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
 <20190228153245.GA17912@lunn.ch>
 <b12067de92864d5db83bd3da9456e2fe@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12067de92864d5db83bd3da9456e2fe@asem.it>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> 
> we produce a lot of boards and we have to change the MAC address,
> from u-boot, for every board.  So I must save in the u-boot
> environment (SPI NOR flash) the MAC address for every board.

Hi Flavio

u-boot should be able to write the MAC address in the correct part of
device tree. Boards have been doing this a long time.

Module parameters are considered bad. You should only do it if you
have no other option. Here you do have another options, so it is going
to be a hard sell getting David to access your patch.

You will have more success by adding a call to
eth_platform_get_mac_address() to the e1000e driver.

   Andrew
