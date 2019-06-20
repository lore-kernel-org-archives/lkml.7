Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A83C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAB52084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfFTIYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:24:09 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25351 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725875AbfFTIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:24:08 -0400
X-UUID: 08f55a0eb60b4e66b6d932667d67b14c-20190620
X-UUID: 08f55a0eb60b4e66b6d932667d67b14c-20190620
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1696634026; Thu, 20 Jun 2019 16:24:02 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 20 Jun
 2019 16:24:00 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 20 Jun 2019 16:23:59 +0800
Message-ID: <1561019039.19385.0.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: dwc3: remove unused @lock member of dwc3_ep struct
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 20 Jun 2019 16:23:59 +0800
In-Reply-To: <87pnn8brej.fsf@linux.intel.com>
References: <342af01a252a9ef9457a6a6ec653a40698058fbc.1561018149.git.chunfeng.yun@mediatek.com>
         <87pnn8brej.fsf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 01A5D843B4FDBFD9D544853B9237509789D7821AEC7631073D22747FFC6924A62000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, 2019-06-20 at 11:19 +0300, Felipe Balbi wrote:
> Hi,
> 
> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> 
> > The member @lock of dwc2_ep struct is only initialized,
> > and not used elsewhere, so remove it.
Sorry, I need send v2 to fix typo of dwc2_ep

> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/dwc3/core.h   | 2 --
> >  drivers/usb/dwc3/gadget.c | 2 --
> >  2 files changed, 4 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index f19cbeb01087..72d28cb14bdf 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -649,7 +649,6 @@ struct dwc3_event_buffer {
> >   * @cancelled_list: list of cancelled requests for this endpoint
> >   * @pending_list: list of pending requests for this endpoint
> >   * @started_list: list of started requests on this endpoint
> > - * @lock: spinlock for endpoint request queue traversal
> >   * @regs: pointer to first endpoint register
> >   * @trb_pool: array of transaction buffers
> >   * @trb_pool_dma: dma address of @trb_pool
> > @@ -677,7 +676,6 @@ struct dwc3_ep {
> >  	struct list_head	pending_list;
> >  	struct list_head	started_list;
> >  
> > -	spinlock_t		lock;
> >  	void __iomem		*regs;
> >  
> >  	struct dwc3_trb		*trb_pool;
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index d67655384eb2..7f75da30caba 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2251,8 +2251,6 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
> >  		dep->endpoint.comp_desc = NULL;
> >  	}
> >  
> > -	spin_lock_init(&dep->lock);
> 
> heh, thanks. This is left-over from when I playing with further
> paralelizing the driver. Turned out that there are not enough gains to
> justify that work. I'll apply this patch.
> 


