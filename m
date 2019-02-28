Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65566C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9352171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbfB1Ixn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:53:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:40441 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730930AbfB1Ixm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:53:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 00:53:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,422,1544515200"; 
   d="scan'208";a="303218114"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2019 00:53:40 -0800
Subject: Re: [PATCH] xhci: use iopoll for xhci_handshake
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     rrangel@chromium.org, Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190227221917.62567-1-djkurtz@chromium.org>
 <20190228070950.GB27446@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <7a6c5fb8-1097-c648-958e-d6547cfa8f72@linux.intel.com>
Date:   Thu, 28 Feb 2019 10:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228070950.GB27446@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.2.2019 9.09, Greg Kroah-Hartman wrote:
> On Wed, Feb 27, 2019 at 03:19:17PM -0700, Daniel Kurtz wrote:
>> In cases such as xhci_abort_cmd_ring(), xhci_handshake() is called with
>> a spin lock held (and local interrupts disabled) with a huge 5 second
>> timeout.  This can translates to 5 million calls to udelay(1).  By its
>> very nature, udelay() is not meant to be precise, it only guarantees to
>> delay a minimum of 1 microsecond. Therefore the actual delay of
>> xhci_handshake() can be significantly longer.  If the average udelay(1)
>> is greater than 2.2 us, the total time in xhci_handshake() - with
>> interrupts disabled can be > 11 seconds triggering the kernel's soft lockup
>> detector.
>>
>> To avoid this, let's replace the open coded io polling loop with one from
>> iopoll.h that uses a loop timed with the more presumably reliable ktime
>> infrastructure.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> Looks sane to me, nice fixup.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Is this causing problems on older kernels/devices today such that we
> should backport this?
> 

A very similar patch was submitted some weeks ago by Andrey Smirnov.

https://lore.kernel.org/lkml/20190208014816.21869-1-andrew.smirnov@gmail.com/

His commit message only mentions that readl_poll_timeout_atomic() does the same job,
not about any issues with the loop,  so I was going to send it forward to usb-next
after 5.1-rc (to 5.2).

-Mathias
