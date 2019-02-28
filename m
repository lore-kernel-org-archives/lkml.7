Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB9E218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4bogwG09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfB1TaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:30:25 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42224 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfB1TaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oqtDSzwd5ELH28w0GCFEmY0xjVDDqKrR18GouO17bKU=; b=4bogwG09B2oVOAyoWd5qTvuf2h
        vjO94hDriHMKFIHccEP1h43B/MFpxbqmuuhSGX7XkxV8kxCNqS9Dn59050For6V23oLG1+z7C4jMZ
        n7lJpsfRYjakW8TNnCCtuAKSdSnnPvjxNi6lgsA4o3rul9Lvhx0K7UB1rYCoKll+7JZw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gzRNW-0006L3-OX; Thu, 28 Feb 2019 20:29:58 +0100
Date:   Thu, 28 Feb 2019 20:29:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: e1000e: add MAC address kernel cmd line parameter
Message-ID: <20190228192958.GA24085@lunn.ch>
References: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
 <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
 <20190228153245.GA17912@lunn.ch>
 <b12067de92864d5db83bd3da9456e2fe@asem.it>
 <20190228163729.GB17912@lunn.ch>
 <6a7a37813e71420b929c769dd1e77664@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7a37813e71420b929c769dd1e77664@asem.it>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 05:13:27PM +0000, Flavio Suligoi wrote:
> > > Hi Andrew,
> > >
> > > we produce a lot of boards and we have to change the MAC address,
> > > from u-boot, for every board.  So I must save in the u-boot
> > > environment (SPI NOR flash) the MAC address for every board.
> > 
> > Hi Flavio
> > 
> > u-boot should be able to write the MAC address in the correct part of
> > device tree. Boards have been doing this a long time.
> > 
> > Module parameters are considered bad. You should only do it if you
> > have no other option. Here you do have another options, so it is going
> > to be a hard sell getting David to access your patch.
> > 
> > You will have more success by adding a call to
> > eth_platform_get_mac_address() to the e1000e driver.
> 
> You have right, and thanks for your suggestions, 
> but with a kernel parameter I can use the same method
> for any board where the NVM is missed, independently of any architecture
> (with or without the device tree presence - ARM or x86 or others).

Hi Flavio

Well, lets wait for David to say what he thinks about the module
parameter.

	Andrew
