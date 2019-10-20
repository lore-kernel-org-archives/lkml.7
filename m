Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA655CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 01:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF32222CD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 01:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="XzpmTSYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZyA4O/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfJTBxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 21:53:17 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40169 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfJTBxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 21:53:16 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2F80F39A;
        Sat, 19 Oct 2019 21:53:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 19 Oct 2019 21:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=N7lvcTtfqNF2xYQM7/Bw3plnmv
        vQ+7cm6jFmlCIU9kY=; b=XzpmTSYf304D7ctUTQaARkdHOH9BxSX7I9RVTgMam6
        cHAVn+hjjdrQYbmBApGhmFBUFlACGcQmQLIHLSa5OofXBSWyzsw5qSH0g+Tw1IQU
        1xIm7aOwEGXpYGpWSwLJxdjgTKJ8bKV2iKMkrd9HfvudneCmoUWvl4sYquIJ9y4a
        O13UXaCyYPCWkwvkNaKmvujxRAuoylIhgCZ10Gjlr/jFCqMk4DfdbpqRcxLQizHd
        T8Ig1d6WsygMLO3ACpQOvpnk3VfGL72gJDY9WZGAtljNL7N6eNlqj5anzV0+JySd
        rvHwtCp/0ef7gOC8Dve/FgT9FpT+G4IlJ7bLLEhXRO0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=N7lvcTtfqNF2xYQM7
        /Bw3plnmvvQ+7cm6jFmlCIU9kY=; b=SZyA4O/DupIKRp3c1clm7qFsgFaujhduF
        bLlYTMb8jbtE9tBHPaSkcMLYIv4YXb+RkO5USD2a5+sT/8gL+cQrqmEw4+XMJYdd
        A8VBrCvx1aNyuO/J6vbB/qt9ITbwnsNSWl3f6pQeY8LaTKvemfJN/nWR9fUPcZIw
        +/pqAjhk8bcGNE9fQejogA30bwMUyilVUo8y1N4aBAM99gsnMT7voO6eGuePJsN6
        6O6UM4M1jg8KGlad8WBXCp80zmMjYw+u0Kmcixk4uVph4kQ+pJHJLCDxwk9ZEeqs
        oIMd6oLphsG07aWYhQTuaABAz0plnTPlHe0x5j+368v0QVhSMmTqw==
X-ME-Sender: <xms:Cr6rXa3jZ0qgIKG9Mt5QkpflThxqUQHX6_zJWqfotfxNBAY1wEdCAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrkedvgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghl
    sehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Cr6rXdTj7rZmrudjctWmIYgdkfk62G5o0gtEgCz4EUOBdxD9yEqh1w>
    <xmx:Cr6rXcbidpCwh_EMKhjZJ_bCRFZs8JV_TSO1C5KriAQL158j9FTTDw>
    <xmx:Cr6rXa4nvErZ2X2IvLIb696F5GcjmrTboRilA07qZtRrkVORNBtjmQ>
    <xmx:Cr6rXdtTEHuSXxB3dGL5HeeXQHwvQye-JN9vErWtCWEHHTnm54P77w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04CD6D6005A;
        Sat, 19 Oct 2019 21:53:13 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>, stable@vger.kernel.org
Subject: [PATCH] usb: xhci: fix Immediate Data Transfer endianness
Date:   Sat, 19 Oct 2019 20:53:13 -0500
Message-Id: <20191020015313.4558-1-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arguments to queue_trb are always byteswapped to LE for placement in
the ring, but this should not happen in the case of immediate data; the
bytes copied out of transfer_buffer are already in the correct order.
Add a complementary byteswap so the bytes end up in the ring correctly.

This was observed on BE ppc64 with a "Texas Instruments TUSB73x0
SuperSpeed USB 3.0 xHCI Host Controller [104c:8241]" as a ch341
usb-serial adapter ("1a86:7523 QinHeng Electronics HL-340 USB-Serial
adapter") always transmitting the same character (generally NUL) over
the serial link regardless of the key pressed.

Cc: stable@vger.kernel.org
Fixes: 33e39350ebd2 ("usb: xhci: add Immediate Data Transfer support")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/usb/host/xhci-ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 85ceb43e3405..e7aab31fd9a5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3330,6 +3330,7 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			if (xhci_urb_suitable_for_idt(urb)) {
 				memcpy(&send_addr, urb->transfer_buffer,
 				       trb_buff_len);
+				le64_to_cpus(&send_addr);
 				field |= TRB_IDT;
 			}
 		}
@@ -3475,6 +3476,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		if (xhci_urb_suitable_for_idt(urb)) {
 			memcpy(&addr, urb->transfer_buffer,
 			       urb->transfer_buffer_length);
+			le64_to_cpus(&addr);
 			field |= TRB_IDT;
 		} else {
 			addr = (u64) urb->transfer_dma;
-- 
2.21.0

