Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EF922318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574140910;
	bh=jiID2sZJtnAMrCFYgJZVScHSBB2UHdlChSpaNDIyjIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VT7U4OMZzDfEidU8QwhpBySkrKf15FQaDFZHGW4OUxD4PXdMf2Fz/jS9OElUtaQtE
	 2iLVxITAL3B2a/0uODeSidj6IQoM9JSvC59CMtBNDRnoaz+srOuSk9ybSytDOr8QkX
	 czehFWafZJ+uN0L6bzexWourb91CHn55rsqu/1Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKSFVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbfKSFVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:21:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D121422318;
        Tue, 19 Nov 2019 05:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574140899;
        bh=jiID2sZJtnAMrCFYgJZVScHSBB2UHdlChSpaNDIyjIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXTyL/Stf3h3rqhdGDK9IdKYlHQhZ9RckFHQQfGas3lu6fklK2P6vQkAdvY3BFD1M
         dnvpIktz8YQxmmrOV1rR4Q8+m4UGpJncj9abpCNXF6f5mTzzy+S92VAdD8RLCxf3X5
         GSGl7QYGpJiVvo59Q/HIDirLuobMh6YJ49CmMPjk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.3 24/48] Input: synaptics-rmi4 - clear IRQ enables for F54
Date:   Tue, 19 Nov 2019 06:19:44 +0100
Message-Id: <20191119051007.079867425@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
References: <20191119050946.745015350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

commit 549766ac2ac1f6c8bb85906bbcea759541bb19a2 upstream.

The driver for F54 just polls the status and doesn't even have a IRQ
handler registered. Make sure to disable all F54 IRQs, so we don't crash
the kernel on a nonexistent handler.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Link: https://lore.kernel.org/r/20191105114402.6009-1-l.stach@pengutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/rmi4/rmi_f54.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -601,7 +601,7 @@ static int rmi_f54_config(struct rmi_fun
 {
 	struct rmi_driver *drv = fn->rmi_dev->driver;
 
-	drv->set_irq_bits(fn->rmi_dev, fn->irq_mask);
+	drv->clear_irq_bits(fn->rmi_dev, fn->irq_mask);
 
 	return 0;
 }


