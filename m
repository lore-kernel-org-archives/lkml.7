Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4837FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FAA20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0PDIcLxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfHLO0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:26:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53580 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfHLO0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8Wex+QovkzawZD3S6Hhckj+rmlfCZSeGYEx7kRh5Q0o=; b=0PDIcLxvYMXFYl4mCLsIhR9LCG
        1kHqu3cIoqEzcFoeNwoq+C9YdMqEy3aemWZZ6jhYkHzH5U2ohxLoHYo+362kqS/y173ZGKVOimXRQ
        jW2BhzGX40uIpMrDicxSR5nJAH1nfkxUeVH8bUSbAhNJQmijJ4GtFDHuLyZjT3+xRmYg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hxBHR-0000sm-OM; Mon, 12 Aug 2019 16:26:37 +0200
Date:   Mon, 12 Aug 2019 16:26:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Subject: Re: [PATCH v4 13/14] net: phy: adin: add ethtool get_stats support
Message-ID: <20190812142637.GR14290@lunn.ch>
References: <20190812112350.15242-1-alexandru.ardelean@analog.com>
 <20190812112350.15242-14-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812112350.15242-14-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Named just like in the datasheet */
> +static struct adin_hw_stat adin_hw_stats[] = {
> +	{ "RxErrCnt",		0x0014,	},
> +	{ "MseA",		0x8402,	0,	true },
> +	{ "MseB",		0x8403,	0,	true },
> +	{ "MseC",		0x8404,	0,	true },
> +	{ "MseD",		0x8405,	0,	true },
> +	{ "FcFrmCnt",		0x940A, 0x940B }, /* FcFrmCntH + FcFrmCntL */
> +	{ "FcLenErrCnt",	0x940C },
> +	{ "FcAlgnErrCnt",	0x940D },
> +	{ "FcSymbErrCnt",	0x940E },
> +	{ "FcOszCnt",		0x940F },
> +	{ "FcUszCnt",		0x9410 },
> +	{ "FcOddCnt",		0x9411 },
> +	{ "FcOddPreCnt",	0x9412 },
> +	{ "FcDribbleBitsCnt",	0x9413 },
> +	{ "FcFalseCarrierCnt",	0x9414 },

I see some value in using the names from the datasheet. However, i
found it quite hard to now what these counters represent given there
current name. What is Mse? How does MseA differ from MseB? You have up
to ETH_GSTRING_LEN characters, so maybe longer names would be better?

   Andrew
