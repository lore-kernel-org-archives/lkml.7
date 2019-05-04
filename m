Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA19C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 21:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B8A205F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 21:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvfFil29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfEDV5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 17:57:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfEDV5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 17:57:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so12252679wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ki2zYft0ou3H6TJj4mjFNNxPee1lMyNDS4gDZCtx/Fs=;
        b=UvfFil29+0EWj3BCtr67enMZScaZXSWmeVO5Cb1rX4+myTaH5rGcEpUg5vSnCN3FiH
         S/RgLe14rF/Afkvhs7mMZpvEnjoRIMXTzfrStJWpBeCUon2Jk3oDQZJFWndi/O3CPq91
         QHi+a5GREyVbehp1rsU4+8tYBywNKNSIHTfU/rxpR/O77B/0jiu52PN4hUd7jpC6N1zW
         4+uqdNlpBpLY79qswAnKlIuw4KHOsNSLGCawF0PwNe6EKJrOosnrHSl/yogLRN/6qp1F
         GJEOvWsyfCpp/88fByVlmNdVOShW6KQ7Ew+d3BIQxCZScKleilG/hy27e7vutMPLZ+4U
         STog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ki2zYft0ou3H6TJj4mjFNNxPee1lMyNDS4gDZCtx/Fs=;
        b=srfpFfkCECKzSGHFx2kzGnH3pL4W6u5DIgfIdT99GTtgoBAs09A0JrSr25rF+jwkjL
         nnq6v/Z0IDQ8UMHsWugxBa0l6yLs49DrjXiWY1ZisdrWGy/Li8/P9CeZ6cvCj7NfvUpI
         4mSLfU9zicVOwfPUmGXFQYB+QOs0c7NYHcLAT/kJbVTi9X8D9TlzZGbk8OHYcKLrKoGm
         5Q1pmbve9I9HBGu0pOMjf/2wgIRHQIOHUBu7XdR3R47psvNLip+sSEPXcDKdRrlwD2SA
         d66d0XLnZZUXBBDkFAy9NMOwMc4h1y4h61mKgszPghwd9wLL832LDoCowe1siZbtRQqO
         dfcQ==
X-Gm-Message-State: APjAAAXOJ4byM28G7TI98424WuWW30ny8OVtJzir089HBwVmxm0iMW2x
        iCwptan/qrm8Li/nlGiP6fQsaqfP
X-Google-Smtp-Source: APXvYqyyDcFpqEvxdx5wH6JIpHwPpyAsNXG0X/4zMD1ZBW3pPsPhTR5afP9aJr9tqNLvL1FnM35AFw==
X-Received: by 2002:adf:df85:: with SMTP id z5mr5795681wrl.127.1557007062869;
        Sat, 04 May 2019 14:57:42 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o6sm11649237wre.60.2019.05.04.14.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 14:57:42 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] uapi/habanalabs: add opcode for enable/disable device debug mode
Date:   Sun,  5 May 2019 00:57:33 +0300
Message-Id: <20190504215733.12823-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504215733.12823-1-oded.gabbay@gmail.com>
References: <20190504215733.12823-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines a new opcode in the DEBUG IOCTL that is used by the
user to notify the driver when the user wants to start or stop using the
debug and profile infrastructure of the device. i.e. set the device to
debug mode or to non-debug mode.

There are a couple of restrictions that this new opcode introduces:

1. The user can't configure the debug/profiling infrastructure before he
   sets the device to debug mode, by using this new opcode.

2. The user can't set the device to debug mode unless he is the only user
   that is currently using (has an open FD) the device.

3. Other users can't use the device (open a new FD) in case an existing
   user has set the device into debug mode.

These restrictions are needed because the debug and profiling
infrastructure is a shared component in the ASIC and therefore, can't be
used while multiple users are working on the device.

Because the driver currently does NOT support multiple users, the
implementation of the restrictions is not required at this point. However,
the interface definition is needed in order to avoid changing the user API
later on.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 include/uapi/misc/habanalabs.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 8ac292cf4d00..204ab9b4ae67 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -413,6 +413,10 @@ struct hl_debug_params_spmu {
 #define HL_DEBUG_OP_SPMU	5
 /* Opcode for timestamp */
 #define HL_DEBUG_OP_TIMESTAMP	6
+/* Opcode for setting the device into or out of debug mode. The enable
+ * variable should be 1 for enabling debug mode and 0 for disabling it
+ */
+#define HL_DEBUG_OP_SET_MODE	7
 
 struct hl_debug_args {
 	/*
@@ -574,8 +578,22 @@ struct hl_debug_args {
  *
  * This IOCTL allows the user to get debug traces from the chip.
  *
- * The user needs to provide the register index and essential data such as
- * buffer address and size.
+ * Before the user can send configuration requests of the various
+ * debug/profile engines, it needs to set the device into debug mode.
+ * This is because the debug/profile infrastructure is shared component in the
+ * device and we can't allow multiple users to access it at the same time.
+ *
+ * Once a user set the device into debug mode, the driver won't allow other
+ * users to "work" with the device, i.e. open a FD. If there are multiple users
+ * opened on the device, the driver won't allow any user to debug the device.
+ *
+ * For each configuration request, the user needs to provide the register index
+ * and essential data such as buffer address and size.
+ *
+ * Once the user has finished using the debug/profile engines, he should
+ * set the device into non-debug mode, i.e. disable debug mode.
+ *
+ * The driver can decide to "kick out" the user if he abuses this interface.
  *
  */
 #define HL_IOCTL_DEBUG		\
-- 
2.17.1

