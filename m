Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A15C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2226205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100146;
	bh=t4JQrWETUCvI1PDLC+Gj2NlQoZwI/rUV1gGkZUpklA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rCPtBdxSST/6JqTRcD//z3CxMwfVfOmsRQBCo4iGBpnaahRrnV0/67z+SKHOtL905
	 yPv478zjkj8f+0qVqvEU+JkOIJCDoewDansc96V9eTzs4ACF93O0665nJL1muy4Et3
	 oSWKN223bWTBdb6Jy5sPgjfbuOVNRgGjcG2Rzpy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbfFIRJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387804AbfFIREW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:04:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9189C20868;
        Sun,  9 Jun 2019 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099862;
        bh=t4JQrWETUCvI1PDLC+Gj2NlQoZwI/rUV1gGkZUpklA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1AbXGtiVC/cTFVxsLWO0oftOPOsPlVAeIKr2caYtFj7UYvDXXMAgQIU+Hqqa2Opgw
         QDikYftIyHscVlTsfLlnGlH4JsMAPY5X+KXe9pl0IJbN+n+SDm5QmpUljvdR/az1nX
         0OIgP1ZYtoYe5Zx9XQ1SOaNE2ByVLKPKWHVV30fc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.4 194/241] xhci: Convert xhci_handshake() to use readl_poll_timeout_atomic()
Date:   Sun,  9 Jun 2019 18:42:16 +0200
Message-Id: <20190609164153.558202861@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

commit f7fac17ca925faa03fc5eb854c081a24075f8bad upstream.

Xhci_handshake() implements the algorithm already captured by
readl_poll_timeout_atomic(). Convert the former to use the latter to
avoid repetition.

Turned out this patch also fixes a bug on the AMD Stoneyridge platform
where usleep(1) sometimes takes over 10ms.
This means a 5 second timeout can easily take over 15 seconds which will
trigger the watchdog and reboot the system.

[Add info about patch fixing a bug to commit message -Mathias]
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Tested-by: Raul E Rangel <rrangel@chromium.org>
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/log2.h>
 #include <linux/module.h>
@@ -46,7 +47,6 @@ static unsigned int quirks;
 module_param(quirks, uint, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
-/* TODO: copied from ehci-hcd.c - can this be refactored? */
 /*
  * xhci_handshake - spin reading hc until handshake completes or fails
  * @ptr: address of hc register to be read
@@ -63,18 +63,16 @@ MODULE_PARM_DESC(quirks, "Bit flags for
 int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
 {
 	u32	result;
+	int	ret;
 
-	do {
-		result = readl(ptr);
-		if (result == ~(u32)0)		/* card removed */
-			return -ENODEV;
-		result &= mask;
-		if (result == done)
-			return 0;
-		udelay(1);
-		usec--;
-	} while (usec > 0);
-	return -ETIMEDOUT;
+	ret = readl_poll_timeout_atomic(ptr, result,
+					(result & mask) == done ||
+					result == U32_MAX,
+					1, usec);
+	if (result == U32_MAX)		/* card removed */
+		return -ENODEV;
+
+	return ret;
 }
 
 /*


