Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2722C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C986C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfLPSG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:06:56 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:49694 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729811AbfLPSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:06:53 -0500
X-Greylist: delayed 1122 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 13:06:52 EST
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1iguTY-0001XZ-D9; Mon, 16 Dec 2019 17:48:08 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iguTX-006Dwq-TZ; Mon, 16 Dec 2019 17:48:07 +0000
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     ben.dooks@codethink.co.uk
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: musb: fix __iomem in trace functions
Date:   Mon, 16 Dec 2019 17:48:07 +0000
Message-Id: <20191216174807.1483538-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace functions should have __iomem on the addr
pointers. Add __iomem to avoid the following warnings
from sparse:

drivers/usb/musb/musb_core.c:253:55: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:253:55:    expected void const *addr
drivers/usb/musb/musb_core.c:253:55:    got void const [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:259:56: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:259:56:    expected void const *addr
drivers/usb/musb/musb_core.c:259:56:    got void [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:267:55: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:267:55:    expected void const *addr
drivers/usb/musb/musb_core.c:267:55:    got void const [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:273:56: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:273:56:    expected void const *addr
drivers/usb/musb/musb_core.c:273:56:    got void [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:383:55: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:383:55:    expected void const *addr
drivers/usb/musb/musb_core.c:383:55:    got void const [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:390:56: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:390:56:    expected void const *addr
drivers/usb/musb/musb_core.c:390:56:    got void [noderef] <asn:2> *addr

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/musb/musb_trace.h | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_trace.h b/drivers/usb/musb/musb_trace.h
index a97d618fe8ff..b193daf69685 100644
--- a/drivers/usb/musb/musb_trace.h
+++ b/drivers/usb/musb/musb_trace.h
@@ -38,11 +38,12 @@ TRACE_EVENT(musb_log,
 );
 
 DECLARE_EVENT_CLASS(musb_regb,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u8 data),
+	TP_PROTO(void *caller, const void  __iomem *addr,
+		 unsigned int offset, u8 data),
 	TP_ARGS(caller, addr, offset, data),
 	TP_STRUCT__entry(
 		__field(void *, caller)
-		__field(const void *, addr)
+		__field(const void __iomem *, addr)
 		__field(unsigned int, offset)
 		__field(u8, data)
 	),
@@ -57,21 +58,24 @@ DECLARE_EVENT_CLASS(musb_regb,
 );
 
 DEFINE_EVENT(musb_regb, musb_readb,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u8 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u8 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DEFINE_EVENT(musb_regb, musb_writeb,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u8 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u8 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DECLARE_EVENT_CLASS(musb_regw,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u16 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u16 data),
 	TP_ARGS(caller, addr, offset, data),
 	TP_STRUCT__entry(
 		__field(void *, caller)
-		__field(const void *, addr)
+		__field(const void __iomem *, addr)
 		__field(unsigned int, offset)
 		__field(u16, data)
 	),
@@ -86,21 +90,24 @@ DECLARE_EVENT_CLASS(musb_regw,
 );
 
 DEFINE_EVENT(musb_regw, musb_readw,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u16 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u16 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DEFINE_EVENT(musb_regw, musb_writew,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u16 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u16 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DECLARE_EVENT_CLASS(musb_regl,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u32 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u32 data),
 	TP_ARGS(caller, addr, offset, data),
 	TP_STRUCT__entry(
 		__field(void *, caller)
-		__field(const void *, addr)
+		__field(const void __iomem *, addr)
 		__field(unsigned int, offset)
 		__field(u32, data)
 	),
@@ -115,12 +122,14 @@ DECLARE_EVENT_CLASS(musb_regl,
 );
 
 DEFINE_EVENT(musb_regl, musb_readl,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u32 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u32 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DEFINE_EVENT(musb_regl, musb_writel,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u32 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u32 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
-- 
2.24.0

