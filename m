Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E65C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B8320717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556229801;
	bh=X6P0ll6xAtfb4TWEgEkXhjdpRYhQGLDx1tNNW+aGWJY=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=XYf8mz71bla7EBe8307YzE1O54EMOVxi/dYd14erTs5cfKtdZzz2aXeAjT3s9LmSv
	 3hWBCijcrPRyDN8Dg7YyG2Vqc/Inf+bG7xUzBBvTo4w6V/34EBf/D/CtXE4ZTkMWBv
	 evrwM0vqay2r7T8vB6Bw4Kp5U5JUxaHEsTWkmRH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfDYWDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbfDYWDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:03:20 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19EB206C1;
        Thu, 25 Apr 2019 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556229799;
        bh=X6P0ll6xAtfb4TWEgEkXhjdpRYhQGLDx1tNNW+aGWJY=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=L+p72NvP52PaOP+px2bOL6vkmozGHbVxQTq0Ju3cZDlr6W9mg4Lp9GelwKRAD0XGK
         UpfV/imEp3Gkz9nvaq5h9vDEeXRxk3WYFH+WaWdgKsTnsJTH1MlYhxTxO3s2MUa5mi
         M1RMAnCLJl4qXTXq3cQGhyTJtgtwHFMqwb4LlxKg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1555921647-21931-1-git-send-email-Anson.Huang@nxp.com>
References: <1555921647-21931-1-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: imx: correct i.MX7D AV PLL num/denom offset
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Message-ID: <155622979855.15276.5762308594961916461@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 15:03:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-04-22 01:32:45)
> According reference manual, i.MX7D's audio/video PLL's
> num/denom register offset are 0x20/0x30, they are different
> from i.MX6's audio/video PLL, correct it by introducing new
> offset variables for audio/video PLL and using runtime
> assignment based on PLL type.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Is there any way you can send plain-text emails instead of base64
encoded emails? I had to get this email properly decoded in plain text
so that it would apply correctly. I think it's an Outlook problem.

Anyway, applied to clk-next

