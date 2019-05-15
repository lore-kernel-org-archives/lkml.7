Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CEEC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDDE20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPqYRCkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEOBS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:18:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45726 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEOBSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:18:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so431526pgi.12;
        Tue, 14 May 2019 18:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rrXtw7EviKnGm7vmIQT/eYWSAY8JBvZyExmWK2e1kgE=;
        b=WPqYRCkGFFu1R0g5uTiZPgl1CPbdoXJW+nGfFeiFTfXwMnE7GiRdnOmkE2J+9iQ+MU
         BJRm63vhkBMkPF+tAt3JmnU8cpAq4WNBDSkyzuf0qsBnXVR1/8ZXKKjurVUf5T13rRYz
         aJrKKatHS4ZiQIQGWBKrFY5oKzbJkgWTwHqgTIstw9RGo6G2atB5zlTmM3EZwtPPP9MR
         vQvqCgR00sCs+FOBnMXkeIRpq3OMii5InaV2Jpn+QXasPIPxhcNFUHBvorRucajbDQN4
         dChO08hFBAdMD8lZWSIw4PtmxovdGjQnpNcA6oMsIfEvyEohx//N3KMdjyaqFAJZJqPG
         /mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rrXtw7EviKnGm7vmIQT/eYWSAY8JBvZyExmWK2e1kgE=;
        b=cPAKLDcC13JrdMnZAq4CqiqRVlgA7FzDM8L52QNf2ACqAD2VGNAridUczlVLiJApy/
         pX20mpdBMdllkfMqCNeGJj6+iNeIlUag9s22wfZPq/Th1Csq8hYpLQeIs8ZRHq/gTDJQ
         iMjuxwPQvDfjmRs2bbt/eVM7Fp4yHglHeu8+biiGY4iqwt+tWMlKDH9e/4+Mh4nyUUJa
         QW5SwSdTkgKj3LcHHrE72DZxjr95uzUhMs6yQQh8IuuNiIS5LH1rlmtYsVR09tkXmPui
         v2/eAqzo6ad1j+MpafCigb/SMMvMNTpTTXf2bnsohaguOa22DZM2g/APmUau/2MX8X3g
         6Uiw==
X-Gm-Message-State: APjAAAW2F6sEyJxugtfi4wa7ALBQ/XQly8NZMrj1IWt/T4YR6IN6jlN9
        WlHUl2CE5CImbC4l6anv/XO2sPmo
X-Google-Smtp-Source: APXvYqwkehQiJSzyV+Iq7YYGhnHhAs1ek80Dsqxe7pT7wEkPQwOJ+GE6eJZVxhL9cfYXD8xcqWk04Q==
X-Received: by 2002:a65:5c8c:: with SMTP id a12mr41110064pgt.452.1557883134946;
        Tue, 14 May 2019 18:18:54 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::6f28? ([2402:f000:4:72:808::6f28])
        by smtp.gmail.com with ESMTPSA id x30sm328899pgl.76.2019.05.14.18.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 18:18:54 -0700 (PDT)
Subject: Re: [BUG] usb: xhci: Possible resource leaks when xhci_run() fails
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <fd7610ec-5f14-7952-cd9a-e56adb4e1353@gmail.com>
 <20190514165511.GA28266@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <294fbf2c-dab9-6be4-d0e0-cbb97e176815@gmail.com>
Date:   Wed, 15 May 2019 09:18:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190514165511.GA28266@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/15 0:55, Greg KH wrote:
> On Tue, May 14, 2019 at 10:58:05PM +0800, Jia-Ju Bai wrote:
>> xhci_pci_setup() is assigned to hc_driver.reset;
>> xhci_run() is assigned to hc_driver.start();
>> xhci_stop() is assigned to hc_driver.stop().
>>
>> xhci_pci_setup() calls xhci_gen_setup, which calls xhci_init(). And
>> xhci_init() calls xhci_mem_init() to allocate resources.
>>
>> xhci_stop() calls xhci_mem_cleanup(), to release the resources allocated in
>> xhci_mem_init() (also namely xhci_pci_setup()).
>>
>> xhci_run() can fail, because xhci_try_enable_msi() or xhci_alloc_command()
>> in this function can fail.
>>
>> In drivers/usb/core/hcd.c:
>>      retval = hcd->driver->reset(hcd);
>>      if (retval < 0) {
>>          ......
>>          goto err_hcd_driver_setup;
>>      }
>>      ......
>>      retval = hcd->driver->start(hcd);
>>      if (retval < 0) {
>>          ......
>>          goto err_hcd_driver_start;
>>      }
>>      .......
>>      hcd->driver->stop(hcd);
>>      hcd->state = HC_STATE_HALT;
>>      clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
>>      del_timer_sync(&hcd->rh_timer);
>> err_hcd_driver_start:
>>      if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
>>          free_irq(irqnum, hcd);
>> err_request_irq:
>> err_hcd_driver_setup:
>> err_set_rh_speed:
>>      usb_put_invalidate_rhdev(hcd);
>> err_allocate_root_hub:
>>      usb_deregister_bus(&hcd->self);
>> err_register_bus:
>>      hcd_buffer_destroy(hcd);
>> err_create_buf:
>>      usb_phy_roothub_power_off(hcd->phy_roothub);
>> err_usb_phy_roothub_power_on:
>>      usb_phy_roothub_exit(hcd->phy_roothub);
>>
>> Thus, when hcd->driver->reset() succeeds and hcd->driver->start() fails,
>> hcd->driver->stop() is not called.
>>
>> Namely, when xhci_pci_setup() successfully allocates resources, and
>> xhci_run() fails, xhci_stop() is not called to release the resources.
>> For this reason, resource leaks occur in this case.
>>
>> I check the code of the ehci driver, uhci driver and ohci driver, and find
>> that they do not have such problem, because:
>> In the ehci driver, ehci_run() (namely hcd->driver->start()) never fails.
>> In the uhci driver, all the resources are allocated in uhci_start (namely
>> hcd->driver->start()), and no resources are allocated in uhci_pci_init()
>> (namely hcd->driver->reset()).
>> In the ohci driver, ohci_setup() (namely hcd->driver->reset()) also
>> allocates resources. But when ohci_start() (namely hcd->driver->start()) is
>> going to fail, ohci_stop() is directly called to release the resources
>> allocated by ohci_setup().
>>
>> Thus, there are two possible ways of fixing bugs:
>> 1) Call xhci_stop() when xhci_run() is going to fail (like the ohci driver)
>> 2) Move all resource-allocation operations into xhci_run() (like the uhci
>> driver).
>>
>> I am not sure whether these ways are correct, so I only report bugs.
> Can you create a patch to show how you would fix this potential issue?
> Given that making this type of thing fail is pretty rare, it's not a
> real high priority to get to, so it might be a while for anyone here to
> look at it.

Okay, I will send a patch soon.


Best wishes,
Jia-Ju Bai
