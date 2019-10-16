Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1A7FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4911E207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264046;
	bh=azaKT2C62TPRSsYE+ckZPK4Di2dsoBRGaz19NRo69Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kELj4mGd83ouGeP6nTdLA8RMKxRQIoStlf7BCNvrVzEFwQ7dyARJkSOVc0i2gMFP4
	 OC/ui/Euzi6MXghS8PPRTI0i2TvCp5BBeNpuTRRpxaOmSyqz44txX0BCCUJ3FvNTAq
	 5hV9Lj5NJsg2T2q6NtdV6BudOgYzvx/orPObr8O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395339AbfJPWOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395309AbfJPVzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:42 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC8521D7E;
        Wed, 16 Oct 2019 21:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262941;
        bh=azaKT2C62TPRSsYE+ckZPK4Di2dsoBRGaz19NRo69Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnPZqFTObqfxpV+6zexcsLo6YB/HliQT7bWLIvc2fCznlqFVD3IM6pLVFajKmhH4k
         9U5rncGb8WDlG7ozOcv95FgEuyuXbQBA/V2W6iEdN/RfSLxrY593K8fFUcQknopWSP
         I6Czx5ced87S2xdsTbNgR6vZ+xnzp7X/7SxuSys8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 12/65] xhci: Increase STS_SAVE timeout in xhci_suspend()
Date:   Wed, 16 Oct 2019 14:50:26 -0700
Message-Id: <20191016214805.437728649@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
References: <20191016214756.457746573@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit ac343366846a445bb81f0a0e8f16abb8bd5d5d88 upstream.

After commit f7fac17ca925 ("xhci: Convert xhci_handshake() to use
readl_poll_timeout_atomic()"), ASMedia xHCI may fail to suspend.

Although the algorithms are essentially the same, the old max timeout is
(usec + usec * time of doing readl()), and the new max timeout is just
usec, which is much less than the old one.

Increase the timeout to make ASMedia xHCI able to suspend again.

BugLink: https://bugs.launchpad.net/bugs/1844021
Fixes: f7fac17ca925 ("xhci: Convert xhci_handshake() to use readl_poll_timeout_atomic()")
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/1570190373-30684-8-git-send-email-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -968,7 +968,7 @@ int xhci_suspend(struct xhci_hcd *xhci,
 	writel(command, &xhci->op_regs->command);
 	xhci->broken_suspend = 0;
 	if (xhci_handshake(&xhci->op_regs->status,
-				STS_SAVE, 0, 10 * 1000)) {
+				STS_SAVE, 0, 20 * 1000)) {
 	/*
 	 * AMD SNPS xHC 3.0 occasionally does not clear the
 	 * SSS bit of USBSTS and when driver tries to poll


