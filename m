Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E144C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0328620861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfGIGb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:31:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:9129 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfGIGb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:31:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 23:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; 
   d="scan'208";a="316941770"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga004.jf.intel.com with ESMTP; 08 Jul 2019 23:29:42 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: RE: [PATCH 1/3] usb: common: Add usb_get_dr_mode_from_string and usb_dr_mode_to_string.
In-Reply-To: <BYAPR07MB4709D1BD29C3E0FA6C5289FBDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562592924-17528-1-git-send-email-pawell@cadence.com> <87y31768k0.fsf@linux.intel.com> <BYAPR07MB4709D1BD29C3E0FA6C5289FBDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Tue, 09 Jul 2019 09:29:41 +0300
Message-ID: <87sgrf67qi.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Pawel Laszczak <pawell@cadence.com> writes:
>>> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
>>> index 69f1b6328532..c156817672c4 100644
>>> --- a/include/linux/usb/otg.h
>>> +++ b/include/linux/usb/otg.h
>>> @@ -129,4 +129,20 @@ enum usb_dr_mode {
>>>   */
>>>  extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
>>>
>>> +/**
>>> + * usb_get_dr_mode_from_string - Convert string to dual role mode.
>>> + * @str: Pointer to the given string
>>> + *
>>> + * The function gets string and returns the correspondig enum usb_dr_mode.
>>> + */
>>> +extern enum usb_dr_mode usb_get_dr_mode_from_string(const char *str);
>>> +
>>> +/**
>>> + * usb_dr_mode_to_string - Convert dual role mode to string.
>>> + * @dr_mode: Pointer to the given dual role mode
>>> + *
>>> + * The function gets enum usb_dr_mode, and returns the correspondig string.
>>> + */
>>> +extern const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_mode);
>>> +
>>>  #endif /* __LINUX_USB_OTG_H */
>>
>>Still missing the stubs I mentioned. Did you try compiling with and
>>without common enabled?
>>
> Sorry, I thought that I send answer yesterday but it's look like I prepared the answer but 
> I  forgot to send. 
>
> In /drivers/usb/Kconfig we have: 
>
> config USB
> 	tristate "Support for Host-side USB"
> 	depends on USB_ARCH_HAS_HCD
> 	select USB_COMMON
>
> and in /drivers/usb/gadget/Kconfig we have:
>
> menuconfig USB_GADGET
> 	tristate "USB Gadget Support"
> 	select USB_COMMON
>
> I think that it should cover all cases. 
>
> Am I right ?

Run a few tens of randconfig builds and see if you ever catch any
problem. I think randconfig can produce a defconfig where USB=n
USB_GADGET=n and USB_COMMON=y.

-- 
balbi
