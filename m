Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E368C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B99720707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403461;
	bh=2GEVP+XTklP07ZP2wt7K2gymaaWsRpRrMdsz26QNACk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvyYwHjSMImx3QjiP9E1G93s7xoMrpOPiSBpYHtIFbKSEpzXTfk2HrKO3PAQq4/7U
	 t4TSVUl0fjOzCfkI/HClBag/oPovMUjVFgqmnWJ5OCl7X3ssEB7/LWQ5oyUQw8IXd0
	 mzCjl6JUTq79FtjYY70RASrwEOW8SJ8vWCWox2Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfKVGRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:17:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbfKVGN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14B820715;
        Fri, 22 Nov 2019 06:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403206;
        bh=2GEVP+XTklP07ZP2wt7K2gymaaWsRpRrMdsz26QNACk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9yxVGV6etFCcrlE0QxGvJuFO2sExIgiIyPSFvk3K3sxHexPVSimmdcgBt3LK0ucv
         NReO5d5DylOUU2LJ+bXw0qFC1YiYscIanvS771/6JomSPnpF+6iaCiS901mhQzDnt3
         r+glLUl53UWw9bXdliw4FXzhdRY8i1gSFDrdzjqM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>, xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 4.4 22/68] xen/pciback: Check dev_data before using it
Date:   Fri, 22 Nov 2019 01:12:15 -0500
Message-Id: <20191122061301.4947-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 1669907e3d1abfa3f7586e2d55dbbc117b5adba2 ]

If pcistub_init_device fails, the release function will be called with
dev_data set to NULL.  Check it before using it to avoid a NULL pointer
dereference.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xen-pciback/pci_stub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 258b7c3256499..47c6df53cabfb 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -104,7 +104,8 @@ static void pcistub_device_release(struct kref *kref)
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
 	__pci_reset_function_locked(dev);
-	if (pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
+	if (dev_data &&
+	    pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
 	else
 		pci_restore_state(dev);
-- 
2.20.1

