Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA09C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5856520842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfCELdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:33:39 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:41816 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfCELdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:33:17 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D9638C8C65E591F4FE46;
        Tue,  5 Mar 2019 19:33:15 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x25BX8XS072571;
        Tue, 5 Mar 2019 19:33:08 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030519332458-3291704 ;
          Tue, 5 Mar 2019 19:33:24 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 14/15] arm64: cpu_ops: fix a leaked reference by adding missing of_node_put
Date:   Tue, 5 Mar 2019 19:34:05 +0800
Message-Id: <1551785646-46173-14-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-05 19:33:24,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-05 19:33:04,
        Serialize complete at 2019-03-05 19:33:04
X-MAIL: mse01.zte.com.cn x25BX8XS072571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm64/kernel/cpu_ops.c:102:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 69, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
v2->v1: add a missing space between "adding" and "missing"

 arch/arm64/kernel/cpu_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index ea00124..00f8b86 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -85,6 +85,7 @@ static const char *__init cpu_read_enable_method(int cpu)
 				pr_err("%pOF: missing enable-method property\n",
 					dn);
 		}
+		of_node_put(dn);
 	} else {
 		enable_method = acpi_get_enable_method(cpu);
 		if (!enable_method) {
-- 
2.9.5

