Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57428C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6D4206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgAHJcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:32:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:3452 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbgAHJcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:32:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 01:32:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="303510529"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 01:32:20 -0800
Subject: Re: BUG: KASAN: use-after-free in
 xhci_trb_virt_to_dma.part.24+0x1c/0x80
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Greg KH <greg@kroah.com>, Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <95b4bdb2-962f-561e-ac14-79cd44395915@molgen.mpg.de>
 <20180720095410.GA11904@kroah.com>
 <107dbdd1-4e45-836f-7f8f-85bc63374e4f@molgen.mpg.de>
 <30b069b5-63f6-dd9e-b323-668f06bff6cf@molgen.mpg.de>
 <20200103110451.GJ465886@lahna.fi.intel.com>
 <81c6f906-3f5a-729d-f3b4-1ac6ac607c05@linux.intel.com>
 <84369435-d355-0462-98ab-91bb1c5d3871@molgen.mpg.de>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <572bea6f-06d4-938a-802e-93386acf59d9@linux.intel.com>
Date:   Wed, 8 Jan 2020 11:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <84369435-d355-0462-98ab-91bb1c5d3871@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.1.2020 17.35, Paul Menzel wrote:
> Dear Mathias, dear Mika,
> 
> 
> On 2020-01-07 13:09, Mathias Nyman wrote:
>> On 3.1.2020 13.04, Mika Westerberg wrote:
>>> On Thu, Jan 02, 2020 at 03:10:14PM +0100, Paul Menzel wrote:
>>>> Mika, as you fixed the other leak, any idea, how to continue from the
>>>> kmemleak log below?
>>>>
>>>> ```
>>>> unreferenced object 0xffff8c207a1e1408 (size 8):
>>>>     comm "systemd-udevd", pid 183, jiffies 4294667978 (age 752.292s)
>>>>     hex dump (first 8 bytes):
>>>>       34 01 05 00 00 00 00 00                          4.......
>>>>     backtrace:
>>>>       [<00000000aea7b46d>] xhci_mem_init+0xcfa/0xec0 [xhci_hcd]
>>>
>>> There are probably better ways for doing this but you can use objdump
>>> for example:
>>>
>>>     $ objdump -l --prefix-addresses -j .text --disassemble=xhci_mem_init drivers/usb/host/xhci-hcd.ko
>>>
>>> then find the offset xhci_mem_init+0xcfa. It should show you the line
>>> numbers as well if you have compiled your kernel with debug info. This
>>> should be close to the line that allocated the memory that was leaked.
> 
> Thank you. I actually remembered `script/f2addr2line`.
> 
>      $ scripts/faddr2line drivers/usb/host/xhci-hcd.o xhci_mem_init+0xcfa
>      xhci_mem_init+0xcfa/0xec0:
>      xhci_add_in_port at /mnt/drivers/usb/host/xhci-mem.c:2161
>      (inlined by) xhci_setup_port_arrays at /mnt/drivers/usb/host/xhci-mem.c:2309
>      (inlined by) xhci_mem_init at /mnt/drivers/usb/host/xhci-mem.c:2538
> 
>> Paul, it possible that your xhci controller has several
>> supported protocol extended capabilities for usb 3 ports, each
>> with their own custom protocol speed ID table.
>>
>> xhci driver assumes there is only one custome PSI table per roothub,
>> and we will end up allocating the second PSI table on top of the first,
>> leaking the first.
>>
>> Could you boot with xhci dynamic debug enabled, and show dmesg after boot, add:
>> xhci_hcd.dyndbg=+p
>> to you kernel cmdline.
>>
>> Or as an alternative, show output of:
>>
>> sudo cat /sys/kernel/debug/usb/xhci/*/reg-ext-protocol*
> 
> `/sys/kernel/debug/` cannot be read by unprivileged users, so the wildcard does
> not work with `sudo`.
> 
> ```
> $ sudo ls /sys/kernel/debug/usb/xhci
> 0000:12:00.0  0000:26:00.3  0000:26:00.4
> # cat /sys/kernel/debug/usb/xhci/*/reg-ext-protocol*

problematic xhci:
capability for first four USB 2 ports
> EXTCAP_REVISION = 0x02000402
> EXTCAP_NAME = 0x20425355
> EXTCAP_PORTINFO = 0x00180401
> EXTCAP_PORTTYPE = 0x00000000

capability for one USB 3.1 port (5th port)
> EXTCAP_REVISION = 0x03100802
> EXTCAP_NAME = 0x20425355
> EXTCAP_PORTINFO = 0x10000105
> EXTCAP_PORTTYPE = 0x00000000
> EXTCAP_MANTISSA1 = 0x00050134
capability for one USB 3.1 port (6th port)
> EXTCAP_REVISION = 0x03100802
> EXTCAP_NAME = 0x20425355
> EXTCAP_PORTINFO = 0x10000106
> EXTCAP_PORTTYPE = 0x00000000
> EXTCAP_MANTISSA1 = 0x00050134
capability for one USB 3.1 port (7th port)
> EXTCAP_REVISION = 0x03100802
> EXTCAP_NAME = 0x20425355
> EXTCAP_PORTINFO = 0x10000107
> EXTCAP_PORTTYPE = 0x00000000
> EXTCAP_MANTISSA1 = 0x00050134
capability for one USB 3.1 port (8th port)
> EXTCAP_REVISION = 0x03100802
> EXTCAP_NAME = 0x20425355
> EXTCAP_PORTINFO = 0x10000108
> EXTCAP_PORTTYPE = 0x00000000
> EXTCAP_MANTISSA1 = 0x00050134

It has eight ports.  last four of them are USB 3.1 ports.
It has a very odd setup where each 3.1 port has their own
supported protocol capability with a custom PSI, but all the PSI's are similar,
telling the port only support a 5Gbps speed.

We leak all the custom PSI tables for USB 3.1 ports except the last,
these would be the EXTCAP_MANTISSA1 = 0x00050134, which is the same as
the hex dump of the unreferenced object you posted earlier (considering byte order):

hex dump (first 8 bytes):
34 01 05 00 00 00 00 00                          4.......

I'm working on a patch for this

-Mathias
