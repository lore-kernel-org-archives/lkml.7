Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54663C47404
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACDF222C8
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570328224;
	bh=08IWgsYtfYEQoxuJKerHwdwPvgltMNLMDmtbgmWVK1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ezV4mvSqhHayAZZ/fQDP6lhXtHALekfQFlOrJBuS7pObsBu3zqBA8FMUxGPWZh37Y
	 K7w4EhK4IMAvLf/qun2oqyBap64Ic7sYSXF/B5QZ+IKMmrLY8UKlr2vN/kRob8QZ1Q
	 ZfYx1TDJklEzDkcgNCb8GBizB9s7MzwzAXfwbcoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfJFCRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 22:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfJFCRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 22:17:02 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3727222C5;
        Sun,  6 Oct 2019 02:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570328222;
        bh=08IWgsYtfYEQoxuJKerHwdwPvgltMNLMDmtbgmWVK1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPpRYsJjzqd4LI8VNtqPHCqhhWF0MhM+wSbYfyvzxudK2sz+pwQsuZGizutKVDKHy
         BBbis6GY9iz7IWs6e79EW3rfUP4pEy6Lh5jkw7Nnk9YJk6Y78+v4EgseYblCQA6QH0
         aEJmeXKgO77mBDEu9gTLIif5z0Ar0WZrTAQfuNsQ=
Date:   Sun, 6 Oct 2019 10:16:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
        chen.fang@nxp.com, shengjiu.wang@nxp.com, aisheng.dong@nxp.com,
        sfr@canb.auug.org.au, l.stach@pengutronix.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] clk: imx8mm: Move 1443X/1416X PLL clock structure
 to common place
Message-ID: <20191006021632.GM7150@dragon>
References: <1567776846-6373-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567776846-6373-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 09:34:05AM -0400, Anson Huang wrote:
> Many i.MX8M SoCs use same 1443X/1416X PLL, such as i.MX8MM,
> i.MX8MN and later i.MX8M SoCs, moving these PLL definitions
> to pll14xx driver can save a lot of duplicated code on each
> platform.
> 
> Meanwhile, no need to define PLL clock structure for every
> module which uses same type of PLL, e.g., audio/video/dram use
> 1443X PLL, arm/gpu/vpu/sys use 1416X PLL, define 2 PLL clock
> structure for each group is enough.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
