Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F48C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D58A20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfCSINI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:13:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:17178 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfCSINI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:13:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 01:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="123866441"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2019 01:13:05 -0700
Subject: Re: [PATCH] usb: xhci: add Immediate Data Transfer support
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     felipe.balbi@linux.intel.com, oneukum@suse.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190219162945.22889-1-nsaenzjulienne@suse.de>
 <31a3530dbd75771c82bfb41a357370b90d7981d2.camel@suse.de>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <1fe79a10-16d4-8d06-4c9b-7e5a3d3807cf@linux.intel.com>
Date:   Tue, 19 Mar 2019 10:15:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <31a3530dbd75771c82bfb41a357370b90d7981d2.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.3.2019 14.51, Nicolas Saenz Julienne wrote:
> On Tue, 2019-02-19 at 17:29 +0100, Nicolas Saenz Julienne wrote:
>> Immediate data transfers (IDT) allow the HCD to copy small chunks of
>> data (up to 8bytes) directly into its output transfer TRBs. This avoids
>> the somewhat expensive DMA mappings that are performed by default on
>> most URBs submissions.
>>
>> In the case an URB was suitable for IDT. The data is directly copied
>> into the "Data Buffer Pointer" region of the TRB and the IDT flag is
>> set. Instead of triggering memory accesses the HC will use the data
>> directly.
>>
>> The implementation could cover all kind of output endpoints. Yet
>> Isochronous endpoints are bypassed as I was unable to find one that
>> matched IDT's constraints. As we try to bypass the default DMA mappings
>> on URB buffers we'd need to find a Isochronous device with an
>> urb->transfer_buffer_length <= 8 bytes.
>>
>> The implementation takes into account that the 8 byte buffers provided
>> by the URB will never cross a 64KB boundary.
>>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> 
> Friendly ping, any more comments on this? :)
> 

Looks good, adding to queue, thanks

-Mathias
