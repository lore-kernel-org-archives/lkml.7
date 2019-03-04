Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C38EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7C3208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688043;
	bh=T/v+I+GhcCIub9+U7K/ZWNKLM6PJnW7sLTCyBvCXnH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dB73lJ0Ce0IYfbIB1K6jtq1fUn2CkV/GIugdJnGXpV+TeoShZKszzwBhRSPvuUo48
	 XHVvn+ACg0w5SpYdSlY4U8b3qp0mq2Mrypiiyyw4lYT23n5OtkLo3fRHioXk5Q57hE
	 TCgaQakXsBehoJiQYip8dgYsV2pMveeWsPJaaUzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfCDI1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:27:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfCDI1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:27:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F92720823;
        Mon,  4 Mar 2019 08:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688035;
        bh=T/v+I+GhcCIub9+U7K/ZWNKLM6PJnW7sLTCyBvCXnH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYVGr5CZ6dgtJFvXEsal4fXTm0kI15eeCpIjuqgF4eIRu0mB1CuI2Q/Bt/z6xxLSx
         KJkwkBWGjEVMITkinpxtIYI7ilndei9RozEqyTAn7vsbzc+1Nd17bEQBoWgk4ZLXpS
         hRsH6ld8+wRn5bjnhyEXXg0o432kBzFcD9H8p2tw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zeng Tao <prime.zeng@hisilicon.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 14/52] usb: dwc3: gadget: Fix the uninitialized link_state when udc starts
Date:   Mon,  4 Mar 2019 09:22:12 +0100
Message-Id: <20190304081617.925222967@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 88b1bb1f3b88e0bf20b05d543a53a5b99bd7ceb6 ]

Currently the link_state is uninitialized and the default value is 0(U0)
before the first time we start the udc, and after we start the udc then
 stop the udc, the link_state will be undefined.
We may have the following warnings if we start the udc again with
an undefined link_state:

WARNING: CPU: 0 PID: 327 at drivers/usb/dwc3/gadget.c:294 dwc3_send_gadget_ep_cmd+0x304/0x308
dwc3 100e0000.hidwc3_0: wakeup failed --> -22
[...]
Call Trace:
[<c010f270>] (unwind_backtrace) from [<c010b3d8>] (show_stack+0x10/0x14)
[<c010b3d8>] (show_stack) from [<c034a4dc>] (dump_stack+0x84/0x98)
[<c034a4dc>] (dump_stack) from [<c0118000>] (__warn+0xe8/0x100)
[<c0118000>] (__warn) from [<c0118050>](warn_slowpath_fmt+0x38/0x48)
[<c0118050>] (warn_slowpath_fmt) from [<c0442ec0>](dwc3_send_gadget_ep_cmd+0x304/0x308)
[<c0442ec0>] (dwc3_send_gadget_ep_cmd) from [<c0445e68>](dwc3_ep0_start_trans+0x48/0xf4)
[<c0445e68>] (dwc3_ep0_start_trans) from [<c0446750>](dwc3_ep0_out_start+0x64/0x80)
[<c0446750>] (dwc3_ep0_out_start) from [<c04451c0>](__dwc3_gadget_start+0x1e0/0x278)
[<c04451c0>] (__dwc3_gadget_start) from [<c04452e0>](dwc3_gadget_start+0x88/0x10c)
[<c04452e0>] (dwc3_gadget_start) from [<c045ee54>](udc_bind_to_driver+0x88/0xbc)
[<c045ee54>] (udc_bind_to_driver) from [<c045f29c>](usb_gadget_probe_driver+0xf8/0x140)
[<c045f29c>] (usb_gadget_probe_driver) from [<bf005424>](gadget_dev_desc_UDC_store+0xac/0xc4 [libcomposite])
[<bf005424>] (gadget_dev_desc_UDC_store [libcomposite]) from[<c023d8e0>] (configfs_write_file+0xd4/0x160)
[<c023d8e0>] (configfs_write_file) from [<c01d51e8>] (__vfs_write+0x1c/0x114)
[<c01d51e8>] (__vfs_write) from [<c01d5ff4>] (vfs_write+0xa4/0x168)
[<c01d5ff4>] (vfs_write) from [<c01d6d40>] (SyS_write+0x3c/0x90)
[<c01d6d40>] (SyS_write) from [<c0107400>] (ret_fast_syscall+0x0/0x3c)

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5da078bf5f76a..32dd0d3462da1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1910,6 +1910,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
+	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
-- 
2.19.1



