Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3269C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D572082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255577;
	bh=WbWKK/5z5i7GD+mkfNsuMl0nO1szzX4OpBe13lH51hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ttXilIAm7l1LHtPiQJtIYtJcCphv0vPfM/duRBYuddNW1KlJa1mIlOnw7xKAsQOiu
	 r4IvTf6QSUKE8yRcFpXi5ONcS3WVFrs5GYJWj/gi6o227m+eDovTUo7exZf/01maDv
	 3oh2PtRpjXmRJUtEIcTGMCW5601zo4Yi3nIKz6tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbfCVLwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732960AbfCVLww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:52:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D622082C;
        Fri, 22 Mar 2019 11:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255571;
        bh=WbWKK/5z5i7GD+mkfNsuMl0nO1szzX4OpBe13lH51hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLTCWwbIz9AOSeFgEpFMeGBkXg06Uq0EXFk+gIfDU0nKGOM1ypDM8BAbqcB6v/XjW
         5x6pEBEn7YeV2PxhIqCXsGMYEkAeam7MrCYH9eR2Peoe48QM7bUv87rhuSOEYFOrGQ
         RT0vVklDB2C7n3IvCCz/Wxdczocbcpg/WVXlDiWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Christophe Lombard <clombard@linux.vnet.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 114/183] cxl: Wrap iterations over afu slices inside afu_list_lock
Date:   Fri, 22 Mar 2019 12:15:42 +0100
Message-Id: <20190322111249.971961540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vaibhav Jain <vaibhav@linux.ibm.com>

commit edeb304f659792fb5bab90d7d6f3408b4c7301fb upstream.

Within cxl module, iteration over array 'adapter->afu' may be racy
at few points as it might be simultaneously read during an EEH and its
contents being set to NULL while driver is being unloaded or unbound
from the adapter. This might result in a NULL pointer to 'struct afu'
being de-referenced during an EEH thereby causing a kernel oops.

This patch fixes this by making sure that all access to the array
'adapter->afu' is wrapped within the context of spin-lock
'adapter->afu_list_lock'.

Fixes: 9e8df8a21963 ("cxl: EEH support")
Cc: stable@vger.kernel.org # v4.3+
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
Acked-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/cxl/guest.c |    2 ++
 drivers/misc/cxl/pci.c   |   39 ++++++++++++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 9 deletions(-)

--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -267,6 +267,7 @@ static int guest_reset(struct cxl *adapt
 	int i, rc;
 
 	pr_devel("Adapter reset request\n");
+	spin_lock(&adapter->afu_list_lock);
 	for (i = 0; i < adapter->slices; i++) {
 		if ((afu = adapter->afu[i])) {
 			pci_error_handlers(afu, CXL_ERROR_DETECTED_EVENT,
@@ -283,6 +284,7 @@ static int guest_reset(struct cxl *adapt
 			pci_error_handlers(afu, CXL_RESUME_EVENT, 0);
 		}
 	}
+	spin_unlock(&adapter->afu_list_lock);
 	return rc;
 }
 
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -2050,7 +2050,7 @@ static pci_ers_result_t cxl_vphb_error_d
 	/* There should only be one entry, but go through the list
 	 * anyway
 	 */
-	if (afu->phb == NULL)
+	if (afu == NULL || afu->phb == NULL)
 		return result;
 
 	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
@@ -2077,7 +2077,8 @@ static pci_ers_result_t cxl_pci_error_de
 {
 	struct cxl *adapter = pci_get_drvdata(pdev);
 	struct cxl_afu *afu;
-	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET, afu_result;
+	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
+	pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
 	int i;
 
 	/* At this point, we could still have an interrupt pending.
@@ -2088,6 +2089,7 @@ static pci_ers_result_t cxl_pci_error_de
 
 	/* If we're permanently dead, give up. */
 	if (state == pci_channel_io_perm_failure) {
+		spin_lock(&adapter->afu_list_lock);
 		for (i = 0; i < adapter->slices; i++) {
 			afu = adapter->afu[i];
 			/*
@@ -2096,6 +2098,7 @@ static pci_ers_result_t cxl_pci_error_de
 			 */
 			cxl_vphb_error_detected(afu, state);
 		}
+		spin_unlock(&adapter->afu_list_lock);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -2177,11 +2180,17 @@ static pci_ers_result_t cxl_pci_error_de
 	 *     * In slot_reset, free the old resources and allocate new ones.
 	 *     * In resume, clear the flag to allow things to start.
 	 */
+
+	/* Make sure no one else changes the afu list */
+	spin_lock(&adapter->afu_list_lock);
+
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
-		afu_result = cxl_vphb_error_detected(afu, state);
+		if (afu == NULL)
+			continue;
 
+		afu_result = cxl_vphb_error_detected(afu, state);
 		cxl_context_detach_all(afu);
 		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
 		pci_deconfigure_afu(afu);
@@ -2193,6 +2202,7 @@ static pci_ers_result_t cxl_pci_error_de
 			 (result == PCI_ERS_RESULT_NEED_RESET))
 			result = PCI_ERS_RESULT_NONE;
 	}
+	spin_unlock(&adapter->afu_list_lock);
 
 	/* should take the context lock here */
 	if (cxl_adapter_context_lock(adapter) != 0)
@@ -2225,14 +2235,18 @@ static pci_ers_result_t cxl_pci_slot_res
 	 */
 	cxl_adapter_context_unlock(adapter);
 
+	spin_lock(&adapter->afu_list_lock);
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
+		if (afu == NULL)
+			continue;
+
 		if (pci_configure_afu(afu, adapter, pdev))
-			goto err;
+			goto err_unlock;
 
 		if (cxl_afu_select_best_mode(afu))
-			goto err;
+			goto err_unlock;
 
 		if (afu->phb == NULL)
 			continue;
@@ -2244,16 +2258,16 @@ static pci_ers_result_t cxl_pci_slot_res
 			ctx = cxl_get_context(afu_dev);
 
 			if (ctx && cxl_release_context(ctx))
-				goto err;
+				goto err_unlock;
 
 			ctx = cxl_dev_context_init(afu_dev);
 			if (IS_ERR(ctx))
-				goto err;
+				goto err_unlock;
 
 			afu_dev->dev.archdata.cxl_ctx = ctx;
 
 			if (cxl_ops->afu_check_and_enable(afu))
-				goto err;
+				goto err_unlock;
 
 			afu_dev->error_state = pci_channel_io_normal;
 
@@ -2274,8 +2288,13 @@ static pci_ers_result_t cxl_pci_slot_res
 				result = PCI_ERS_RESULT_DISCONNECT;
 		}
 	}
+
+	spin_unlock(&adapter->afu_list_lock);
 	return result;
 
+err_unlock:
+	spin_unlock(&adapter->afu_list_lock);
+
 err:
 	/* All the bits that happen in both error_detected and cxl_remove
 	 * should be idempotent, so we don't need to worry about leaving a mix
@@ -2296,10 +2315,11 @@ static void cxl_pci_resume(struct pci_de
 	 * This is not the place to be checking if everything came back up
 	 * properly, because there's no return value: do that in slot_reset.
 	 */
+	spin_lock(&adapter->afu_list_lock);
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
-		if (afu->phb == NULL)
+		if (afu == NULL || afu->phb == NULL)
 			continue;
 
 		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
@@ -2308,6 +2328,7 @@ static void cxl_pci_resume(struct pci_de
 				afu_dev->driver->err_handler->resume(afu_dev);
 		}
 	}
+	spin_unlock(&adapter->afu_list_lock);
 }
 
 static const struct pci_error_handlers cxl_err_handler = {


