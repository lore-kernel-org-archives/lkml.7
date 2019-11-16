Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E72AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AC8206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573911429;
	bh=N7e7ejkFZ0oYT6mA483jRqdcw8Rt9UrDJu2/WlCYpWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iDD9qz+pDRnh44c8IntMIPB3/Ao+kl2fpEYy3AxidswWlmqUkmNaY2v9eBxeAwHHx
	 DSrX7BLrqOG2A8C0NCWE7CM0At3k+dKL9oEESXi+J0iSAxnRDuGRRYhtZovWSwjTXi
	 1wVjAcE7JPOTkRXRg0h2vZKjGZAO3AUaS7xkdfag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKPNgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 08:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfKPNgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 08:36:51 -0500
Received: from localhost (unknown [84.241.192.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45C4206D4;
        Sat, 16 Nov 2019 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573911410;
        bh=N7e7ejkFZ0oYT6mA483jRqdcw8Rt9UrDJu2/WlCYpWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfYaKuCi3okMgehQ1BrFT49lXxAk7x0kpXGuBflFO2QzX1M2B9UySxO6hxlgL0xNF
         vRkjFHW2LH1kl9L4D0s4IVbn4g5CGLjov7Ylo5GpmJeOLiYRHJNP6DlPjayPXSbwUk
         0bHsItqP2OLqVfChwoOgvAoq1T6rt9aACICDvi9Y=
Date:   Sat, 16 Nov 2019 14:36:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, coreboot@coreboot.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] firmware: google: Expose CBMEM over sysfs
Message-ID: <20191116133647.GA454551@kroah.com>
References: <20191115161524.23738-1-patrick.rudolph@9elements.com>
 <20191115161524.23738-2-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115161524.23738-2-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 05:15:15PM +0100, patrick.rudolph@9elements.com wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Make all CBMEM buffers available to userland. This is useful for tools
> that are currently using /dev/mem.
> 
> Make the id, size and address available, as well as the raw table data.
> 
> Tools can easily scan the right CBMEM buffer by reading
> /sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/id
> The binary table data can then be read from
> /sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/data
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  drivers/firmware/google/Kconfig          |   9 ++
>  drivers/firmware/google/Makefile         |   1 +
>  drivers/firmware/google/cbmem-coreboot.c | 162 +++++++++++++++++++++++
>  drivers/firmware/google/coreboot_table.h |  13 ++
>  4 files changed, 185 insertions(+)
>  create mode 100644 drivers/firmware/google/cbmem-coreboot.c

As Stephen said, you have to document new sysfs attributes (or changes
or removals) in Documentation/ABI so we have a clue as to how to review
these changes to see if they match the code or not.

Please do so and resend the series with that addition and we will be
glad to review.

thanks,

greg k-h
