Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D698CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445A0205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210959;
	bh=8jmxZ2IQvza0hiJBvlidENn+RvnEXJ8eFPMGst97j9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BWd46QgIIdytXFschEFxXO3eopA+X+Q9/bgU3PR4zBFvwuWScORxYz7tsWpoEjeay
	 OeM/ewKTjFiGn14fxS3DqEjSPxCoRfQF5OlYr40Jd8HH2HPSTBplBZKKTmLNExxRvt
	 4ZBF1PmKBott43f7T1tiOROxlulA7HUnjNUoAGgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfJ0VPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbfJ0VPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:15:49 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F2A52070B;
        Sun, 27 Oct 2019 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210948;
        bh=8jmxZ2IQvza0hiJBvlidENn+RvnEXJ8eFPMGst97j9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsI21zOHMf3Wc6VeF/5wHeesRgfgPyTV7Ycx4spIRVBBkIhRRgk6sI+ZHDtyaGvdy
         /sR8jN8QBh62Wb7uicGqBgFv9GQvYgdfHHRtDsbA7PoJF8GOt8isfqICcNg2X8XCE+
         Gqr2YahOTQ6WskkchPsQkogQ06r0FItvx9CYc7cU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 4.19 71/93] parisc: Fix vmap memory leak in ioremap()/iounmap()
Date:   Sun, 27 Oct 2019 22:01:23 +0100
Message-Id: <20191027203309.163217642@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 513f7f747e1cba81f28a436911fba0b485878ebd upstream.

Sven noticed that calling ioremap() and iounmap() multiple times leads
to a vmap memory leak:
	vmap allocation for size 4198400 failed:
	use vmalloc=<size> to increase size

It seems we missed calling vunmap() in iounmap().

Signed-off-by: Helge Deller <deller@gmx.de>
Noticed-by: Sven Schnelle <svens@stackframe.org>
Cc: <stable@vger.kernel.org> # v3.16+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/mm/ioremap.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -3,7 +3,7 @@
  * arch/parisc/mm/ioremap.c
  *
  * (C) Copyright 1995 1996 Linus Torvalds
- * (C) Copyright 2001-2006 Helge Deller <deller@gmx.de>
+ * (C) Copyright 2001-2019 Helge Deller <deller@gmx.de>
  * (C) Copyright 2005 Kyle McMartin <kyle@parisc-linux.org>
  */
 
@@ -84,7 +84,7 @@ void __iomem * __ioremap(unsigned long p
 	addr = (void __iomem *) area->addr;
 	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
 			       phys_addr, pgprot)) {
-		vfree(addr);
+		vunmap(addr);
 		return NULL;
 	}
 
@@ -92,9 +92,11 @@ void __iomem * __ioremap(unsigned long p
 }
 EXPORT_SYMBOL(__ioremap);
 
-void iounmap(const volatile void __iomem *addr)
+void iounmap(const volatile void __iomem *io_addr)
 {
-	if (addr > high_memory)
-		return vfree((void *) (PAGE_MASK & (unsigned long __force) addr));
+	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
+
+	if (is_vmalloc_addr((void *)addr))
+		vunmap((void *)addr);
 }
 EXPORT_SYMBOL(iounmap);


