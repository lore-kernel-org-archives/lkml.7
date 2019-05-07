Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0910C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A5120989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfEGHhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:37:37 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:18790 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726175AbfEGHhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:37:37 -0400
X-UUID: 30d28f96dd634158bdf39ddcf422b952-20190507
X-UUID: 30d28f96dd634158bdf39ddcf422b952-20190507
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1598305782; Tue, 07 May 2019 15:37:29 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 7 May
 2019 15:37:25 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 7 May 2019 15:37:24 +0800
Message-ID: <1557214644.10179.266.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] usb: xhci-mtk: Do not create shared_hcd if no USB
 3.0 port available
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Hoan Tran <hoan@os.amperecomputing.com>
Date:   Tue, 7 May 2019 15:37:24 +0800
In-Reply-To: <20190502045631.229386-2-drinkcat@chromium.org>
References: <20190502045631.229386-1-drinkcat@chromium.org>
         <20190502045631.229386-2-drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: F29A5653419344021C7CCE1ECFF7F5112A40D61367D92EF03386E42FBB22C6DA2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,
On Thu, 2019-05-02 at 12:56 +0800, Nicolas Boichat wrote:
> When the controller only supports USB 2.0, do not even create the
> USB 3.0 hcd/root hub.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  drivers/usb/host/xhci-mtk.c | 44 +++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 026fe18972d3e5b..189f5dc614e6e05 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -527,23 +527,28 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>  	xhci->imod_interval = 5000;
>  	device_property_read_u32(dev, "imod-interval-ns", &xhci->imod_interval);
>  
> -	xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
> +	/* Only create shared_hcd when USB3.0 port is available. */
> +	if (xhci->usb3_rhub.num_ports > 0) {
xhci->usb3_rhub.num_ports is not set until usb_add_hcd() is called.

> +		xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
>  			dev_name(dev), hcd);
> -	if (!xhci->shared_hcd) {
> -		ret = -ENOMEM;
> -		goto disable_device_wakeup;
> +		if (!xhci->shared_hcd) {
> +			ret = -ENOMEM;
> +			goto disable_device_wakeup;
> +		}
>  	}
>  
>  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (ret)
>  		goto put_usb3_hcd;
>  
> -	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> -		xhci->shared_hcd->can_do_streams = 1;
> +	if (xhci->usb3_rhub.num_ports > 0) {
> +		if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> +			xhci->shared_hcd->can_do_streams = 1;
>  
> -	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> -	if (ret)
> -		goto dealloc_usb2_hcd;
> +		ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> +		if (ret)
> +			goto dealloc_usb2_hcd;
> +	}
>  
>  	return 0;
>  
> @@ -552,7 +557,8 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>  
>  put_usb3_hcd:
>  	xhci_mtk_sch_exit(mtk);
> -	usb_put_hcd(xhci->shared_hcd);
> +	if (xhci->shared_hcd)
> +		usb_put_hcd(xhci->shared_hcd);
>  
>  disable_device_wakeup:
>  	device_init_wakeup(dev, false);
> @@ -579,12 +585,14 @@ static int xhci_mtk_remove(struct platform_device *dev)
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>  	struct usb_hcd  *shared_hcd = xhci->shared_hcd;
>  
> -	usb_remove_hcd(shared_hcd);
> +	if (shared_hcd)
> +		usb_remove_hcd(shared_hcd);
>  	xhci->shared_hcd = NULL;
>  	device_init_wakeup(&dev->dev, false);
>  
>  	usb_remove_hcd(hcd);
> -	usb_put_hcd(shared_hcd);
> +	if (shared_hcd)
> +		usb_put_hcd(shared_hcd);
>  	usb_put_hcd(hcd);
>  	xhci_mtk_sch_exit(mtk);
>  	xhci_mtk_clks_disable(mtk);
> @@ -611,8 +619,10 @@ static int __maybe_unused xhci_mtk_suspend(struct device *dev)
>  	xhci_dbg(xhci, "%s: stop port polling\n", __func__);
>  	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
>  	del_timer_sync(&hcd->rh_timer);
> -	clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
> -	del_timer_sync(&xhci->shared_hcd->rh_timer);
> +	if (xhci->shared_hcd) {
> +		clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
> +		del_timer_sync(&xhci->shared_hcd->rh_timer);
> +	}
>  
>  	xhci_mtk_host_disable(mtk);
>  	xhci_mtk_clks_disable(mtk);
> @@ -631,8 +641,10 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
>  	xhci_mtk_host_enable(mtk);
>  
>  	xhci_dbg(xhci, "%s: restart port polling\n", __func__);
> -	set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
> -	usb_hcd_poll_rh_status(xhci->shared_hcd);
> +	if (xhci->shared_hcd) {
> +		set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
> +		usb_hcd_poll_rh_status(xhci->shared_hcd);
> +	}
>  	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
>  	usb_hcd_poll_rh_status(hcd);
>  	return 0;


