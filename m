Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13DEC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F8421927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931476;
	bh=MqV2wpDomJRKYrDCq3ihcJ863yZKr1gH+8fHVxZCNBE=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=Gr6/C6S4210rGaNNoK+H131DlhwjzMGCY9CZPhbv4I+cwqDgqpOVn+6yzRtdyRTcU
	 99yJAiy3y5KX2U9le9ToPtL+KWv5g9U+zEvZNJpwIKnQbTKzcGqtro/1tmQy0ayqoK
	 gRZ3nZCto9xBHgvoriS4NKizChQhaRmXafG9Otwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392504AbfISWRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406541AbfISWRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:17:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853A921907;
        Thu, 19 Sep 2019 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931470;
        bh=MqV2wpDomJRKYrDCq3ihcJ863yZKr1gH+8fHVxZCNBE=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=P3fsiJZVHmtqiJdkY+1llOwtbQQ7EKFaNVYdlAiGSgTLv3Yg65XWGVFtjIThaYj2D
         tT3cu1RI5vDhhjBCrSdblPBhae4yl1S2ggg6+I3qPzRgc8A0kw4WFQg8YH1K+ghTe6
         7Tpdo8rM3QvFyqJtE+0xGFBCNXbdnzzhgtEY5TFk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190919030912.16957-2-chen.fang@nxp.com>
References: <20190919030912.16957-1-chen.fang@nxp.com> <20190919030912.16957-2-chen.fang@nxp.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fancy Fang <chen.fang@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk: imx7ulp: remove IMX7ULP_CLK_MIPI_PLL clock
User-Agent: alot/0.8.1
Date:   Thu, 19 Sep 2019 15:17:49 -0700
Message-Id: <20190919221750.853A921907@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fancy Fang (2019-09-18 20:10:48)
> diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindi=
ngs/clock/imx7ulp-clock.h
> index 6f66f9005c81..a39b0c40cb41 100644
> --- a/include/dt-bindings/clock/imx7ulp-clock.h
> +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> @@ -49,7 +49,6 @@
>  #define IMX7ULP_CLK_NIC1_DIV           36
>  #define IMX7ULP_CLK_NIC1_BUS_DIV       37
>  #define IMX7ULP_CLK_NIC1_EXT_DIV       38
> -#define IMX7ULP_CLK_MIPI_PLL           39

You can't remove this. Just add a comment like /* unused */ or
something to indicate this shouldn't be used.

>  #define IMX7ULP_CLK_SIRC               40
>  #define IMX7ULP_CLK_SOSC_BUS_CLK       41
>  #define IMX7ULP_CLK_FIRC_BUS_CLK       42
> --=20
> 2.17.1
>=20
