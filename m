Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D7DC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A3B206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565939163;
	bh=nm906M80KO0Xu3l6PWo+UB5AziH6MjwJ4ERd8RA4nlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LijbPb/WQ8MdvAttK+awaxc4meE5jAZOqHoaMRWeF24zB2yzELmCgnAMH+ohnucek
	 JE98X7DQ+whFljvywk9N82Fg5YmAP2dZ8ylmtYBNwqAzWBGoxYkx2VnjHaYdTvlehS
	 nJ9VVVb2yCN/9j974iJI5JXW+NNU1Y+LK1hrl3vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfHPHGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPHGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:06:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC570206C1;
        Fri, 16 Aug 2019 07:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565939161;
        bh=nm906M80KO0Xu3l6PWo+UB5AziH6MjwJ4ERd8RA4nlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIJRJpIqb8t6HI3YwtHz+CaoxOj+ej8gL0oStt1J9jR/k68GfgsF5KI0zIb5i9S5h
         UAPKhRCpOeTvcY4MlmqOCjTtzqg/MT36wSFTSb5ShXTeavXGzhlSnPzZAAy++kbFdY
         NhBemp7LY/Xc0ywrA0Q4IsUePHEjzJ7ALQvalpK0=
Date:   Fri, 16 Aug 2019 09:05:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Mingqiang Chi <mingqiang.chi@intel.com>,
        Jack Ren <jack.ren@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>
Subject: Re: [RFC PATCH 04/15] drivers/acrn: add the basic framework of acrn
 char device driver
Message-ID: <20190816070559.GB1368@kroah.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-5-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565922356-4488-5-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:25:45AM +0800, Zhao Yakui wrote:
> ACRN hypervisor service module is the important middle layer that allows
> the Linux kernel to communicate with the ACRN hypervisor. It includes
> the management of virtualized CPU/memory/device/interrupt for other ACRN
> guest. The user-space applications can use the provided ACRN ioctls to
> interact with ACRN hypervisor through different hypercalls.
> 
> Add one basic framework firstly and the following patches will
> add the corresponding implementations, which includes the management of
> virtualized CPU/memory/interrupt and the emulation of MMIO/IO/PCI access.
> The device file of /dev/acrn_hsm can be accessed in user-space to
> communicate with ACRN module.
> 
> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Co-developed-by: Jack Ren <jack.ren@intel.com>
> Signed-off-by: Jack Ren <jack.ren@intel.com>
> Co-developed-by: Mingqiang Chi <mingqiang.chi@intel.com>
> Signed-off-by: Mingqiang Chi <mingqiang.chi@intel.com>
> Co-developed-by: Liu Shuo <shuo.a.liu@intel.com>
> Signed-off-by: Liu Shuo <shuo.a.liu@intel.com>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/staging/Kconfig         |   2 +

Also, your subject line for all of these patches are wrong, it is not
drivers/acrn :(

And you forgot to cc: the staging maintainer :(

As I have said with NUMEROUS Intel patches in the past, I now refuse to
take patches from you all WITHOUT having it signed-off-by someone from
the Intel "OTC" group (or whatever the Intel Linux group is called these
days).  They are a resource you can not ignore, and if you do, you just
end up making the rest of the kernel community grumpy by having us do
their work for them :(

Please work with them.

greg k-h
