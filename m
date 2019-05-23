Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B4CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A000F20863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639152;
	bh=Y6sN/mNBKAs6hV5e43Rgw1ryBj2VnmjFMb21rwPfXUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DfBHO6fppDA25rks2d2vGubGjiLEJ6fvA+uuudxtcPZ6XeuH8eGIgiVqtZaSzvs3D
	 oGcppLdL+HsUU+jiUVL3tAQ63MKjbrOnbFiSGgz0WGwXIjbe9CvZLuAVSa8+4Bawlr
	 uaIGDig78Q4GgimBnd/wHrlbaYuj9N47i22Z1kJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389754AbfEWTTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389224AbfEWTTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:19:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0890A217D7;
        Thu, 23 May 2019 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639145;
        bh=Y6sN/mNBKAs6hV5e43Rgw1ryBj2VnmjFMb21rwPfXUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fl7x1i5AhXwdQsZZZvV8jRg5LTxxc0Z0vEo8QniYnRZQyC3ImdCIckCuGUj4HecPM
         HkZDl5Yex6HdAiDV7qFeD/U22/XJNKnDn2H3dbHS1rd+8LS+WhRn8RqAleklIqEb20
         ifWfp6DiU7B5o/1Yw5zh2mWvMUJfkM0ht1YHIs3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/114] PCI: Fix issue with "pci=disable_acs_redir" parameter being ignored
Date:   Thu, 23 May 2019 21:06:33 +0200
Message-Id: <20190523181739.898387193@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d5bc73f34cc97c4b4b9202cc93182c2515076edf ]

In most cases, kmalloc() will not be available early in boot when
pci_setup() is called.  Thus, the kstrdup() call that was added to fix the
__initdata bug with the disable_acs_redir parameter usually returns NULL,
so the parameter is discarded and has no effect.

To fix this, store the string that's in initdata until an initcall function
can allocate the memory appropriately.  This way we don't need any
additional static memory.

Fixes: d2fd6e81912a ("PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 30649addc6252..61f2ef28ea1c7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6135,8 +6135,7 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
-				disable_acs_redir_param =
-					kstrdup(str + 18, GFP_KERNEL);
+				disable_acs_redir_param = str + 18;
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
@@ -6147,3 +6146,19 @@ static int __init pci_setup(char *str)
 	return 0;
 }
 early_param("pci", pci_setup);
+
+/*
+ * 'disable_acs_redir_param' is initialized in pci_setup(), above, to point
+ * to data in the __initdata section which will be freed after the init
+ * sequence is complete. We can't allocate memory in pci_setup() because some
+ * architectures do not have any memory allocation service available during
+ * an early_param() call. So we allocate memory and copy the variable here
+ * before the init section is freed.
+ */
+static int __init pci_realloc_setup_params(void)
+{
+	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
+
+	return 0;
+}
+pure_initcall(pci_realloc_setup_params);
-- 
2.20.1



