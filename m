Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32028C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C954214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfEIBhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIBhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:37:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 626E9307D935;
        Thu,  9 May 2019 01:37:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DB1F19744;
        Thu,  9 May 2019 01:36:58 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 2/3] x86/kexec/64: Error out if try to jump to old 4-level kernel from 5-level kernel
Date:   Thu,  9 May 2019 09:36:43 +0800
Message-Id: <20190509013644.1246-3-bhe@redhat.com>
In-Reply-To: <20190509013644.1246-1-bhe@redhat.com>
References: <20190509013644.1246-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 09 May 2019 01:37:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the running kernel has 5-level paging activated, the 5-level paging
mode is preserved across kexec. If the kexec'ed kernel does not contain
support for handling active 5-level paging mode in the decompressor, the
decompressor will crash with #GP.

Prevent this situation at load time. If 5-level paging is active, check the
xloadflags whether the kexec kernel can handle 5-level paging at least in
the decompressor. If not, reject the load attempt and print out error
message.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 22f60dd26460..858cc892672f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -321,6 +321,11 @@ static int bzImage64_probe(const char *buf, unsigned long len)
 		return ret;
 	}
 
+	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
+		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");
+		return ret;
+	}
+
 	/* I've got a bzImage */
 	pr_debug("It's a relocatable bzImage64\n");
 	ret = 0;
-- 
2.17.2

