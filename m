Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F52C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97B720449
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfFUFjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 01:39:55 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47594 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725989AbfFUFjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 01:39:54 -0400
X-UUID: 37acaca11a7f47e8b645bf0aa6b4fec9-20190621
X-UUID: 37acaca11a7f47e8b645bf0aa6b4fec9-20190621
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2142318987; Fri, 21 Jun 2019 13:39:44 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Jun
 2019 13:39:41 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Jun 2019 13:39:39 +0800
Message-ID: <1561095579.32589.3.camel@mhfsdcap03>
Subject: Re: [PATCH 3/6] usb: bdc: driver may fail to get USB PHY
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Al Cooper <alcooperx@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Jun 2019 13:39:39 +0800
In-Reply-To: <1561064991-16874-4-git-send-email-alcooperx@gmail.com>
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
         <1561064991-16874-4-git-send-email-alcooperx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 43013DC376CE0C2D6BA9A2FFAED04B892277477DCD77C754F66B812CB2D1E7A02000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-20 at 17:09 -0400, Al Cooper wrote:
> Initialization order is important for the USB PHY and the PHY clients.
> The init order is based on the build order of the drivers in the
> makefiles and the PHY drivers are built early to help with
> dependencies, but the new SCMI based clock subsystem has the side
> effect of making some additional drivers DEFER until the clock
> is ready. This is causing the USB PHY driver to defer which is causing
> some PHY clients to fail when they try to get the PHY. The fix is to have
> the client driver return DEFER when it's "get phy" routine returns DEFER.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/usb/gadget/udc/bdc/bdc_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> index 11a43de6c1c6..c794890d785b 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -543,9 +543,13 @@ static int bdc_probe(struct platform_device *pdev)
>  			dev, dev->of_node, phy_num);
>  		if (IS_ERR(bdc->phys[phy_num])) {
>  			ret = PTR_ERR(bdc->phys[phy_num]);
> +			if (ret == -EPROBE_DEFER) {
> +				dev_dbg(bdc->dev, "DEFER, waiting for PHY\n");
why not disable clock here? when re-probe, will enable clock again.
to me, no need check -EPROBE_DEFFER.
> +				return ret;
> +			}

>  			dev_err(bdc->dev,
>  				"BDC phy specified but not found:%d\n", ret);
> -			return ret;
> +			goto clk_cleanup;
>  		}
>  	}
>  


