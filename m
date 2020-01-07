Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D680C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56B9206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgAGMHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:07:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:63952 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgAGMHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:07:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 04:07:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="303173288"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2020 04:07:27 -0800
Subject: Re: BUG: KASAN: use-after-free in
 xhci_trb_virt_to_dma.part.24+0x1c/0x80
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg KH <greg@kroah.com>, Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <95b4bdb2-962f-561e-ac14-79cd44395915@molgen.mpg.de>
 <20180720095410.GA11904@kroah.com>
 <107dbdd1-4e45-836f-7f8f-85bc63374e4f@molgen.mpg.de>
 <30b069b5-63f6-dd9e-b323-668f06bff6cf@molgen.mpg.de>
 <20200103110451.GJ465886@lahna.fi.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <81c6f906-3f5a-729d-f3b4-1ac6ac607c05@linux.intel.com>
Date:   Tue, 7 Jan 2020 14:09:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200103110451.GJ465886@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.1.2020 13.04, Mika Westerberg wrote:
> On Thu, Jan 02, 2020 at 03:10:14PM +0100, Paul Menzel wrote:
>> Mika, as you fixed the other leak, any idea, how to continue from the
>> kmemleak log below?
>>
>> ```
>> unreferenced object 0xffff8c207a1e1408 (size 8):
>>    comm "systemd-udevd", pid 183, jiffies 4294667978 (age 752.292s)
>>    hex dump (first 8 bytes):
>>      34 01 05 00 00 00 00 00                          4.......
>>    backtrace:
>>      [<00000000aea7b46d>] xhci_mem_init+0xcfa/0xec0 [xhci_hcd]
> 
> There are probably better ways for doing this but you can use objdump
> for example:
> 
>    $ objdump -l --prefix-addresses -j .text --disassemble=xhci_mem_init drivers/usb/host/xhci-hcd.ko
> 
> then find the offset xhci_mem_init+0xcfa. It should show you the line
> numbers as well if you have compiled your kernel with debug info. This
> should be close to the line that allocated the memory that was leaked.
> 

Paul, it possible that your xhci controller has several
supported protocol extended capabilities for usb 3 ports, each
with their own custom protocol speed ID table.

xhci driver assumes there is only one custome PSI table per roothub,
and we will end up allocating the second PSI table on top of the first,
leaking the first.

Could you boot with xhci dynamic debug enabled, and show dmesg after boot, add:
xhci_hcd.dyndbg=+p
to you kernel cmdline.

Or as an alternative, show output of:

sudo cat /sys/kernel/debug/usb/xhci/*/reg-ext-protocol*

-Mathias
