Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E33CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D2F20867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572094023;
	bh=hGFDC4Nu8mbTB5zbF13Hz1VJ3ZgMHdiimoh7+B06Fkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZDic8h2yuIJE0MMSce9eOewOmEEN75Z67eOObX37pk/6AnnY/AlKnA44TOHILUjTH
	 xbfaZfCcjKkGNsUM5ucWCTqWcpeUGUBEj8o8SEidtIr8UJiBaWPQlctSRhAfaHRpx2
	 ++T8T1911/qPKoFtHYED5os8xlL2Jzlnldd9Q9CE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfJZMrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 08:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJZMrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:47:02 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7530720863;
        Sat, 26 Oct 2019 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572094021;
        bh=hGFDC4Nu8mbTB5zbF13Hz1VJ3ZgMHdiimoh7+B06Fkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faqk2H8OyAPDbhMgrOIef/qosCn6G18hGs9dRZbQDMnHaHCQcGawXcAq2tvKFQI31
         UBdngput/xCOoju/croNMmv6kB2sKImcU0To3TY1wePGavyai4npTIhwNKTnuTmKIq
         D3nVEjQL8iZ/1FpbqJkQIUAy+Rku/gXNFM4o1w6c=
Date:   Sat, 26 Oct 2019 20:46:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM64: dts: imx8mm-evk: Assigned clocks for audio plls
Message-ID: <20191026124639.GN14401@dragon>
References: <20191016103513.13088-1-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016103513.13088-1-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:36:05AM +0000, S.j. Wang wrote:
> Assign clocks and clock-rates for audio plls, that audio
> drivers can utilize them.
> 
> Add dai-tdm-slot-num and dai-tdm-slot-width for sound-wm8524,
> that sai driver can generate correct bit clock.
> 
> Fixes: 13f3b9fdef6c ("arm64: dts: imx8mm-evk: Enable audio codec wm8524")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

As a practise, we use prefix 'ARM: ...' for arch/arm/ and 'arm64: ...'
for arch/arm64/ patches.

I fixed up the prefix and applied the patch.

Shawn
