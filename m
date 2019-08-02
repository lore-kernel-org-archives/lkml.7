Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0D4C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45EA217D6
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738475;
	bh=v48wVHhPiKP8smes6yqznQFLzAjSRq0UFD5Bb/SPnSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UIIaCx28p2TW7Uk2Fr0jlBK5YLrgmQunJCLCuGoeWWd3EusiB9ya63E9iMTg+Fo84
	 iLxIAn7kGs42aA7xK5C1Krr73gVmW+qnTUpOuawWUx4UbBRGsNTD3LR9Mqubpur0fB
	 fEAYl24ar/GsisDAepoPVbndLPXYzZF+3LtqfBRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391350AbfHBJee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbfHBJe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:34:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB83F217D7;
        Fri,  2 Aug 2019 09:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738469;
        bh=v48wVHhPiKP8smes6yqznQFLzAjSRq0UFD5Bb/SPnSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyhFtyglNHF4P4wbxDo+WjWYSrI+9CwzBDBw+VdKxf1ZjoaLQxKkk9IlW/hjeH3Le
         mNs7porbeJc39FYwvbbba/5mFtbpu8418vMwYFchpKJ5Hv8ZXKrmJRKL+p2YCYuqga
         ijrZtGo5DYIS4nxwra6eSmDTXHusO3y30jnhueoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 116/158] powerpc/pseries/mobility: prevent cpu hotplug during DT update
Date:   Fri,  2 Aug 2019 11:28:57 +0200
Message-Id: <20190802092227.618197382@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
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
index c773396d0969..fcd1a32267c4 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -9,6 +9,7 @@
  * 2 as published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/smp.h>
@@ -309,11 +310,19 @@ void post_mobility_fixup(void)
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



