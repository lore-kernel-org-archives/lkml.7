Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0207C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B982084E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9r/17xB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfENO6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:58:17 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:42052 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfENO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:58:14 -0400
Received: by mail-pl1-f180.google.com with SMTP id x15so8387868pln.9;
        Tue, 14 May 2019 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=0LsZkohtkLGwcDs9hRe0VJ+ypCQo2GRqxmcPfS0ioFc=;
        b=q9r/17xBR7SJhg2wxXoddjTsUJl5WLsUQ0mM6cpOwkSyLeqhqanDu322FS9tp8tqGG
         lXPHeBchF6lZJEWf67HKBafqZTfFsXZItGoWPREIfY4oYu37y/dyG8keOPX/Tn8x3MXg
         zvTCK6Ga2EIe6xtvtqyIz30aUFddv+ti9A5M57Q5JQXrWrBZZLRqdwWPtasrQGxx1Wko
         JBy7tCNr6wqHv0af7/fvI88DfdtIFviKartbD7o0AUt76Cei4eCPojbopRGgl7nCdlG8
         x5oV9FLV7Ue/Phvd7tQYOnnc5Gwo1veuFDP9jAfoUZtXc6Zxof7PRPxq2HyiTCsxlBcM
         KwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=0LsZkohtkLGwcDs9hRe0VJ+ypCQo2GRqxmcPfS0ioFc=;
        b=T61HVVNUju6b6uo7nO2Rwmk6NUUPkducpOBgvpfQrHa00faum3Sq9kWTIv78TLo1Is
         Wrz6Ni/BC6rzjdyg2S2jLp0aIi8TAnQFzKz02yGUH4uyBujLpjV0+U94r1Ei/3OWusZi
         9vDJq+q/RiLHc3ZHNNOPulfobxEsrKAAYLNUroEAfn/1lg7LGQJ4CoMm1wddKWJnoax3
         Twdn9/3wjXjK1YY/601IBzAI/3/N5gOBZEUgUyrzFcBzMD9UnPQLc6O0nZ6V6kO7tzye
         X3XXewErKcCqRJAUP/vj3I5Dmr5YAQUS4sZv0KGxvzRlAnspxd1EmcbuKeTEHe5IeWXH
         /dCQ==
X-Gm-Message-State: APjAAAVmGlQ7NV98tgdAISjiNSJEh5ywBQltkThNeYF0yHS1wiKuU/3P
        oKeKyLIbyMuKzfea8wkRxdVltyfj
X-Google-Smtp-Source: APXvYqyCJlRLzCMnsZYmmkcjVr7eBSSe4MvuLLZxWawlfMF0nyetLZsXq/olBoQm2HJua7HSGSY1wQ==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr39505744plp.27.1557845893729;
        Tue, 14 May 2019 07:58:13 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.27? ([2402:f000:1:1501:200:5efe:a66f:471b])
        by smtp.gmail.com with ESMTPSA id q17sm7643780pfq.74.2019.05.14.07.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 07:58:12 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] usb: xhci: Possible resource leaks when xhci_run() fails
To:     mathias.nyman@intel.com, Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <fd7610ec-5f14-7952-cd9a-e56adb4e1353@gmail.com>
Date:   Tue, 14 May 2019 22:58:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci_pci_setup() is assigned to hc_driver.reset;
xhci_run() is assigned to hc_driver.start();
xhci_stop() is assigned to hc_driver.stop().

xhci_pci_setup() calls xhci_gen_setup, which calls xhci_init(). And 
xhci_init() calls xhci_mem_init() to allocate resources.

xhci_stop() calls xhci_mem_cleanup(), to release the resources allocated 
in xhci_mem_init() (also namely xhci_pci_setup()).

xhci_run() can fail, because xhci_try_enable_msi() or 
xhci_alloc_command() in this function can fail.

In drivers/usb/core/hcd.c:
     retval = hcd->driver->reset(hcd);
     if (retval < 0) {
         ......
         goto err_hcd_driver_setup;
     }
     ......
     retval = hcd->driver->start(hcd);
     if (retval < 0) {
         ......
         goto err_hcd_driver_start;
     }
     .......
     hcd->driver->stop(hcd);
     hcd->state = HC_STATE_HALT;
     clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
     del_timer_sync(&hcd->rh_timer);
err_hcd_driver_start:
     if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
         free_irq(irqnum, hcd);
err_request_irq:
err_hcd_driver_setup:
err_set_rh_speed:
     usb_put_invalidate_rhdev(hcd);
err_allocate_root_hub:
     usb_deregister_bus(&hcd->self);
err_register_bus:
     hcd_buffer_destroy(hcd);
err_create_buf:
     usb_phy_roothub_power_off(hcd->phy_roothub);
err_usb_phy_roothub_power_on:
     usb_phy_roothub_exit(hcd->phy_roothub);

Thus, when hcd->driver->reset() succeeds and hcd->driver->start() fails, 
hcd->driver->stop() is not called.

Namely, when xhci_pci_setup() successfully allocates resources, and 
xhci_run() fails, xhci_stop() is not called to release the resources.
For this reason, resource leaks occur in this case.

I check the code of the ehci driver, uhci driver and ohci driver, and 
find that they do not have such problem, because:
In the ehci driver, ehci_run() (namely hcd->driver->start()) never fails.
In the uhci driver, all the resources are allocated in uhci_start 
(namely hcd->driver->start()), and no resources are allocated in 
uhci_pci_init() (namely hcd->driver->reset()).
In the ohci driver, ohci_setup() (namely hcd->driver->reset()) also 
allocates resources. But when ohci_start() (namely hcd->driver->start()) 
is going to fail, ohci_stop() is directly called to release the 
resources allocated by ohci_setup().

Thus, there are two possible ways of fixing bugs:
1) Call xhci_stop() when xhci_run() is going to fail (like the ohci driver)
2) Move all resource-allocation operations into xhci_run() (like the 
uhci driver).

I am not sure whether these ways are correct, so I only report bugs.

These bugs are found by a runtime fuzzing tool named FIZZER written by us.


Best wishes,
Jia-Ju Bai
