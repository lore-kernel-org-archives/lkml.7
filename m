Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C467BC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F59A20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfDQFxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:53:41 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24321 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbfDQFxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:53:40 -0400
X-UUID: 3899224390ce47519e2ce45abe2bc926-20190417
X-UUID: 3899224390ce47519e2ce45abe2bc926-20190417
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1593429824; Wed, 17 Apr 2019 13:53:33 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Apr
 2019 13:53:28 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 13:53:28 +0800
Message-ID: <1555480408.10179.202.camel@mhfsdcap03>
Subject: Re: [v2 PATCH 1/6] usb: xhci-mtk: get optional clock by
 devm_clk_get_optional()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 17 Apr 2019 13:53:28 +0800
In-Reply-To: <20190416101258.GA26091@kroah.com>
References: <bc6cdc2dce698dddbd692ba100fbf08c15c7b023.1554877692.git.chunfeng.yun@mediatek.com>
         <20190416101258.GA26091@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: B869C67EFBC31644559755DF4053266ADFB8265FFA9401318A6355018D3BCD072000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-16 at 12:12 +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 10, 2019 at 02:47:24PM +0800, Chunfeng Yun wrote:
> > Use devm_clk_get_optional() to get optional clock
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v2: no changes
> > ---
> >  drivers/usb/host/xhci-mtk.c | 19 +++----------------
> >  1 file changed, 3 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > index 60987c787e44..026fe18972d3 100644
> > --- a/drivers/usb/host/xhci-mtk.c
> > +++ b/drivers/usb/host/xhci-mtk.c
> > @@ -206,19 +206,6 @@ static int xhci_mtk_ssusb_config(struct xhci_hcd_mtk *mtk)
> >  	return xhci_mtk_host_enable(mtk);
> >  }
> >  
> > -/* ignore the error if the clock does not exist */
> > -static struct clk *optional_clk_get(struct device *dev, const char *id)
> > -{
> > -	struct clk *opt_clk;
> > -
> > -	opt_clk = devm_clk_get(dev, id);
> > -	/* ignore error number except EPROBE_DEFER */
> > -	if (IS_ERR(opt_clk) && (PTR_ERR(opt_clk) != -EPROBE_DEFER))
> 
> Are you sure about this?
> 
> devm_clk_get_optional() does not check for -EPROBE_DEFER, so you just
> changed the functionality of this code.  Is that ok?  
Yes, checking for -ENOENT covers more error cases than -EPROBE_DEFER,
and the original purpose also wants to ignore non-exist clock

> If so, please call
> it out explicitly in your changelog comment when you resend this.
I'll add it in next version

Thanks a lot

> 
> thanks,
> 
> greg k-h


