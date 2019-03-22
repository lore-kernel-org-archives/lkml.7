Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE74C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B4F2195D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256432;
	bh=WcDeUCZQ1Hq013GIz3wFLQONgd831QZYVtD7nZ4dKZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZJi3UxsDBv66LQmo+eJJPpiBTBhO4w1QAlmJAmA+FxA60MS2OgLWc8eXUUJOmoegd
	 1xWpjZX4W+tY86cVaHuU/CU8hfkSIjNf2YhslDO9tBsbWdyvHHt2Buu5vPPhegcbqd
	 i8zB8d1M9G6UbCXYhW1mUd+ZqdILyE319QsEuxFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbfCVMHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388990AbfCVMHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:07:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D09921929;
        Fri, 22 Mar 2019 12:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256425;
        bh=WcDeUCZQ1Hq013GIz3wFLQONgd831QZYVtD7nZ4dKZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/8QExR09ZCwiesdU+oI+9AJgoM+cL4DrC+HZmXWtP6/fH7d6GOkvISEXdPUaL42Q
         SRG1N30esS/B46gNIp/0BmOCeICnzgW3GhWDFcYDRyiTLGHkxwymIV6xi4y3L9bRTS
         FaeiMeJWE6P9Vw4g/of5QsLTkJ0MxA9zsQHZuy5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Christophe Lombard <clombard@linux.vnet.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 189/280] cxl: Wrap iterations over afu slices inside afu_list_lock
Date:   Fri, 22 Mar 2019 12:15:42 +0100
Message-Id: <20190322111328.287085428@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1807,7 +1807,7 @@ static pci_ers_result_t cxl_vphb_error_d
 	/* There should only be one entry, but go through the list
 	 * anyway
 	 */
-	if (afu->phb == NULL)
+	if (afu == NULL || afu->phb == NULL)
 		return result;
 
 	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
@@ -1834,7 +1834,8 @@ static pci_ers_result_t cxl_pci_error_de
 {
 	struct cxl *adapter = pci_get_drvdata(pdev);
 	struct cxl_afu *afu;
-	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET, afu_result;
+	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
+	pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
 	int i;
 
 	/* At this point, we could still have an interrupt pending.
@@ -1845,6 +1846,7 @@ static pci_ers_result_t cxl_pci_error_de
 
 	/* If we're permanently dead, give up. */
 	if (state == pci_channel_io_perm_failure) {
+		spin_lock(&adapter->afu_list_lock);
 		for (i = 0; i < adapter->slices; i++) {
 			afu = adapter->afu[i];
 			/*
@@ -1853,6 +1855,7 @@ static pci_ers_result_t cxl_pci_error_de
 			 */
 			cxl_vphb_error_detected(afu, state);
 		}
+		spin_unlock(&adapter->afu_list_lock);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -1934,11 +1937,17 @@ static pci_ers_result_t cxl_pci_error_de
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
@@ -1950,6 +1959,7 @@ static pci_ers_result_t cxl_pci_error_de
 			 (result == PCI_ERS_RESULT_NEED_RESET))
 			result = PCI_ERS_RESULT_NONE;
 	}
+	spin_unlock(&adapter->afu_list_lock);
 
 	/* should take the context lock here */
 	if (cxl_adapter_context_lock(adapter) != 0)
@@ -1982,14 +1992,18 @@ static pci_ers_result_t cxl_pci_slot_res
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
@@ -2001,16 +2015,16 @@ static pci_ers_result_t cxl_pci_slot_res
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
 
@@ -2031,8 +2045,13 @@ static pci_ers_result_t cxl_pci_slot_res
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
@@ -2053,10 +2072,11 @@ static void cxl_pci_resume(struct pci_de
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
@@ -2065,6 +2085,7 @@ static void cxl_pci_resume(struct pci_de
 				afu_dev->driver->err_handler->resume(afu_dev);
 		}
 	}
+	spin_unlock(&adapter->afu_list_lock);
 }
 
 static const struct pci_error_handlers cxl_err_handler = {


