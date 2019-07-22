Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57D8C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F2820449
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfGVL5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:57:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727507AbfGVL5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:57:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D711BB019;
        Mon, 22 Jul 2019 11:57:03 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Chih-Wei Huang <cwhuang@android-x86.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] firmware: fix build errors in paged buffer handling code
Date:   Mon, 22 Jul 2019 13:56:56 +0200
Message-Id: <20190722115656.10883-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Rossi <issor.oruam@gmail.com>

fw_{grow,map}_paged_buf() need to be defined as static inline
when CONFIG_FW_LOADER_PAGED_BUF is not enabled,
infact fw_free_paged_buf() is also defined as static inline
when CONFIG_FW_LOADER_PAGED_BUF is not enabled.

Fixes the following mutiple definition building errors for Android kernel:

drivers/base/firmware_loader/fallback_efi.o: In function `fw_grow_paged_buf':
fallback_efi.c:(.text+0x0): multiple definition of `fw_grow_paged_buf'
drivers/base/firmware_loader/main.o:(.text+0x73b): first defined here
drivers/base/firmware_loader/fallback_efi.o: In function `fw_map_paged_buf':
fallback_efi.c:(.text+0xf): multiple definition of `fw_map_paged_buf'
drivers/base/firmware_loader/main.o:(.text+0x74a): first defined here

[ slightly corrected the patch description -- tiwai ]

Fixes: 5342e7093ff2 ("firmware: Factor out the paged buffer handling code")
Fixes: 82fd7a8142a1 ("firmware: Add support for loading compressed files")
Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: Fixed the mistakenly dropped inline, as done in Mauro's original
        patch

 drivers/base/firmware_loader/firmware.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 7048a41973ed..7ecd590e67fe 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -141,8 +141,8 @@ int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed);
 int fw_map_paged_buf(struct fw_priv *fw_priv);
 #else
 static inline void fw_free_paged_buf(struct fw_priv *fw_priv) {}
-int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { return -ENXIO; }
-int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
+static inline int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { return -ENXIO; }
+static inline int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
 #endif
 
 #endif /* __FIRMWARE_LOADER_H */
-- 
2.16.4

