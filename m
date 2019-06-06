Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDDFC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC28520868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559838345;
	bh=qyHzBivnLPb/+lw9r58rXcindZmclzeck6Tk1ntbfR8=;
	h=In-Reply-To:References:To:Subject:From:Cc:Date:List-ID:From;
	b=z7L5qOMG7DEVAYKlQpuW8jbJ6S72jiJeRMGkEkuUqsQuSMSw8Z+In1nB7U8LtMaGG
	 95nLoUX7MqpWTUP8+S6WFzKJqstl4HVvVeAVs9Afd9WbZkhe/VdlWUGa3I6JwsKDEG
	 KEGmGotfXmO39Gh0/Yl7B4q4pP7RVAGp1Vue4Vck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfFFQZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfFFQZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:25:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFB820645;
        Thu,  6 Jun 2019 16:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559838344;
        bh=qyHzBivnLPb/+lw9r58rXcindZmclzeck6Tk1ntbfR8=;
        h=In-Reply-To:References:To:Subject:From:Cc:Date:From;
        b=deawRK9bcY7UvS2ygyKhywdOffS+3brvmGlW2SlvDOHttQaf7wnof7uHccsjyeatp
         Gk+k7lIjZO8FcpKii4zkyaj9wtgTtS0DEFR6HxkE0Sl0EEtPsCFgBCE3fKFcuFywAc
         6D0cV/u/qkgXNd/su348kRgsPNygN/kkrBCFUkhE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190604015928.23157-3-Anson.Huang@nxp.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com> <20190604015928.23157-3-Anson.Huang@nxp.com>
To:     Anson.Huang@nxp.com, abel.vesa@nxp.com, aisheng.dong@nxp.com,
        bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        enric.balletbo@collabora.com, festevam@gmail.com,
        horms+renesas@verge.net.au, jagan@amarulasolutions.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        mturquette@baylibre.com, olof@lixom.net, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        will.deacon@arm.com
Subject: Re: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 09:25:43 -0700
Message-Id: <20190606162543.EFFB820645@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson.Huang@nxp.com (2019-06-03 18:59:27)
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> This patch adds i.MX8MN clock driver support.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
>         - use platform driver model for this clock driver;

Can you also use platform device APIs like platform_*(),
devm_ioremap_resource() and devmified clk registration?

