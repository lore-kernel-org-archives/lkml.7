Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE778C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842712192D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138630;
	bh=n6y4Nswza9VUXyOYVWLoGe+5z2/UT5vkVWBjj5qJF+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjJTVg2P7Ia7FdlwW9daCXCW4Bnxw+1yZ9JtvNFl46EJGcqyy1LQPq0uTwilJt7Pv
	 QtSvDMDiW4ye5X673J6ln+bkJVuJLKlCPPCwgrEsL1nsA/zVik/SVIFxHl597zTyni
	 cYiFXOl/dhshUtsu1Up5FhGbOXfGHbhdCKJrkb/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfDARK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbfDARK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B3021B1C;
        Mon,  1 Apr 2019 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138625;
        bh=n6y4Nswza9VUXyOYVWLoGe+5z2/UT5vkVWBjj5qJF+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sq6ggjIo3WXGQpYYGYmDCm1lB5ntt0zP2aIhDPKVO1YJLo77EzNVu1iigKgqVy1Yi
         hJ09FVpU2QOybFfvB4u09RzLbauMYV1waLKaE9u18Qk8+9C4xAz22Qw69b8Bw+ufXX
         OpiX+X1rRoO6dfjbab2BWS/JWTQuvGA0SWQeDvno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.0 120/146] usb: xhci: dbc: Dont free all memory with spinlock held
Date:   Mon,  1 Apr 2019 19:02:12 +0200
Message-Id: <20190401170058.508358876@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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


