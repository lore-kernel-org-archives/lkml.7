Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8632CFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4F821925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263879;
	bh=BakXtVNyWxfe6/6cNUyEpr7kiZiRERaM4EkEd9adm7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tO1RBlwsBrsUEBp+OCmT/yn1vYNRXdjRxt8MAeVjcmlk8r4QxYjvTxx+asIuuWbIQ
	 BAwmZFsI3KBuct4E/7jakD/OPBSiaKfwtjf1m9oZCmzt8qyQj1011dyrY3d79UaAiC
	 CIghtmMaK5Gqow8nev2F8yCz62doJH7U+JTXdzSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407273AbfJPWLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437924AbfJPV4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:56:50 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8562F21925;
        Wed, 16 Oct 2019 21:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263009;
        bh=BakXtVNyWxfe6/6cNUyEpr7kiZiRERaM4EkEd9adm7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrjHYQ31+PRoLRWDOnF6Q+H4bNorriRjz7/fC5CRprVOVFSgtq67WsMjY2QHF3jvw
         UqOeO5Vh6OLROtNs9zpzbJI3PZTPRFAharsv/oRiSVIHLwJJqqr5LzmxG+Jys6ft0r
         PMGtq3l0gteBLNXLOdvMbMtKeXMONOcsTfEwtUSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rick Tseng <rtseng@nvidia.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 12/81] usb: xhci: wait for CNR controller not ready bit in xhci resume
Date:   Wed, 16 Oct 2019 14:50:23 -0700
Message-Id: <20191016214817.920493885@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Tseng <rtseng@nvidia.com>

commit a70bcbc322837eda1ab5994d12db941dc9733a7d upstream.

NVIDIA 3.1 xHCI card would lose power when moving power state into D3Cold.
Thus we need to wait for CNR bit to clear in xhci resume, just as in
xhci init.

[Minor changes to comment and commit message -Mathias]
Cc: <stable@vger.kernel.org>
Signed-off-by: Rick Tseng <rtseng@nvidia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/1570190373-30684-6-git-send-email-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1098,6 +1098,18 @@ int xhci_resume(struct xhci_hcd *xhci, b
 		hibernated = true;
 
 	if (!hibernated) {
+		/*
+		 * Some controllers might lose power during suspend, so wait
+		 * for controller not ready bit to clear, just as in xHC init.
+		 */
+		retval = xhci_handshake(&xhci->op_regs->status,
+					STS_CNR, 0, 10 * 1000 * 1000);
+		if (retval) {
+			xhci_warn(xhci, "Controller not ready at resume %d\n",
+				  retval);
+			spin_unlock_irq(&xhci->lock);
+			return retval;
+		}
 		/* step 1: restore register */
 		xhci_restore_registers(xhci);
 		/* step 2: initialize command ring buffer */


