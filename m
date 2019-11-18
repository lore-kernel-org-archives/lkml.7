Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A4EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242D72075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574067579;
	bh=AaTzF3cJV8Sg3eBg3hJbaGH/Qs9golmuYlRDaHIVe1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cqdTRsVHRj6tkLK9j1KwxsC5EzITngGewaEh84dKhntV1QTVdzeHzojAFp9vlZY1+
	 721mPEoIrmuJnpEGo79ojNjOHn/ghS68QsZ3lQYDAYsHIk4roeImFJSTGH1htRwB3+
	 4PvkV/v6LU3lvnNQw7+T8xn6Eu7JR/Xw9edebvXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfKRI7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:59:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfKRI7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:59:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F28B20727;
        Mon, 18 Nov 2019 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574067577;
        bh=AaTzF3cJV8Sg3eBg3hJbaGH/Qs9golmuYlRDaHIVe1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAKBqW11oMQS19BrtGVHxwBqbPE7uYwcEEy0g21zDgZPA9XwPysrQA20v0zDXI3C+
         wH2ekGVRYjXy2LH3ppBX/LUq1WfrS1CJcDyGBDLktil3JkGzjHQJxTJIBW5rctXBsZ
         yV1zIOtbU0QPfxf0u3lwNJrtByj6SbCPfNeYudV0=
Date:   Mon, 18 Nov 2019 09:59:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, coreboot@coreboot.org,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: Re: [Patch v2 1/3] firmware: google: Release devices before
 unregistering the bus
Message-ID: <20191118085933.GA150384@kroah.com>
References: <20191118083903.19311-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118083903.19311-1-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 09:38:58AM +0100, patrick.rudolph@9elements.com wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Fix a bug where the kernel module can't be loaded after it has been
> unloaded as the devices are still present and conflicting with the
> to be created coreboot devices.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  drivers/firmware/google/coreboot_table.c | 7 +++++++
>  1 file changed, 7 insertions(+)

You forgot to document what changed from v1 of this patch and/or series
somewhere :(

Usually it just goes below the --- line on each patch.

Can you fix that up and send a v3 of this series?

thanks

greg k-h
