Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5609FC04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AED62075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556913361;
	bh=2fH2M5sQ8jmDxxjHYOTc0EzT1IE1mBjRWKLvF07ZDJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zH/j03lCgDH/o6q+ptuHAD+BQ8KkqfVyTRqbn0b7FrdCHKfdozYQMuSNSyopMxP+O
	 vXhEGsRL4o/UOYhjXU+INnJRi3Isd2unEDzO0WdTwMRRmVoL/h3ZjF7+D4HGmDhW2D
	 xtmRDoJ9Ueur6AUrXijNpDOGeE7ALRGEEr0tGaao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfECT4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfECTz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:55:59 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF6FD206BB;
        Fri,  3 May 2019 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556913359;
        bh=2fH2M5sQ8jmDxxjHYOTc0EzT1IE1mBjRWKLvF07ZDJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdlolEb/sTaBBzVCoGSEAnP7QrwOe2EBUEJgSzjARmEhUFjyZ+OxRoYJzYZe4mHr8
         /QG0y2Ey0lDoO+ZhYS8ah17XQ4oP0SNWorijg5Sp/9MnjAW/+R+7IYy8oYIM3UhCMl
         AvxcLyHa4yoMIIurgg8fhK/vBdXDW6wtedLRjdVs=
Date:   Fri, 3 May 2019 14:55:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH v2 3/9] PCI/PME: Prefix dmesg logs with PCIe service name
Message-ID: <20190503195557.GC180403@google.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-4-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503035946.23608-4-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 10:59:40PM -0500, Frederick Lawler wrote:
> Prefix dmesg logs with PCIe service name.

... to make it consistent with other PCIe services.

It's interesting that there are three uses here:

  pci_dbg(port, "PME interrupt generated for non-existent device ...")
  pci_dbg(port, "Spurious native PME interrupt!\n")
  pci_info(port, "Signaling PME with IRQ %d\n", srv->irq)

The first two use pci_dbg(), so whether it goes anywhere depends on
CONFIG_DYNAMIC_DEBUG and DEBUG.  To me they seem interesting enough to
become pci_info().

And all three already include "PME", so I could go either way with
adding the prefix.  But I agree that having it consistent with the
other services is probably a nice small hint that this is a PCIe port
thing, not an endpoint thing.

> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/pcie/pme.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 54d593d10396..d6698423a6d6 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -7,6 +7,8 @@
>   * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
>   */
>  
> +#define dev_fmt(fmt) "PME: " fmt
> +
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> -- 
> 2.17.1
> 
