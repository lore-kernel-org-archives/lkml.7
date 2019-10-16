Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3124BFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3148207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263612;
	bh=kbqYrKp9K7Y0yVz+0W0CU40rQnMwPb3hoPbkR185Xq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uYn8Re7lUxdasCijVsWXqr69N0QkALDiMMJqDdYqpJKvwdIz8wqa9Q6CEvpvkz4Il
	 ATzCyySZFPD9IOP3UfRdhZOyw2Ev2dnKqrlnJyHJk6GjRdXXsGXLsUFYc/MCPfFa0S
	 ckX7wZYgtyhY7xhZjd05pJQuoPEWrRwZ0cE65e60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407006AbfJPWGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406717AbfJPV6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:23 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51FC021A49;
        Wed, 16 Oct 2019 21:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263103;
        bh=kbqYrKp9K7Y0yVz+0W0CU40rQnMwPb3hoPbkR185Xq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w9uZxNTBsWF9kFon7hF7B8iJVK7BAN6zLd6VRPVtg1N9pfaMJiD4RqF9p8GcIUCQv
         2d+fzP6ImIpz60XJ6ZasU4jeablFV6kkccOIl3/CUqDvjal9MSGOdlLG7EBpKTyr83
         1Am3pahKqDFpzoa05and6X0ZxFsc4S0F2TAI/Wgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.3 007/112] xhci: Fix false warning message about wrong bounce buffer write length
Date:   Wed, 16 Oct 2019 14:49:59 -0700
Message-Id: <20191016214845.950987317@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit c03101ff4f74bb30679c1a03d551ecbef1024bf6 upstream.

The check printing out the "WARN Wrong bounce buffer write length:"
uses incorrect values when comparing bytes written from scatterlist
to bounce buffer. Actual copied lengths are fine.

The used seg->bounce_len will be set to equal new_buf_len a few lines later
in the code, but is incorrect when doing the comparison.

The patch which added this false warning was backported to 4.8+ kernels
so this should be backported as far as well.

Cc: <stable@vger.kernel.org> # v4.8+
Fixes: 597c56e372da ("xhci: update bounce buffer with correct sg num")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/1570190373-30684-2-git-send-email-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-ring.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3202,10 +3202,10 @@ static int xhci_align_td(struct xhci_hcd
 	if (usb_urb_dir_out(urb)) {
 		len = sg_pcopy_to_buffer(urb->sg, urb->num_sgs,
 				   seg->bounce_buf, new_buff_len, enqd_len);
-		if (len != seg->bounce_len)
+		if (len != new_buff_len)
 			xhci_warn(xhci,
 				"WARN Wrong bounce buffer write length: %zu != %d\n",
-				len, seg->bounce_len);
+				len, new_buff_len);
 		seg->bounce_dma = dma_map_single(dev, seg->bounce_buf,
 						 max_pkt, DMA_TO_DEVICE);
 	} else {


