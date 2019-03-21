Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA51FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6BA218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfCUKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:33:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfCUKdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:33:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84C77C02E60C;
        Thu, 21 Mar 2019 10:33:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-199.pek2.redhat.com [10.72.12.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55DA319C59;
        Thu, 21 Mar 2019 10:33:26 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid confusion
Date:   Thu, 21 Mar 2019 18:33:07 +0800
Message-Id: <20190321103309.27883-2-lijiang@redhat.com>
In-Reply-To: <20190321103309.27883-1-lijiang@redhat.com>
References: <20190321103309.27883-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 21 Mar 2019 10:33:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the commit <0e4c12b45aa8> ("x86/mm, resource: Use
PAGE_KERNEL protection for ioremap of memory pages"), here
it is really checking for the 'IORES_DESC_ACPI_*' values.
Therefore, it is necessary to change the examination condition
to avoid confusion.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/mm/ioremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 0029604af8a4..0e3ba620612d 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -83,7 +83,8 @@ static bool __ioremap_check_ram(struct resource *res)
 
 static int __ioremap_check_desc_other(struct resource *res)
 {
-	return (res->desc != IORES_DESC_NONE);
+	return ((res->desc == IORES_DESC_ACPI_TABLES) ||
+		(res->desc == IORES_DESC_ACPI_NV_STORAGE));
 }
 
 static int __ioremap_res_check(struct resource *res, void *arg)
-- 
2.17.1

