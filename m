Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8014C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB2821881
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MvbLElas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfHSH2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:28:31 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:22303 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:28:31 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x7J7RmL3006232;
        Mon, 19 Aug 2019 16:27:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x7J7RmL3006232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566199669;
        bh=KlKgZRIRmY7DJ25kdvWMZBaaLiZzDkAo1IiDuDvncA0=;
        h=From:To:Cc:Subject:Date:From;
        b=MvbLElasiQybP0hWkMmTrEy5UwJlLmP/b220ksZOl7WpMCcROP+LEhmoc7edCWfK9
         4rlpUO8GGslq1B3hVt8AalUWnr+DIYAKa/fxajCFAy3WHP2HMNjUD4h7vBJiMGvrBh
         TGOVJHc4AxC+JOxvnf3Fz8Oj0VLhFycqtXse3/zNMlrHTqa1gPEGLA6V2L0Ut1BHTZ
         pJnQihnPRLuuaOtDtuH7lqMSIEXwDx4M+tbowA9EeffmxJ0PCgN1MHG14mg2Ouy80/
         dCV081W5x/1ERxFbHLzYJ2zw7zVIzKEc6fU4uuxYXrQsDoc4GhOjZiaVp4yqt9rB2b
         PVYa6YHAYaTLA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] firmware: arm_scmi: add include guard to linux/scmi_protocol.h
Date:   Mon, 19 Aug 2019 16:27:39 +0900
Message-Id: <20190819072740.11257-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/scmi_protocol.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 9ff2e9357e9a..8a840e644907 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -4,6 +4,10 @@
  *
  * Copyright (C) 2018 ARM Ltd.
  */
+
+#ifndef _LINUX_SCMI_PROTOCOL_H
+#define _LINUX_SCMI_PROTOCOL_H
+
 #include <linux/device.h>
 #include <linux/types.h>
 
@@ -288,3 +292,5 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
 int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
 void scmi_protocol_unregister(int protocol_id);
+
+#endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1

