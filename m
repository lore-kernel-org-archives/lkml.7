Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC5DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225B62087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R19fkSTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfEGQC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:02:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42223 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEGQC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:02:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so8519936pgh.9;
        Tue, 07 May 2019 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QfYhgnupP/fNNGiA2QuLfe/QEx3mVDKl1QTV9dNr/Z4=;
        b=R19fkSTCfI77P8wyoe3SWgYJbKkC5nJ6jhMes3Y0Hxt+yf1JMlLw63gdxuX3bVSnbF
         GkXm06YNr7F0bNafCSPdvqFd8wDdKB3z9REFauWglIjOGglhgt2cKPllqE1/cvurQryJ
         IroFl3yd8vqgeqbWxr+DL56x7G4F0I/eAVxg27FbbCzCXPNC4Fzxm/TzXVD9amMwO55/
         EUiHrn0ZOIbgI5pARLPbRWY8EQE1VY6VySalhp5rZMlYEul/5HY94TbnTkbYXboRqRBK
         eVxQH9qKE+ZRgS5IGlPj0qffPm1/nH6hQdobUMb5tq1VYcCXbZVx7F7YYnMWCQ7jSYMP
         wG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QfYhgnupP/fNNGiA2QuLfe/QEx3mVDKl1QTV9dNr/Z4=;
        b=PRN/4YUg9A1+Y+OPF+ibKmdD4cIgO2nrEewwnzzHcdRDOBTPefTrDjkE59WTBGtNnC
         OorBQEj0YGr5cVgr7y43MmAdJ+oPOQN8K8K1u/tUwyBME2CJE+t0e65DkF23ZWmr7MJA
         BR9a3OW1W8AEwPvF3zhaslsQSkTVU2NF12R93hH43CdoSzBCCohisYVuK2jySRi/pycW
         k9oj7P9/rUf221mnqbrORaDoHC1CSUNTxMHGBMo696hIHYs5VMc3MF9iUh1scvi7a4li
         8ct9bq4ke75828OfgEWlwxM6X0NAv+GEYOX//429ZgoOhR+FsVCKL1V3RT3nVhG2Rri1
         6wwQ==
X-Gm-Message-State: APjAAAXbVNDCD4+h24JQ/fTasPLq/6NSnkB4o78ep1bJG+6jYoIKccZm
        DgbXrtA2x5qI2SRTBu1MIcF/LOdqxkE=
X-Google-Smtp-Source: APXvYqypRqdlzRGtvI5D91yjVNcV0/v8NIUzlP4VvunTQplsrOMv0Qto9Lg3grBb0v3MeON9Byge4Q==
X-Received: by 2002:a65:578b:: with SMTP id b11mr18793071pgr.446.1557244945913;
        Tue, 07 May 2019 09:02:25 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id 132sm18568503pfw.87.2019.05.07.09.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:02:25 -0700 (PDT)
Date:   Wed, 8 May 2019 01:02:20 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mathias.nyman@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] usb: host: xhci: Support running urb giveback in
 tasklet context
