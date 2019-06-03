Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E9C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D69C24067
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfFCMc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:32:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:60756 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCMc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:32:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 05:32:26 -0700
X-ExtLoop1: 1
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2019 05:32:23 -0700
Subject: Re: [PATCH v11 2/2] usb: xhci: Add Clear_TT_Buffer
To:     Jim Lin <jilin@nvidia.com>, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com, stern@rowland.harvard.edu,
        kai.heng.feng@canonical.com, drinkcat@chromium.org,
        Thinh.Nguyen@synopsys.com, nsaenzjulienne@suse.de,
        jflat@chromium.org, malat@debian.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1559559224-9845-1-git-send-email-jilin@nvidia.com>
 <1559559224-9845-3-git-send-email-jilin@nvidia.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <10d35c94-5938-aa47-0f12-7ce1143caa41@linux.intel.com>
Date:   Mon, 3 Jun 2019 15:35:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1559559224-9845-3-git-send-email-jilin@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.6.2019 13.53, Jim Lin wrote:
> USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
> processing for full-/low-speed endpoints connected via a TT, the host
> software must use the Clear_TT_Buffer request to the TT to ensure
> that the buffer is not in the busy state".
> 
> In our case, a full-speed speaker (ConferenceCam) is behind a high-
> speed hub (ConferenceCam Connect), sometimes once we get STALL on a
> request we may continue to get STALL with the folllowing requests,
> like Set_Interface.
> 
> Here we invoke usb_hub_clear_tt_buffer() to send Clear_TT_Buffer
> request to the hub of the device for the following Set_Interface
> requests to the device to get ACK successfully.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
>      , remove its claiming in xhci.h
> v3: Add description for clearing_tt (xhci.h)
> v4: Remove clearing_tt flag because hub_tt_work has hub->tt.lock
>      to protect for Clear_TT_Buffer to be run serially.
>      Remove xhci_clear_tt_buffer_complete as it's not necessary.
>      Same reason as the above.
>      Extend usb_hub_clear_tt_buffer parameter
> v5: Not extending usb_hub_clear_tt_buffer parameter
>      Add description.
> v6: Remove unused parameter slot_id from xhci_clear_hub_tt_buffer
> v7: Add devaddr field in "struct usb_device"
> v8: split as two patches
> v9: no change flag
> v10: Add EP_CLEARING_TT flag
> v11: Add spin_lock/unlock in xhci_clear_tt_buffer_complete
> 
> 
>   drivers/usb/host/xhci-ring.c | 27 ++++++++++++++++++++++++++-
>   drivers/usb/host/xhci.c      | 21 +++++++++++++++++++++
>   drivers/usb/host/xhci.h      |  5 +++++
>   3 files changed, 52 insertions(+), 1 deletion(-)
> 

xhci parts look good to me,

In case Greg wants to pick up both the core changes (1/2) and
the xhci changes (2/2) at the same time:

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>


