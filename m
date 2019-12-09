Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C9BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2852071A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575862804;
	bh=d+hshf6HNbYVQ7YUWyTquZO8CIdL9NhE1d6gbrTXxqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LeZiKJcs3NyLFS7aICLuGExmaeGGUI49gSiwSeM4jCuXrrSldZ/Ax7lIBYVZW4ZAg
	 mr8XTBI3SlJlU09aUCsZvFKcv1LxIr1ITmvYV1h/QlxruV7Mdh8Vy6kK8Bko5NEnlw
	 eiMAa64ETpl5dfuVBhUxsgoxI+N7ds5MZKg2FfEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfLIDkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfLIDkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:40:03 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E1920663;
        Mon,  9 Dec 2019 03:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575862802;
        bh=d+hshf6HNbYVQ7YUWyTquZO8CIdL9NhE1d6gbrTXxqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVrbfbQPmtX1764syBxFyHfYgT9SyVYo53w4afoqGNmqZ0yOzCqhl5fqIIBBZsgh4
         uYdJoTij9+ZqM2RdNOBbmPfUJXpQIbigcbGXSwo/rL8sSo+OYACQFr0StELYspkKub
         LqZaBP9P944GTrANZ5qme08q6yAq16Ai13Jh9rv0=
Date:   Mon, 9 Dec 2019 11:39:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] clk: imx: Trivial cleanups for clk_hw based API
Message-ID: <20191209033946.GX3365@dragon>
References: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:48:09AM +0000, Abel Vesa wrote:
> These changes are cleanups for the clk_hw based API i.MX clock drivers switch
> longterm effort. As mentioned in the commit messages, the end goal here is to
> have all the i.MX drivers use clk_hw based API only.
> 
> I've put these all in a single patchset since they do not impact in any way
> the expected behavior of the drivers and they are quite obvious trivial ones.
> More patches to follow for the older i.MX platforms but those might not be as
> harmless (and trivial) as these ones.
> 
> Changes since v1:
>  - added a patch that takes care of the register function handling when the
>    clk based API helpers are used, as suggested by Leonard Crestez.
>  - Renamed the SCCG to SSCG, as suggested by Leonard Crestez.
> 
> Abel Vesa (11):
>   clk: imx: Add correct failure handling for clk based helpers
>   clk: imx: Rename the SCCG to SSCG
>   clk: imx: Replace all the clk based helpers with macros
>   clk: imx: pllv1: Switch to clk_hw based API
>   clk: imx: pllv2: Switch to clk_hw based API
>   clk: imx: imx7ulp composite: Rename to show is clk_hw based
>   clk: imx: Rename sccg and frac pll register to suggest clk_hw
>   clk: imx: Rename the imx_clk_pllv4 to imply it's clk_hw based
>   clk: imx: Rename the imx_clk_pfdv2 to imply it's clk_hw based
>   clk: imx: Rename the imx_clk_divider_gate to imply it's clk_hw based
>   clk: imx7up: Rename the clks to hws

I'm fine with the series.  But it doesn't apply to my clk/imx branch.
Can you rebase and resend?

Shawn
