Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FB0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A820205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZI9YopFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfB1N2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:28:02 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48282 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfB1N2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k92QvSmx+3kuHBsA++yT7eHLxptnoXwD4pUVBOcjWkU=; b=ZI9YopFFlpfEw8BW+8AtWxZkm
        lmOdWYXlugYPCO8mFYJ+lROoM5dO8mYwucb+rRN/i8C3y64RjbsWS/mI5q/aaIvCEyQh4KNWB35bZ
        dqoQjtCcj1p8xowo6AsbrzqbNfIYQcKwJLiQcs5FV56/RM6kw4QFNqgJIjxyTy5TQ5bbI327iMVcl
        58PseqxzO+d1aNuBc4iu00fHitMLaAkRiFhY+Y05zUPvHoFwYdeJiuiUJ6W7wy4oFB/g5pMY3yC1G
        CJ44q4yUGqLEyuZbutlcwCCZ38kmhTXT3I2g7IW5SC9hQJ90Odqi3cT7X66fgJlP2AQ3r1ycDvgfO
        xitJ0GBbg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54872)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gzLj5-0000dH-HA; Thu, 28 Feb 2019 13:27:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gzLj2-0007QS-Rj; Thu, 28 Feb 2019 13:27:48 +0000
Date:   Thu, 28 Feb 2019 13:27:48 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/7] ARM: trusted_foundations: Support L2 cache
 maintenance
Message-ID: <20190228132748.s2woduoycm7igfub@shell.armlinux.org.uk>
References: <20190228131707.2592-1-digetx@gmail.com>
 <20190228131707.2592-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228131707.2592-2-digetx@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:17:01PM +0300, Dmitry Osipenko wrote:
> +#ifdef CONFIG_CACHE_L2X0
> +static void tf_cache_write_sec(unsigned long val, unsigned int reg)
> +{
> +	u32 l2x0_way_mask = 0xff;
> +
> +	switch (reg) {
> +	case L2X0_CTRL:
> +		if (l2x0_saved_regs.aux_ctrl & BIT(16))

And bit 16 is what?  We have definitions in one of the headers you've
added above, please use them.  Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
