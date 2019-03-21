Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6A0218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n7UdehgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfCUOZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:25:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33541 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbfCUOZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TH5AxfWaU8xkYWHPcEWnKOaoCPwc527eUpgo2bmbH6A=; b=n7UdehgCK4vyjZMtu13+qYdS+B
        GwqUsB/WvrOLRSCsW9it9R/K4sb5bRMgZtcP86EdSiTCFt4wt3vcp7AxTKCpNe0UINXp6WzpMcJLi
        jxaqE0kCkx/6UQDNWWHL6cHlwfe1huGuW+5D/ryzUpYArSE01BD1jaQPCZCJl3SufpR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h6yd0-0005aS-1M; Thu, 21 Mar 2019 15:25:06 +0100
Date:   Thu, 21 Mar 2019 15:25:06 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        piotrs@cadence.com, jank@cadence.com
Subject: Re: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in
 MDIO read/write functions.
Message-ID: <20190321142506.GD17655@lunn.ch>
References: <20190223152540.GE10693@lunn.ch>
 <1552930948-6755-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552930948-6755-1-git-send-email-pthombar@cadence.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 05:42:28PM +0000, Parshuram Thombare wrote:
> Sorry for sending this patch again, but I didn't sent previous
> email --in-reply-to last comment on v1 of this patch. So
> rectifying this mistake.
> 
> This version 2 of patch to modify MDIO read/write functions to support
> communication with C45 PHY in Cadence ethernet controller driver.
> 
> Changes:
> 	1. Added timeout
> 	2. Removed unused operation macro MACB_MAN_C45_POST_READ_INCR
> 
> I thought of starting with relatively smaller, independant and simpler changes.
> This patch is independant of patch series and looks relatively straight forward
> with aim of supporting C45 PHY for support of high speed PHY's.

Hi Parshuram

Something i asked last time, but i'm not sure i got an answer.  Do all
generations of the MDIO controller support C45? If the older versions
only support C22, we need to be sure it does the right thing when
asked to do a C45 transfer.

      Andrew
