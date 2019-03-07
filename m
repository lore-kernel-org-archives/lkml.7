Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CC520840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S+86QOvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCGQrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:47:01 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50358 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGQrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pCwswwmYIHnrFxXlhIsNRSupNq7yZrqqEkBsIkIIXjg=; b=S+86QOvyVOYAl2ApACnbkgTat
        3SaTuIuvHtEO0LNKQJFZyVrJWFQnqJ9IvXGPWRjGbISv4NUDNgxE35Ej34u5SFQNmypuFF9jKVBeh
        8K2lAbdetvzw3XCOSYYVwq41h+tfQBhjVujSMNd5VeUK0wPxKFO4DloYSCT4z56wW4OYc94uhaqjo
        gJFEDF0mNPG2W6uJ5k/Ab2hrgiY7Y1qG+fU8FoiVPPVmSUI89vru3+X1zlqBE8+6F9/2euoD/oQqu
        LNIOffrXCq0gQYZN+pgs7kfPvzUWEdFjP99mWLWdPAhayJ0e1hfKW96BblfmqkIThp9KMECRHilwz
        ZwUSN6H2A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54996)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h1wAY-00075h-18; Thu, 07 Mar 2019 16:46:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h1wAT-00053S-Fk; Thu, 07 Mar 2019 16:46:49 +0000
Date:   Thu, 7 Mar 2019 16:46:49 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 6/6] mmc: mmci: replace blksz_datactrlXX by
 get_datactrl_cfg callback
Message-ID: <20190307164649.ywhgdikxf4nhb2sd@shell.armlinux.org.uk>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
 <1551976742-4358-7-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551976742-4358-7-git-send-email-ludovic.Barre@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:39:02PM +0100, Ludovic Barre wrote:
> -	if (data->flags & MMC_DATA_READ)
> -		datactrl |= MCI_DPSM_DIRECTION;

Given that this is currently an invariant between all, it doesn't make
sense to have a separate public function and combine it into the
get_datactrl_cfg() implementations.  You may as well leave it in place
here, after you call get_datactrl_cfg().

> +	datactrl = host->ops->get_datactrl_cfg(host);

Otherwise, I don't see a problem with this, although it would be nice to
avoid the overhead of so many public functions, which could be done by
adding them as inline functions in mmci.h

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
