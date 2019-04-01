Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072132146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139813;
	bh=BWmYTTNHpnHAyEB7k/B5ihH0K+Wu7EDcXJQm2GDfFZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fsLbFaQzR9tLkQDquCi8n6rMHc2u934VDv5qOJV58LMIGyZrNyftcyw7h71r/x7PB
	 vsZ+SUmur5eeLnm2NmIdX87tex2IT9OgmBoSWWQBJqVlHx5JMrL6uQptuV6OMtMTOc
	 9M1aywDv3XLWtYA5UCk+5yNQD6IiUxH1COagXodM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfDARaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733040AbfDARaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2446920830;
        Mon,  1 Apr 2019 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139806;
        bh=BWmYTTNHpnHAyEB7k/B5ihH0K+Wu7EDcXJQm2GDfFZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQegzTZ9x9XQv5xclkC5d53A5Ojnv76hC0tV6r2J/fny9P+l221xD3L0wUIZ5opCu
         dCz9q0P+Vy/sJu79o2lNtWcgbe1r7k8s7YGIgAqXXT9OnEvsZe9kciuLBajSc6oIaX
         N0YoOQfKkumFip53siueajptC/sYwv1eZYEhIdBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 020/131] usb: dwc3: gadget: Fix suspend/resume during device mode
Date:   Mon,  1 Apr 2019 19:01:30 +0200
Message-Id: <20190401170053.681720263@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>

commit 9772b47a4c2916d645c551228b6085ea24acbe5d upstream.

Gadget controller might not be always active during system
suspend/resume as gadget driver might not have yet been loaded or
might have been unloaded prior to system suspend.

Check if we're active and only then perform
necessary actions during suspend/resume.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2894,6 +2894,9 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	if (!dwc->gadget_driver)
+		return 0;
+
 	if (dwc->pullups_connected) {
 		dwc3_gadget_disable_irq(dwc);
 		dwc3_gadget_run_stop(dwc, true, true);
@@ -2912,6 +2915,9 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	struct dwc3_ep		*dep;
 	int			ret;
 
+	if (!dwc->gadget_driver)
+		return 0;
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 


