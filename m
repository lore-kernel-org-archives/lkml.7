Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2121CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD8521874
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127541;
	bh=bciCVAO771nWd3gcn770/n2Rb6usypvaCcgPlLxEQ58=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lzhPbecYsUHDkaZt4NiIRDnwVwED5nTl6KCZFgZCmZh+xBDvKiMqfK6BydbUkCR6P
	 osnekLRKpm8vggLY9tuiU9ntP5dxITkGOnEaoYPoRiEEaDknYxwujlIOlNNzpPEezl
	 aybalOdT3GNHqIt6Zmc0evMykzMfc55wjri7gnuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfHFVh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbfHFVhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:37:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A074D21874;
        Tue,  6 Aug 2019 21:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127471;
        bh=bciCVAO771nWd3gcn770/n2Rb6usypvaCcgPlLxEQ58=;
        h=From:To:Cc:Subject:Date:From;
        b=LzPVLC186TZSh+QRWSP8aTLXnXkh8CrHPOnH3rrZoPYm+skP3SarGBy7RbpKhXFNa
         kVBHvt5pOd0F7Gl812+x/+UOBnqYfl3MaznlxVTIixpD3EeNenpkCxQ0/5FgkPJrA4
         fV+rWTN60E3RIWMvQkM3IGHrwxLAGpdWduUBln94=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.4 01/14] xtensa: fix build for cores with coprocessors
Date:   Tue,  6 Aug 2019 17:37:35 -0400
Message-Id: <20190806213749.20689-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
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
index a482df5df2b2c..c5d6285201252 100644
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

