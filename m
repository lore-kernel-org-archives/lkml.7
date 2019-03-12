Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF2A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfCLKbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:31:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLKbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:31:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97D65A768;
        Tue, 12 Mar 2019 10:31:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 704A51001DED;
        Tue, 12 Mar 2019 10:31:05 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, bp@alien8.de, hpa@zytor.com, dyoung@redhat.com,
        x86@kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/3] x86/kexec/64: Error out if try to jump to old 4-level kernel from 5-level kernel
Date:   Tue, 12 Mar 2019 18:30:50 +0800
Message-Id: <20190312103051.18086-3-bhe@redhat.com>
In-Reply-To: <20190312103051.18086-1-bhe@redhat.com>
References: <20190312103051.18086-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 12 Mar 2019 10:31:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In relocate_kernel() CR4.LA57 flag is set before kexec jumping if
the kernel has 5-level paging enabled. Then in boot/compressed/head_64.S,
it will check if the booting kernel is in 4-level or 5-level paging
mode, and handle accordingly. However, the old kernel which doesn't
contain the 5-level codes doesn't know how to cope with it, then #GP
triggered.

Instead of triggering #GP during kexec kernel boot, error out during
kexec loading if find out we are trying to jump to old 4-level kernel
from 5-level kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 1f3b77367948..4c9c079b5673 100644
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

