Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E8DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A9D206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfKMUFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:05:08 -0500
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:47951 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfKMUFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:05:08 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id xADK4blA015292
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 21:04:37 +0100
Date:   Wed, 13 Nov 2019 21:04:37 +0100
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 16/16] firewire: ohci: stop using get_seconds() for
 BUS_TIME
Message-ID: <20191113210437.323f9acd@kant>
In-Reply-To: <20191108213257.3097633-17-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
        <20191108213257.3097633-17-arnd@arndb.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 08 Arnd Bergmann wrote:
> The ohci driver uses the get_seconds() function to implement the 32-bit
> CSR_BUS_TIME register. This was added in 2010 commit a48777e03ad5
> ("firewire: add CSR BUS_TIME support").
> 
> As get_seconds() returns a 32-bit value (on 32-bit architectures), it
> seems like a good fit for that register, but it is also deprecated because
> of the y2038/y2106 overflow problem, and should be replaced throughout
> the kernel with either ktime_get_real_seconds() or ktime_get_seconds().
> 
> I'm using the latter here, which uses monotonic time. This has the
> advantage of behaving better during concurrent settimeofday() updates
> or leap second adjustments and won't overflow a 32-bit integer, but
> the downside of using CLOCK_MONOTONIC instead of CLOCK_REALTIME is
> that the observed values are not related to external clocks.
> 
> If we instead need UTC but can live with clock jumps or overflows,
> then we should use ktime_get_real_seconds() instead, retaining the
> existing behavior.
> 
> Reviewed-by: Clemens Ladisch <clemens@ladisch.de>
> Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Link: https://lore.kernel.org/lkml/20180711124923.1205200-1-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Committed to linux1394.git:for-next.
Thank you for the patch and your extraordinary patience.

> ---
>  drivers/firewire/ohci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
> index 522f3addb5bd..33269316f111 100644
> --- a/drivers/firewire/ohci.c
> +++ b/drivers/firewire/ohci.c
> @@ -1752,7 +1752,7 @@ static u32 update_bus_time(struct fw_ohci *ohci)
>  
>  	if (unlikely(!ohci->bus_time_running)) {
>  		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_cycle64Seconds);
> -		ohci->bus_time = (lower_32_bits(get_seconds()) & ~0x7f) |
> +		ohci->bus_time = (lower_32_bits(ktime_get_seconds()) & ~0x7f) |
>  		                 (cycle_time_seconds & 0x40);
>  		ohci->bus_time_running = true;
>  	}

-- 
Stefan Richter
-======---== =-== -==-=
http://arcgraph.de/sr/
