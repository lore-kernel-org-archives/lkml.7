Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC5C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE3F233A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qEgMPUef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfHUJzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:55:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59490 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfHUJzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:55:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7L9sgee033183;
        Wed, 21 Aug 2019 04:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566381282;
        bh=74u7LBGqGO9qndO4rNdGufmM8g+fd0+Tr8ZLK1OFHgk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qEgMPUef4lJB5i56JDvxf+i5F4wx1lNKFbcwQn/AU8wjwmNqmUSRAV+miEF0ru/+R
         c3TDzimlaFXIoInFSLxhrTGJZnGEfridvDIpc4bljf4W96VP7kiT+1QyQ5aJH31bTk
         4LoP6zr0zjkVDLofqKsFy5614j6X0VvW8pxOQ4X8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7L9sgif112062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Aug 2019 04:54:42 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 21
 Aug 2019 04:54:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 21 Aug 2019 04:54:41 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7L9scFQ130114;
        Wed, 21 Aug 2019 04:54:38 -0500
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Pawel Laszczak <pawell@cadence.com>,
        <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <aniljoy@cadence.com>
References: <Pine.LNX.4.44L0.1908191017560.1506-100000@iolanthe.rowland.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <696da9d1-edf1-ef9f-9d52-18a9ddb04788@ti.com>
Date:   Wed, 21 Aug 2019 12:54:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1908191017560.1506-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/08/2019 17:19, Alan Stern wrote:
> On Mon, 19 Aug 2019, Roger Quadros wrote:
> 
>> On 15/08/2019 17:39, Alan Stern wrote:
>>> On Thu, 15 Aug 2019, Roger Quadros wrote:
>>>
>>>> Felipe & Alan,
>>>>
>>>> On 21/07/2019 21:32, Pawel Laszczak wrote:
>>>>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>>>>
>>>>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>>>>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>>>>> Host Only (XHCI)configurations.
>>>>>
>>>>> The current driver has been validated with FPGA burned. We have support
>>>>> for PCIe bus, which is used on FPGA prototyping.
>>>>>
>>>>> The host side of USBSS-DRD controller is compliance with XHCI
>>>>> specification, so it works with standard XHCI Linux driver.
>>>>
>>>> While testing this driver I encountered the following issue if I do the following.
>>>>
>>>> 1) USB port is "otg" and nothing connected so it is in IDLE mode to begin with.
>>>>    i.e. HCD & UDC not registered.
>>>>
>>>> 2) Load mass storage gadget with backing medium.
>>>>    > modprobe g_mass_storage file=lun stall=0
>>>>
>>>> [   28.172142] udc-core: couldn't find an available UDC - added [g_mass_storage] to list of pending drivers
>>>>
>>>> 3) Connect port to PC host
> 
> ...
> 
>>>> [   30.786313] Mass Storage Function, version: 2009/09/11
>>>> [   30.791455] LUN: removable file: (no medium)
>>>> [   31.039497] lun0: unable to open backing file: 500M.bin
> 
>>>> Is opening the backing file from irq_thread_fn the issue here?
>>>> If yes, how to resolve this?
>>>
>>> I would guess that it probably is related to that.
>>>
>>> In any case, the backing filename should be an explicit complete path.  
>>> Who knows what the current directory will be when the actual open call
>>> takes place?
>>
>> This seems to be the case. It works fine with complete path.
>>
>> Do we need to care about this in the mass storage gadget or just
>> rely on the user to provide the full path?
> 
> I think it's okay to rely on the user to provide the full path.

Makes sense. But kernel shouldn't segfault like so when
user unloads g_mass_storage soon after.

