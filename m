Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A50C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90345227BF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgACLEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:04:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:42417 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgACLEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:04:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 03:04:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,390,1571727600"; 
   d="scan'208";a="224936720"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 03 Jan 2020 03:04:52 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 03 Jan 2020 13:04:51 +0200
Date:   Fri, 3 Jan 2020 13:04:51 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg KH <greg@kroah.com>, Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: KASAN: use-after-free in
 xhci_trb_virt_to_dma.part.24+0x1c/0x80
Message-ID: <20200103110451.GJ465886@lahna.fi.intel.com>
References: <95b4bdb2-962f-561e-ac14-79cd44395915@molgen.mpg.de>
 <20180720095410.GA11904@kroah.com>
 <107dbdd1-4e45-836f-7f8f-85bc63374e4f@molgen.mpg.de>
 <30b069b5-63f6-dd9e-b323-668f06bff6cf@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b069b5-63f6-dd9e-b323-668f06bff6cf@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 03:10:14PM +0100, Paul Menzel wrote:
> Mika, as you fixed the other leak, any idea, how to continue from the
> kmemleak log below?
> 
> ```
> unreferenced object 0xffff8c207a1e1408 (size 8):
>   comm "systemd-udevd", pid 183, jiffies 4294667978 (age 752.292s)
>   hex dump (first 8 bytes):
>     34 01 05 00 00 00 00 00                          4.......
>   backtrace:
>     [<00000000aea7b46d>] xhci_mem_init+0xcfa/0xec0 [xhci_hcd]

There are probably better ways for doing this but you can use objdump
for example:

  $ objdump -l --prefix-addresses -j .text --disassemble=xhci_mem_init drivers/usb/host/xhci-hcd.ko

then find the offset xhci_mem_init+0xcfa. It should show you the line
numbers as well if you have compiled your kernel with debug info. This
should be close to the line that allocated the memory that was leaked.