Message-ID: <20190507160219.GB2427@localhost.localdomain>
References: <20190401141611.10087-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401141611.10087-1-suwan.kim027@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:16:11PM +0900, Suwan Kim wrote:
> Patch "USB: HCD: support giveback of URB in tasklet context"[1]
> introduced giveback of urb in tasklet context. [1] This patch was
> applied to ehci but not xhci. [2] This patch significantly reduces
> the hard irq time of xhci. Especially for uvc driver, the hard irq
> including the uvc completion function runs quite long but applying
> this patch reduces the hard irq time of xhci.
> 
> I have tested four SS devices to check if performance degradation
> occurs when urb completion functions run in the tasklet context.
> 
> As a result of the test, all devices works well and shows very
> similar performance with the upstream kernel. Moreover, usb ethernet
> adapter show better performance than the upstream kernel about 5% for
> RX and 2% for TX. Four SS devices is as follows.
> 
> SS devices for test
> 
> 1. WD My Passport 2TB (external hard drive)
> 2. Sandisk Ultra Flair USB 3.0 32GB
> 3. Logitech Brio webcam
> 4. Iptime 1gigabit ethernet adapter (Mediatek RTL8153)
> 
> Test description
> 
> 1. Mass storage (hard drive) performance test
> - run below command 10 times and compute the average performance
> 
>     dd if=/dev/sdN iflag=direct of=/dev/null bs=1G count=1
> 
> 2. Mass storage (flash memory) performance test
> - run below command 10 times and compute the average performance
> 
>     dd if=/dev/sdN iflag=direct of=/dev/null bs=1G count=1
> 
> 3. Webcam streaming performance test
> - run simple capture program and get the average frame rate per second
> - capture 1500 frames
> - program link
> 
>     https://github.com/asfaca/Webcam-performance-analyzing-tool
> 
> - video resolution : 4096 X 2160 (4K) at 30 or 24 fps
> - device (Logitech Brio) spec url for the highest resolution and fps
> 
>     https://support.logitech.com/en_gb/product/brio-stream/specs
> 
> 4. USB Ethernet adapter performance test
> - directly connect two linux machines with ethernet cable
> - run pktgen of linux kernel and send 1500 bytes packets
> - run vnstat to measure the network bandwidth for 180 seconds
> 
> Test machine
> 
> - CPU : Intel i5-7600 @ 3.5GHz
> 
> Test results
> 
> 1. Mass storage (hard drive) performance test
> 
>             WD My Passport 2TB (external hard drive)
> --------------------------------------------------------------------
>     xhci without tasklet        |          xhci with tasklet
> --------------------------------------------------------------------
>          103.667MB/s            |            103.692MB/s
> --------------------------------------------------------------------
> 
> 2. Mass storage (flash memory) performance test
> 
>                Sandisk Ultra Flair USB 3.0 32GB
> --------------------------------------------------------------------
>     xhci without tasklet        |          xhci with tasklet
> --------------------------------------------------------------------
>          129.727MB/s            |            130.2MB/s
> --------------------------------------------------------------------
> 
> 3. Webcam streaming performance test
> 
>                      Logitech Brio webcam
> --------------------------------------------------------------------
>     xhci without tasklet        |          xhci with tasklet
> --------------------------------------------------------------------
>           26.4451 fps           |            26.3949 fps
> --------------------------------------------------------------------
> 
> 4. USB Ethernet adapter performance test
> 
>       Iptime 1gigabit ethernet adapter (Mediatek RTL8153)
> --------------------------------------------------------------------
>     xhci without tasklet        |          xhci with tasklet
> --------------------------------------------------------------------
> RX      933.86 Mbit/s           |            983.86 Mbit/s
> --------------------------------------------------------------------
> TX      830.18 Mbit/s           |            882.75 Mbit/s
> --------------------------------------------------------------------
> 
> [1], https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=94dfd7edfd5c9b605caf7b562de7a813d216e011
> [2], https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=428aac8a81058e2303677a8fbf26670229e51d3a
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> 
> ---
> v2 change:
>         - Add SS device test results and rewrite the description
> ---
>  drivers/usb/host/xhci-ring.c | 2 --
>  drivers/usb/host/xhci.c      | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 40fa25c4d041..0ede5265e6e2 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -644,10 +644,8 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
>  	}
>  	xhci_urb_free_priv(urb_priv);
>  	usb_hcd_unlink_urb_from_ep(hcd, urb);
> -	spin_unlock(&xhci->lock);
>  	trace_xhci_urb_giveback(urb);
>  	usb_hcd_giveback_urb(hcd, urb, status);
> -	spin_lock(&xhci->lock);
>  }
>  
>  static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 7fa58c99f126..bb212b4669cf 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5141,7 +5141,7 @@ static const struct hc_driver xhci_hc_driver = {
>  	 * generic hardware linkage
>  	 */
>  	.irq =			xhci_irq,
> -	.flags =		HCD_MEMORY | HCD_USB3 | HCD_SHARED,
> +	.flags =		HCD_MEMORY | HCD_USB3 | HCD_SHARED | HCD_BH,
>  
>  	/*
>  	 * basic lifecycle operations
> -- 
> 2.20.1

Hi,

I sent this patch a month ago but got no answer.
Is there any feedback for this?
Please let me know if there are any faults or it needs more tests.

Regards

Suwan Kim
