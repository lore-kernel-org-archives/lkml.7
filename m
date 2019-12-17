Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA239C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB77D20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLQLOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:14:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:22879 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfLQLOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:14:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:14:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="298015511"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2019 03:14:27 -0800
Subject: Re: [PATCH v2 2/2] USB: core: Attempt power cycle port when it's in
 eSS.Disabled state
To:     Alan Stern <stern@rowland.harvard.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1912111006280.1549-100000@iolanthe.rowland.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <c8fc54db-9037-3635-f6a7-d6220e5d02cb@linux.intel.com>
Date:   Tue, 17 Dec 2019 13:16:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1912111006280.1549-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.2019 17.08, Alan Stern wrote:
> On Wed, 11 Dec 2019, Kai-Heng Feng wrote:
> 
>>
>>
>>> On Nov 30, 2019, at 01:41, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>
>>> On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
>>> then connects to ASMedia xHCI's root hub:
>>>
>>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>>>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>>>             |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
>>>
>>> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>>> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
>>> Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
>>>
>>> The SMSC hub may disconnect after system resume from suspend. When this
>>> happens, the reset resume attempt fails, and the last resort to disable
>>> the port and see something comes up later, also fails.
>>>
>>> When the issue occurs, the link state stays in eSS.Disabled state
>>> despite the warm reset attempts. Accoding to spec this can be caused by
>>> invalid VBus, after some expiremets, the SMSC hub can be brought back
>>> after a powercycle.

Could you open up a bit more how this happens, mainly codepaths how the
USB3 port ends up in eSS.Disabled state

There might be something else wrong here.
My impression is that port should only end up in eSS.Disabled when directed
to with a Set_Port_Feature(PORT_LINK_STATE, eSS.Disabled) Request.
After this we shouldn't attempt warm resets, they won't work for USB3 ports in
ss.Disabled state.

-Mathias
