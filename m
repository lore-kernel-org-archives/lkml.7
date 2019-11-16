Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC24C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC6F2089D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920315;
	bh=uf/SQX7gvex7V0ZjiMgcVzRM39CtftIlMt1fKTjPSYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W9jRJGiDpJVXNKFAuWJOo2ZZzqpe9b83IHJ6i3d4w8TrPbbPqGl1YFpLvwe8Xh4fM
	 B4zLTbYaLJ+ll7A7TzJIPtdYF1BkC0r04VnGyhn8OzO5F3OiayNVPhufRZ8wTDH3vU
	 C2fczO74IUZp7noCSB7BZPQ4HomLqQba52Q9li3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbfKPQFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730737AbfKPPvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:51:24 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCC93208CE;
        Sat, 16 Nov 2019 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919484;
        bh=uf/SQX7gvex7V0ZjiMgcVzRM39CtftIlMt1fKTjPSYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOqwaifXf4C8rU+4Pf6X0w0HrU/9YhxlufD01eg+ZvT5ARMe2MTNulfEBy8+vJFeS
         JmZ127ruzHQb4OcEN9s74wpGwzrH6zlxRybuSZRdHR74g+DvFF4O2O6ukIp/lt0Alk
         Wf4ktZ2QZhdtBs7acymNqAE+wB2QgYWebqo/n+34=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Angelo Dureghello <angelo@sysam.it>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH AUTOSEL 4.9 14/99] m68k: fix command-line parsing when passed from u-boot
Date:   Sat, 16 Nov 2019 10:49:37 -0500
Message-Id: <20191116155103.10971-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Dureghello <angelo@sysam.it>

[ Upstream commit 381fdd62c38344a771aed06adaf14aae65c47454 ]

This patch fixes command_line array zero-terminated
one byte over the end of the array, causing boot to hang.

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/kernel/uboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
index b3536a82a2620..e002084af1012 100644
--- a/arch/m68k/kernel/uboot.c
+++ b/arch/m68k/kernel/uboot.c
@@ -103,5 +103,5 @@ __init void process_uboot_commandline(char *commandp, int size)
 	}
 
 	parse_uboot_commandline(commandp, len);
-	commandp[size - 1] = 0;
+	commandp[len - 1] = 0;
 }
-- 
2.20.1

