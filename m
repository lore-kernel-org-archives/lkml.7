Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1094BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDDE217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389152AbfEXHi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:38:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfEXHi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:38:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FE8530DE18C;
        Fri, 24 May 2019 07:38:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48A725B683;
        Fri, 24 May 2019 07:38:38 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 2/3] x86/kexec/64: Error out if try to jump to old 4-level kernel from 5-level kernel
Date:   Fri, 24 May 2019 15:38:09 +0800
Message-Id: <20190524073810.24298-3-bhe@redhat.com>
In-Reply-To: <20190524073810.24298-1-bhe@redhat.com>
References: <20190524073810.24298-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 24 May 2019 07:38:58 +0000 (UTC)
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
index 22f60dd26460..7f439739ea3d 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -321,6 +321,11 @@ static int bzImage64_probe(const char *buf, unsigned long len)
 		return ret;
 	}
 
+	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
+		pr_err("bzImage cannot handle 5-level paging mode.\n");
+		return ret;
+	}
+
 	/* I've got a bzImage */
 	pr_debug("It's a relocatable bzImage64\n");
 	ret = 0;
-- 
2.17.2

