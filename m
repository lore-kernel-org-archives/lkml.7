Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4A4ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973DC21925
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="td8vDyR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfJOG7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:59:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46524 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfJOG7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:59:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so3526844pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mTg0FMT6vr5u2XqGUSj/m+I5t1w5ozsNKbohqK+I32g=;
        b=td8vDyR3YArCs7AvGhwya+a/EH7MvQV5uULvkgZc8iUSMyZSzj/kfOFE4o8bKSjlRD
         Ep0bQKe7+Xm1abyFo9bhsXvg/oxXCfTs2CWuoKoSGl+KoG0bpgN13Dg96xQuzykxcKTA
         MWQxa32hsBFO17VdLpPpYIJKflEYr9dkiuDWgimgEG9JyNtBr25nN3m9lY93eKlEwRne
         o3OMq1nBUsTkAwygR7+/B1RVombnoQxYB3+Lh3/GHeAsEsIKH5h+D4oNfm9pAiS8utyS
         L1p8fe4A6VpA25fbfmQBUbiceQA1L7yWPiW7HCjYsvRT2rcall2pNF2fn7x1hIvBoxrf
         Un7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mTg0FMT6vr5u2XqGUSj/m+I5t1w5ozsNKbohqK+I32g=;
        b=Kn4Avy/R4sza392VJNt9hqX4LNaRDp+LjMBtvepkdXkYhsSzp3qw6hrqt4BnKwc92k
         XSaSf2U3WwjcDMehfvsIr85yIKNbW1YG46lmfc+5FLMyQT7/GEdzAxDmxIo+oGIDGc6c
         1ma+2uo0M3xKGwNxnIEbsgudbQw5SH8oOlV2QmroJ4H+5PvAj3GpTEKc3GiwFZ5JsCo7
         Rs5No5oytxMdbsZCvlewoBkM1pdet6rwFr6Luc3M6+1d9jf7s/jiv8LEKQTkgodWFqNW
         +bFuR5KLeKsNp6G6oFBrkvvwpYl/dn3uCznlk6mCdrQBCrpAELB2qjPuxP7wCVeeSj6K
         bCQA==
X-Gm-Message-State: APjAAAXwLDz2nzsDM/pdDeiF+zTjGxBUZBpm/cm5dHHIPX9MFswJbuR9
        ZDx0QEjmWWomQVQZAxAK1gOBUSAlGqU=
X-Google-Smtp-Source: APXvYqxoLX22ZMv6ADNBO+02t8Ng3OFUGaEOVWKpsG4ca9+5fEvBI/KEECsVZ2SkW2Zj9+Gej6jlpA==
X-Received: by 2002:a62:e70d:: with SMTP id s13mr36572094pfh.240.1571122783277;
        Mon, 14 Oct 2019 23:59:43 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i16sm17952646pfa.184.2019.10.14.23.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 23:59:42 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 4/4] usb: gadget: udc: core: Fix segfault if udc_bind_to_driver() for pending driver fails
Date:   Tue, 15 Oct 2019 00:59:37 -0600
Message-Id: <20191015065937.23169-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015065937.23169-1-mathieu.poirier@linaro.org>
References: <20191015065937.23169-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

commit 163be6ff7739b12ff300d77897d340f661821da2 upstream

If a gadget driver is in the pending drivers list, a UDC
becomes available and udc_bind_to_driver() fails, then it
gets deleted from the pending list.
i.e. list_del(&driver->pending) in check_pending_gadget_drivers().

Then if that gadget driver is unregistered,
usb_gadget_unregister_driver() does a list_del(&driver->pending)
again thus causing a page fault as that list entry has been poisoned
by the previous list_del().

Fix this by using list_del_init() instead of list_del() in
check_pending_gadget_drivers().

Test case:

- Make sure no UDC is available
- modprobe g_mass_storage file=wrongfile
- Load UDC driver so it becomes available
	lun0: unable to open backing file: wrongfile
- modprobe -r g_mass_storage

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
[   61.008658] Hardware name: Texas Instruments SoC (DT)
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

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/usb/gadget/udc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index af88b48c1cea..b564a3251923 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1138,7 +1138,7 @@ static int check_pending_gadget_drivers(struct usb_udc *udc)
 						dev_name(&udc->dev)) == 0) {
 			ret = udc_bind_to_driver(udc, driver);
 			if (ret != -EPROBE_DEFER)
-				list_del(&driver->pending);
+				list_del_init(&driver->pending);
 			break;
 		}
 
-- 
2.17.1

