Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4547C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AD6214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XXlkH77d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfEHLrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:47:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58441 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbfEHLrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OcWBQ+7Rq2ct1XjlZ6VIj8ZWNx07gVgTDlWGIn6bFi0=; b=XXlkH77dbWEO0TnwA3cRIFIfTa
        wrWDMZj0+s4rqJZlFn3SeENPXaVJILoDfRihIytp1y9U21xQaBZ6gWYty+hxh3OLnpCM/JNGzhpNc
        b5sLekMRSrN+DNb9JF6RRd5HV/kiWbZhA8ZD+U+r7SNYR7Rif5e2ihPkLzuphSyBjInk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hOL2Z-0000gM-Vg; Wed, 08 May 2019 13:47:15 +0200
Date:   Wed, 8 May 2019 13:47:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: [RFC PATCH 1/5] net: dsa: mv88e6xxx: introduce support for two
 chips using direct smi addressing
Message-ID: <20190508114715.GB30557@lunn.ch>
References: <20190501193126.19196-1-rasmus.villemoes@prevas.dk>
 <20190501193126.19196-2-rasmus.villemoes@prevas.dk>
 <20190501201919.GC19809@lunn.ch>
 <f5924091-352c-c14a-f959-6bb8a32746e3@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5924091-352c-c14a-f959-6bb8a32746e3@prevas.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Rasmus
> > 
> > This works, but i think i prefer adding mv88e6xxx_smi_dual_chip_write,
> > mv88e6xxx_smi_dual_chip_read, and create a
> > mv88e6xxx_smi_single_chip_ops.
> 
> Hi Andrew
> 
> Now that Vivien's "net: dsa: mv88e6xxx: refine SMI support" is in
> master, do you still prefer introducing a third bus_ops structure
> (mv88e6xxx_smi_dual_direct_ops ?), or would the approach of adding
> chip->sw_addr in the smi_direct_{read/write} functions be ok (which
> would then require changing the indirect callers to pass 0 instead of
> chip->swaddr).

Hi Rasmus

I would still prefer a new bus_ops.

Thanks
	Andrew
