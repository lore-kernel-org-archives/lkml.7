Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37C4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5D12064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430987;
	bh=6KoBIfRycs0fd73LI5Ph46OJrdLpdAWCZXhfKYUdFK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fShzsCFg3JLezZYQeOdiXQJRiQE6ufoXN1TctPCkM8n797RWzozsHK2sdu2n1/quq
	 XHgnLMgIw6Bi3NLEcABcdQmqeRyJYyqpWRME6mBMwv2H0wDVpZDgk5chzLbQVt5uSA
	 3xdG9X0USOZAW0JaTLLlQlYFuv2EAw81TZJ/EJmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbfG2Tfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388528AbfG2Tfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:35:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A25A2070B;
        Mon, 29 Jul 2019 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428949;
        bh=6KoBIfRycs0fd73LI5Ph46OJrdLpdAWCZXhfKYUdFK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UErMUOjxJ5FCw0Qg2LrEju37LfPOYIPwBjxIeFI+RI67YIBBzvMwEpU5nLfLj26fo
         aUM90/YqU8FPzkI5cwGpUBRl8pTLmZok5uMd7qOBP9a+3KIa6mdo8xExggCYn2FCFm
         4LrupNdu0CdPVpRL/XsXSwsqj+4ZJsmwo66q+RKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 238/293] powerpc/pseries/mobility: prevent cpu hotplug during DT update
Date:   Mon, 29 Jul 2019 21:22:09 +0200
Message-Id: <20190729190842.688563055@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index fbea7db043fa..4addc552eb33 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -9,6 +9,7 @@
  * 2 as published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/smp.h>
@@ -343,11 +344,19 @@ void post_mobility_fixup(void)
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



