Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A1ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0778520659
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405400AbfJQLlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:41:05 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53848 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfJQLlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:41:05 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iL49O-0003jg-1V; Thu, 17 Oct 2019 12:41:02 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iL49N-0002s2-CN; Thu, 17 Oct 2019 12:41:01 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: include cs_internal.h for missing declarations
Date:   Thu, 17 Oct 2019 12:40:59 +0100
Message-Id: <20191017114059.10989-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include cs_internal.h (and pcmcia/cistpl.h as required by
cs_internal.h) for the declearions of cb_alloc and cb_free
to silence the following sparse warnings;

drivers/pcmcia/cardbus.c:64:11: warning: symbol 'cb_alloc' was not declared. Should it be static?
drivers/pcmcia/cardbus.c:103:6: warning: symbol 'cb_free' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/pcmcia/cardbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index c502dfbf66e3..45c8252c8edc 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -22,7 +22,9 @@
 #include <linux/pci.h>
 
 #include <pcmcia/ss.h>
+#include <pcmcia/cistpl.h>
 
+#include "cs_internal.h"
 
 static void cardbus_config_irq_and_cls(struct pci_bus *bus, int irq)
 {
-- 
2.23.0

