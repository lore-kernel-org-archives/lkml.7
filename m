Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDEBC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9432084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfFTITV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:19:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:50876 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfFTITV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:19:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 01:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="150860357"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2019 01:19:17 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: dwc3: remove unused @lock member of dwc3_ep struct
In-Reply-To: <342af01a252a9ef9457a6a6ec653a40698058fbc.1561018149.git.chunfeng.yun@mediatek.com>
References: <342af01a252a9ef9457a6a6ec653a40698058fbc.1561018149.git.chunfeng.yun@mediatek.com>
Date:   Thu, 20 Jun 2019 11:19:16 +0300
Message-ID: <87pnn8brej.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:

> The member @lock of dwc2_ep struct is only initialized,
> and not used elsewhere, so remove it.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/dwc3/core.h   | 2 --
>  drivers/usb/dwc3/gadget.c | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index f19cbeb01087..72d28cb14bdf 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -649,7 +649,6 @@ struct dwc3_event_buffer {
>   * @cancelled_list: list of cancelled requests for this endpoint
>   * @pending_list: list of pending requests for this endpoint
>   * @started_list: list of started requests on this endpoint
> - * @lock: spinlock for endpoint request queue traversal
>   * @regs: pointer to first endpoint register
>   * @trb_pool: array of transaction buffers
>   * @trb_pool_dma: dma address of @trb_pool
> @@ -677,7 +676,6 @@ struct dwc3_ep {
>  	struct list_head	pending_list;
>  	struct list_head	started_list;
>  
> -	spinlock_t		lock;
>  	void __iomem		*regs;
>  
>  	struct dwc3_trb		*trb_pool;
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index d67655384eb2..7f75da30caba 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2251,8 +2251,6 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
>  		dep->endpoint.comp_desc = NULL;
>  	}
>  
> -	spin_lock_init(&dep->lock);

heh, thanks. This is left-over from when I playing with further
paralelizing the driver. Turned out that there are not enough gains to
justify that work. I'll apply this patch.

-- 
balbi
