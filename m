Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F54C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6890218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vz99B6wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfDYMWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:22:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43814 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfDYMWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UY0arVveNFSYSz3FddQN2GcVIvcVeKJYS6aneMZAL98=; b=vz99B6wWCVVclfobMF8j/ZgDSW
        xX9vbDbIRzAU7uflhcv790PMFRUnQEY/MWB9S6ZVieCrk8+DNF8jwQ4QO6onSyHzSc7FKgQ+6q4Vn
        wCaHm89UFu0jMIBByu1A4DhckTTtPg7T/9Pim1aOMzYrLibCKLffSpLeqwfgFIxIc6Qc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJdOi-0002F1-0t; Thu, 25 Apr 2019 14:22:40 +0200
Date:   Thu, 25 Apr 2019 14:22:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Ong, Boon Leong" <boon.leong.ong@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>
Subject: Re: [PATCH 4/7] net: stmmac: introducing support for DWC xPCS logics
Message-ID: <20190425122240.GB8117@lunn.ch>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-5-git-send-email-weifeng.voon@intel.com>
 <20190424134136.GO28405@lunn.ch>
 <AF233D1473C1364ABD51D28909A1B1B75C0B0244@pgsmsx114.gar.corp.intel.com>
 <20190425032120.GJ3371@lunn.ch>
 <AF233D1473C1364ABD51D28909A1B1B75C0B0E38@pgsmsx114.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF233D1473C1364ABD51D28909A1B1B75C0B0E38@pgsmsx114.gar.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> >> +/* MII MMD AN Status defines for C37 AN SGMII Status */
> >> >> +#define AN_STAT_C37_AN_CMPLT		BIT(0)	/* AN
> >Complete Intr */
> >> >> +#define AN_STAT_C37_AN_FD		BIT(1)	/* Full Duplex */
> >> >> +#define AN_STAT_C37_AN_SPEED_SHIFT	2	/* AN Speed shift */
> >> >> +#define AN_STAT_C37_AN_SPEED		GENMASK(3, 2)	/* AN
> >Speed */
> >> >> +#define AN_STAT_C37_AN_10MBPS		0x0	/* 10 Mbps */
> >> >> +#define AN_STAT_C37_AN_100MBPS		0x1	/* 100 Mbps
> >> >*/
> >> >> +#define AN_STAT_C37_AN_1000MBPS		0x2	/* 1000 Mbps
> >> >*/
> >> >> +#define AN_STAT_C37_AN_LNKSTS		BIT(4)	/* Link Status
> >*/
> >> >
> >> >Is these are standardized, not proprietary, consider adding them to
> >> >include/uapi/linux/mii.h so similar.
> >>
> >> Yeah, it does look very standardized. However, per DW spec, they are
> >> vendor-specific register set which uses MDIO_MMD_VEND2 to access.
> >
> >Maybe you can go get the 802.3 standard and check section 37. If these
> >registers are the same, they could still be placed in mii.h. What MMD
> >you use is a different matter.
> >
> I cross-checked on 802.3 section 37.2.5.1 Management registers, the spec only
> talks about BMSR and extended status. I also checked on 802.3 section 45.2
> MDIO interface registers, section 45.2.7 AN registers, section 45.2.9 &
> 45.2.10 Vendor specific MMD1 & MMD2, there are no field format that
> matches the above bit fields. So, it should be reasonable to park these #defines
> in this local file for now.  

Thanks for checking the standards. If these don't actually represent
anything from C37, maybe you should change the name to avoid
confusion. s/C37/SGMII/g ?

	   Thanks
		Andrew
