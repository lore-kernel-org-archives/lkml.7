Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B68C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AD22087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564483333;
	bh=GhiK+LDdSz/qFNfzUK8xakRYJiEhfODCVpwNMczlKkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IJ5MKfPrb+xcrnuDQEPj/crfIalwjTmWZJVpRDIDYU4RzMZXZ65pj0sMkGYlrrHTF
	 8LJsnJYTYL3B29nmPNQGJuGUlZ6i+Pe9jRoi20V8qDA3QTwyCyl1Cmp4tym9zbxHZ/
	 vNtpgGg0fDUPx2cP46Ah/KeSPGsYfxmkTH2empmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfG3KmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfG3KmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:42:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3040F2087F;
        Tue, 30 Jul 2019 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564483329;
        bh=GhiK+LDdSz/qFNfzUK8xakRYJiEhfODCVpwNMczlKkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gD7KIs1jX78YYswIjWwcDUPIdYSzvwVyIxjOozWIqsPLaU3QTGk1BypuaKiX2p+mk
         4vksFlv6dN9v2pvAGEg+3vVBtPE/7LVss9Kvs98fALIblKmvI4p8ORbzcMgfKNdO+H
         oNcTHLqAd5rvFe5xg+kLeflM76CNaEZo8EXyIbn8=
Date:   Tue, 30 Jul 2019 12:42:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH v2 7/7] habanalabs: create two char devices per ASIC
Message-ID: <20190730104207.GB7325@kroah.com>
References: <20190730094724.18691-1-oded.gabbay@gmail.com>
 <20190730094724.18691-8-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730094724.18691-8-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:47:24PM +0300, Oded Gabbay wrote:
> This patch changes the driver to create two char devices for each ASIC
> it discovers. This is done to allow system/monitoring applications to
> query the device for stats, information, idle state and more, while also
> allowing the deep-learning application to send work to the ASIC.
> 
> One char device is the original device, hlX. IOCTL calls through this
> device file can perform any task on the device (compute, memory, queries).
> The open function for this device will fail if it was called before but
> the file-descriptor it created was not completely released yet (the
> release callback function is not called from the kernel until all
> instances of that FD are closed). The driver needs to keep this behavior
> to support backward compatibility with existing userspace, which count
> that the open will fail if the device is "occupied".
> 
> The second char device is called "hl_controlDx", where x is the minor
> number of the original char device + 64 (HL_CONTROL_MINOR). Applications
> that open this device can only call the INFO IOCTL. There is no limitation
> on the number of applications opening this device.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

This reminds me of the old tty "control" devices we finally got rid of
many years ago.  The more things change... :)

Anyway, looks sane to me.  If you are ok with this userspace api, no
objection from me.

Only one comment below:

> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -51,6 +51,8 @@
>  /* MMU */
>  #define MMU_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
>  
> +#define HL_CONTROL_MINOR		64

Don't try to segment your "dev" and "control" device nodes by minor
number range, as you will run into problems once you have a system with
more than 64 of these in the box at once.

Just use the whole range, and do:
	dev = minor N
	control = minor N+1
and so on.  That makes your control device node an "odd" minor and your
"real" device an "even".

Given that all existing systems should be using devtmpfs, you should not
have any problem with changing the minor number of them at the next
reboot, right?

thanks,

greg k-h
