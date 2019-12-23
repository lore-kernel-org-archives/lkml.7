Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AA3C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3852073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577073111;
	bh=bNHYhWnRLyUJqAMGEzrDslyGkK0A/ZfjsusSFKmfCQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0lrjnu7ehz0fSJHzPZYjihDLaIuJpxlLelKgcIoZ/5qL6yJOaiqTyzaoo6Fs+19AH
	 krTzSLqJtkK504PrvAzrIuy5TM8rZz0GeDc7ZbNBmoZS5dsmTm6L/coMLYsZ3d/6sa
	 LLmHmHHwXT0efoM5mnth7qsTq+dmydi883IZfaBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLWDvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 22:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfLWDvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 22:51:50 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F5620709;
        Mon, 23 Dec 2019 03:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577073109;
        bh=bNHYhWnRLyUJqAMGEzrDslyGkK0A/ZfjsusSFKmfCQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qaw0+09Qtj/xcd7pQeSKWf3SgRNGvExU2Qg0W1DxpGjudXqZwR9poa5juZVyQxk5S
         pF/GUWYQgKjLhnN/C8RvBhtDLXOvQgOqdPl1e8vfG5V+kxxElW3yMQSvhDzaZuBEY/
         jIsL4jeOMc11fsCHGMWq16GFFhnNNkBmub/4YFv4=
Date:   Mon, 23 Dec 2019 11:51:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH V2 0/9] clk: imx8m: switch to clk_hw based API
Message-ID: <20191223035122.GI11523@dragon>
References: <1576119353-26679-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576119353-26679-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 02:58:38AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This covers v1 https://patchwork.kernel.org/cover/11217881/ and
> v3 https://patchwork.kernel.org/cover/11251585/
> 
> V2:
> Per Leonard's comments, use to_clk helpers
> Add Abel's R-b tag
> Rebased on Shawn's next branch
> 
> This patchset is to convert i.MX8M clk driver to clk_hw based API,
> and add clk_hw helpers that will be used by i.MX8M clk driver.
> 
> Peng Fan (9):
>   clk: imx: clk-pll14xx: Switch to clk_hw based API
>   clk: imx: clk-composite-8m: Switch to clk_hw based API
>   clk: imx: add imx_unregister_hw_clocks
>   clk: imx: add hw API imx_clk_hw_mux2_flags
>   clk: imx: gate3: Switch to clk_hw based API
>   clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API
>   clk: imx: imx8mn: Switch to clk_hw based API
>   clk: imx: imx8mm: Switch to clk_hw based API
>   clk: imx: imx8mq: Switch to clk_hw based API

Applied all, thanks.
