Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F292DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6185206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cinuiUHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfLJPht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:37:49 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:53760 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727645AbfLJPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:37:43 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F41AB405D4;
        Tue, 10 Dec 2019 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1575992263; bh=9uIArk7W/VoQqStsEzOZbVA9gvJuUpov0r2L92iFq/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=cinuiUHh9Si9BaJO/IpfKrVF3he0bzfZTFf9miLGhgaswE8kCAQDZhjH2ESDy+Jca
         ek57K74C43TL6d7dM/R4NEHeRiI58s5nRi4GuGOdKMMq+Q7vtuVf7l16DXZYtz6ZjE
         1StsAF5/dPiA8Noky+se3axFdxcn1nBLMxaG053XJgqGtKDpVc6L6cuFpkQJsczVC7
         4IXoPurEDTOJ9jrIrSfLd0N6XXN+7dCsJb1m2thsIU5m7lxXvmg8KtR/BhzrWpzDI3
         orTONP0URW4+P0GIkiUmsXAp1hfBo0qwOg2VDS90obk+CSG8g1ZiTl+jy6xNLiwZSn
         6Yo2hhYw93YoA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 97B18A0086;
        Tue, 10 Dec 2019 15:37:36 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 7C8FB3E2D3;
        Tue, 10 Dec 2019 16:37:36 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, bbrezillon@kernel.org,
        gregkh@linuxfoundation.org, wsa@the-dreams.de, arnd@arndb.de,
        broonie@kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [RFC 2/5] i3c: master: export i3c_bus_type symbol
Date:   Tue, 10 Dec 2019 16:37:30 +0100
Message-Id: <96507b6036bf834ca8ee086578b8616958a363be.1575977795.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1575977795.git.vitor.soares@synopsys.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1575977795.git.vitor.soares@synopsys.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export i3c_bus_type symbol so i3cdev can register a notifier chain
for the i3c bus.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index a1fb5f7..a9df276 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -321,6 +321,7 @@ struct bus_type i3c_bus_type = {
 	.probe = i3c_device_probe,
 	.remove = i3c_device_remove,
 };
+EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
-- 
2.7.4

