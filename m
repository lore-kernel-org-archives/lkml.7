Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B2DC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DF3216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564746177;
	bh=Xan5DZzaMXhHwR3HpDUVQjKov78JoUNnq/m/XEFCYls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d536oHR7gSuhbafljOR78eGkdljhwLrgdfrRy8syaouZvONGYJIziYYvUHvtaU7Oc
	 9McHnFNck8cZ6zbcQi0WKurlQL9Fo3cMynj1mTTgz2L+EUHkUZ3+9fMkSurHMNVHcL
	 Ioyr1YqSSRVQR1TN/c26EEUwEWRW1KZvayzmiiME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbfHBLmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732584AbfHBLmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:42:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 393E4206A3;
        Fri,  2 Aug 2019 11:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564746172;
        bh=Xan5DZzaMXhHwR3HpDUVQjKov78JoUNnq/m/XEFCYls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lC7CdGY5ef9KTz8k2VdyznVeoNv3FsQgPz7+h725TrJnTWJyNJWj20UxkJjRdYdqe
         SByxkIzMHWMou1Y3AFn0emKcmOkBgqAMvUKXgM+17jwtALjeg3DxsRHPFBdA3ZE1Y2
         fBjoRQN1QCa54hEWbM3lJGl5AIscKNLA1gxpWwA8=
Date:   Fri, 2 Aug 2019 13:42:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [RFC PATCH] usb: typec: tcpm: Ignore unsupported/unknown
 alternate mode requests
Message-ID: <20190802114250.GA4721@kroah.com>
References: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 09:30:37PM -0700, Guenter Roeck wrote:
> TCPM may receive PD messages associated with unknown or unsupported
> alternate modes. If that happens, calls to typec_match_altmode()
> will return NULL. The tcpm code does not currently take this into
> account. This results in crashes.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000001f0
> pgd = 41dad9a1
> [000001f0] *pgd=00000000
> Internal error: Oops: 5 [#1] THUMB2
> Modules linked in: tcpci tcpm
> CPU: 0 PID: 2338 Comm: kworker/u2:0 Not tainted 5.1.18-sama5-armv7-r2 #6
> Hardware name: Atmel SAMA5
> Workqueue: 2-0050 tcpm_pd_rx_handler [tcpm]
> PC is at typec_altmode_attention+0x0/0x14
> LR is at tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm]
> ...
> [<c03fbee8>] (typec_altmode_attention) from [<bf8030fb>]
> 				(tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm])
> [<bf8030fb>] (tcpm_pd_rx_handler [tcpm]) from [<c012082b>]
> 				(process_one_work+0x123/0x2a8)
> [<c012082b>] (process_one_work) from [<c0120a6d>]
> 				(worker_thread+0xbd/0x3b0)
> [<c0120a6d>] (worker_thread) from [<c012431f>] (kthread+0xcf/0xf4)
> [<c012431f>] (kthread) from [<c01010f9>] (ret_from_fork+0x11/0x38)
> 
> Ignore PD messages if the asociated alternate mode is not supported.
> 
> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Fixes: e9576fe8e605c ("usb: typec: tcpm: Support for Alternate Modes")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Taking a stab at the problem. I don't really know if this is the correct
> fix, or even if my understanding of the problem is correct, thus marking
> the patch as RFC.

Now that I think everyone agrees this is a "real" fix, can you resend it
in a format that I can apply it in, with the various acks added?

thanks,

greg k-h
