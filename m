Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE47C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28480206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564578149;
	bh=KjEe7amqpCqC9w7RxZ3Oq8fK75FxK2HEnrDQMQKNAvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hPsxvC7BcoxWBvTjoFSlDrTwTr43rDekglrh3izNLQnjZAe9TRJbwFrOyfyjFfMme
	 a5LBHTbhrWlxGvntC4df2JceyslvDAuebnuatVp2k9PNUOu3UoHDT0QNJLK9UEwJW+
	 +Lbvr4UjzfmMnUWPUa+U1CeN/L3aY5K41i2VypBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfGaNC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbfGaNC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:02:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50A1D206B8;
        Wed, 31 Jul 2019 13:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564578145;
        bh=KjEe7amqpCqC9w7RxZ3Oq8fK75FxK2HEnrDQMQKNAvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCEgr1blBe2Jtrqctr1QgorJfZNSL+7Asd5bf7r05K4ZMoBTowaiuB/hR6+XCeKnr
         kBfuBfkAoMbhlPtJZZ99dWeMRZ6OhAW/G7fDxgALknV7I0bix4P3A7/9p8UcxkVmBm
         3OFb5cax0Dvdizet+qqBRAxciDMd8lCDMqSJdZVQ=
Date:   Wed, 31 Jul 2019 15:02:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH v3 7/7] habanalabs: create two char devices per ASIC
Message-ID: <20190731130223.GB7590@kroah.com>
References: <20190731125901.20709-1-oded.gabbay@gmail.com>
 <20190731125901.20709-8-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731125901.20709-8-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:59:01PM +0300, Oded Gabbay wrote:
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
> The second char device is called "hl_controlDx", where x is the same index
> of the main device with a minor number of the original char device + 1.
> Applications that open this device can only call the INFO IOCTL. There is
> no limitation on the number of applications opening this device.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Looks good, thanks for changing the minor allocation:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
