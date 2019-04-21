Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A35C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 07:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA9C2147C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555833598;
	bh=WeRg4KSjI+4PPSsTWhAKMrKBNthp4wl9LpEfXFetrfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wtU5slJebpiMhShYNJzw7lbZTXNfOWXztEM+AVjeve355GR0BItXYUp5ETMWDX8Rg
	 cE0mUsc8xNb3apKPnSFnKldMiqSTFuAMJ7vYguMIb4lOz3+ZqzDPZ2KK8sf00vrcCP
	 EW9Wa4ppajwswgRo2t1Fq+BQPw/+4yaY6PP5UFGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfDUH75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 03:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfDUH75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 03:59:57 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6DF20869;
        Sun, 21 Apr 2019 07:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555833596;
        bh=WeRg4KSjI+4PPSsTWhAKMrKBNthp4wl9LpEfXFetrfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5rEqR31M42UD4BCWWWPQHZE1+mkeQelvX/+TUDmgEDUoxgvZOUHZryDrReS74o3L
         vIwBKHjSWCX8de85pXrOpW149jOvBoSrt6nlESpFDaUMKdTo41M+pbbBeJ5tGV0GwS
         R1eh8eUHb5KLnMwlzLjT7uwLif2dCSXCkgVqM2vg=
Date:   Sun, 21 Apr 2019 15:59:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     leoyang.li@nxp.com, claudiu.manoil@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH v2 2/2] ARM: dts: ls1021: Fix SGMII PCS link remaining
 down after PHY disconnect
Message-ID: <20190421075939.GE19962@dragon>
References: <20190411232315.19588-1-olteanv@gmail.com>
 <20190411232315.19588-2-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411232315.19588-2-olteanv@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 02:23:15AM +0300, Vladimir Oltean wrote:
> Each eTSEC MAC has its own TBI (SGMII) PCS and private MDIO bus.
> But due to a DTS oversight, both SGMII-compatible MACs of the LS1021 SoC
> are pointing towards the same internal PCS. Therefore nobody is
> controlling the internal PCS of eTSEC0.
> 
> Upon initial ndo_open, the SGMII link is ok by virtue of U-boot
> initialization. But upon an ifdown/ifup sequence, the code path from
> ndo_open -> init_phy -> gfar_configure_serdes does not get executed for
> the PCS of eTSEC0 (and is executed twice for MAC eTSEC1). So the SGMII
> link remains down for eTSEC0. On the LS1021A-TWR board, to signal this
> failure condition, the PHY driver keeps printing
> '803x_aneg_done: SGMII link is not ok'.
> 
> Fixes: 055223d4d22d ("ARM: dts: ls1021a: Enable the eTSEC ports on QDS and TWR")
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

To get it land as fix a bit easier, I squashed both patches into one
(with a little edit on commit log), and applied it.

Shawn
