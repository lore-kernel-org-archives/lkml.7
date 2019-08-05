Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11977C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF2020B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4NJXPaas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfHEN6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:58:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34128 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbfHEN6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WYw8/CsyIIlaQwFPL6bzkXMXLdhLLRjQOPAaRx584DU=; b=4NJXPaaslt7RJRsdw2e/74OJjF
        QOdM8wOeY/5x0ivcRrz2Rz65swlscRiNyfyM3IZe3Jz5JbKKYqXSunnwMl4CuoCeqLqEdG83lYodN
        vlZgJQqagH3Q6hpoGI0wfVjTWphygWGmHbYPCGOVQ9fTWaVNkhysxe/YLkn1suixFKbo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hudVW-0007B7-EP; Mon, 05 Aug 2019 15:58:38 +0200
Date:   Mon, 5 Aug 2019 15:58:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hubert Feurstein <h.feurstein@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: extend PTP gettime
 function to read system clock
Message-ID: <20190805135838.GF24275@lunn.ch>
References: <20190805082642.12873-1-hubert.feurstein@vahle.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805082642.12873-1-hubert.feurstein@vahle.at>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:26:42AM +0200, Hubert Feurstein wrote:
> From: Hubert Feurstein <h.feurstein@gmail.com>

Hi Hubert

In your RFC patch, there was some interesting numbers. Can you provide
numbers of just this patch? How much of an improvement does it make?

Your RFC patch pushed these ptp_read_system_{pre|post}ts() calls down
into the MDIO driver. This patch is much less invasive, but i wonder
how much a penalty you paid?

Did you also try moving these calls into global2_avb.c, around the one
write that really matters?

It was speculated that the jitter comes from contention on the mdio
bus lock. Did you investigate this? If you can prove this true, one
thing to try is to take the mdio bus lock in the mv88e6xxx driver,
take the start timestamp, call __mdiobus_write(), and then the end
timestamp. The bus contention is then outside your time snapshot.

We could even think about adding a mdiobus_write variant which does
all this. I'm sure other DSA drivers would find it useful, if it
really does help.

	   Andrew
