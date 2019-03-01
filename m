Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3229C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC9E20854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfCAGGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:06:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfCAGGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:06:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BE543087BAB;
        Fri,  1 Mar 2019 06:06:36 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 729AC5D782;
        Fri,  1 Mar 2019 06:06:35 +0000 (UTC)
Date:   Fri, 1 Mar 2019 14:06:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     fanc.fnst@cn.fujitsu.com
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org
Subject: A quesiton about commit 3a63f70bf4c3
Message-ID: <20190301060631.GU14858@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 01 Mar 2019 06:06:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chao,

I am back porting this commit to our distrols from tip.
3a63f70bf4c3 x86/boot: Early parse RSDP and save it in boot_params

Findind out those SRAT handling related declarations are out of
BOOT_COMPRESSED_MISC_H ifdeffery. Is this made on purpose? 

Saw "misc.h" is included in several places, shouldn't be changed like
below? Please correct me if I was wrong.

Thanks
Baoquan

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index fd13655..252091b 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -120,8 +120,6 @@ static inline void console_init(void)
 
 void set_sev_encryption_mask(void);
 
-#endif
-
 /* acpi.c */
 #ifdef CONFIG_ACPI
 acpi_physical_address get_rsdp_addr(void);
@@ -135,3 +133,4 @@ int count_immovable_mem_regions(void);
 #else
 static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
+#endif
