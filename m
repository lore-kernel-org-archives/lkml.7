Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E39C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C02F208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141544;
	bh=+V/kBv2FT4LMrr6EzmLacGwQdRe5eI7eaEhFZBRsZCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W6BIW9Qv21G3EYgPJSPq5A/PBPFqGXbZp4CCabesTmQW8pf+Q/tJ6znkJpnYji+5+
	 jhzJUzELKWOx+BMD/88qGlxE0uGbJXhYVhc8E7e1qu8EQIQC89bdknv6r35TaLKEuK
	 oArd6ky1aMMFXIrkYWNxn/gpy+2CE4semX59d0n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfDAR7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731318AbfDARSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2800521473;
        Mon,  1 Apr 2019 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139085;
        bh=+V/kBv2FT4LMrr6EzmLacGwQdRe5eI7eaEhFZBRsZCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vAEa6E+t6iTxfQoikKoa8q0YCb3Wrqp6IC1673H2fRGLHqokfctrRzocp9X8wL5t
         hEEuE7hSVOnpxnDlKFGsHyeAEqwl/6YWxkzcSiACXJueIfto5uReRtIRU3mkdMXM6W
         tQhKEZVvDPWDhHIfoM7SO8SZiUbxvT+HX63FNB/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 108/134] usb: xhci: dbc: Dont free all memory with spinlock held
Date:   Mon,  1 Apr 2019 19:02:24 +0200
Message-Id: <20190401170054.310737307@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 8867ea262196a6945c24a0fb739575af646ec0e9 upstream.

The xhci debug capability (DbC) feature did its memory cleanup with
spinlock held. dma_free_coherent() warns if called with interrupts
disabled

move the memory cleanup outside the spinlock

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-dbgcap.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -516,7 +516,6 @@ static int xhci_do_dbc_stop(struct xhci_
 		return -1;
 
 	writel(0, &dbc->regs->control);
-	xhci_dbc_mem_cleanup(xhci);
 	dbc->state = DS_DISABLED;
 
 	return 0;
@@ -562,8 +561,10 @@ static void xhci_dbc_stop(struct xhci_hc
 	ret = xhci_do_dbc_stop(xhci);
 	spin_unlock_irqrestore(&dbc->lock, flags);
 
-	if (!ret)
+	if (!ret) {
+		xhci_dbc_mem_cleanup(xhci);
 		pm_runtime_put_sync(xhci_to_hcd(xhci)->self.controller);
+	}
 }
 
 static void


