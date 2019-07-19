Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA9BC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477A920873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510717;
	bh=/cRgCB+zYEoNN399PqKr6s8l7jl3n9vu6eqd9DwI5SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MYWwhJxOsYfAZawW4rxcQaY50gnTKxV3u0/u2othWbmMXE/CQDKGKlGeSyV4QNvtP
	 b+pTzGs+w8jkmDGuoP0hh/a0d9SqyQFr4uplT0iAyW6nYpsg3lR9RWQXvuUSfdk419
	 xa3HUJvfpE8/nhafj1rrKateI1+SmFUbC2fqk/Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbfGSEbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729920AbfGSEET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:04:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B351621873;
        Fri, 19 Jul 2019 04:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509058;
        bh=/cRgCB+zYEoNN399PqKr6s8l7jl3n9vu6eqd9DwI5SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHTCAhqGrOHcEC+r29mNKGyj74cWPieKU29Yji8aZjhtswb5KK3/AnNsMaPWvvPi1
         9O5Qkn0JNZ3+/84hMZ32WIGpXFGtj9Acb504lkm5nLcIhYJGAYrc+22AcG8iGMOQ2r
         Hf/HjDMl5FZChxTeRMborV6hmWAxF3whmYOSpeoc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.1 043/141] powerpc/pseries/mobility: prevent cpu hotplug during DT update
Date:   Fri, 19 Jul 2019 00:01:08 -0400
Message-Id: <20190719040246.15945-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit e59a175faa8df9d674247946f2a5a9c29c835725 ]

CPU online/offline code paths are sensitive to parts of the device
tree (various cpu node properties, cache nodes) that can be changed as
a result of a migration.

Prevent CPU hotplug while the device tree potentially is inconsistent.

Fixes: 410bccf97881 ("powerpc/pseries: Partition migration in the kernel")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/mobility.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 88925f8ca8a0..edc1ec408589 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -9,6 +9,7 @@
  * 2 as published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/smp.h>
@@ -338,11 +339,19 @@ void post_mobility_fixup(void)
 	if (rc)
 		printk(KERN_ERR "Post-mobility activate-fw failed: %d\n", rc);
 
+	/*
+	 * We don't want CPUs to go online/offline while the device
+	 * tree is being updated.
+	 */
+	cpus_read_lock();
+
 	rc = pseries_devicetree_update(MIGRATION_SCOPE);
 	if (rc)
 		printk(KERN_ERR "Post-mobility device tree update "
 			"failed: %d\n", rc);
 
+	cpus_read_unlock();
+
 	/* Possibly switch to a new RFI flush type */
 	pseries_setup_rfi_flush();
 
-- 
2.20.1

