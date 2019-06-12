Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98805C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7C12086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406714AbfFLIq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:46:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29095 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726731AbfFLIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:46:59 -0400
X-UUID: faa316b07d844a8eaa6d6698e80ba31b-20190612
X-UUID: faa316b07d844a8eaa6d6698e80ba31b-20190612
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 658078462; Wed, 12 Jun 2019 16:46:47 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs07n1.mediatek.inc
 (172.21.101.16) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Jun
 2019 16:46:46 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 16:46:45 +0800
Message-ID: <1560329205.3255.17.camel@mhfsdcap03>
Subject: Re: [PATCH] mtu3: fix setup packet response for HNP and SRP request
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 12 Jun 2019 16:46:45 +0800
In-Reply-To: <1560320892-30551-1-git-send-email-macpaul.lin@mediatek.com>
References: <1560320892-30551-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Macpaul,

On Wed, 2019-06-12 at 14:28 +0800, Macpaul Lin wrote:
> 1. Add OTG_HNP_REQD and OTG_SRP_REQD definitions in ch9.h.
> 2. When OTG_HNP_REQD and OTG_SRP_REQD has been received,
> usb hardware must not enter TEST mode but need to response setup packet.
> 3. Add otg_srp_reqd and otg_hnp_reqd in struct ssusb_mtk for futher
> implementation.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/usb/mtu3/mtu3.h            |  4 ++++
>  drivers/usb/mtu3/mtu3_gadget_ep0.c | 13 +++++++++++++
>  include/uapi/linux/usb/ch9.h       |  5 +++++
>  3 files changed, 22 insertions(+)
The driver currently doesn't support HNP/SRP, so there will be something
wrong when connected with PET to run compliance test, and I prefer not
to support it, because it's rarely used in normal case, thanks

> 
> diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
> index 76ecf12fdf62..bb8a31bc6e4d 100644
> --- a/drivers/usb/mtu3/mtu3.h
> +++ b/drivers/usb/mtu3/mtu3.h
> @@ -226,6 +226,8 @@ struct otg_switch_mtk {
>   * @dma_clk: dma_bus_ck clock for AXI bus etc
>   * @dr_mode: works in which mode:
>   *		host only, device only or dual-role mode
> + * @otg_srp_reqd: used for SRP request handling.
> + * @otg_hnp_reqd: used for HNP request handling.
>   * @u2_ports: number of usb2.0 host ports
>   * @u3_ports: number of usb3.0 host ports
>   * @u3p_dis_msk: mask of disabling usb3 ports, for example, bit0==1 to
> @@ -252,6 +254,8 @@ struct ssusb_mtk {
>  	/* otg */
>  	struct otg_switch_mtk otg_switch;
>  	enum usb_dr_mode dr_mode;
> +	bool otg_srp_reqd;
> +	bool otg_hnp_reqd;
>  	bool is_host;
>  	int u2_ports;
>  	int u3_ports;
> diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> index 4da216c99726..1247c43a63e6 100644
> --- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> +++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> @@ -285,11 +285,24 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
>  		dev_dbg(mtu->dev, "TEST_PACKET\n");
>  		mtu->test_mode_nr = TEST_PACKET_MODE;
>  		break;
> +	case OTG_SRP_REQD:
> +		dev_dbg(mtu->dev, "OTG_SRP_REQD\n");
> +		mtu->ssusb->otg_srp_reqd = 1;
> +		break;
> +	case OTG_HNP_REQD:
> +		dev_dbg(mtu->dev, "OTG_HNP_REQD\n");
> +		mtu->ssusb->otg_hnp_reqd = 1;
> +		break;
>  	default:
>  		handled = -EINVAL;
>  		goto out;
>  	}
>  
> +	if (mtu->ssusb->otg_srp_reqd || mtu->ssusb->otg_hnp_reqd) {
> +		mtu->ep0_state = MU3D_EP0_STATE_SETUP;
> +		goto out;
> +	}
> +
>  	mtu->test_mode = true;
>  
>  	/* no TX completion interrupt, and need restart platform after test */
> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
> index d5a5caec8fbc..545918c83fd1 100644
> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -143,6 +143,11 @@
>  #define	TEST_SE0_NAK	3
>  #define	TEST_PACKET	4
>  #define	TEST_FORCE_EN	5
> +/*
> + * OTG HNP and SRP REQD
> + */
> +#define	OTG_SRP_REQD	6
> +#define	OTG_HNP_REQD	7
>  
>  /* Status Type */
>  #define USB_STATUS_TYPE_STANDARD	0


