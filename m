Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801FC218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCUWAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:00:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:53201 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfCUWA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="127513569"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 50E0F30214C; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, hugues.fruchet@st.com,
        mchehab@s-opensource.com
Subject: [PATCH 10/17] delta: Fix buffer overrun in delta_ipc_open
Date:   Thu, 21 Mar 2019 15:00:02 -0700
Message-Id: <20190321220009.29334-11-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

delta_ipc_open is always called with a single constant string
as name, but it uses a longer memcpy to copy the string to
a different structure. The memcpy would read outside the bounds
of the string, potentially accessing unmapped memory.

Just use strcpy instead after clearing the area.

This fixes a build error with LTO, which can detect this.

Cc: hugues.fruchet@st.com
Cc: mchehab@s-opensource.com
Fixes: 91c83f395fbe [media] st-delta: rpmsg ipc support
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/media/platform/sti/delta/delta-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sti/delta/delta-ipc.c b/drivers/media/platform/sti/delta/delta-ipc.c
index a4603d573c34..bd1bbbeedec3 100644
--- a/drivers/media/platform/sti/delta/delta-ipc.c
+++ b/drivers/media/platform/sti/delta/delta-ipc.c
@@ -175,8 +175,8 @@ int delta_ipc_open(struct delta_ctx *pctx, const char *name,
 	msg.ipc_buf_size = ipc_buf_size;
 	msg.ipc_buf_paddr = ctx->ipc_buf->paddr;
 
-	memcpy(msg.name, name, sizeof(msg.name));
-	msg.name[sizeof(msg.name) - 1] = 0;
+	memset(msg.name, 0, sizeof(msg.name));
+	strcpy(msg.name, name);
 
 	msg.param_size = param->size;
 	memcpy(ctx->ipc_buf->vaddr, param->data, msg.param_size);
-- 
2.20.1

