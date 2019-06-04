Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C40C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2644923CEB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfFDNux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:50:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:39344 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfFDNux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:50:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:50:52 -0700
X-ExtLoop1: 1
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga007.jf.intel.com with ESMTP; 04 Jun 2019 06:50:50 -0700
Subject: Re: [PATCH] xhci: clear port_remote_wakeup after resume failure
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     oneukum@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190524145231.6605-1-nsaenzjulienne@suse.de>
 <eb5d9252-1283-be73-96d6-c24a0fdf1eab@linux.intel.com>
 <e2dd83c5dbba1bb9bd300285285ab07135dc6166.camel@suse.de>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <9286ec05-d2a2-bd23-3397-b6a3623cad8f@linux.intel.com>
Date:   Tue, 4 Jun 2019 16:53:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e2dd83c5dbba1bb9bd300285285ab07135dc6166.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.5.2019 14.28, Nicolas Saenz Julienne wrote:
> Hi Matthias,
> thanks for the review.
> 
> On Mon, 2019-05-27 at 14:16 +0300, Mathias Nyman wrote:
>> On 24.5.2019 17.52, Nicolas Saenz Julienne wrote:
>>> This was seen on a Dell Precision 5520 using it's WD15 dock. The dock's
>>> Ethernet device interfaces with the laptop through one of it's USB3
>>> ports. While idle, the Ethernet device and HCD are suspended by runtime
>>> PM, being the only device connected on the bus. Then, both are resumed on
>>> behalf of the Ethernet device, which has remote wake-up capabilities.
>>>
>>> The Ethernet device was observed to randomly disconnect from the USB
>>> port shortly after submitting it's remote wake-up request. Probably a
>>> weird timing issue yet to be investigated. This causes runtime PM to
>>> busyloop causing some tangible CPU load. The reason is the port gets
>>> stuck in the middle of a remote wake-up operation, waiting for the
>>> device to switch to U0. This never happens, leaving "port_remote_wakeup"
>>> enabled, and automatically triggering a failure on any further suspend
>>> operation.
>>>
>>> This patch clears "port_remote_wakeup" upon detecting a device with a
>>> wrong resuming port state (see Table 4-9 in 4.15.2.3). Making sure the
>>> above mentioned situation doesn't trigger a PM busyloop.
>>>
>>
>> There was a similar case where the USB3 link had transitioned to a
>> lower power U1 or U2 state after resume, before driver read the state,
>> leaving port_remote_wakeup flag uncleared.
>>
>> This was fixed in 5.1 kernel by commit:
>>
>> 6cbcf59 xhci: Fix port resume done detection for SS ports with LPM enable
>>
>> Can you check if you have it?
>> It should be in recent stable releases as well.
> 
> I was aware of that patch, unfortunately it doesn't address the same issue. In
> my case I never get a second port status event (so no PLC == 1 or any state
> change seen in PLS). The device simply disconnects from the bus.
> 

I see, ok, then we need to clear the flag in the hub thread.

But to me it looks like this patch could cause a small race risk in the successful
device initiated resume cases.

If the hub thread, i.e. the get_port_status() function, notices the U0 state before
the interrupt handler, i.e. handle_port_status() function, then port_remote_wakeup
flag is cleared in the hub thread and the wakeup notification is never called from
handle_port_status().

Would it be enough to just check for (port_remote_wakeup flag && !PORT_CONNECT) in the hub thread?
USB3 PORT_CONNECT bit is lost in most error cases.

-Mathias
