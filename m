Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE685ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0CA20640
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502167AbfJQLvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:51:09 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:54208 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfJQLvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:51:09 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iL4J7-00042a-2N; Thu, 17 Oct 2019 12:51:05 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iL4J6-0000Bo-ED; Thu, 17 Oct 2019 12:51:04 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: fix missing include of <linux/rio_drv.h>
Date:   Thu, 17 Oct 2019 12:51:03 +0100
Message-Id: <20191017115103.684-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/rio_drv.h> for the missing declarations
of functions exported from this file. Fixes the following
sparse warnings:

drivers/rapidio/rio-access.c:59:1: warning: symbol '__rio_local_read_config_8' was not declared. Should it be static?
drivers/rapidio/rio-access.c:60:1: warning: symbol '__rio_local_read_config_16' was not declared. Should it be static?
drivers/rapidio/rio-access.c:61:1: warning: symbol '__rio_local_read_config_32' was not declared. Should it be static?
drivers/rapidio/rio-access.c:62:1: warning: symbol '__rio_local_write_config_8' was not declared. Should it be static?
drivers/rapidio/rio-access.c:63:1: warning: symbol '__rio_local_write_config_16' was not declared. Should it be static?
drivers/rapidio/rio-access.c:64:1: warning: symbol '__rio_local_write_config_32' was not declared. Should it be static?
drivers/rapidio/rio-access.c:112:1: warning: symbol 'rio_mport_read_config_8' was not declared. Should it be static?
drivers/rapidio/rio-access.c:113:1: warning: symbol 'rio_mport_read_config_16' was not declared. Should it be static?
drivers/rapidio/rio-access.c:114:1: warning: symbol 'rio_mport_read_config_32' was not declared. Should it be static?
drivers/rapidio/rio-access.c:115:1: warning: symbol 'rio_mport_write_config_8' was not declared. Should it be static?
drivers/rapidio/rio-access.c:116:1: warning: symbol 'rio_mport_write_config_16' was not declared. Should it be static?
drivers/rapidio/rio-access.c:117:1: warning: symbol 'rio_mport_write_config_32' was not declared. Should it be static?
drivers/rapidio/rio-access.c:136:5: warning: symbol 'rio_mport_send_doorbell' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 drivers/rapidio/rio-access.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rapidio/rio-access.c b/drivers/rapidio/rio-access.c
index 33c8d1ecc988..f9e10647f94e 100644
--- a/drivers/rapidio/rio-access.c
+++ b/drivers/rapidio/rio-access.c
@@ -9,6 +9,8 @@
 #include <linux/rio.h>
 #include <linux/module.h>
 
+#include <linux/rio_drv.h>
+
 /*
  *  Wrappers for all RIO configuration access functions.  They just check
  *  alignment and call the low-level functions pointed to by rio_mport->ops.
-- 
2.23.0

