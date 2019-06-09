Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952D7C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A27C205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099162;
	bh=oy9SgvTgrXOvvCWL9PBmLvliks1+yZDfJ8ery3etdGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GQVtSuVhyGal9WVLqnJEGm6Rkbnz88jIfA7b6aQTz/Pw9Y9x5+XaTJX2xs7YXMXzL
	 mWBYhMo3/8dVDF1Hm6ahvUGxSMcGKrZ1w2EJk6uTTPyrw7qk5ud/pMf4VF2mvqiJWp
	 3pVi8ww+Oq2GxDAUib7Q/Rirag8KB9Xr9aPKzBME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbfFIQwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732239AbfFIQwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:52:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196D9205ED;
        Sun,  9 Jun 2019 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099154;
        bh=oy9SgvTgrXOvvCWL9PBmLvliks1+yZDfJ8ery3etdGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5QzHE5hlf77/9tVkrpOrvQykiY/ZK0epxeu8T6vEe+Zxj+iMghbmiCWG7H5nnbKx
         4ivrBhGixYlmYbbJpo4ABUesf2vF4GxQvPYNbYuRwlEPus4YGLS6wlf9YJbK3HuosI
         QXW8VI/ylbHZAyNlEtC/Xj4Q7ZvLs+BHfVFjNatw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.9 22/83] xhci: Convert xhci_handshake() to use readl_poll_timeout_atomic()
Date:   Sun,  9 Jun 2019 18:41:52 +0200
Message-Id: <20190609164129.398178303@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
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
@@ -47,7 +48,6 @@ static unsigned int quirks;
 module_param(quirks, uint, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
-/* TODO: copied from ehci-hcd.c - can this be refactored? */
 /*
  * xhci_handshake - spin reading hc until handshake completes or fails
  * @ptr: address of hc register to be read
@@ -64,18 +64,16 @@ MODULE_PARM_DESC(quirks, "Bit flags for
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


