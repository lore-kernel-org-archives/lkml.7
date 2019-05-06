Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7A8C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B21205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfEFO5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:57:51 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:52196 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727262AbfEFO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:57:49 -0400
Received: (qmail 4141 invoked by uid 2102); 6 May 2019 10:57:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 May 2019 10:57:48 -0400
Date:   Mon, 6 May 2019 10:57:48 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jim Lin <jilin@nvidia.com>
cc:     gregkh@linuxfoundation.org, <mathias.nyman@intel.com>,
        <hminas@synopsys.com>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <prime.zeng@hisilicon.com>,
        <malat@debian.org>, <nsaenzjulienne@suse.de>, <jflat@chromium.org>,
        <linus.walleij@linaro.org>, <clabbe@baylibre.com>,
        <colin.king@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] usb: xhci: Add Clear_TT_Buffer
In-Reply-To: <1557153262-22972-1-git-send-email-jilin@nvidia.com>
Message-ID: <Pine.LNX.4.44L0.1905061053550.1585-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019, Jim Lin wrote:

> USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
> processing for full-/low-speed endpoints connected via a TT, the host
> software must use the Clear_TT_Buffer request to the TT to ensure
> that the buffer is not in the busy state".
> 
> In our case, a full-speed speaker (ConferenceCam) is behind a high-
> speed hub (ConferenceCam Connect), sometimes once we get STALL on a
> request we may continue to get STALL with the folllowing requests,
> like Set_Interface.
> 
> Here we add Clear_TT_Buffer for the following Set_Interface requests
> to get ACK successfully.
> 
> Originally usb_hub_clear_tt_buffer uses urb->dev->devnum as device
> address while sending Clear_TT_Buffer command, but this doesn't work
> for XHCI.

Why doesn't it work for xHCI?  Clear-TT-Buffer is part of the USB 2.0 
spec; it should work exactly the same for xHCI as for a USB-2.0 host 
controller.

Alan Stern

