Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB14C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA75E2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCDESZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:18:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDESZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:18:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2ADF5368D0;
        Mon,  4 Mar 2019 04:18:25 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 171515C207;
        Mon,  4 Mar 2019 04:18:22 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     fanc.fnst@cn.fujitsu.com, bp@alien8.de, Baoquan He <bhe@redhat.com>
Subject: [PATCH] x86/boot: Fix incorrect ifdeffery scope
Date:   Mon,  4 Mar 2019 12:18:20 +0800
Message-Id: <20190304041820.14409-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 04 Mar 2019 04:18:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The declarations related to immovable memory handling are put out of

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/compressed/misc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index fd13655e0f9b..8bbaf362855c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -120,8 +120,6 @@ static inline void console_init(void)
 
 void set_sev_encryption_mask(void);
 
-#endif
-
 /* acpi.c */
 #ifdef CONFIG_ACPI
 acpi_physical_address get_rsdp_addr(void);
@@ -135,3 +133,5 @@ int count_immovable_mem_regions(void);
 #else
 static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
+
+#endif
-- 
2.17.2

