Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EE3C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBCC206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfKMVDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:03:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38867 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfKMVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:19 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmL-00066g-T0; Wed, 13 Nov 2019 22:02:18 +0100
Message-Id: <20191113210104.404509322@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:47 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 07/20] x86/ioperm: Avoid bitmap allocation if no
 permissions are set
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ioperm() is invoked the first time and the @turn_on argument is 0, then
there is no point to allocate a bitmap just to clear permissions which are
not set.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Split out from large combo patch
---
 arch/x86/kernel/ioport.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -36,6 +36,9 @@ long ksys_ioperm(unsigned long from, uns
 	 */
 	bitmap = t->io_bitmap_ptr;
 	if (!bitmap) {
+		/* No point to allocate a bitmap just to clear permissions */
+		if (!turn_on)
+			return 0;
 		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!bitmap)
 			return -ENOMEM;


