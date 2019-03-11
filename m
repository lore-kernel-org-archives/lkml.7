Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C51C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0250D2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552329341;
	bh=AulZLFCPGa/BCuPCi7dORdg9DSyBtpi0oEztYXKG/zM=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=FgYFwj5fLbhcV/jmg0SZQqJMhOXp+XPLbeBnHLMJ7xOkjHmkAB2viJlOt0+2jEfH3
	 H1zghvk8I48GZR4CWGoFRXkImQyJ3t27H1TEkdfgB2Y+TOyTJuMCG5DmxwA05CO0tG
	 ic7QHwDMc+qbwtgMr2DuziTQiJolJFmb0WeUlCfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCKSfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfCKSfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:35:38 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D18D20657;
        Mon, 11 Mar 2019 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552329337;
        bh=AulZLFCPGa/BCuPCi7dORdg9DSyBtpi0oEztYXKG/zM=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=oFTsrgeIdKJDn/B3+VGKpuTxbbhn3Ao6L/n/w0kuUnC376XAYTVNcc44Le6OnFKrS
         w+th9V66nU4wIXNrOTUteTPa5r7HweTKuG/QQEZYwUbQ5l98DDAF5AKpgD2b+oymjR
         HKkSH7xEG+66IzpeCszl7XWrInc9x+MXGKvFAJq0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1552319997-24622-2-git-send-email-eric@nelint.com>
References: <1552304271.2453.12.camel@pengutronix.de> <1552319997-24622-1-git-send-email-eric@nelint.com> <1552319997-24622-2-git-send-email-eric@nelint.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [V2 1/2] clk: imx6q: remove unsupported pll4_audio_div
Cc:     anson.huang@nxp.com, colin.didier@devialet.com, festevam@gmail.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tiny.windzz@gmail.com,
        Eric Nelson <eric@nelint.com>
To:     Eric Nelson <eric@nelint.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Message-ID: <155232933665.20095.16726298881697876719@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 11 Mar 2019 11:35:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric Nelson (2019-03-11 08:59:56)
> diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindi=
ngs/clock/imx6qdl-clock.h
> index b3cef29..34bb14d 100644
> --- a/include/dt-bindings/clock/imx6qdl-clock.h
> +++ b/include/dt-bindings/clock/imx6qdl-clock.h
> @@ -213,7 +213,15 @@
>  #define IMX6QDL_CLK_CKO2                       200
>  #define IMX6QDL_CLK_CKO                                201
>  #define IMX6QDL_CLK_VDOA                       202
> -#define IMX6QDL_CLK_PLL4_AUDIO_DIV             203
> +
> +/* The PLL4_AUDIO_DIV divider only appeared in
> + * early versions of the reference manual.
> + *
> + * Renamed to _BROKEN to prevent inadvertent use,
> + * but reserved the array slot to maintain DT binary
> + * compatibility.
> + */
> +#define IMX6QDL_CLK_PLL4_AUDIO_DIV_BROKEN      203

But it breaks the build. I don't get it. Just add a comment indicating
it shouldn't be used? That breaks the cross-tree dependency chain and
lets clk tree merge the clk driver part and arm-soc merge the dts part.

