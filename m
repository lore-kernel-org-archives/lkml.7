Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E1FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10ADD21872
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127336;
	bh=6JV/eXHPRFmydwhx6rceM0VG9eU28vzSbQjCmveJ8qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvF3eSz4Z2nnQGh/0TgxAsznyAy/KbuJUHMjTUzv8er/zV08+321OtN7162JX/m/K
	 QuNo4AHvdd9vbPe5WBQHXc8yDuHDvmswy295nIdXOpd/cGOTXHnnauv4L/NpHV29v1
	 qdRWXMYmjtXzSpYCJLoKV3bRXEpPwvcnKBiq/kx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfHFVfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbfHFVfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:35:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9CD2186A;
        Tue,  6 Aug 2019 21:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127331;
        bh=6JV/eXHPRFmydwhx6rceM0VG9eU28vzSbQjCmveJ8qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkOxHOeodWm/ka5FTJUwKORV+AwDAyFnQeQTutA6OYtvUWCZsHzNH4Z9ChQo4C+KO
         6ZKQUXVO2dSZ4HLCMbBnTjXqGEewDY3rrfoIIdUlM0i+/m91qnAax+G8FDw0Np4H7x
         Cp3RV1P3X+HJQ5RcEasF6NyTLSGjfsgds5/8Fj84=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.19 04/32] xtensa: fix build for cores with coprocessors
Date:   Tue,  6 Aug 2019 17:34:52 -0400
Message-Id: <20190806213522.19859-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213522.19859-1-sashal@kernel.org>
References: <20190806213522.19859-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit e3cacb73e626d885b8cf24103fed0ae26518e3c4 ]

Assembly entry/return abstraction change didn't add asmmacro.h include
statement to coprocessor.S, resulting in references to undefined macros
abi_entry and abi_ret on cores that define XTENSA_HAVE_COPROCESSORS.
Fix that by including asm/asmmacro.h from the coprocessor.S.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/coprocessor.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/kernel/coprocessor.S b/arch/xtensa/kernel/coprocessor.S
index 4f8b52d575a24..6454c0a95cccb 100644
--- a/arch/xtensa/kernel/coprocessor.S
+++ b/arch/xtensa/kernel/coprocessor.S
@@ -14,6 +14,7 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/asmmacro.h>
 #include <asm/processor.h>
 #include <asm/coprocessor.h>
 #include <asm/thread_info.h>
-- 
2.20.1

