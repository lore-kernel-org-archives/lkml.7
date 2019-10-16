Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A15FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2C921928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263964;
	bh=LgVAG5PeN9vkdUBi+ZqFOcr+Y6j7z+12r4Irna2Ly/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1zcef3WvwOrqda38P3xXybxC4pIAQ4w0sQqVXZLgeDnpsZzCQ4LC4sgwpq+vNpl47
	 BcFs5oHgWD1ADUptLp98aDzu6V61B5s9JjE7L5ePKKpffjdnA3S4B/Kgy7zHHCyvRi
	 gzcu8N/UDKf6nmymO9QfYIc+zbnVMX4WtednM860=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439267AbfJPWMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406507AbfJPV4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:56:13 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3635A20872;
        Wed, 16 Oct 2019 21:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262973;
        bh=LgVAG5PeN9vkdUBi+ZqFOcr+Y6j7z+12r4Irna2Ly/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhvdwaooSOYXvV/usfBq3XYQx+fUmj2oe54mJm8EhzTU61AF2w5O2NRN5BE/8vFuw
         ol9D+oeZXNXdBeKPSfI1CmEqAJYJFwCcnhHJOY8cZHPsfZepfVu/9VZWInZOmSJC8O
         PIpYKFHP8h+HPi0sF8WpbR3qTV2vy76aQXEFx1Cg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 08/65] xhci: Fix false warning message about wrong bounce buffer write length
Date:   Wed, 16 Oct 2019 14:50:22 -0700
Message-Id: <20191016214801.649672190@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
References: <20191016214756.457746573@linuxfoundation.org>
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
@@ -3223,10 +3223,10 @@ static int xhci_align_td(struct xhci_hcd
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


