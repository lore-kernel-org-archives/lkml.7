Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87187C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FCA20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1CU5hz3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDZU7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:59:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46043 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfDZU7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OCh7hT70whp/+unoMK2jqCVOcBFEvfKRG5b+VUOJD2I=; b=1CU5hz3nVs7ef8TMlXNAhWk/KB
        Vj2QqJiBl+W/gF58XyYvADOZDqrxI3rRwOJkNmnxn1f+4jFw6p00hkERkOWbAnIDt1iwvAumCTd5q
        Mjb48qJv4PHQhJctGvPCQIj/cav01dzGvhmBQTXpQSAb6Pt5h3oDcwjCAnLclCs+pJvY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK7w8-0004ty-B9; Fri, 26 Apr 2019 22:59:12 +0200
Date:   Fri, 26 Apr 2019 22:59:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] net: ll_temac: Fix support for 64-bit platforms
Message-ID: <20190426205912.GI4041@lunn.ch>
References: <20190426073231.4008-1-esben@geanix.com>
 <20190426073231.4008-4-esben@geanix.com>
 <20190426114013.333e62c8@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426114013.333e62c8@cakuba.netronome.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:40:13AM -0700, Jakub Kicinski wrote:
> On Fri, 26 Apr 2019 09:32:22 +0200, Esben Haabendal wrote:
> > The use of buffer descriptor APP4 field (32-bit) for storing skb pointer
> > obviously does not work on 64-bit platforms.
> > As APP3 is also unused, we can use that to store the other half of 64-bit
> > pointer values.
> > 
> > Contrary to what is hinted at in commit message of commit 15bfe05c8d63
> > ("net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit")
> > there are no other pointers stored in cdmac_bd.
> > 
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
> 
> This is a bit strange, the driver stores the host's virtual address into
> the HW descriptor?

Hi Jukub

This is reasonably common. You need some sort of cookie which links
the hardware descriptor to the skbuf it points to. The hardware makes
no use of it, it is just a cookie.

    Andrew
