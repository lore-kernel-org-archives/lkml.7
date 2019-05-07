Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19856C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3F520B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfEGH6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:58:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:8399 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfEGH6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:58:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 00:58:04 -0700
X-ExtLoop1: 1
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by FMSMGA003.fm.intel.com with ESMTP; 07 May 2019 00:57:59 -0700
Subject: Re: [PATCH v4 1/1] usb: xhci: Add Clear_TT_Buffer
To:     Alan Stern <stern@rowland.harvard.edu>, Jim Lin <jilin@nvidia.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        hminas@synopsys.com, kai.heng.feng@canonical.com,
        drinkcat@chromium.org, prime.zeng@hisilicon.com, malat@debian.org,
        nsaenzjulienne@suse.de, jflat@chromium.org,
        linus.walleij@linaro.org, clabbe@baylibre.com,
        colin.king@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.1905061053550.1585-100000@iolanthe.rowland.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <9ea9fd3e-cf1a-9015-6d21-377c2fd41e66@linux.intel.com>
Date:   Tue, 7 May 2019 11:00:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1905061053550.1585-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.5.2019 17.57, Alan Stern wrote:
> On Mon, 6 May 2019, Jim Lin wrote:
> 
>> USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
>> processing for full-/low-speed endpoints connected via a TT, the host
>> software must use the Clear_TT_Buffer request to the TT to ensure
>> that the buffer is not in the busy state".
>>
>> In our case, a full-speed speaker (ConferenceCam) is behind a high-
>> speed hub (ConferenceCam Connect), sometimes once we get STALL on a
>> request we may continue to get STALL with the folllowing requests,
>> like Set_Interface.
>>
>> Here we add Clear_TT_Buffer for the following Set_Interface requests
>> to get ACK successfully.
>>
>> Originally usb_hub_clear_tt_buffer uses urb->dev->devnum as device
>> address while sending Clear_TT_Buffer command, but this doesn't work
>> for XHCI.
> 
> Why doesn't it work for xHCI?  Clear-TT-Buffer is part of the USB 2.0
> spec; it should work exactly the same for xHCI as for a USB-2.0 host
> controller.
> 
> Alan Stern
> 

For other host controllers udev->devnum is the same as the address of the
usb device, chosen and set by usb core.

With xHC the controller hardware assigns the address, and won't be the same as
devnum.

The Clear-TT-Buffer request sent to the hub includes the address of the LS/FS
child device in wValue field. usb_hub_clear_tt_buffer() uses udev->devnum to set the
address wValue. This won't work for devices connected to xHC
    
-Mathias
