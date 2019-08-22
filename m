Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC7EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9012B233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbfHVOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:43:05 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:52232 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388564AbfHVOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:43:02 -0400
Received: (qmail 1313 invoked by uid 2102); 22 Aug 2019 10:43:01 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Aug 2019 10:43:01 -0400
Date:   Thu, 22 Aug 2019 10:43:01 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Roger Quadros <rogerq@ti.com>
cc:     balbi@kernel.org, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: udc: core: Fix segfault if udc_bind_to_driver()
 for pending driver fails
In-Reply-To: <20190822134028.2623-1-rogerq@ti.com>
Message-ID: <Pine.LNX.4.44L0.1908221042440.1311-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019, Roger Quadros wrote:

> If a gadget driver is in the pending drivers list, a UDC
> becomes available and udc_bind_to_driver() fails, then it
> gets deleted from the pending list.
> i.e. list_del(&driver->pending) in check_pending_gadget_drivers().
> 
> Then if that gadget driver is unregistered,
> usb_gadget_unregister_driver() does a list_del(&driver->pending)
> again thus causing a page fault as that list entry has been poisoned
> by the previous list_del().
> 
> Fix this by using list_del_init() instead of list_del() in
> check_pending_gadget_drivers().
> 
> Test case:
> 
> - Make sure no UDC is available
> - modprobe g_mass_storage file=wrongfile
> - Load UDC driver so it becomes available
> 	lun0: unable to open backing file: wrongfile
> - modprobe -r g_mass_storage
> 
> [   60.900431] Unable to handle kernel paging request at virtual address dead000000000108
> [   60.908346] Mem abort info:
> [   60.911145]   ESR = 0x96000044
> [   60.914227]   Exception class = DABT (current EL), IL = 32 bits
> [   60.920162]   SET = 0, FnV = 0
> [   60.923217]   EA = 0, S1PTW = 0
> [   60.926354] Data abort info:
> [   60.929228]   ISV = 0, ISS = 0x00000044
> [   60.933058]   CM = 0, WnR = 1
> [   60.936011] [dead000000000108] address between user and kernel address ranges
> [   60.943136] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> [   60.948691] Modules linked in: g_mass_storage(-) usb_f_mass_storage libcomposite xhci_plat_hcd xhci_hcd usbcore ti_am335x_adc kfifo_buf omap_rng cdns3 rng_core udc_core crc32_ce xfrm_user crct10dif_ce snd_so6
> [   60.993995] Process modprobe (pid: 834, stack limit = 0x00000000c2aebc69)
> [   61.000765] CPU: 0 PID: 834 Comm: modprobe Not tainted 4.19.59-01963-g065f42a60499 #92
> [   61.008658] Hardware name: Texas Instruments SoC (DT)
> [   61.014472] pstate: 60000005 (nZCv daif -PAN -UAO)
> [   61.019253] pc : usb_gadget_unregister_driver+0x7c/0x108 [udc_core]
> [   61.025503] lr : usb_gadget_unregister_driver+0x30/0x108 [udc_core]
> [   61.031750] sp : ffff00001338fda0
> [   61.035049] x29: ffff00001338fda0 x28: ffff800846d40000
> [   61.040346] x27: 0000000000000000 x26: 0000000000000000
> [   61.045642] x25: 0000000056000000 x24: 0000000000000800
> [   61.050938] x23: ffff000008d7b0d0 x22: ffff0000088b07c8
> [   61.056234] x21: ffff000001100000 x20: ffff000002020260
> [   61.061530] x19: ffff0000010ffd28 x18: 0000000000000000
> [   61.066825] x17: 0000000000000000 x16: 0000000000000000
> [   61.072121] x15: 0000000000000000 x14: 0000000000000000
> [   61.077417] x13: ffff000000000000 x12: ffffffffffffffff
> [   61.082712] x11: 0000000000000030 x10: 7f7f7f7f7f7f7f7f
> [   61.088008] x9 : fefefefefefefeff x8 : 0000000000000000
> [   61.093304] x7 : ffffffffffffffff x6 : 000000000000ffff
> [   61.098599] x5 : 8080000000000000 x4 : 0000000000000000
> [   61.103895] x3 : ffff000001100020 x2 : ffff800846d40000
> [   61.109190] x1 : dead000000000100 x0 : dead000000000200
> [   61.114486] Call trace:
> [   61.116922]  usb_gadget_unregister_driver+0x7c/0x108 [udc_core]
> [   61.122828]  usb_composite_unregister+0x10/0x18 [libcomposite]
> [   61.128643]  msg_cleanup+0x18/0xfce0 [g_mass_storage]
> [   61.133682]  __arm64_sys_delete_module+0x17c/0x1f0
> [   61.138458]  el0_svc_common+0x90/0x158
> [   61.142192]  el0_svc_handler+0x2c/0x80
> [   61.145926]  el0_svc+0x8/0xc
> [   61.148794] Code: eb03003f d10be033 54ffff21 a94d0281 (f9000420)
> [   61.154869] ---[ end trace afb22e9b637bd9a7 ]---
> Segmentation fault
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Changelog:
> v2
> - Retain policy behaviour if pending gadget driver fails to bind.
> 
>  drivers/usb/gadget/udc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 7cf34beb50df..92af8dc98c3d 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1143,7 +1143,7 @@ static int check_pending_gadget_drivers(struct usb_udc *udc)
>  						dev_name(&udc->dev)) == 0) {
>  			ret = udc_bind_to_driver(udc, driver);
>  			if (ret != -EPROBE_DEFER)
> -				list_del(&driver->pending);
> +				list_del_init(&driver->pending);
>  			break;
>  		}
>  

Acked-by: Alan Stern <stern@rowland.harvard.edu>

