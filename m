Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FE9C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0CA21897
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566671490;
	bh=DmSHzsJoUz62nz9KFHCqYK6dgiAFue8c2ZDdH9pdfK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q5FPxQiMRIF56EmGwrbA24jyrREYO3ntA1RGIHSxdrUfZfY2qSGjazgxB+TIZ6li5
	 nboSoJclnaQUm1QyUkEGe5THoPpr7MjM1QfCYgwfzn/xgUBJ3X8ZVeijXNDnRbbDhH
	 PQuW8kAsUFoviVKffXfAeewy+vpPJeHpBoTs0t1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfHXSbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 14:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfHXSbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:31:22 -0400
Received: from X250 (cm-84.211.118.175.getinternet.no [84.211.118.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E42B21897;
        Sat, 24 Aug 2019 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566671481;
        bh=DmSHzsJoUz62nz9KFHCqYK6dgiAFue8c2ZDdH9pdfK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2QXTWCICjZPv5ZEEjocTVjyM1eAuZZ3ftM80JvvuhT4NKVpk5Jg22a5w8p1+0DDh
         JOznZRvPQ6/xi4yZUjy/WzTPwV1ALtOQP+3r75xC7IncNppOtnZ5fdQL+xtpea0Sz1
         ZdMtyV0YApmDfm/u7EXdgNGBZkX1LECVOlTh6iUQ=
Date:   Sat, 24 Aug 2019 20:31:09 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH] ARM: imx: Drop imx_anatop_init()
Message-ID: <20190824183108.GA14936@X250>
References: <20190731180131.8597-1-andrew.smirnov@gmail.com>
 <VI1PR04MB7023AE3910B261877892EEABEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB7023AE3910B261877892EEABEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 05:33:13PM +0000, Leonard Crestez wrote:
> On 31.07.2019 21:01, Andrey Smirnov wrote:
> > With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger
> > detect in mxs_phy_hw_init()") in tree all of the necessary charger
> > setup is done by the USB PHY driver which covers all of the affected
> > i.MX6 SoCs.
> > 
> > NOTE: Imx_anatop_init() was also called for i.MX7D, but looking at its
> > datasheet it appears to have a different USB PHY IP block, so
> > executing i.MX6 charger disable configuration seems unnecessary.
> > 
> > -void __init imx_anatop_init(void)
> > -{
> > -	anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
> > -	if (IS_ERR(anatop)) {
> > -		pr_err("%s: failed to find imx6q-anatop regmap!\n", __func__);
> > -		return;
> > -	}
> 
> This patch breaks suspend on imx6 in linux-next because the "anatop" 
> regmap is no longer initialized. This was found via bisect but 
> no_console_suspend prints a helpful stack anyway:
> 
> (regmap_read) from [<c01226e4>] (imx_anatop_enable_weak2p5+0x28/0x70)
> (imx_anatop_enable_weak2p5) from [<c0122744>] 
> (imx_anatop_pre_suspend+0x18/0x64)
> (imx_anatop_pre_suspend) from [<c0124434>] (imx6q_pm_enter+0x60/0x16c)
> (imx6q_pm_enter) from [<c018c8a4>] (suspend_devices_and_enter+0x7d4/0xcbc)
> (suspend_devices_and_enter) from [<c018d544>] (pm_suspend+0x7b8/0x904)
> (pm_suspend) from [<c018b1b4>] (state_store+0x68/0xc8)

I dropped it from my branch for now.  Thanks for reporting!

Shawn
