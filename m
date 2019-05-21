Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E449C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51B0217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558433833;
	bh=omOok4OFtOW0GJ23HMKWDqUM1PZkhGph9ABMqIPnCkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hod9bnBjAk1QKN0kOW5dUsY/Q6nX9a5Q0plE/OQYd9b5lLdblkn+1a2IRtsFelE8m
	 i5jEkHQpl5jKUOY2eWfNnFf91rBFq+HuCli1zgF2QbE9nfDEZKkLwi+0cnT6WSGisQ
	 HIY9BYdpDinWhl9ishDRrO/GZxPkWXP7e5JtPe0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfEUKRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUKRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:17:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 537E921773;
        Tue, 21 May 2019 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558433831;
        bh=omOok4OFtOW0GJ23HMKWDqUM1PZkhGph9ABMqIPnCkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LF22EzwwEy0UTKUxnbibe7PJbBYAXTZEDlL9f24YFxvNBit710rgIS/qikBBwKQkZ
         GiIfMq8FClOSqnG4lZt2NBrCkwEwhGKwYvcI/9P166dJg/hQgd1nVdVma0sZ4vuvyx
         AqUFfEs/m97vpoAgfv/86v07f0RXSn/aYa83BbIg=
Date:   Tue, 21 May 2019 12:17:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] tty: max310x: Simplify the code and fix a few bugs
Message-ID: <20190521101701.GA31141@kroah.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 01:14:08PM +0300, Serge Semin wrote:
> I started using this driver two years ago in kernek 4.4 and then in kernel
> 4.9. It didn't go well from the very beginning due to my platform
> peculiarities: DW SPI core with hardware CS and relatively slow MIPS-based
> SoC. This patchset is intended to fix some of the problems I found out
> during the max310x driver utilization with max14830 device.
> 
> First of all it was discovered, that workqueue API isn't optimally used.
> Work context isn't re-entrant by design, so the mutex used to guard the
> TX-method is redundant. schedule_work() method is also created in a way
> the work item is scheduled only if it isn't pending. Patch 1 concerns all
> these fixes. Seeing the similar container_of(uart_port) is used three
> times in the driver, the patch 2 introduces a macro to_max310x_port() to
> get a pointer to corresponding struct max310x_one. This is the code
> simplification and is going to be used in the following patches.
> 
> It was found out, that batch read and write methods used buffers allocated
> on the kernel stack. Since they might be utilized by SPI controllers for
> DMA it might be unsafe on some platforms. Patch 3 provides a dedicated
> kmalloced buffers for this.
> 
> The baud-rate calculator function didn't work correct for all the possible
> baud-rates requested within a pre-defined input reference frequency.
> Instead an algo fully compliant with datasheet divisor formulae is
> implemented in patch 4.
> 
> Patches 5 and 6 are created to fix some rs485 issues. Particularly the
> rs485 mode is configured on the port startup if it's enabled. And seeing
> the mode2 register provides a way to enable/disable the echo-suppression
> in RS485 mode, it is used to implement the SER_RS485_RX_DURING_TX flag
> support.
> 
> Finally it was discovered that in case if inbound hardware FIFO
> experienced overflow, a lot of '\0' characters inserted into the
> flip-buffer as a character of the RX-FIFO overrun. It isn't quite correct
> since the overflow happened only after the last character had been
> received. Patch 7 is dedicated to push only a single RX-FIFO overrun
> character in this case.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Nice cleanups, all now applied, thanks!

greg k-h
