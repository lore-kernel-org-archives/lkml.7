Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6937C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FADB2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401924;
	bh=89gxeJGzthezn63gW8QWdpmf0myFbNkTNKcj5J4kHOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XMf4Tqxm9p/vhQVr6+fSIpAsI77U5sn7BMEU3M3YHh6s+UNnSIX46K4WrfiTgPtQO
	 1dVesYBs4HL7uADGTC4QWPITcfgl/xLByYdb4omMMtt7IDnToaW14aI5urx53HYbat
	 fDyATxYNgC+To2WzK1ctLlt691ODY9UNe/MBxh9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfKVFwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbfKVFvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A752072D;
        Fri, 22 Nov 2019 05:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401912;
        bh=89gxeJGzthezn63gW8QWdpmf0myFbNkTNKcj5J4kHOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8yU9nyO2MCMRRYUq1qfTlMQZKQcIT7fxnAheWoNGxHVkzoZgS4xWOeNcDRcQWyh9
         2dDZ2cZlvV4DNMPmC8ne4RPmAZC19OJwBTgdY6c+1Lh0agdQdv8tLnMGYzz1gSdOY7
         55dhWb0SJ5Q5EPvx0skzz9sLWjCwAgfic3WizAAY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 143/219] um: Include sys/uio.h to have writev()
Date:   Fri, 22 Nov 2019 00:47:55 -0500
Message-Id: <20191122054911.1750-136-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 0053102a869f1b909904b1b85ac282e2744deaab ]

sys/uio.h gives us writev(), otherwise the build might fail on
some systems.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/vector_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 4d6a78e31089f..00c4c2735a5f7 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -30,6 +30,7 @@
 #include <stdlib.h>
 #include <os.h>
 #include <um_malloc.h>
+#include <sys/uio.h>
 #include "vector_user.h"
 
 #define ID_GRE 0
-- 
2.20.1