[   36.120594] Mass Storage Function, version: 2009/09/11
[   36.125734] LUN: removable file: (no medium)
[   36.130466] lun0: unable to open backing file: 100M.bin
[   36.135731] g_mass_storage 6000000.usb: failed to start g_mass_storage: -2
[   36.142664] cdns-usb3 6000000.usb: Failed to register USB device controller
[   36.149640] cdns-usb3 6000000.usb: set 2 has failed, back to 0root@am65xx-evm:~# modprobe -r g_mass_storage
[   60.900431] Unable to handle kernel paging request at virtual address dead000000000108
[   60.908346] Mem abort info:
[   60.911145]   ESR = 0x96000044
[   60.914227]   Exception class = DABT (current EL), IL = 32 bits
[   60.920162]   SET = 0, FnV = 0
[   60.923217]   EA = 0, S1PTW = 0
[   60.926354] Data abort info:
[   60.929228]   ISV = 0, ISS = 0x00000044
[   60.933058]   CM = 0, WnR = 1
[   60.936011] [dead000000000108] address between user and kernel address ranges
[   60.943136] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[   60.948691] Modules linked in: g_mass_storage(-) usb_f_mass_storage libcomposite xhci_plat_hcd xhci_hcd usbcore ti_am335x_adc kfifo_buf omap_rng cdns3 rng_core udc_core crc32_ce xfrm_user crct10dif_ce snd_so6
[   60.993995] Process modprobe (pid: 834, stack limit = 0x00000000c2aebc69)
[   61.000765] CPU: 0 PID: 834 Comm: modprobe Not tainted 4.19.59-01963-g065f42a60499 #92
[   61.008658] Hardware name: Texas Instruments K3 J721E SoC (DT)
[   61.014472] pstate: 60000005 (nZCv daif -PAN -UAO)
[   61.019253] pc : usb_gadget_unregister_driver+0x7c/0x108 [udc_core]
[   61.025503] lr : usb_gadget_unregister_driver+0x30/0x108 [udc_core]
[   61.031750] sp : ffff00001338fda0
[   61.035049] x29: ffff00001338fda0 x28: ffff800846d40000 
[   61.040346] x27: 0000000000000000 x26: 0000000000000000 
[   61.045642] x25: 0000000056000000 x24: 0000000000000800 
[   61.050938] x23: ffff000008d7b0d0 x22: ffff0000088b07c8 
[   61.056234] x21: ffff000001100000 x20: ffff000002020260 
[   61.061530] x19: ffff0000010ffd28 x18: 0000000000000000 
[   61.066825] x17: 0000000000000000 x16: 0000000000000000 
[   61.072121] x15: 0000000000000000 x14: 0000000000000000 
[   61.077417] x13: ffff000000000000 x12: ffffffffffffffff 
[   61.082712] x11: 0000000000000030 x10: 7f7f7f7f7f7f7f7f 
[   61.088008] x9 : fefefefefefefeff x8 : 0000000000000000 
[   61.093304] x7 : ffffffffffffffff x6 : 000000000000ffff 
[   61.098599] x5 : 8080000000000000 x4 : 0000000000000000 
[   61.103895] x3 : ffff000001100020 x2 : ffff800846d40000 
[   61.109190] x1 : dead000000000100 x0 : dead000000000200 
[   61.114486] Call trace:
[   61.116922]  usb_gadget_unregister_driver+0x7c/0x108 [udc_core]
[   61.122828]  usb_composite_unregister+0x10/0x18 [libcomposite]
[   61.128643]  msg_cleanup+0x18/0xfce0 [g_mass_storage]
[   61.133682]  __arm64_sys_delete_module+0x17c/0x1f0
[   61.138458]  el0_svc_common+0x90/0x158
[   61.142192]  el0_svc_handler+0x2c/0x80
[   61.145926]  el0_svc+0x8/0xc
[   61.148794] Code: eb03003f d10be033 54ffff21 a94d0281 (f9000420) 
[   61.154869] ---[ end trace afb22e9b637bd9a7 ]---
Segmentation fault


The fix for this is below. I will post a patch for it separately.

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index af88b48c1cea..85b08756c724 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1137,7 +1137,7 @@ static int check_pending_gadget_drivers(struct usb_udc *udc)
 		if (!driver->udc_name || strcmp(driver->udc_name,
 						dev_name(&udc->dev)) == 0) {
 			ret = udc_bind_to_driver(udc, driver);
-			if (ret != -EPROBE_DEFER)
+			if (!ret)
 				list_del(&driver->pending);
 			break;
 		}

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
