Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BF7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED852175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfCTNww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:52:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:22797 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfCTNww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:52:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 06:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="124260986"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2019 06:52:49 -0700
Subject: Re: [RFC] xhci: clear port_remote_wakeup on device disconnection
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Oliver Neukum <oneukum@suse.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20190318170038.23914-1-nsaenzjulienne@suse.de>
 <1552993288.14757.23.camel@suse.com>
 <82718bec37e4e16e0a08b3b7a00452f99adc707b.camel@suse.de>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <cd27b6cf-805a-8051-23e4-3bd1de2ede4d@linux.intel.com>
Date:   Wed, 20 Mar 2019 15:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <82718bec37e4e16e0a08b3b7a00452f99adc707b.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.3.2019 16.54, Nicolas Saenz Julienne wrote:
> Hi Oliver, thanks for the review!
> 
> On Tue, 2019-03-19 at 12:01 +0100, Oliver Neukum wrote:
>> On Mo, 2019-03-18 at 18:00 +0100, Nicolas Saenz Julienne wrote:
>>> This patch clears "port_remote_wakeup" upon detecting a device
>>> disconnection. Making sure the above mentioned situation doesn't trigger
>>> a PM busyloop.
>>
>> Hi,
>>
>> that is an interesting race condition.
>>

Turns out that port_remote_wakeup was only properly cleared in case of a
successful resume where port stays in U0, or in case of an error where port
goes to inactive state.

In all other cases port_remote_wakeup bit was left uncleared.

>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>> ---
>>>   drivers/usb/host/xhci-hub.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>>> index e2eece693655..bea853f45aec 100644
>>> --- a/drivers/usb/host/xhci-hub.c
>>> +++ b/drivers/usb/host/xhci-hub.c
>>> @@ -942,6 +942,9 @@ static void xhci_get_usb3_port_status(struct xhci_port
>>> *port, u32 *status,
>>>   			bus_state->suspended_ports &= ~(1 << portnum);
>>>   	}
>>>   
>>> +	if (!(portsc & PORT_CONNECT))
>>> +		bus_state->port_remote_wakeup &= ~(1 << portnum);
>>> +

A check like this should cover the failing resume cases, thanks

We also saw a case when a successful resume was missed as port went into U1
Link power save state (resume->U0->U1) before xhci driver read the port status.

A patch adding U1 and U2 to successful resume states is pending in my for-usb-linus
branch for this.

>>
>> Why are you putting that logic into xhci_get_usb3_port_status()?
>> It looks to me like there is already something related in the caller
> 
> You're right, xhci_get_usb3_port_status() is not the ideal spot I'll move the
> code there.
> 

Sounds good, thanks

-Mathias
