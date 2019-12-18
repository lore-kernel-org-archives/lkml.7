Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9134DC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6378224650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="Xg93ZJD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLRMVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:21:53 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:64698 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:21:53 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 07:21:51 EST
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 003D53F4E2;
        Wed, 18 Dec 2019 13:16:10 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=Xg93ZJD1;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=flawful.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S8UUBs6IQdRp; Wed, 18 Dec 2019 13:16:09 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id DD3363F3BA;
        Wed, 18 Dec 2019 13:16:08 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id E3946E50; Wed, 18 Dec 2019 13:16:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1576671368; bh=tDgQ8Hd7X2DMLFKWDPV38ouTSnh9qudUss4S+7QTdhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xg93ZJD1Xo4idJjy5M2BapnXGYA2U/a5Ejjo3qQjPm/B97aFFjq/73mWy1iGtyuhN
         NGNIe8OkbS2NvfLHbteFPSdHYcNxK/2MR+kxTunx7t89lmQfQ2NwujCZ264jx6cfRV
         +fkGbppgVjYEqm3txWXU+N5tk+nkzxFZCJ3cKtL4=
Date:   Wed, 18 Dec 2019 13:16:07 +0100
From:   Niklas Cassel <nks@flawful.org>
To:     sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, niklas.cassel@linaro.org
Subject: Re: [PATCH v3 0/7] Clock changes to support cpufreq on QCS404
Message-ID: <20191218121607.djwnxkrsgpdcf5k3@flawful.org>
References: <20191125135910.679310-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125135910.679310-1-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 02:59:02PM +0100, Niklas Cassel wrote:
> The following clock changes are required to enable cpufreq support on
> the QCS404.
> 
> Changes since v2:
> -Addressed Stephen Boyd's comment regarding apcs-msm8916
> should use new way of specifying clock parents.
> -DT binding now has "pll" as first clock, in order to
> not break DT backwards compatibility (in case no clock-names
> are given).
> -Moved EPROBE_DEFER error handling to its own patch.
> 
> Jorge Ramirez-Ortiz (6):
>   dt-bindings: mailbox: qcom: Add clock-name optional property
>   clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
>   clk: qcom: hfpll: register as clock provider
>   clk: qcom: hfpll: CLK_IGNORE_UNUSED
>   clk: qcom: hfpll: use clk_parent_data to specify the parent
>   clk: qcom: apcs-msm8916: silently error out on EPROBE_DEFER
> 
> Niklas Cassel (1):
>   clk: qcom: apcs-msm8916: use clk_parent_data to specify the parent
> 
>  .../mailbox/qcom,apcs-kpss-global.txt         | 24 ++++++++++++++---
>  drivers/clk/qcom/apcs-msm8916.c               | 26 ++++++++++++++-----
>  drivers/clk/qcom/clk-alpha-pll.c              |  8 ++++++
>  drivers/clk/qcom/clk-alpha-pll.h              |  1 +
>  drivers/clk/qcom/gcc-qcs404.c                 |  2 +-
>  drivers/clk/qcom/hfpll.c                      | 21 +++++++++++++--
>  6 files changed, 70 insertions(+), 12 deletions(-)
> 
> -- 
> 2.23.0
> 

Hello Stephen,

I have adressed your review comments
on the previous patch series version.

Could you please have a look?

If it looks good, could you please
consider taking them via your tree?

Kind regards,
Niklas
